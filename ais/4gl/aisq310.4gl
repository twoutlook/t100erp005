#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-01-07 13:53:40), PR版次:0005(2016-05-10 17:42:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000334
#+ Filename...: aisq310
#+ Description: (取消)發票列印作業
#+ Creator....: 02114(2014-04-02 00:00:00)
#+ Modifier...: 05016 -SD/PR- 04152
 
{</section>}
 
{<section id="aisq310.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1 15/02/26 By Reanna  掃把清空&給預設值&營運據點檢核異常修正&TOPMENU功能修改
#160510-00024#1 16/05/10 By Reanna  營運據點開窗&檢核不一致問題
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
 TYPE type_g_isae_m RECORD
       isae002             LIKE isae_t.isae002, #生效日期
       isae003             LIKE isae_t.isae003, #失效日期
       isaesite            LIKE isae_t.isaesite,
       isae001             LIKE isae_t.isae001,
       isae014             LIKE isae_t.isae014,
       isae008             LIKE isae_t.isae008,
       isae009             LIKE isae_t.isae009,
       isac007             LIKE isac_t.isac007,       
       isae018             LIKE isae_t.isae018,
       isae018_desc        LIKE type_t.chr80,
       isaesite_desc       LIKE type_t.chr80,
       isaf008             LIKE isaf_t.isaf008,
       isaf008_desc        LIKE type_t.chr80,     
       isae004             LIKE isae_t.isae004,
       isae017             LIKE isae_t.isae017,
       isae006             LIKE isae_t.isae006,
       isae013             LIKE isae_t.isae013,
       isaf005             LIKE isaf_t.isaf005,
       isaf006             LIKE isaf_t.isaf006
       END RECORD

#模組變數(Module Variables)
DEFINE g_isae_m        type_g_isae_m
DEFINE g_isae_m_t      type_g_isae_m                #備份舊值

 TYPE type_g_isaf_d        RECORD
       check       LIKE type_t.chr1,
       isafdocno   LIKE isaf_t.isafdocno,
       isaf014     LIKE isaf_t.isaf014,
       isaf002     LIKE isaf_t.isaf002,
       isaf021     LIKE isaf_t.isaf021,
       isaf010     LIKE isaf_t.isaf010,
       isaf011     LIKE isaf_t.isaf011,
       isaf044     LIKE isaf_t.isaf044,
       isaf103     LIKE isaf_t.isaf103,
       isaf104     LIKE isaf_t.isaf104,
       isaf105     LIKE isaf_t.isaf105,
       isafcomp    LIKE isaf_t.isafcomp
       END RECORD
DEFINE g_isaf_d   DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t type_g_isaf_d       
DEFINE g_detail_idx1         LIKE type_t.num5             
DEFINE g_wc2_table1          STRING
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數


   

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗

DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_glaa013      LIKE glaa_t.glaa013
DEFINE g_flag         LIKE type_t.chr1

DEFINE g_row_count           LIKE type_t.num5
DEFINE g_curs_index          LIKE type_t.num5
DEFINE g_docno   LIKE xrda_t.xrdadocno
DEFINE g_docdt   LIKE xrda_t.xrdadocdt
DEFINE g_glaq022 LIKE glaq_t.glaq022

DEFINE g_glaa004    LIKE glaa_t.glaa004
DEFINE g_change     LIKE type_t.chr1
DEFINE g_update_axr LIKE type_t.chr1   #拋轉憑證后回寫axr

DEFINE g_xrca   RECORD   LIKE xrca_t.* 
DEFINE g_xrcb   RECORD   LIKE xrcb_t.*
DEFINE g_xrcc   RECORD   LIKE xrcc_t.*
DEFINE g_xrcd   RECORD   LIKE xrcd_t.*
DEFINE g_isaf   RECORD   LIKE isaf_t.*
DEFINE g_isag   DYNAMIC ARRAY OF RECORD
                isagseq   LIKE isag_t.isagseq, 
                isagorga  LIKE isag_t.isagorga, 
                isag001   LIKE isag_t.isag001, 
                isag002   LIKE isag_t.isag002, 
                isag003   LIKE isag_t.isag003, 
                isag004   LIKE isag_t.isag004, 
                isag005   LIKE isag_t.isag005, 
                isag006   LIKE isag_t.isag006, 
                isag007   LIKE isag_t.isag007,
                isag008   LIKE isag_t.isag008,                
                isag101   LIKE isag_t.isag101, 
                isag103   LIKE isag_t.isag103,
                isag104   LIKE isag_t.isag104,
                isag105   LIKE isag_t.isag105,
                isag113   LIKE isag_t.isag113,
                isag114   LIKE isag_t.isag114,
                isag115   LIKE isag_t.isag115,
                isag116   LIKE isag_t.isag116,
                isag117   LIKE isag_t.isag117,
                isag126   LIKE isag_t.isag126,
                isag127   LIKE isag_t.isag127,
                isag128   LIKE isag_t.isag128,
                isag136   LIKE isag_t.isag136,
                isag137   LIKE isag_t.isag137,
                isag138   LIKE isag_t.isag138
                END RECORD
DEFINE g_ooag004     LIKE ooag_t.ooag004
DEFINE g_ooef017     LIKE ooef_t.ooef017
DEFINE g_ooef019     LIKE ooef_t.ooef019
DEFINE g_isai002     LIKE isai_t.isai002
DEFINE g_ooef004     LIKE ooef_t.ooef004
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_xrcadocno   LIKE xrca_t.xrcadocno
DEFINE g_isagseq     LIKE isag_t.isagseq
DEFINE g_success1          BOOLEAN
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aisq310.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
                                             
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
                                             
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   #LET g_forupd_sql = "SELECT xrdald,'','','',xrda001,xrda004,xrdadocdt,xrdadocno,'' FROM xrda_t WHERE xrdaent= ? AND xrdald=? AND xrdadocno=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aisq310_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
                                                                                          
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq310 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisq310_init()
 
      #進入選單 Menu (='N')
      CALL aisq310_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aisq310
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aisq310.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aisq310_init()
CALL aisq310_default_search()    

END FUNCTION

PRIVATE FUNCTION aisq310_isaf_fill(p_wc)
   DEFINE p_wc              STRING
   DEFINE l_sql             STRING
   DEFINE r_success         LIKE type_t.num5

   CALL g_isaf_d.clear()
   LET g_flag = 'Y'
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF
   

   
   
   CALL aisq310_create_tmp() RETURNING r_success
   DELETE FROM aisq310_tmp
    
   LET l_sql= " SELECT DISTINCT 'Y',isafdocno,isaf014,isaf002,isaf021,isaf010,isaf011,isaf044,isaf103,isaf104,isaf105,isafcomp ",
              "   FROM isaf_t",
              "  WHERE isafent = '",g_enterprise,"'",
              "    AND (isafstus = 'Y' OR  isafstus = 'S')",
              "    AND ",p_wc,
              "    AND isaf008 = '",g_isae_m.isaf008,"' "
                
   PREPARE isaf_pre FROM l_sql
   DECLARE isaf_cur CURSOR FOR isaf_pre

   CALL g_isaf_d.clear()
   LET g_cnt = 1
   FOREACH isaf_cur INTO g_isaf_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF g_isaf_d[g_cnt].isaf014 < g_glaa013 THEN 
         LET g_flag = 'N'
      END IF
      
      
      INSERT INTO aisq310_tmp VALUES(g_isaf_d[g_cnt].*)
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_isaf_d.deleteElement(g_cnt)

   LET g_rec_b = g_cnt - 1
   LET g_cnt = 0

   FREE isaf_pre
   IF g_flag = 'N'  THEN
      CALL cl_ask_pressanykey('axr-00061')
   END IF

END FUNCTION

PRIVATE FUNCTION aisq310_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE l_cmd    STRING
   DEFINE l_slip   LIKE ooba_t.ooba002
   DEFINE l_date   LIKE glap_t.glapdocdt
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1   LIKE type_t.num5
   
   LET li_exit = FALSE
   
   WHILE li_exit = FALSE
   
      CALL aisq310_construct()
      IF INT_FLAG THEN
         LET INT_FLAG = 0      
         EXIT WHILE
      END IF
      LET g_change = 'N'
      CALL aisq310_isaf_fill(g_wc)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
          INPUT ARRAY g_isaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
             BEFORE INPUT
             
             BEFORE ROW
                LET l_ac = ARR_CURR()
                
             ON CHANGE check
                IF g_isaf_d[l_ac].check = "Y" THEN  
                   UPDATE aisq310_tmp SET chk = 'Y' 
                    WHERE isafdocno = g_isaf_d[l_ac].isafdocno
                ELSE
                   UPDATE aisq310_tmp SET chk = 'N' 
                    WHERE isafdocno = g_isaf_d[l_ac].isafdocno
                END IF
                
          END INPUT
        

         BEFORE DIALOG
          CALL cl_set_act_visible("all_chk",TRUE)  

         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
            
            #end add-point
                        
         ON ACTION invoice_printing
            LET g_action_choice="invoice_printing"
            IF cl_auth_chk_act("invoice_printing") THEN  
                CALL aisq310_invoice_print()   
                CONTINUE DIALOG                 
            END IF

         ON ACTION query
            #LET li_exit = FALSE
            #EXIT DIALOG    
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               INITIALIZE g_isae_m.* TO NULL
               CALL aisq310_construct()
               IF INT_FLAG =1 THEN       
                  EXIT WHILE
               END IF               
               CALL aisq310_isaf_fill(g_wc)               
            END IF 

         ON ACTION selall  #全選
            UPDATE aisq310_tmp SET chk = 'Y' 
            FOR l_ac = 1 TO g_isaf_d.getLength()
               LET g_isaf_d[l_ac].check = 'Y'
            END FOR
                   
         ON ACTION selnone  #全不選
            UPDATE aisq310_tmp SET chk = 'N'  
            FOR l_ac = 1 TO g_isaf_d.getLength()
               LET g_isaf_d[l_ac].check = 'N'
            END FOR            

         
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG

          ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
      END DIALOG
   END WHILE
   #DROP TABLE aisq310_gen_ar_tmp;
   #DROP TABLE aisq310_gen_ar_tmp2;
   
END FUNCTION

PRIVATE FUNCTION aisq310_construct()
   DEFINE l_msg1         STRING 
   DEFINE l_msg2         STRING 
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_year         LIKE type_t.num5
   DEFINE l_month        LIKE type_t.num5
   DEFINE l_isac003      LIKE isac_t.isac003
   DEFINE l_comp         LIKE isae_t.isaecomp
   DEFINE l_isai006      LIKE isai_t.isai006
   DEFINE l_flag         LIKE type_t.num5
   DEFINE l_isae002_mon  LIKE type_t.num5     
   DEFINE l_isae003_mon  LIKE type_t.num5
   DEFINE l_isaq004      LIKE isaq_t.isaq004
   
   CLEAR FORM
   CALL g_isaf_d.clear()

   INITIALIZE g_wc TO NULL
   
   LET g_errshow = 1
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_isae_m.isaf008,g_isae_m.isac007,g_isae_m.isae002,g_isae_m.isae003

         BEFORE INPUT                    
            AFTER FIELD isaf008        
            CALL aisq310_ref_show()
            IF NOT cl_null(g_isae_m.isaf008) THEN  
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL                     
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_isae_m.isaf008
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_isac002_2") THEN
                  #檢查成功時後續處理                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_isae_m.isaf008 = g_isae_m_t.isaf008
                  CALL aisq310_ref_show()
                  NEXT FIELD CURRENT
               END IF            
            END IF
            
            
         ON ACTION controlp INFIELD isaf008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_m.isaf008             #給予default值
            LET g_qryparam.where = " isac001 = '",g_ooef019,"' AND isac003 IN (2,4) "
            CALL q_isac002()                                       #呼叫開窗
            LET g_isae_m.isaf008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_isae_m.isaf008 TO isaf008                    #顯示到畫面上
            CALL aisq310_ref_show()
            DISPLAY g_isae_m.isaf008_desc TO isaf008_desc 
            NEXT FIELD isaf008                                     #返回原欄位
                                    
         AFTER INPUT  
            #不可跨月
            LET l_isae002_mon = MONTH(g_isae_m.isae002)
            LET l_isae003_mon = MONTH(g_isae_m.isae003)
            IF l_isae002_mon != l_isae003_mon THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00115"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD isae002
            END IF
            LET l_isai006 = ''
            SELECT isai006 INTO l_isai006
              FROM isai_t
             WHERE isaient =g_enterprise
               AND isai001 = g_ooef019
            LET l_isac003 = ''
            SELECT isac003 INTO l_isac003
              FROM isac_t
             WHERE isac002 = g_isae_m.isaf008
               AND isacent = g_enterprise
            CALL aisq310_set_comp_entry("isasite",TRUE)
            CALL aisq310_set_comp_entry("isae001",TRUE)
            CALL aisq310_set_comp_entry("isae009",TRUE)
            #發票取得時機
            SELECT isaq004 INTO l_isaq004
              FROM isaq_t
             WHERE isaqent  = g_enterprise
               AND isaq001  = g_isae_m.isaf008
               AND isaqsite = g_ooef017
            IF l_isaq004 = 2 THEN
               CALL aisq310_set_comp_entry("isasite",FALSE)
               CALL aisq310_set_comp_entry("isae001",FALSE)
               CALL aisq310_set_comp_entry("isae009",FALSE)
            END IF
            IF l_isac003 = 4 AND l_isai006 = 'N' THEN
               CALL aisq310_set_comp_entry("isae001",FALSE)
               CALL aisq310_set_comp_entry("isae009",FALSE)
            END IF
      END INPUT 

       
      BEFORE DIALOG
         SELECT ooag004 INTO g_ooag004 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user
         SELECT ooef017,ooef019
           INTO g_ooef017,g_ooef019
           FROM ooef_t 
          WHERE ooefent = g_enterprise
            AND ooef001 = g_ooag004
            
            
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = FALSE
         EXIT DIALOG
          
      ON ACTION exporttoexcel   #匯出excel
        LET g_action_choice="exporttoexcel"
        IF cl_auth_chk_act("exporttoexcel") THEN
           CALL g_export_node.clear()
           LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
           LET g_export_id[1]   = "s_detail1"
           CALL cl_export_to_excel_getpage()
           CALL cl_export_to_excel()
        END IF
      
      #150127-00007#1 add---
      ON ACTION qbeclear
         CLEAR FORM
         INITIALIZE g_isae_m.* TO NULL
         CALL g_isaf_d.clear()

      ON ACTION close
         EXIT DIALOG
      #150127-00007#1 add end---
      
      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
      
   END DIALOG
   
   IF INT_FLAG =1 THEN
      RETURN
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT BY NAME g_isae_m.isaesite,g_isae_m.isae008,g_isae_m.isae001,
                    g_isae_m.isae009,g_isae_m.isae014
         BEFORE INPUT
            
         AFTER FIELD isaesite
            IF NOT cl_null(g_isae_m.isaesite) THEN
               CALL aisq310_isaesite_chk() RETURNING  g_success1,g_errno
               IF NOT g_success1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aisq310_ref_show()
         
         AFTER FIELD isae001
            CALL aisq310_isae_ref() 
                              
         ON ACTION controlp INFIELD isaesite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_m.isaesite
            #160510-00024#1 mark ------
            #LET g_qryparam.where = " isaesite IN ('",g_isae_m.isaesite,"','",l_comp,"' ) ",
            #                       " AND isae004  = '",g_isae_m.isaf008,"'",
            #                       " AND isae002 >= '",g_isae_m.isae002,"'",
            #                       " AND isae003 <= '",g_isae_m.isae003,"'"
            #160510-00024#1 mark end---
            #160510-00024#1 add ------
            LET g_qryparam.where = " isae004      = '",g_isae_m.isaf008,"'",
                                   " AND isae002 <= '",g_isae_m.isae002,"'",
                                   " AND isae003 >= '",g_isae_m.isae003,"'"
            #160510-00024#1 add end---
            CALL q_isaesite_3()
            LET g_isae_m.isaesite = g_qryparam.return1
            LET g_isae_m.isae001  = g_qryparam.return2
            DISPLAY g_isae_m.isaesite TO isaesite
            CALL aisq310_ref_show()
            CALL aisq310_isae_ref()
            NEXT FIELD isaesite
                            
         ON ACTION controlp INFIELD isae001
			   #發票簿號
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_m.isae001
            #160510-00024#1 mark ------
            #LET g_qryparam.where = " isaesite IN ('",g_isae_m.isaesite,"','",l_comp,"' ) ",
            #                       " AND isae004  = '",g_isae_m.isaf008,"'",
            #                       " AND isae002 >= '",g_isae_m.isae002,"'",
            #                       " AND isae003 <= '",g_isae_m.isae003,"'"
            #160510-00024#1 mark end---
            #160510-00024#1 add ------
            LET g_qryparam.where = " isae004      = '",g_isae_m.isaf008,"'",
                                   " AND isae002 <= '",g_isae_m.isae002,"'",
                                   " AND isae003 >= '",g_isae_m.isae003,"'"
            #160510-00024#1 add end---
            CALL q_isaesite_3()
            LET g_isae_m.isae001  = g_qryparam.return2
            DISPLAY g_isae_m.isae001 TO isae001
            CALL aisq310_ref_show()
            CALL aisq310_isae_ref()  
            NEXT FIELD isae001

         AFTER INPUT
           
      END INPUT 
#      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON isafdocno,isaf002,isaf010,isaf011,isaf005,isaf006

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
         
         ON ACTION controlp INFIELD isafdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "     isaf008 = '",g_isae_m.isaf008,"'",
                                   " AND isaf004 = '",g_isae_m.isaesite,"'"
            CALL q_isafdocno_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO isafdocno  #顯示到畫面上  
            NEXT FIELD isafdocno                     #返回原欄位  
            
         ON ACTION controlp INFIELD isaf002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf002    #顯示到畫面上
            NEXT FIELD isaf002                       #返回原欄位  
            
         ON ACTION controlp INFIELD isaf005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf005    #顯示到畫面上
            NEXT FIELD isaf005                       #返回原欄位
            
         ON ACTION controlp INFIELD isaf006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf006    #顯示到畫面上
            NEXT FIELD isaf006                       #返回原欄位
            
      END CONSTRUCT      
      
      BEFORE DIALOG                
        LET g_isae_m.isaesite = g_site
        CALL aisq310_ref_show()
        DISPLAY g_isae_m.isaesite TO isaesite          
        CALL aisq310_isaecomp_ref() RETURNING l_comp #使用者所屬法人
        LET l_flag = 0
        CALL cl_set_comp_required("isaesite" ,FALSE)
        CALL cl_set_comp_required("isae001" ,FALSE)

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = FALSE
         EXIT DIALOG
         
      ON ACTION query
         LET g_action_choice="query"
         IF cl_auth_chk_act("query") THEN
            INITIALIZE g_isae_m.* TO NULL
            LET l_flag =1
            EXIT DIALOG
         END IF
      
      #150127-00007#1 add---
      ON ACTION qbeclear
         CLEAR FORM
         INITIALIZE g_isae_m.* TO NULL
         CALL g_isaf_d.clear()
         EXIT DIALOG
      
      ON ACTION close
         EXIT DIALOG
      #150127-00007#1 add end---
      
      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
   END DIALOG
   IF l_flag = 1 THEN 
      CALL aisq310_construct()
   END IF
   
END FUNCTION

PRIVATE FUNCTION aisq310_show()
   CALL cl_show_fld_cont()

   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_xrda_m.xrdald
   #CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_xrda_m.xrdald_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_xrda_m.xrdald_desc


   #DISPLAY BY NAME g_type

END FUNCTION

PRIVATE FUNCTION aisq310_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   DEFINE l_comp  LIKE isae_t.isaecomp
   DEFINE l_count LIKE type_t.num5
   {</Local define>}
   #add-point:default_search段define
   
   #end add-point

   #add-point:default_search段開始前
   
   #end add-point

   #LET g_pagestart = 1
   #IF cl_null(g_order) THEN
   #   LET g_order = "ASC"
   #END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " isae018 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " isaesite = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " isaf008 = '", g_argv[03], "' AND "
   END IF


   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   
   #add-point:default_search段結束前
   
   #end add-point


END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aisq310_create_tmp()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq310_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF 
   
   DROP TABLE aisq310_tmp;
   CREATE TEMP TABLE aisq310_tmp(
   chk         LIKE type_t.chr1,
   isafdocno   LIKE isaf_t.isafdocno,
   isaf014     LIKE isaf_t.isaf014,
   isaf002     LIKE isaf_t.isaf002,
   isaf021     LIKE isaf_t.isaf021,   
   isaf010     LIKE isaf_t.isaf010,
   isaf011     LIKE isaf_t.isaf011,
   isaf044     LIKE isaf_t.isaf044,
   isaf103     LIKE isaf_t.isaf103,
   isaf104     LIKE isaf_t.isaf104,
   isaf105     LIKE isaf_t.isaf105,
   isafcomp    LIKE isaf_t.isafcomp
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 發票列印
PRIVATE FUNCTION aisq310_invoice_print()
   DEFINE l_start_no      LIKE xrca_t.xrcadocno
   DEFINE l_end_no        LIKE xrca_t.xrcadocno
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_isafdocno     LIKE isaf_t.isafdocno
   DEFINE l_isafcomp      LIKE isaf_t.isafcomp
   DEFINE l_isaf014_max   LIKE isaf_t.isaf014
   DEFINE l_isaf014_min   LIKE isaf_t.isaf014
   DEFINE l_month_1       LIKE type_t.num5
   DEFINE l_month_2       LIKE type_t.num5
   DEFINE l_isaf010       LIKE isaf_t.isaf010
   DEFINE l_isaf011       LIKE isaf_t.isaf011
   DEFINE l_isaf012       LIKE isaf_t.isaf012
   DEFINE l_isaf013       LIKE isaf_t.isaf013
   DEFINE l_isaf044       LIKE isaf_t.isaf044
   DEFINE l_isag009       LIKE isag_t.isag009
   DEFINE l_isag010       LIKE isag_t.isag010
   DEFINE l_isaf010_1     LIKE isaf_t.isaf010
   DEFINE l_isaf014       LIKE isaf_t.isaf014
   
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   CALL cl_showmsg_init()
   
   SELECT MAX(isaf014),MIN(isaf014) INTO l_isaf014_max,l_isaf014_min
     FROM aisq310_tmp
    WHERE chk = 'Y'
   
   LET l_month_1 = MONTH(l_isaf014_max)
   LET l_month_2 = MONTH(l_isaf014_min)
   
   IF l_month_1 <> l_month_2 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ais-00115'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF 
   
   
   LET g_sql = " SELECT isafdocno,isafcomp,isaf010,isaf044,isaf014 FROM aisq310_tmp",
               "  WHERE chk = 'Y'"
   PREPARE isafdocno_pre FROM g_sql
   DECLARE isafdocno_cur CURSOR FOR isafdocno_pre   
  
   FOREACH isafdocno_cur INTO l_isafdocno,l_isafcomp,l_isaf010_1,l_isaf044,l_isaf014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      SELECT COUNT(*) INTO l_n
        FROM isah_t
       WHERE isahent = g_enterprise
         AND isahdocno = l_isafdocno
         AND isahcomp = l_isafcomp
         
      IF l_n = 0  THEN 
         CALL cl_errmsg('','','','ais-00114',1)
         LET g_success = 'N'  
      END IF
     
      IF cl_null(l_isaf044) THEN 
         LET l_isaf044 = 0
      END IF
      
      IF cl_null(l_isaf010_1) THEN 
         UPDATE isaf_t SET isaf010 = l_isaf010,
                           isaf011 = l_isaf011,
                           isaf012 = l_isaf012,
                           isaf013 = l_isaf013,
                           isaf044 = l_isaf044 + 1
          WHERE isafent = g_enterprise
            AND isafdocno = l_isafdocno
            AND isafcomp = l_isafcomp
      ELSE
         UPDATE isaf_t SET isaf044 = l_isaf044 + 1
          WHERE isafent = g_enterprise
            AND isafdocno = l_isafdocno
            AND isafcomp = l_isafcomp
      END IF
      
      LET g_sql = " SELECT isag009,isag010 ",
                  "   FROM isag_t ",
                  "  WHERE isagent = '",g_enterprise,"'",
                  "    AND isagcomp = '",l_isafcomp,"'",
                  "    AND isagdocno = '",l_isafdocno,"'"
      PREPARE isag_pre FROM g_sql
      DECLARE isag_cur CURSOR FOR isag_pre 
      FOREACH isag_cur INTO l_isag009,l_isag010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            EXIT FOREACH
         END IF
         
         UPDATE xrcb_t set xrcb027 = l_isaf010	#發票代碼
                          ,xrcb028 = l_isaf011  #發票號碼
          WHERE xrcbent = g_enterprise
            AND xrcbdocno = l_isag009
            AND xrcbseq = l_isag010
      END FOREACH 
      
      #若發票日期為大於發票簿已開發票日期,則要以發票簿日期為主
      IF NOT cl_null(g_isae_m.isae017) AND l_isaf014 > g_isae_m.isae017 THEN 
         UPDATE isaf_t SET isaf014 = g_isae_m.isae017
          WHERE isafent = g_enterprise
            AND isafdocno = l_isafdocno
            AND isafcomp = l_isafcomp
      END IF
   END FOREACH 
   CALL cl_err_showmsg() 
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   END IF
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','1')
   END IF
   
END FUNCTION
# 動態設定元件開啟與關閉
PRIVATE FUNCTION aisq310_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
# 參考欄位帶值
PRIVATE FUNCTION aisq310_ref_show()
   DEFINE l_isae005     LIKE isae_t.isae005
   DEFINE l_isae006     LIKE isae_t.isae006
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_isae_m.isaesite_desc TO isaesite_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_isae_m.isaf008
   CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002 = ? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaf008_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_isae_m.isaf008_desc TO isaf008_desc  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_isae_m.isaf008
   CALL ap_ref_array2(g_ref_fields,"SELECT isac007 FROM isac_t WHERE isacent='"||g_enterprise||"' AND isac001=? AND isac002 = ? ","") RETURNING g_rtn_fields
   LET g_isae_m.isac007 = '', g_rtn_fields[1] , ''
   DISPLAY g_isae_m.isac007 TO isac007 
   
   
 
END FUNCTION

################################################################################
# Descriptions...: 使用者所屬法人
# Memo...........:
# Usage..........: CALL aisq310_isaecomp_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq310_isaecomp_ref()
 DEFINE l_success  BOOLEAN
   DEFINE l_lsaeld   LIKE glaa_t.glaald 
   DEFINE l_isaecomp LIKE isae_t.isaecomp
   DEFINE l_errno    LIKE type_t.num5
   CALL s_fin_ld_carry('',g_user) RETURNING l_success,l_lsaeld,l_isaecomp,l_errno
   
   RETURN l_isaecomp
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq310_isae_ref()

DEFINE l_isae007 LIKE isae_t.isae007
DEFINE l_isae008 LIKE isae_t.isae008
DEFINE l_site    LIKE isae_t.isaesite
      
      LET l_site = g_isae_m.isaesite
     
      IF cl_null(g_isae_m.isaesite) THEN
         CALL aisq310_isaecomp_ref() RETURNING l_site        
      END IF
      
      SELECT isae014,isae007,isae008,isae009
        INTO g_isae_m.isae014,l_isae007,l_isae008,g_isae_m.isae009
        FROM isae_t           
        WHERE isaesite = l_site
         AND  isae001  = g_isae_m.isae001
      
      IF cl_null(l_isae007) THEN             
         LET g_isae_m.isae008 = l_isae008
      ELSE
         LET g_isae_m.isae008 = l_isae007
      END IF
      
      
               
END FUNCTION

################################################################################
# Descriptions...: 營運據點檢核是否存在發票類型
# Memo...........:
# Usage..........: CALL aisq310_isaesite_chk()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION aisq310_isaesite_chk()
DEFINE l_count     LIKE type_t.num10  # 錯誤數目
DEFINE r_success   BOOLEAN
DEFINE r_errno     LIKE gzze_t.gzze001 
DEFINE l_site      LIKE isae_t.isaesite   
DEFINE l_comp      LIKE isae_t.isaecomp
   
   LET r_success = TRUE
   LET r_errno =''
   LET l_site = ''

   CALL aisq310_isaecomp_ref() RETURNING l_comp 
   
   LET l_count = ''
   #150127-00007#1 mark---
   #SELECT count (*) INTO l_count 
   #  FROM isae_t 
   # WHERE isaeent = g_enterprise
   #   AND isaesite IN (g_isae_m.isaesite,l_comp) 
   #   AND isae004  = g_isae_m.isaf008
   #   AND isae002 >= g_isae_m.isae002
   #   AND isae003 <= g_isae_m.isae003
   #
   #SELECT isaesite INTO l_site 
   #  FROM isae_t 
   # WHERE isaeent = g_enterprise
   #   AND isaesite = g_isae_m.isaesite
   #   AND isae004  = g_isae_m.isaf008
   #   AND isae002 BETWEEN  g_isae_m.isae002 AND g_isae_m.isae003
   #150127-00007#1 mark end---
   #150127-00007#1 add---
   LET g_sql = "SELECT COUNT(*)",
               "  FROM isae_t ",
               " WHERE isaeent = ",g_enterprise,
               "   AND isaesite IN ('",g_isae_m.isaesite,"','",l_comp,"')", 
               "   AND isae004 = '",g_isae_m.isaf008,"'",
               "   AND isae002 <= '",g_isae_m.isae002,"'",
               "   AND isae003 >= '",g_isae_m.isae003,"'"
   PREPARE aisq310_pb1 FROM g_sql
   EXECUTE aisq310_pb1 INTO l_count
   
   LET g_sql = "SELECT isaesite",
               "  FROM isae_t ",
               " WHERE isaeent = ",g_enterprise,
               "   AND isaesite IN ('",g_isae_m.isaesite,"','",l_comp,"')", 
               "   AND isae004 = '",g_isae_m.isaf008,"'",
               "   AND isae002 <= '",g_isae_m.isae002,"'",
               "   AND isae003 >= '",g_isae_m.isae003,"'"
   PREPARE aisq310_pb2 FROM g_sql
   EXECUTE aisq310_pb2 INTO l_site
   #150127-00007#1 add end---
   
   IF cl_null(l_count) THEN 
    LET l_count = 0
   END IF
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno ='ais-00144'
   END IF
   IF cl_null(l_site) THEN
      LET r_success = FALSE
      LET r_errno ='ais-00144'
   END IF

   RETURN r_success,r_errno

END FUNCTION

#end add-point
 
{</section>}
 
