#該程式未解開Section, 採用最新樣板產出!
{<section id="aint700_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-11-14 13:41:12), PR版次:0017(2017-01-19 11:26:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: aint700_02
#+ Description: 批量新增配送分貨單身明細
#+ Creator....: 06137(2016-08-25 15:33:14)
#+ Modifier...: 06137 -SD/PR- 06189
 
{</section>}
 
{<section id="aint700_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160914-00015#1   2016/9/14   By   06137   【批量新增分货单身明细】中查询出的资料要依项次过滤掉已经产生过配送单的部分
#160831-00068#7   2016/9/19   By   06137    1.整单操作-添加需求单，上市日期应该可以空白，空白表筛选全部
#                                           2.成调拨单按钮和生成拣货装箱单按钮可用条件，要刨去后置已作废的单据
#                                           3.生成拣货装箱单.配送中心inbmunit改为抓配送单头indiunit
#161017-00051#3   2016/10/20  by   08742    整单操作-添加需求单，1.上市日期不要有默认值，2.点对勾按钮也同产生配送明细按钮的逻辑
#161024-00023#3   2016/10/25  by   06137    整单操作-添加需求单，需求对象类型下拉隐藏掉3.供应商
#161029-00003#1   2016/10/31  by   tangyi   单头增加料件编号查询条件，用以限制料件；单身增加一个货品的页签，点击查询数据时，将单头料件编号条件内的商品列到此页签画面，产生单据单身时按两个页签交集内容产生
#161017-00051#6   2016/11/02  by   geza     抓取pmcz按照pmcz001,pmcz002顺序排序,pmcz里的需求对象类型pmcz063须与单身第一笔indj里的需求单号、需求项次的一致
#161102-00026#7   2016/11/02  by   06189    备注带值
#161110-00008#2   2016/11/10  by   geza     修改预带数量逻辑：若需求量<=配送仓可用量，此次分配量=需求量；若需求量>配送仓可用量，此次分配量=配送仓可用量,
#161117-00022#1   2016/11/18  By   lori     筆數相關變數型態定義改為NUM10
#161110-00008#2   2016/12/12  by   geza     aint705配送分货单，单身要货需求明细页签中的此次分配量预带值逻辑修改：当配送仓可用库存量大于等于0时，预带值为需求量；当小于0时，预带值按inax_t表中在拣清单时间顺序将库存量分配于每张需求单的量来预带。
#161219-00001#5   2016/12/19  by   geza     添加需求单按钮增加需求日期为空时的相关处理逻辑
#161221-00027#2   2016/12/21  by   geza     单据别参数：按可用量自动计算此次分配量为N时可用库存为负时，aint705单身此次分配量按需求单数量
#161220-00037#4   2016/12/27  By   06137    增加多次装箱处理，详见分镜；s_add_aint701修改产生装箱单身inbp里数量的取值逻辑，应装量改为此次分配量indj010-已装箱量indj022
#161227-00050#1   2016/12/28  By   lori     避免全表掃描的SQL語法:WHERE inax_t.inax008||inax_t.inax009 = a.inax008||a.inax009
#170110-00032#1   2017/01/10  by   08172    aint705零售配送分货单若有作废状况，程序逻辑没有处理，导致作废单据中的需求无法再进行配送分货处理。
#170116-00018#2   2017/01/19  by   geza     預計可用量抓取inas計算,当预计可用量小于0时，预带值按inas_t表中时间顺序将库存量分配于每张需求单的量来预带
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
 
{<section id="aint700_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmcz_d RECORD
       sel LIKE type_t.chr500, 
   pmcz001 LIKE pmcz_t.pmcz001,   #需求單號
   pmcz027 LIKE pmcz_t.pmcz027,   #需求日期
   pmcz062 LIKE pmcz_t.pmcz062,   #需求對象
   pmcz062_desc LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_pmcz_d          DYNAMIC ARRAY OF type_g_pmcz_d #單身變數
DEFINE g_pmcz_d_t        type_g_pmcz_d                  #單身備份
DEFINE g_pmcz_d_o        type_g_pmcz_d                  #單身備份
DEFINE g_pmcz_d_mask_o   DYNAMIC ARRAY OF type_g_pmcz_d #單身變數
DEFINE g_pmcz_d_mask_n   DYNAMIC ARRAY OF type_g_pmcz_d #單身變數
 
 
DEFINE g_rec_b              LIKE type_t.num10             #161117-00022#1 161118 by lori mod:num5 to num10
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
 
{<section id="aint700_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_where_sql           STRING
DEFINE g_type                LIKE type_t.num5
DEFINE g_indisite            LIKE indi_t.indisite    #物流組織
DEFINE g_indiunit            LIKE indi_t.indiunit    #配送中心
DEFINE g_indidocno           LIKE indi_t.indidocno   #配送單號
DEFINE g_indi007             LIKE indi_t.indi007     #來源類型
DEFINE g_indi001             LIKE indi_t.indi001     #需求日期
DEFINE l_pmcz023             LIKE pmcz_t.pmcz023     #來源類型
DEFINE l_pmcz027             LIKE pmcz_t.pmcz027     #需求日期
DEFINE l_imaa158             LIKE imaa_t.imaa158     #上市日期
DEFINE l_pmcz063             LIKE pmcz_t.pmcz063     #需求對象類型  #160831-00068#2 Add By ken 160906
DEFINE g_success             LIKE type_t.num5
#161029-00003#1 -str-
TYPE type_g_pmcz_d2 RECORD 
   pmcz001 LIKE pmcz_t.pmcz001,   #需求單號
   pmcz027 LIKE pmcz_t.pmcz027,   #需求日期
   pmcz062 LIKE pmcz_t.pmcz062,   #需求對象
   pmcz062_desc LIKE type_t.chr500,
   pmcz004 LIKE pmcz_t.pmcz004,
   pmcz004_desc LIKE imaal_t.imaal003
       END RECORD
DEFINE g_pmcz_d2          DYNAMIC ARRAY OF type_g_pmcz_d2
DEFINE l_ac2       LIKE type_t.num10
DEFINE g_rec_b2    LIKE type_t.num10
#161029-00003#1 -end-
#end add-point
 
{</section>}
 
{<section id="aint700_02.other_dialog" >}

 
{</section>}
 
{<section id="aint700_02.other_function" readonly="Y" >}

PUBLIC FUNCTION aint700_02(--)
   #add-point:main段變數傳入
   p_type,
   p_indisite,
   p_indiunit,
   p_indidocno,
   p_indi007,
   p_indi001
   #end add-point
   )
   #add-point:main段define
   DEFINE p_type          LIKE type_t.num5        #來源類別
   DEFINE p_indisite      LIKE indi_t.indisite    #物流組織
   DEFINE p_indiunit      LIKE indi_t.indiunit    #配送中心
   DEFINE p_indidocno     LIKE indi_t.indidocno   #配送單號
   DEFINE p_indi007       LIKE indi_t.indi007     #來源類型
   DEFINE p_indi001       LIKE indi_t.indi001     #需求日期
   DEFINE l_session_id    LIKE type_t.num20
   #end add-point
   #add-point:main段define(客製用)

   #end add-point

   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id

   IF cl_null(p_indidocno) THEN
      RETURN
   END IF

   CREATE TEMP TABLE aint700_02_tmp (
       sel           VARCHAR(1),            #選擇
       pmcz001       VARCHAR(20),         #需求單號
       pmcz027       DATE,         #需求日期
       pmcz062       VARCHAR(10));        #需求對象       
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化
   #161029-00003#1 -str-
   CREATE TEMP TABLE aint700_02_tmp2 (
       pmcz001       VARCHAR(20),         #需求單號
       pmcz027       DATE,         #需求日期
       pmcz062       VARCHAR(10),         #需求對象 
       pmcz004       VARCHAR(40),
       pmcz004_desc  VARCHAR(255)); 
   #161029-00003#1 -end-       
   #end add-point



   #LOCK CURSOR (identifier)


   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = "SELECT pmczent,pmczsite,pmcz001 FROM pmcz_t WHERE pmczent=? AND pmczsite=?
       AND pmcz001=? FOR UPDATE"
   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint700_02_bcl CURSOR FROM g_forupd_sql



   #畫面開啟 (identifier)
   OPEN WINDOW w_aint700_02 WITH FORM cl_ap_formpath("ain","aint700_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   LET g_type = p_type
   LET g_indisite = p_indisite
   LET g_indiunit = p_indiunit
   LET g_indidocno = p_indidocno
   LET g_indi007 = p_indi007
   LET g_indi001 = p_indi001
   
   CALL aint700_02_init()
   


   LET g_success = TRUE
   #進入選單 Menu (="N")
   CALL aint700_02_input()

   #畫面關閉
   CLOSE WINDOW w_aint700_02


   #add-point:離開前
   DROP TABLE aint700_02_tmp
   #end add-point
   #RETURN g_success
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aint700_02_input()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_sql        STRING
DEFINE l_sys        LIKE type_t.num5   
DEFINE l_n          LIKE type_t.num5
DEFINE li_idx       LIKE type_t.num10

   CLEAR FORM
   CALL g_pmcz_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT BY NAME l_pmcz023,l_pmcz027,l_imaa158,l_pmcz063 ATTRIBUTE(WITHOUT DEFAULTS)  #160831-00068#2 Add By ken 160906 新增pmcz063
         
         
         BEFORE INPUT

                   
      END INPUT
      
      
      #CONSTRUCT BY NAME g_wc ON pmcz001,pmcz062
      CONSTRUCT BY NAME g_wc ON pmcz001,pmcz062,pmcz004   #161029-00003#1 mod add pmcz004
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD pmcz001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcz001  #顯示到畫面上
            NEXT FIELD pmcz001                     #返回原欄位
                       
         ON ACTION controlp INFIELD pmcz062
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160831-00068#2 Add By ken 160906(S)
            IF l_pmcz063 = '1' THEN  #內部組織  
               LET g_qryparam.where = s_aooi500_q_where('apmt830','pmdbsite',g_site,'c')
               CALL q_ooef001_24()
            #160831-00068#2 Add By ken 160906(E)   
            ELSE                     #客戶
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                         #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO pmcz062  #顯示到畫面上
            NEXT FIELD pmcz062                     #返回原欄位
         #161029-00003#1 add -str-
         ON ACTION controlp INFIELD pmcz004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcz004  #顯示到畫面上
            NEXT FIELD pmcz004                     #返回原欄位
         #161029-00003#1 add -end-
      END CONSTRUCT
      
     
      INPUT ARRAY g_pmcz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL aint700_02_b_fill()              
            LET g_rec_b = g_pmcz_d.getLength()
            DISPLAY "g_rec_b:",g_rec_b
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_pmcz_d_t.* = g_pmcz_d[l_ac].*
            LET g_pmcz_d_o.* = g_pmcz_d[l_ac].*            
            CALL aint700_02_set_entry_b("a")
            CALL aint700_02_set_no_entry_b("a")           

         ON CHANGE sel   
            #mark by geza 20161219 #161219-00001#5(S)         
#            UPDATE aint700_02_tmp
#               SET sel = g_pmcz_d[l_ac].sel
#             WHERE pmcz001 = g_pmcz_d[l_ac].pmcz001
#               AND pmcz027 = g_pmcz_d[l_ac].pmcz027
#               AND pmcz062 = g_pmcz_d[l_ac].pmcz062
            #mark by geza 20161219 #161219-00001#5(S)     
            IF g_indi001 IS NULL THEN
               UPDATE aint700_02_tmp
                  SET sel = g_pmcz_d[l_ac].sel
                WHERE pmcz001 = g_pmcz_d[l_ac].pmcz001
                  AND pmcz062 = g_pmcz_d[l_ac].pmcz062
            ELSE
               UPDATE aint700_02_tmp
                  SET sel = g_pmcz_d[l_ac].sel
                WHERE pmcz001 = g_pmcz_d[l_ac].pmcz001
                  AND pmcz027 = g_pmcz_d[l_ac].pmcz027
                  AND pmcz062 = g_pmcz_d[l_ac].pmcz062            
            END IF            
            
            DISPLAY BY NAME g_pmcz_d[l_ac].sel
            CALL aint700_02_set_entry_b("a")
            CALL aint700_02_set_no_entry_b("a")     
         
         ON ROW CHANGE
             
      END INPUT
      
      #161029-00003#1 add -str-
      DISPLAY ARRAY g_pmcz_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)  
        
          BEFORE DISPLAY
            
      END DISPLAY
      #161029-00003#1 add -end-
      
      BEFORE DIALOG   
         LET l_pmcz023 = g_indi007   #來源類型
         LET l_pmcz027 = g_indi001   #需求日期
         #LET l_imaa158 = g_today     #上市日期   #161017-00051#3   2016/10/20  by   08742 mark
         LET l_imaa158 = ' '     #上市日期   #161017-00051#3   2016/10/20  by   08742 add
         DISPLAY BY NAME l_pmcz023,l_pmcz027,l_imaa158,l_pmcz063      
      
         NEXT FIELD l_imaa158      
      
      ON ACTION data_ok
         #產生配送明細單身
         CALL aint700_02_gen_pmcz()      
                  
      ON ACTION check_all
         #需求明細單身全選
         CALL aint700_02_check_all() 
      
      ON ACTION check_no_all
         #需求明細單身全不選
         CALL aint700_02_check_no_all()
         
      ON ACTION gen_indj
         #產生配送明細單身
         
         #檢查單身的必輸欄位不可為空
         SELECT COUNT(*) INTO g_rec_b 
           FROM aint700_02_tmp 
          WHERE sel = 'Y'           
         
         IF g_rec_b > 0 THEN                                       
             LET g_success = TRUE
             IF NOT aint700_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_pmcz_d.clear()
                   DELETE FROM aint700_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del aint700_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL aint700_02_gen_pmcz()                                      
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00783'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
          
      ON ACTION accept
      #161017-00051#3   2016/10/20  by   08742  -S
      #檢查單身的必輸欄位不可為空
         SELECT COUNT(*) INTO g_rec_b 
           FROM aint700_02_tmp 
          WHERE sel = 'Y'           
         
         IF g_rec_b > 0 THEN                                       
             LET g_success = TRUE
             IF NOT aint700_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_pmcz_d.clear()
                   DELETE FROM aint700_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del aint700_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL aint700_02_gen_pmcz()                                      
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00783'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
         #161017-00051#3   2016/10/20  by   08742  -E
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

PRIVATE FUNCTION aint700_02_b_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

    CALL g_pmcz_d.clear()
    LET l_ac = 1
    
    LET l_sql = "SELECT sel,         pmcz001,     pmcz027,     ",
                "       pmcz062,     t1.pmaal003               ",        
                "  FROM aint700_02_tmp ",
                "  LEFT OUTER JOIN pmaal_t t1 ON t1.pmaalent = ",g_enterprise,
                "                            AND t1.pmaal001 = pmcz062",
                "                            AND t1.pmaal002 = '",g_dlang,"'",
                "  ORDER BY pmcz001 "
    PREPARE aint700_02_pmcz_pb FROM l_sql
    DECLARE aint700_02_pmcz_cs CURSOR FOR aint700_02_pmcz_pb
    FOREACH aint700_02_pmcz_cs
       INTO g_pmcz_d[l_ac].sel,                   g_pmcz_d[l_ac].pmcz001,             g_pmcz_d[l_ac].pmcz027,      
            g_pmcz_d[l_ac].pmcz062,               g_pmcz_d[l_ac].pmcz062_desc
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach aint700_02_pmcz_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
       
       IF l_pmcz023 != '3' THEN
          CALL s_desc_get_department_desc(g_pmcz_d[l_ac].pmcz062) RETURNING g_pmcz_d[l_ac].pmcz062_desc
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
    
    CALL g_pmcz_d.deleteElement(g_pmcz_d.getLength()) 
    LET l_ac = g_pmcz_d.getLength()    
END FUNCTION

PRIVATE FUNCTION aint700_02_default_search()
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
      LET ls_wc = ls_wc, " pmcz001 = '", g_argv[01], "' AND "
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

PRIVATE FUNCTION aint700_02_delete()
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
   FOR li_idx = 1 TO g_pmcz_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN
         #確定是否有被鎖定
         IF NOT aint700_02_lock_b("pmcz_t") THEN
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

   FOR li_idx = 1 TO g_pmcz_d.getLength()
      IF g_pmcz_d[li_idx].pmcz001 IS NOT NULL

         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN

         #add-point:單身刪除前

         #end add-point

         DELETE FROM pmcz_t
          WHERE pmczent = g_enterprise AND pmczsite = g_site AND
                pmcz001 = g_pmcz_d[li_idx].pmcz001

         #add-point:單身刪除中

         #end add-point

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "pmcz_t"
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
               LET gs_keys[1] = g_pmcz_d_t.pmcz001

            #add-point:單身同步刪除中(同層table)

            #end add-point
                           CALL aint700_02_delete_b('rtdx_t',gs_keys,"'1'")
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
   CALL aint700_02_b_fill()

END FUNCTION

PRIVATE FUNCTION aint700_02_delete_b(ps_table,ps_keys_bak,ps_page)
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

         DELETE FROM pmcz_t
          WHERE pmczent = g_enterprise AND pmczsite = g_site AND
            pmcz001 = ps_keys_bak[1]

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
         CALL g_pmcz_d.deleteElement(li_idx)
      END IF


      #add-point:delete_b段刪除後

      #end add-point

      RETURN
   END IF



END FUNCTION

PRIVATE FUNCTION aint700_02_detail_show()
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

PRIVATE FUNCTION aint700_02_init()
   #add-point:init段define
   CALL g_pmcz_d2.clear()   #161029-00003#1
   #end add-point
   #add-point:init段define(客製用)
   
   #end add-point

   CALL g_pmcz_d.clear()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_error_show = 1

   #add-point:畫面資料初始化
   #160831-00068#2 Add By ken 160906(S)
   #CALL cl_set_combo_scc('l_pmcz063','6968')           #161024-00023#3 Mark By Ken 161025
   CALL cl_set_combo_scc_part('l_pmcz063','6968','1,2') #161024-00023#3 Add By Ken 161025
   LET l_pmcz063 = '1'   
   IF cl_null(g_indi007) THEN
      CALL cl_set_comp_entry("l_pmcz063",TRUE)
   ELSE
      CALL cl_set_comp_entry("l_pmcz063",FALSE)
      IF g_indi007 = '3' THEN  #來源類型為銷售訂單
         LET l_pmcz063 = '2'
      END IF
   END IF
   #160831-00068#2 Add By ken 160906(E)
   CALL cl_set_combo_scc('l_pmcz023','6874')

   #end add-point


END FUNCTION

PRIVATE FUNCTION aint700_02_insert()
   #add-point:delete段define

   #end add-point
   #add-point:insert段define(客製用)

   #end add-point

   #add-point:單身新增前

   #end add-point

   LET g_insert = 'Y'
   #CALL aint700_02_modify()

   #add-point:單身新增後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_insert_b(ps_table,ps_keys,ps_page)
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

PRIVATE FUNCTION aint700_02_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point
   #add-point:lock_b段define(客製用)

   #end add-point

   #先刷新資料
   #CALL aint700_02_b_fill()

   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdx_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aint700_02_bcl USING g_enterprise, g_site,
                                       g_pmcz_d[g_detail_idx].pmcz001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "aint700_02_bcl"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

   END IF



   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION aint700_02_modify()
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
 #           CALL aint700_02_b_fill()
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
 #              IF NOT aint700_02_lock_b("rtdx_t") THEN
 #                 LET l_lock_sw='Y'
 #              ELSE
 #                 FETCH aint700_02_bcl INTO g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,
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
 #                 CALL aint700_02_rtdx_t_mask()
 #                 LET g_rtdx_d_mask_n[l_ac].* =  g_rtdx_d[l_ac].*
 #
 #                 CALL aint700_02_detail_show()
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
 #           CALL aint700_02_set_entry_b("a")
 #           CALL aint700_02_set_no_entry_b("a")
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
 #              CALL aint700_02_insert_b('rtdx_t',gs_keys,"'1'")
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
 #              #CALL aint700_02_b_fill()
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
 #                 CALL aint700_02_set_pk_array()
 #                 IF NOT cl_log_modified_record('','') THEN
 #                 ELSE
 #                 END IF
 #              END IF
 #              CLOSE aint700_02_bcl
 #              #add-point:單身關閉bcl
 #
 #              #end add-point
 #              LET l_count = g_rtdx_d.getLength()
 #                             INITIALIZE gs_keys TO NULL
 #              LET gs_keys[1] = g_rtdx_d_t.rtdx001
 #
 #              #應用 a47 樣板自動產生(Version:2)
 #     #刪除相關文件
 #     CALL aint700_02_set_pk_array()
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
 #                             CALL aint700_02_delete_b('rtdx_t',gs_keys,"'1'")
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
  #             CLOSE aint700_02_bcl
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
  #             CALL aint700_02_rtdx_t_mask_restore('restore_mask_o')
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
  #             CALL aint700_02_update_b('rtdx_t',gs_keys,gs_keys_bak,"'1'")
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
  #             CALL aint700_02_rtdx_t_mask_restore('restore_mask_n')
  #
  #             #add-point:單身修改後
  #
  #             #end add-point
  #
  #          END IF
  #
  #       AFTER ROW
  #          CALL aint700_02_unlock_b("rtdx_t")
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
  # CLOSE aint700_02_bcl

END FUNCTION

PRIVATE FUNCTION aint700_02_modify_detail_chk(ps_record)
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

PRIVATE FUNCTION aint700_02_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   #add-point:query段define

   #end add-point
   #add-point:query段define(客製用)

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_entry_b段define

   #end add-point
   #add-point:set_entry_b段define(客製用)

   #end add-point

   #add-point:set_entry_b段control
  
   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry_b段define

   #end add-point
   #add-point:set_no_entry_b段define(客製用)

   #end add-point

   #add-point:set_no_entry_b段control

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_set_pk_array()
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
   LET g_pk_array[1].values = g_pmcz_d[l_ac].pmcz001
   LET g_pk_array[1].column = 'pmcz001'


   #add-point:set_pk_array段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_ui_dialog()

END FUNCTION

PRIVATE FUNCTION aint700_02_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define

   #end add-point
   #add-point:unlock_b段define(客製用)

   #end add-point

   LET ls_group = ""

   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aint700_02_bcl
   #END IF



   #add-point:unlock_b段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint700_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "pmcz_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "pmcz_t" THEN
      #add-point:update_b段修改前

      #end add-point

      #add-point:update_b段修改中

      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "pmcz_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "pmcz_t"
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
# Usage..........: CALL aint700_02_gen_detail_pre()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint700_02_gen_detail_pre()
DEFINE l_pmcz001        LIKE pmcz_t.pmcz001
DEFINE l_pmcz027        LIKE pmcz_t.pmcz027
DEFINE l_pmcz062        LIKE pmcz_t.pmcz062
DEFINE l_sel            LIKE type_t.chr1
DEFINE l_sql            STRING
DEFINE l_slip           LIKE ooba_t.ooba001   #單別 #add by geza 20161219 #161219-00001#5
DEFINE l_default        LIKE type_t.chr10     #add by geza 20161219 #161219-00001#5   
   DEFINE  l_success    LIKE type_t.num5      #add by geza 20161219 #161219-00001#5   
   CALL s_aooi200_get_slip(g_indidocno) RETURNING l_success,l_slip   #add by geza 20161219 161219-00001#5
   CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-CIR-0005') RETURNING l_default #add by geza 20161219 161219-00001#5
   
   LET l_sql = " SELECT pmcz001,pmcz027,pmcz062,sel  ",
               "   FROM aint700_02_tmp  "
   PREPARE aint700_02_test_pre FROM l_sql
   DECLARE aint700_02_test_cs CURSOR FOR aint700_02_test_pre
   FOREACH aint700_02_test_cs INTO l_pmcz001,l_pmcz027,l_pmcz062,l_sel
      DISPLAY "pmcz001:",l_pmcz001,":",l_pmcz027,":",l_pmcz062,":",l_sel
   END FOREACH
 
   #符合選取的明細資料
   LET l_sql = " SELECT pmcz001,pmcz002,pmcz021,pmcz062 ",  
               "   FROM pmcz_t t1 ",
               "  WHERE t1.pmczent  = ",g_enterprise," ",
               "    AND t1.pmcz042  = '",g_indiunit,"' " 
               #"    AND t1.pmcz027  = '",g_indi001,"' ", #mark by geza 20161219 161219-00001#5
               #add by geza 20161219 161219-00001#5(S)
               IF l_default = 'N' THEN
                  LET l_sql = l_sql,"    AND t1.pmcz027  = '",g_indi001,"' "  
               END IF
               #add by geza 20161219 161219-00001#5(E)
               #161029-00003#1 mod -str-              
#               "    AND EXISTS (SELECT 1 FROM aint700_02_tmp t01 ",
#               "                 WHERE t1.pmcz001=t01.pmcz001 ",
#               "                   AND t1.pmcz027=t01.pmcz027 ",
#               "                   AND t1.pmcz062=t01.pmcz062 ",
#               "                   AND t01.sel = 'Y' ) "
               LET l_sql = l_sql,"    AND EXISTS (SELECT 1 FROM aint700_02_tmp t01, aint700_02_tmp2 t02",
               "                 WHERE t1.pmcz001=t01.pmcz001 "
               #"                   AND t1.pmcz027=t01.pmcz027 ", #mark by geza 20161219 161219-00001#5
               #add by geza 20161219 161219-00001#5(S)
               IF l_default = 'N' THEN
                  LET l_sql = l_sql," AND t1.pmcz027=t01.pmcz027 " 
               END IF
               #add by geza 20161219 161219-00001#5(E)
               LET l_sql = l_sql,"                   AND t1.pmcz062=t01.pmcz062 ",
                "                  AND t01.pmcz001=t02.pmcz001 "
               #"                   AND t01.pmcz027=t02.pmcz027 ", #mark by geza 20161219 161219-00001#5
               #add by geza 20161219 161219-00001#5(S)
               IF l_default = 'N' THEN
                  LET l_sql = l_sql," AND t01.pmcz027=t02.pmcz027 "
               END IF
               #add by geza 20161219 161219-00001#5(E)
               LET l_sql = l_sql,"                   AND t01.pmcz062=t02.pmcz062 ",
               "                   AND t1.pmcz004=t02.pmcz004",
               "                   AND t01.sel = 'Y' ) "
               #161029-00003#1 mod -end-
   IF NOT cl_null(l_imaa158) THEN   #160831-00068#7 Add By ken 160919 上市日不為空時再加上當條件                
   LET l_sql = l_sql,"    AND EXISTS (SELECT 1 FROM imaa_t ",
               "                 WHERE t1.pmczent=imaaent ",
               "                   AND t1.pmcz004=imaa001 ",
               "                   AND imaa158 = '",l_imaa158,"') "
   END IF
   LET l_sql = l_sql, "ORDER BY pmcz001, pmcz002 " #add by geza 20161102 #161017-00051#6
   PREPARE aint700_02_sel_pre FROM l_sql
   DECLARE aint700_02_sel_cs CURSOR FOR aint700_02_sel_pre
   
   DISPLAY "----------------------------------------------------------------------------------"
   DISPLAY "l_SQL: ",l_sql
   DISPLAY "----------------------------------------------------------------------------------"
   
   #檢查是否已存在配送單
   LET l_sql = " SELECT COUNT(1) FROM indj_t ",
               "  WHERE indjent = ",g_enterprise,
               "    AND indjdocno = ? ",
               "    AND indj001 = ? ",
               "    AND indj002 = ? "
   PREPARE aint700_02_chk_pre FROM l_sql
   
   #項次
   LET l_sql = "SELECT COALESCE(MAX(indjseq),0)+1",
               "  FROM indj_t",
               " WHERE indjent = ",g_enterprise,
               "   AND indjdocno = '",g_indidocno,"'"
   PREPARE aint700_02_indiseq FROM l_sql
END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細資料
# Memo...........:
# Usage..........: CALL aint700_02_gen_detail()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint700_02_gen_detail()
DEFINE l_i               LIKE type_t.num5
DEFINE l_pmcz061         LIKE pmcz_t.pmcz061      #分配狀態
DEFINE l_pmcz023         LIKE pmcz_t.pmcz023   #add by geza 20161103 #161102-00026#7 pmcz023  
DEFINE l_indi005         LIKE indi_t.indi005   #add by geza 20161103 #161102-00026#7  
DEFINE l_pmda022         LIKE pmda_t.pmda022   #add by geza 20161103 #161102-00026#7
DEFINE l_inag009         LIKE inag_t.inag009   #add by geza 20161110 161110-00008#2
DEFINE l_pmcz            RECORD
       pmcz001           LIKE pmcz_t.pmcz001,     #需求單號
       pmcz002           LIKE pmcz_t.pmcz002,     #需求項次
       pmcz021           LIKE pmcz_t.pmcz021,     #取貨組織
       pmcz062           LIKE pmcz_t.pmcz062      #需求對象
                         END RECORD
DEFINE l_indj            RECORD 
       indjunit        LIKE indj_t.indjunit,       
       indj001         LIKE indj_t.indj001,
       indj002         LIKE indj_t.indj002,
       indjseq         LIKE indj_t.indjseq,      
       indj003         LIKE indj_t.indj003,       
       indj004         LIKE indj_t.indj004,
       indj005         LIKE indj_t.indj005,
       indj006         LIKE indj_t.indj006, 
       indj007         LIKE indj_t.indj007, 
       indj008         LIKE indj_t.indj008, 
       indj009         LIKE indj_t.indj009, 
       indj010         LIKE indj_t.indj010,
       indj011         LIKE indj_t.indj011,
       indj012         LIKE indj_t.indj012, 
       indj015         LIKE indj_t.indj015,
       indj016         LIKE indj_t.indj016,
       indj018         LIKE indj_t.indj018,
       indj020         LIKE indj_t.indj020
                         END RECORD 
DEFINE l_indj021       LIKE indj_t.indj021   #161109-00078#3 Add By Ken 161114 單身拋單狀態
#161220-00037#4 Add By Ken 161227(S)      
DEFINE l_indj022         LIKE indj_t.indj022
DEFINE l_indj023         LIKE indj_t.indj023
#161220-00037#4 Add By Ken 161227(E)
#取得要貨單資料使用的回傳Record
DEFINE r_indj            RECORD 
       indjunit        LIKE indj_t.indjunit,       
       indj001         LIKE indj_t.indj001,
       indj002         LIKE indj_t.indj002,
       indjseq         LIKE indj_t.indjseq,      
       indj003         LIKE indj_t.indj003,       
       indj004         LIKE indj_t.indj004,
       indj005         LIKE indj_t.indj005,
       indj006         LIKE indj_t.indj006, 
       indj007         LIKE indj_t.indj007, 
       indj008         LIKE indj_t.indj008, 
       indj009         LIKE indj_t.indj009, 
       indj010         LIKE indj_t.indj010,
       indj011         LIKE indj_t.indj011,
       indj012         LIKE indj_t.indj012, 
       indj015         LIKE indj_t.indj015,
       indj016         LIKE indj_t.indj016,
       indj018         LIKE indj_t.indj018,
       indj020         LIKE indj_t.indj020,
       indj021         LIKE indj_t.indj021   #161109-00078#3 Add By Ken 161114 單身拋單狀態       
                         END RECORD 
DEFINE l_seq             LIKE type_t.num5                         
DEFINE l_success         LIKE type_t.num5
DEFINE l_errno           LIKE type_t.chr10
DEFINE l_cnt             LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
DEFINE l_inag009_1       LIKE inag_t.inag009   #add by geza 20161212 #161110-00008#5
DEFINE l_indj010         LIKE indj_t.indj010   #add by geza 20161212 #161110-00008#5
DEFINE l_indj001         LIKE indj_t.indj001   #add by geza 20161212 #161110-00008#5
DEFINE l_indj002         LIKE indj_t.indj002   #add by geza 20161212 #161110-00008#5
DEFINE l_sql             STRING                #add by geza 20161212 #161110-00008#5
DEFINE l_inax RECORD  #庫存在揀明細檔
       inaxent LIKE inax_t.inaxent, #企業代碼
       inax001 LIKE inax_t.inax001, #計算專案
       inax002 LIKE inax_t.inax002, #計算加減項
       inax003 LIKE inax_t.inax003, #異動日期
       inax004 LIKE inax_t.inax004, #異動據點
       inax005 LIKE inax_t.inax005, #異動單號
       inax006 LIKE inax_t.inax006, #異動項次
       inax007 LIKE inax_t.inax007, #需求據點
       inax008 LIKE inax_t.inax008, #需求單號
       inax009 LIKE inax_t.inax009, #需求项次
       inax010 LIKE inax_t.inax010, #商品編號
       inax011 LIKE inax_t.inax011, #產品特征
       inax012 LIKE inax_t.inax012, #庫存特徵
       inax013 LIKE inax_t.inax013, #庫存單位
       inax014 LIKE inax_t.inax014, #數量
       inax015 LIKE inax_t.inax015, #在揀庫位
       inax016 LIKE inax_t.inax016, #採購方式
       inax017 LIKE inax_t.inax017  #配送中心
END RECORD
#add by geza 20170118 #170116-00018#5(S) 
DEFINE l_inas RECORD  #庫存需求等候明細檔
       inassite LIKE inas_t.inassite, #營運據點
       inas001 LIKE inas_t.inas001, #單據編號
       inas002 LIKE inas_t.inas002, #單據項次
       inas003 LIKE inas_t.inas003, #單據項序
       inas004 LIKE inas_t.inas004, #單據分批序
       inas005 LIKE inas_t.inas005, #原始排隊日期時間
       inas006 LIKE inas_t.inas006, #調整後排隊日期時間
       inas007 LIKE inas_t.inas007, #單據性質
       inas008 LIKE inas_t.inas008, #作業編號
       inas009 LIKE inas_t.inas009, #料件編號
       inas010 LIKE inas_t.inas010, #產品特徵
       inas011 LIKE inas_t.inas011, #排隊數量
       inas012 LIKE inas_t.inas012, #基礎單位排隊數量
       inas013 LIKE inas_t.inas013, #交易單位
       inas014 LIKE inas_t.inas014, #原始需求數量
       inas015 LIKE inas_t.inas015, #需求日期
       inas016 LIKE inas_t.inas016, #負責人員
       inas017 LIKE inas_t.inas017  #負責部門
END RECORD
#add by geza 20170118 #170116-00018#5(E) 
DEFINE l_slip            LIKE ooba_t.ooba001   #add by geza 20161221 #161221-00027#2
DEFINE l_default         LIKE type_t.chr10     #add by geza 20161221 #161221-00027#2
   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL aint700_02_gen_detail_pre()
   
   FOREACH aint700_02_sel_cs  INTO l_pmcz.pmcz001,   l_pmcz.pmcz002,  l_pmcz.pmcz021,  l_pmcz.pmcz062
      INITIALIZE l_indj.* TO NULL      
      LET l_cnt = 0

      EXECUTE aint700_02_indiseq INTO l_indj.indjseq  #取得項次
      EXECUTE aint700_02_chk_pre USING g_indidocno,l_pmcz.pmcz001,l_pmcz.pmcz002 INTO l_cnt
      
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF 

      LET l_success = FALSE
      CALL s_aint700_chk_indj001_indj002(l_pmcz.pmcz001,l_pmcz.pmcz002,g_indidocno,l_indj.indjseq) RETURNING l_success,l_errno
      IF l_success THEN
         #add by geza 20161103 #161102-00026#7(S) 
         SELECT pmcz023 INTO l_pmcz023
           FROM pmcz_t
          WHERE pmczent = g_enterprise
            AND pmcz001 = l_pmcz.pmcz001
            AND pmcz002 = l_pmcz.pmcz002
         #更新单头的备注栏位
         #查出单头的已有备注
         LET l_indi005 = ''
         SELECT indi005 INTO l_indi005
           FROM indi_t
          WHERE indient = g_enterprise
            AND indidocno = g_indidocno
         #来源单号在单身是否存在   
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM indj_t
          WHERE indjent = g_enterprise
            AND indjdocno = g_indidocno
            AND indj001 = l_pmcz.pmcz001
         #来源单号的备注  
         #1.要货单,2.铺货单,3.分销订单
         LET l_pmda022 = ''
         IF l_pmcz023 = '1' THEN
            SELECT pmda022 INTO l_pmda022
              FROM pmda_t
             WHERE pmdaent = g_enterprise
               AND pmdadocno = l_pmcz.pmcz001
         END IF
         IF l_pmcz023 = '2' THEN
            SELECT pmco005 INTO l_pmda022
              FROM pmco_t
             WHERE pmcoent = g_enterprise
               AND pmcodocno = l_pmcz.pmcz001
         END IF
         IF l_pmcz023 = '3' THEN
            SELECT xmda071 INTO l_pmda022
              FROM xmda_t
             WHERE xmdaent = g_enterprise
               AND xmdadocno = l_pmcz.pmcz001
         END IF
         
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM indj_t
          WHERE indjent = g_enterprise
            AND indjdocno = g_indidocno
            AND indj001 = l_pmcz.pmcz001   
         IF l_indi005 IS NULL THEN
            IF l_cnt = 0 THEN
               IF l_pmda022 IS NOT NULL THEN
                  LET l_indi005 = l_pmda022
                  UPDATE indi_t 
                     SET indi005 = l_indi005
                   WHERE indient = g_enterprise
                     AND indidocno = g_indidocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "UPDATE indi_t:" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     EXIT FOREACH
                  END IF    
               END IF
            END IF
         ELSE 
            IF l_cnt = 0 THEN
               IF l_pmda022 IS NOT NULL THEN
                  LET l_indi005 = l_indi005,"&",l_pmda022
                  UPDATE indi_t 
                     SET indi005 = l_indi005
                   WHERE indient = g_enterprise
                     AND indidocno = g_indidocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "UPDATE indi_t:" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     EXIT FOREACH
                  END IF    
               END IF 
            END IF
         END IF
         #add by geza 20161103 #161102-00026#7(E)
         LET l_indj.indj001 = l_pmcz.pmcz001   #需求單號
         LET l_indj.indj002 = l_pmcz.pmcz002   #需求項次
         #LET l_indj.indjsite = g_indisite
         LET l_indj.indj011 = "0"
         LET l_indj.indj018 = "N"
         LET l_indj.indj020 = l_pmcz.pmcz062   #需求對象
         LET l_indj021 = 'N'   #161109-00078#3 Add By Ken 161114  加拋單狀態
         #161220-00037#4 Add By Ken 161227(S)      
         LET l_indj022 = 0     #已裝箱量
         LET l_indj023 = 'N'   #結束碼
         #161220-00037#4 Add By Ken 161227(E)         
         CALL s_aint700_carry_pmdb(g_type,g_indiunit,g_indisite,l_pmcz.pmcz001,l_pmcz.pmcz002,l_indj.indjseq) 
           RETURNING l_indj.*
         #add by geza 20161110 161110-00008#2(S)
         #算出可用库存
         LET l_inag009 = 0
         SELECT SUM(inag009) INTO l_inag009
           FROM inag_t
          WHERE inagent = g_enterprise
            AND inag001 = l_indj.indj004
            AND inag002 = l_indj.indj005
            AND inag004 = l_indj.indj012
            AND inag007 = l_indj.indj008 #add by geza 201611206 161124-00039#1
            AND inagsite = g_indiunit #add by geza 201611206 161124-00039#1
         IF l_inag009 IS NULL THEN
            LET l_inag009 = 0
         END IF
         LET l_inag009_1 = l_inag009 #备份实际库存 #add by geza 20161212 #161110-00008#5
         #CALL s_get_inag009_valid(l_indj.indj003,l_indj.indj004,l_indj.indj005,l_inag009,'2') RETURNING l_inag009 #mark by geza 20161208 #161124-00039#1      
         CALL s_get_inag009_valid(l_indj.indj003,l_indj.indj004,l_indj.indj005,l_inag009,'2','',l_indj.indj012,l_indj.indj008,g_indiunit) RETURNING l_inag009 #add by geza 20161208 #161124-00039#1         
         #mark by geza 20161130 #161129-00068#1(S)
#         IF l_inag009 > 0 THEN
#            IF l_indj.indj009 <= l_inag009 THEN
#               LET l_indj.indj010  = l_indj.indj009
#               LET l_indj.indj011 = 0
#            ELSE
#               LET l_indj.indj010  = l_inag009
#               LET l_indj.indj011 = l_indj.indj009 - l_indj.indj010         
#            END IF
#         ELSE
#            LET l_indj.indj010  = 0
#            LET l_indj.indj011 = l_indj.indj009
#         END IF
#        #add by geza 20161130 #161129-00068#1(E)
         IF l_inag009 > = 0 THEN
            LET l_indj.indj010  = l_indj.indj009
            LET l_indj.indj011 = 0
         ELSE
            #mark by geza 20161212 #161110-00008#5(S)
#            LET l_indj.indj010  = 0
#            LET l_indj.indj011 = l_indj.indj009
            #mark by geza 20161212 #161110-00008#5(E)
            #add by geza 20161221 #161221-00027#2(S)
            CALL s_aooi200_get_slip(g_indidocno) RETURNING l_success,l_slip
            CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-CIR-0008') RETURNING l_default
            IF l_default = 'Y' THEN
            #add by geza 20161221 #161221-00027#2(E)
               
#               #mark by geza 20170119 #170116-00018#2(S)
#               #add by geza 20161212 #161110-00008#5(S)
#               #先扣除aint705的占用量
#               LET l_indj.indj010  = 0
#               LET l_indj.indj011 = l_indj.indj009
#               LET l_indj010 = 0
#               LET l_sql = " SELECT DISTINCT indj001,indj002,indj010 ",
#                           "   FROM inax_t,indj_t,indi_t ",
#                           "  WHERE inaxent = ",g_enterprise," AND inax001 IN ('2','14','15')  ",
#                           "    AND inax002 IS NOT NULL ",
#                           "    AND indjent = inaxent AND indient = indjent AND indidocno = indjdocno AND indistus <> 'X' AND indj001 = inax008 AND inax009 = indj002  ",                
#                           "    AND inax017 = '",g_indiunit,"' AND inax010 = '",l_indj.indj004,"' AND inax011 = '",l_indj.indj005,"'",
#                           "    AND inax015 = '",l_indj.indj012,"' AND inax013 = '",l_indj.indj008,"' ", 
#                           "    AND indjent = inaxent AND indient = indjent AND indidocno = indjdocno AND indistus <> 'X' AND indj001 = inax008 AND inax009 = indj002  ",                
##                          "    AND NOT EXISTS (SELECT 1 FROM indd_t, indc_t WHERE indcent = inddent AND indddocno = indcdocno AND indcstus  in ('O', 'C', 'P')
##                               AND indd047 = indj001 AND indd048 = indj002) ",
##                          "    AND NOT EXISTS (SELECT 1 FROM xmdk_t, xmdl_t WHERE xmdlent = xmdkent AND xmdkdocno = xmdldocno AND xmdkstus  in ('S') AND xmdl003 = INDJ001
##                               AND xmdl004 = indj002) ",
#                          #"    AND inax008||inax009 NOT IN (SELECT a.inax008||a.inax009 as docno FROM inax_t a  WHERE a.inaxent = ",g_enterprise," AND a.inax001 <> '16' AND a.inax002 IS NOT NULL ",  #mark by geza 20161221 #161221-00027#2
#                          #161227-00050#1 161228 by lori mod---(S)
#                          #"    AND NOT EXISTS (SELECT  1 FROM inax_t a  WHERE inax_t.inax008||inax_t.inax009 = a.inax008||a.inax009 AND a.inaxent = ",g_enterprise," AND a.inax001 <> '16' AND a.inax002 IS NOT NULL ", #add by geza 20161221 #161221-00027#2
#                           "    AND NOT EXISTS (SELECT  1 FROM inax_t a ",
#                           "                     WHERE inax_t.inax008 = a.inax008 AND inax_t.inax009 = a.inax009 ",
#                           "                       AND a.inaxent = ",g_enterprise,
#                           "                       AND a.inax001 <> '16' ",
#                           "                       AND a.inax002 IS NOT NULL ",
#                          #161227-00050#1 161228 by lori mod---(E) 
#                           "    AND EXISTS (SELECT 1 FROM inax_t b WHERE b.inaxent=a.inaxent AND a.inax008 =b.inax008 AND b.inax009 = a.inax009 AND a.inax001 = b.inax001 AND b.inax002 <> a.inax002 AND b.inax001 <> '16' AND b.inax002 IS NOT NULL )  ) "   
#                          
#               PREPARE aint700_sel_pre2 FROM l_sql
#               DECLARE aint700_sel_cs2 CURSOR FOR aint700_sel_pre2   
#               FOREACH aint700_sel_cs2 INTO l_indj001,l_indj002,l_indj010
#               
#                  LET l_inag009_1 = l_inag009_1 - l_indj010
#               END FOREACH
#               #当小于0时，预带值按inax_t表中在拣清单时间顺序将库存量分配于每张需求单的量来预带
#               LET l_sql = " SELECT DISTINCT inax001,inax002,inax003,inax004,inax005,inax006,inax007,inax008,inax009,inax010,inax011,inax012,inax013,inax014,inax015,inax016,inax017",
#                           "   FROM inax_t ",
#                           "  WHERE inaxent = ",g_enterprise," AND inax001 IN ('2','14','15')  ",
#                           "    AND inax002 IS NOT NULL ",
#                           "    AND inax017 = '",g_indiunit,"' AND inax010 = '",l_indj.indj004,"' AND inax011 = '",l_indj.indj005,"'",
#                           "    AND inax015 = '",l_indj.indj012,"' AND inax013 = '",l_indj.indj008,"' ", 
#                           "    AND NOT EXISTS (SELECT 1 FROM indj_t,indi_t  WHERE indjent = inaxent AND indient = indjent AND indidocno = indjdocno AND indistus <> 'X' AND indj001 = inax008 AND inax009 = indj002  )  ",
#                          #"    AND inax008||inax009 NOT IN (SELECT a.inax008||a.inax009 as docno FROM inax_t a  WHERE a.inaxent = ",g_enterprise," AND a.inax001 <> '16' AND a.inax002 IS NOT NULL ",  #mark by geza 20161221 #161221-00027#2
#                          #161227-00050#1 161228 by lori mod---(S)
#                          #"    AND NOT EXISTS (SELECT  1 FROM inax_t a  WHERE inax_t.inax008||inax_t.inax009 = a.inax008||a.inax009 AND a.inaxent = ",g_enterprise," AND a.inax001 <> '16' AND a.inax002 IS NOT NULL ", #add by geza 20161221 #161221-00027#2
#                           #170110-00032#1 -s mark by 08172
##                           "    AND NOT EXISTS (SELECT  1 FROM inax_t a ",
##                           "                     WHERE inax_t.inax008 = a.inax008 AND inax_t.inax009 = a.inax009 ",
##                           "                       AND a.inaxent = ",g_enterprise,
##                           "                       AND a.inax001 <> '16' ",
##                           "                       AND a.inax002 IS NOT NULL ", 
##                          #161227-00050#1 161228 by lori mod---(E)
##                           "    AND EXISTS (SELECT 1 FROM inax_t b WHERE b.inaxent=a.inaxent AND a.inax008 =b.inax008 AND b.inax009 = a.inax009 AND a.inax001 = b.inax001 AND b.inax002 <> a.inax002 AND b.inax001 <> '16' AND b.inax002 IS NOT NULL )  ) ",
#                           #170110-00032#1 -e mark by 08172
#                           "  ORDER BY inax003 "      
#               PREPARE aint700_sel_pre FROM l_sql
#               DECLARE aint700_sel_cs CURSOR FOR aint700_sel_pre   
#               FOREACH aint700_sel_cs INTO l_inax.inax001,l_inax.inax002,l_inax.inax003,
#                                           l_inax.inax004,l_inax.inax005,l_inax.inax006,l_inax.inax007,
#                                           l_inax.inax008,l_inax.inax009,l_inax.inax010,l_inax.inax011,
#                                           l_inax.inax012,l_inax.inax013,l_inax.inax014,l_inax.inax015,
#                                           l_inax.inax016,l_inax.inax017
#                  #未分配实际库存
#                  IF l_inag009_1 > 0 THEN
#                    IF l_inag009_1 < l_inax.inax014  THEN
#                       LET l_inax.inax014 = l_inag009_1
#                       LET l_inag009_1 = 0
#                    ELSE
#                       LET l_inag009_1 = l_inag009_1 - l_inax.inax014         
#                    END IF
#                  ELSE
#                     LET l_inax.inax014  = 0
#                  END IF
#                  IF l_inax.inax008 = l_pmcz.pmcz001 AND  l_inax.inax009 = l_pmcz.pmcz002 THEN
#                     LET l_indj.indj010  = l_inax.inax014
#                     LET l_indj.indj011 = l_indj.indj009 - l_indj.indj010   
#                  END IF
#               END FOREACH
#               #add by geza 20161212 #161110-00008#5(E)
#               #mark by geza 20170119 #170116-00018#2(E)
                
               #add by geza 20170119 #170116-00018#2(S)
               #先扣除aint705的占用量
               LET l_indj.indj010  = 0
               LET l_indj.indj011 = l_indj.indj009
               LET l_indj010 = 0
               LET l_sql = " SELECT DISTINCT indj001,indj002,indj010 ",
                           "   FROM inas_t,indj_t,indi_t ",
                           "  WHERE inasent = ",g_enterprise," ",
                           "    AND indjent = inasent AND indient = indjent AND indidocno = indjdocno AND indistus <> 'X' AND indj001 = inas001 AND inas002 = indj002  ",                
                           "    AND inassite = '",g_indiunit,"' AND inas009 = '",l_indj.indj004,"' AND inas010 = '",l_indj.indj005,"'",
                           "    AND inas013 = '",l_indj.indj008,"' "  
                         
               PREPARE aint700_sel_pre2 FROM l_sql
               DECLARE aint700_sel_cs2 CURSOR FOR aint700_sel_pre2   
               FOREACH aint700_sel_cs2 INTO l_indj001,l_indj002,l_indj010
               
                  LET l_inag009_1 = l_inag009_1 - l_indj010
               END FOREACH
               #当小于0时，预带值按inas_t表中在拣清单时间顺序将库存量分配于每张需求单的量来预带
               LET l_sql = " SELECT DISTINCT inassite,inas001,inas002,inas003,inas004,inas005,inas006,inas007,inas008,inas009,inas010,inas011,inas012,inas013,inas014,inas015,inas016,inas017 ",
                           "   FROM inas_t ",
                           "  WHERE inasent = ",g_enterprise,"  ",
                           "    AND inassite = '",g_indiunit,"' AND inas009 = '",l_indj.indj004,"' AND inas010 = '",l_indj.indj005,"'",
                           "    AND inas013 = '",l_indj.indj008,"' ", 
                           "    AND NOT EXISTS (SELECT 1 FROM indj_t,indi_t  WHERE indjent = inasent AND indient = indjent AND indidocno = indjdocno AND indistus <> 'X' AND indj001 = inas001 AND inas002 = indj002  )  ",
                           "  ORDER BY inas006 "      
               PREPARE aint700_sel_pre FROM l_sql
               DECLARE aint700_sel_cs CURSOR FOR aint700_sel_pre   
               FOREACH aint700_sel_cs INTO  l_inas.inassite,l_inas.inas001,l_inas.inas002,l_inas.inas003,
                                            l_inas.inas004,l_inas.inas005,l_inas.inas006,l_inas.inas007,
                                            l_inas.inas008,l_inas.inas009,l_inas.inas010,l_inas.inas011,
                                            l_inas.inas012,l_inas.inas013,l_inas.inas014,l_inas.inas015,
                                            l_inas.inas016,l_inas.inas017
                  #未分配实际库存
                  IF l_inag009_1 > 0 THEN
                    IF l_inag009_1 < l_inas.inas011  THEN
                       LET l_inas.inas011 = l_inag009_1
                       LET l_inag009_1 = 0
                    ELSE
                       LET l_inag009_1 = l_inag009_1 - l_inas.inas011
                    END IF
                  ELSE
                     LET l_inas.inas011  = 0
                  END IF
                  IF l_inas.inas001 = l_pmcz.pmcz001 AND  l_inas.inas002 = l_pmcz.pmcz002 THEN
                     LET l_indj.indj010  = l_inas.inas011
                     LET l_indj.indj011 = l_indj.indj009 - l_indj.indj010   
                  END IF
               END FOREACH
               #add by geza 20170119 #170116-00018#2(E)
                
            #add by geza 20161221 #161221-00027#2(S)
            ELSE
               LET l_indj.indj010  = l_indj.indj009
               LET l_indj.indj011 = 0
            END IF
            #add by geza 20161221 #161221-00027#2(E)    
         END IF
         #add by geza 20161130 #161129-00068#1(E)

         #add by geza 20161110 161110-00008#2(E)
         INSERT INTO indj_t (indjent,indjdocno,indj001,indj002,indjseq,
                             indj003,indj004  ,indj005,indj006,indj007,
                             indj008,indj009  ,indj010,indj012,indjunit,
                             indj015,indj016  ,indj011,indj018,indjsite,
                             indj020,   #160825-00021#3 Add By Ken 160825加需求對象欄位  indj020
                             indj021,   #161109-00078#3 Add By Ken 161114加拋單狀態
                             indj022,indj023)   #161220-00037#4 Add By Ken 161227
         VALUES(g_enterprise,g_indidocno,l_indj.indj001,l_indj.indj002,l_indj.indjseq,
            l_indj.indj003,l_indj.indj004,l_indj.indj005,l_indj.indj006,l_indj.indj007, 
            l_indj.indj008,l_indj.indj009,l_indj.indj010,l_indj.indj012,l_indj.indjunit,
            l_indj.indj015,l_indj.indj016,l_indj.indj011,l_indj.indj018,g_indisite,
            l_indj.indj020,   #160825-00021#3 Add By Ken 160825加需求對象欄位  indj020
            l_indj021,        #161109-00078#3 Add By Ken 161114加拋單狀態
            l_indj022,l_indj023)    #161220-00037#4 Add By Ken 161227
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "insert indj_t:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         #更新分配狀態
         LET l_pmcz061 = '21'
         CALL s_aint700_pmcz061_upd(l_pmcz061,g_indisite,l_pmcz.pmcz001,l_pmcz.pmcz002)
            RETURNING l_success 

         CALL s_aint700_modify_indk(g_type,g_indidocno,g_indisite,l_indj.*) 
            RETURNING l_success 
      END IF
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
# Descriptions...: 按查詢後把資料寫到tmp
# Memo...........:
# Usage..........: CALL aint700_02_gen_pmcz()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/8/26 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint700_02_gen_pmcz()
DEFINE l_sql             STRING
DEFINE l_where_sql       STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_pmdbsite        LIKE pmdb_t.pmdbsite
DEFINE l_pmcz            RECORD
       pmcz001           LIKE pmcz_t.pmcz001,     #需求單號
       pmcz027           LIKE pmcz_t.pmcz027,     #需求日期
       pmcz062           LIKE pmcz_t.pmcz062      #需求對象      
                         END RECORD

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   DELETE FROM aint700_02_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del aint700_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   
   LET l_where_sql = ''

   LET l_sql = "INSERT INTO aint700_02_tmp(sel,       pmcz001,      pmcz027,       pmcz062) ",
               "SELECT DISTINCT 'N',       pmcz001,   pmcz027,      pmcz062 ",
               "  FROM pmcz_t ",
               " WHERE pmczent  =",g_enterprise,
               "   AND pmcz042 = '",g_indiunit,"'"   #配送中心
               #"   AND pmcz027 = '",l_pmcz027,"'"     #需求日期 #mark by geza 20161219 161219-00001#5
   #add by geza 20161219 161219-00001#5(S)
   IF l_pmcz027 IS NOT NULL THEN
      LET l_sql = l_sql,"    AND pmcz027 = '",l_pmcz027,"' " 
   END IF
   #add by geza 20161219 161219-00001#5(E)            
   IF NOT cl_null(l_pmcz023) THEN
      LET l_sql = l_sql ,"   AND pmcz023 = '",l_pmcz023,"'"    #需求類型
   END IF
   LET l_sql = l_sql,"   AND pmcz060 = '1' ",         #結案碼：1
               "   AND pmcz063 = '",l_pmcz063,"'"     #需求對象類型   #160831-00068#2 Add By ken 160907
   IF NOT cl_null(l_imaa158) THEN   #160831-00068#7 Add By ken 160919 上市日不為空時再加上當條件         
      LET l_sql = l_sql ,"   AND EXISTS (SELECT 1 FROM imaa_t WHERE pmczent=imaaent AND pmcz004=imaa001 AND imaa158 = '",l_imaa158,"') "  #上市日期
   END IF   
   LET l_sql = l_sql,"   AND NOT EXISTS(SELECT 1 FROM indj_t,indi_t WHERE pmczent=indjent AND pmcz001=indj001 AND pmcz002=indj002 AND indient=indjent AND indidocno=indjdocno AND indistus<>'X') "  #170110-00032#1 add by 08172 
#   LET l_sql = l_sql,"   AND NOT EXISTS(SELECT 1 FROM indj_t WHERE pmczent = indjent AND pmcz001 = indj001 AND pmcz002 = indj002) "  #排除已存在配送單中  #160914-00015#1 Add by ken 160914  #170110-00032#1 mark by 08172

   
   LET l_sql = l_sql ," AND ",g_wc
   LET l_sql = l_sql ," ORDER BY pmcz001  "
   
   DISPLAY ' QBE SQL = ',l_sql
   
   PREPARE aint700_02_ins_tmp FROM l_sql
   EXECUTE aint700_02_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins aint700_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   CALL aint700_02_b_fill()
   
   LET g_rec_b = g_pmcz_d.getLength()
   #IF g_rec_b = 0 THEN   #161017-00051#3   2016/10/20  by   08742  mark
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'sub-01321'  #apm-00294   #160318-00005#38  By 07900--mod
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #END IF
   
   #161029-00003#1 -str-
   DELETE FROM aint700_02_tmp2
   LET l_sql = "INSERT INTO aint700_02_tmp2(pmcz001,pmcz027,pmcz062,pmcz004) ",
               "SELECT DISTINCT pmcz001,pmcz027,pmcz062,pmcz004 ",
               "  FROM pmcz_t ",
               " WHERE pmczent  =",g_enterprise,
               "   AND pmcz042 = '",g_indiunit,"'"   #配送中心
               #"   AND pmcz027 = '",l_pmcz027,"'"     #需求日期 #mark by geza 20161219 161219-00001#5
   #add by geza 20161219 161219-00001#5(S)
   IF l_pmcz027 IS NOT NULL THEN
      LET l_sql = l_sql,"    AND pmcz027 = '",l_pmcz027,"' " 
   END IF
   #add by geza 20161219 161219-00001#5(E)             
   IF NOT cl_null(l_pmcz023) THEN
      LET l_sql = l_sql ,"   AND pmcz023 = '",l_pmcz023,"'"    #需求類型
   END IF
   LET l_sql = l_sql,"   AND pmcz060 = '1' ",         #結案碼：1
               "   AND pmcz063 = '",l_pmcz063,"'"     #需求對象類型   #160831-00068#2 Add By ken 160907
   IF NOT cl_null(l_imaa158) THEN   #160831-00068#7 Add By ken 160919 上市日不為空時再加上當條件         
      LET l_sql = l_sql ,"   AND EXISTS (SELECT 1 FROM imaa_t WHERE pmczent=imaaent AND pmcz004=imaa001 AND imaa158 = '",l_imaa158,"') "  #上市日期
   END IF   
   LET l_sql = l_sql,"   AND NOT EXISTS(SELECT 1 FROM indj_t,indi_t WHERE pmczent=indjent AND pmcz001=indj001 AND pmcz002=indj002 AND indient=indjent AND indidocno=indjdocno AND indistus<>'X') "  #170110-00032#1 add by 08172
#   LET l_sql = l_sql,"   AND NOT EXISTS(SELECT 1 FROM indj_t WHERE pmczent = indjent AND pmcz001 = indj001 AND pmcz002 = indj002) "  #排除已存在配送單中  #160914-00015#1 Add by ken 160914 #170110-00032#1 mark by 08172
   LET l_sql = l_sql ," AND ",g_wc
   LET l_sql = l_sql ," ORDER BY pmcz001  "
   
   DISPLAY ' QBE SQL = ',l_sql
   
   PREPARE aint700_02_ins_tmp2 FROM l_sql
   EXECUTE aint700_02_ins_tmp2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins aint700_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   UPDATE aint700_02_tmp2 set pmcz004_desc=(select imaal003 FROM imaal_t 
                                          WHERE imaal001=pmcz004
                                            AND imaal002=g_dlang
                                            AND imaalent=g_enterprise)
   CALL aint700_02_b_fill2()
   
   LET g_rec_b2 = g_pmcz_d2.getLength()
   
   #161029-00003#1 -end-
   
END FUNCTION

################################################################################
# Descriptions...: 全選
# Memo...........:
# Usage..........: CALL aint700_02_check_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint700_02_check_all()
   UPDATE aint700_02_tmp SET sel = 'Y'
   CALL aint700_02_set_entry_b("a")
   CALL aint700_02_set_no_entry_b("a")    
   CALL aint700_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 全不選
# Memo...........:
# Usage..........: CALL aint700_02_check_no_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint700_02_check_no_all()
   UPDATE aint700_02_tmp SET sel = 'N'
   CALL aint700_02_set_entry_b("a")
   CALL aint700_02_set_no_entry_b("a")    
   CALL aint700_02_b_fill()
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
PRIVATE FUNCTION aint700_02_b_fill2()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

    CALL g_pmcz_d2.clear()
    LET l_ac2 = 1
    
    LET l_sql = "SELECT DISTINCT '',     '',     ",
                "       '',     '' ,pmcz004,pmcz004_desc              ",        
                "  FROM aint700_02_tmp2 ",
               # "  LEFT OUTER JOIN pmaal_t t1 ON t1.pmaalent = ",g_enterprise,
               # "                            AND t1.pmaal001 = pmcz062",
               # "                            AND t1.pmaal002 = '",g_dlang,"'",
                "  ORDER BY 5 "
    PREPARE aint700_02_pmcz_pb2 FROM l_sql
    DECLARE aint700_02_pmcz_cs2 CURSOR FOR aint700_02_pmcz_pb2
    FOREACH aint700_02_pmcz_cs2
       INTO g_pmcz_d2[l_ac2].pmcz001,g_pmcz_d2[l_ac2].pmcz027,      
            g_pmcz_d2[l_ac2].pmcz062,g_pmcz_d2[l_ac2].pmcz062_desc,
            g_pmcz_d2[l_ac2].pmcz004,g_pmcz_d2[l_ac2].pmcz004_desc
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach aint700_02_pmcz_cs2"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
       
             
       LET l_ac2 = l_ac2 + 1
       IF l_ac2 > g_max_rec AND g_error_show = 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  9035
          LET g_errparam.extend =  ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    
    CALL g_pmcz_d2.deleteElement(l_ac2) 
    LET l_ac2 = g_pmcz_d2.getLength() 
    LET g_rec_b2= g_pmcz_d2.getLength()    
END FUNCTION

 
{</section>}
 
