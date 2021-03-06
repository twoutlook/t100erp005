#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp540_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0020(2017-01-03 15:24:27), PR版次:0020(2017-02-13 16:34:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000326
#+ Filename...: axmp540_01
#+ Description: 待出貨資料
#+ Creator....: 02040(2014-06-09 11:18:46)
#+ Modifier...: 01534 -SD/PR- 05384
 
{</section>}
 
{<section id="axmp540_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160414-00002#2   2016/04/14  By 02040     效能調整
#160318-00025#22  2016/04/21  BY 07900     校验代码重复错误讯息的修改
#160801-00041#1   2016/08/09  BY 02097     “查看底稿”时未来出货数据中客户栏位未显示值
#160727-00019#23  2016/08/11  By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                           Mod   p540_01_lock_b_t --> p540_tmp01
#160706-00037#5   2016/10/24  By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#161109-00085#10  2016/11/10  By lienjunqi 整批調整系統星號寫法
#161207-00033#3   2016/12/20  By08992      一次性交易對象顯示說明，所以的客戶/供應商欄位都應該處理
#161006-00018#25  2016/12/26  By lixh      增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改
#170104-00066#3   2017/01/06  By Rainy     筆數相關變數由num5放大至num10
#161230-00019#5   2017/02/02  By shiun     引導式作業一次性交易對象處理，顯示一次性交易對象名稱
#161205-00025#15  2017/02/09  By shiun     效能調整
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../axm/4gl/axmp540_01.inc"
GLOBALS "../../axm/4gl/axmp540_02.inc"
#end add-point
 
{</section>}
 
{<section id="axmp540_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
                    
 TYPE type_g_xmdh_d RECORD
                    sel_01            LIKE type_t.chr1,                    #選擇
                    xmda004_01        LIKE xmda_t.xmda004,                 #客戶
                    xmda004_01_desc   LIKE type_t.chr500,
                    source_01         LIKE type_t.chr10,                   #來源單據1訂單2出貨通知單
                    xmdhdocno_01      LIKE xmdh_t.xmdhdocno,               #出通單單號
                    xmdhseq_01        LIKE xmdh_t.xmdhseq,                 #出通單項次                    
                    xmdh001_01        LIKE xmdh_t.xmdh001,                 #訂單單號
                    xmdadocdt_01      LIKE xmda_t.xmdadocdt,               #訂單日期
                    xmda002_01        LIKE xmda_t.xmda002,                 #業務員
                    xmda002_01_desc   LIKE type_t.chr500,                 
                    xmdh002_01        LIKE xmdh_t.xmdh002,                 #訂單項次
                    xmdh003_01        LIKE xmdh_t.xmdh003,                 #訂單項序
                    xmdh004_01        LIKE xmdh_t.xmdh004,                 #訂單分批序
                    xmda033_01        LIKE xmda_t.xmda033,                 #客戶訂購單號
                    xmdh005_01        LIKE xmdh_t.xmdh005,                 #子件特性
                    xmdh006_01        LIKE xmdh_t.xmdh006,
                    imaal003_01       LIKE imaal_t.imaal003,
                    imaal004_01       LIKE imaal_t.imaal004,
                    xmdh007_01        LIKE xmdh_t.xmdh007,
                    xmdh007_01_desc   LIKE type_t.chr500,
                    xmdh009_01        LIKE xmdh_t.xmdh009,
                    xmdh009_01_desc   LIKE type_t.chr500,
                    xmdh010_01        LIKE xmdh_t.xmdh010,
                    xmdh015_01        LIKE xmdh_t.xmdh015,
                    xmdh015_01_desc   LIKE type_t.chr500,
                    xmdc012_01        LIKE xmdc_t.xmdc012,
                    days_01           LIKE type_t.num5,                     #逾期天數
                    xmdh016_01        LIKE xmdh_t.xmdh016,
                    xmdh017_01        LIKE xmdh_t.xmdh017,
                    xmdh012_01        LIKE xmdh_t.xmdh012,
                    xmdh012_01_desc   LIKE type_t.chr500,
                    xmdh013_01        LIKE xmdh_t.xmdh013,
                    xmdh013_01_desc   LIKE type_t.chr500,
                    xmdh014_01        LIKE xmdh_t.xmdh014,
                    xmdh029_01        LIKE xmdh_t.xmdh029
                           END RECORD
 TYPE type_g_xmdh2_d RECORD
                    sel_02            LIKE type_t.chr1,                    #選擇
                    xmda004_02        LIKE xmda_t.xmda004,                 #客戶
                    xmda004_02_desc   LIKE type_t.chr500,
                    source_02         LIKE type_t.chr10,                   #來源單據1訂單2出貨通知單
                    xmdhdocno_02      LIKE xmdh_t.xmdhdocno,               #出通單單號
                    xmdhseq_02        LIKE xmdh_t.xmdhseq,                 #出通單項次                    
                    xmdh001_02        LIKE xmdh_t.xmdh001,                 #訂單單號
                    xmdadocdt_02      LIKE xmda_t.xmdadocdt,               #訂單日期
                    xmda002_02        LIKE xmda_t.xmda002,                 #業務員  
                    xmda002_02_desc   LIKE type_t.chr500,                     
                    xmdh002_02        LIKE xmdh_t.xmdh002,                 #訂單項次
                    xmdh003_02        LIKE xmdh_t.xmdh003,                 #訂單項序
                    xmdh004_02        LIKE xmdh_t.xmdh004,                 #訂單分批序
                    xmda033_02        LIKE xmda_t.xmda033,                 #客戶訂購單號
                    xmdh005_02        LIKE xmdh_t.xmdh005,
                    xmdh006_02        LIKE xmdh_t.xmdh006,
                    imaal003_02       LIKE imaal_t.imaal003,
                    imaal004_02       LIKE imaal_t.imaal004,
                    xmdh007_02        LIKE xmdh_t.xmdh007,
                    xmdh007_02_desc   LIKE type_t.chr500,
                    xmdh009_02        LIKE xmdh_t.xmdh009,
                    xmdh009_02_desc   LIKE type_t.chr500,
                    xmdh010_02        LIKE xmdh_t.xmdh010,
                    xmdh015_02        LIKE xmdh_t.xmdh015,
                    xmdh015_02_desc   LIKE type_t.chr500,
                    xmdc012_02        LIKE xmdc_t.xmdc012,
                    days_02           LIKE type_t.num5,                     #逾期天數
                    xmdh016_02        LIKE xmdh_t.xmdh016,
                    xmdh017_02        LIKE xmdh_t.xmdh017,
                    xmdh012_02        LIKE xmdh_t.xmdh012,
                    xmdh012_02_desc   LIKE type_t.chr500,
                    xmdh013_02        LIKE xmdh_t.xmdh013,
                    xmdh013_02_desc   LIKE type_t.chr500,
                    xmdh014_02        LIKE xmdh_t.xmdh014,
                    xmdh029_02        LIKE xmdh_t.xmdh029
                           END RECORD
   
DEFINE g_rec_b             LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_xmdh_d            DYNAMIC ARRAY OF type_g_xmdh_d
DEFINE g_xmdh_d_t          type_g_xmdh_d
DEFINE g_xmdh2_d           DYNAMIC ARRAY OF type_g_xmdh2_d
DEFINE g_xmdh2_d_t         type_g_xmdh2_d
DEFINE l_ac                LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_docno             LIKE xmdk_t.xmdkdocno
DEFINE g_xmdl_d   RECORD   
                  sel            LIKE type_t.chr1,                    
                  xmda004        LIKE xmda_t.xmda004,                
                  source         LIKE type_t.chr10,              
                  xmdl001        LIKE xmdl_t.xmdl001,       #出通單號
                  xmdl002        LIKE xmdl_t.xmdl002,       #出通項次           
                  xmdl003        LIKE xmdl_t.xmdl003,       #訂單單號
                  xmdadocdt      LIKE xmda_t.xmdadocdt,     #訂單日期
                  xmda002        LIKE xmda_t.xmda002,       #業務員
                  xmdl004        LIKE xmdl_t.xmdl004,       #項次
                  xmdl005        LIKE xmdl_t.xmdl005,       #項序
                  xmdl006        LIKE xmdl_t.xmdl006,       #分批序
                  xmda033        LIKE xmda_t.xmda033,       #客戶訂購單號
                  xmdl007        LIKE xmdl_t.xmdl007,       #子件特性
                  xmdl008        LIKE xmdl_t.xmdl008,       #料件編號
                  xmdl009        LIKE xmdl_t.xmdl009,       #產品特徵
                  xmdl011        LIKE xmdl_t.xmdl011,       #作業編號
                  xmdl012        LIKE xmdl_t.xmdl012,       #作業序
                  xmdl017        LIKE xmdl_t.xmdl017,       #單位
                  xmdc012        LIKE xmdc_t.xmdc012,       #約定交貨日
                  days           LIKE type_t.num5,          #逾期天數           
                  qua            LIKE xmdl_t.xmdl018,       #待出貨數量
                  xmdl018        LIKE xmdl_t.xmdl018,       #本次出貨量               
                  xmdl014        LIKE xmdl_t.xmdl014,       #庫位
                  xmdl015        LIKE xmdl_t.xmdl015,       #儲位
                  xmdl016        LIKE xmdl_t.xmdl016,       #批號
                  xmdl052        LIKE xmdl_t.xmdl052        #庫存管理特徵
                  END RECORD    
#end add-point
 
{</section>}
 
{<section id="axmp540_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmp540_01.other_dialog" >}

DIALOG axmp540_01_input01()
DEFINE l_inaa007  LIKE inaa_t.inaa007  #161006-00018#25

    INPUT ARRAY g_xmdh_d FROM s_detail1_axmp540_01.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)

      BEFORE INPUT
         LET g_current_page = 1
         
      BEFORE ROW             
         LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_axmp540_01")
         LET l_ac = g_detail_idx
         LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b()          
         
      ON CHANGE sel_01
         IF g_xmdh_d[l_ac].sel_01 = 'Y' THEN
            LET g_xmdh_d[l_ac].xmdh017_01 = g_xmdh_d[l_ac].xmdh016_01
         ELSE
             LET g_xmdh_d[l_ac].xmdh017_01 = 0
         END IF
         
      
      AFTER FIELD sel_01
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b() 
         
      AFTER FIELD xmdh017_01
         IF g_xmdh_d[l_ac].xmdh017_01 >  g_xmdh_d[l_ac].xmdh016_01 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axm-00364"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_xmdh_d[l_ac].xmdh017_01 = g_xmdh_d_t.xmdh017_01
            NEXT FIELD CURRENT
         END IF
         LET g_xmdh_d_t.xmdh017_01 = g_xmdh_d[l_ac].xmdh017_01 
         

      AFTER FIELD xmdh012_01
         CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
         IF NOT cl_null(g_xmdh_d[l_ac].xmdh012_01) THEN
            IF g_xmdh_d[l_ac].xmdh012_01 != g_xmdh_d_t.xmdh012_01 OR g_xmdh_d_t.xmdh012_01 IS NULL THEN
               IF NOT axmp540_01_chk_xmdh012(g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh012_01) THEN
                  LET g_xmdh_d[l_ac].xmdh012_01 = g_xmdh_d_t.xmdh012_01
                  CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
         #161006-00018#25-S
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b() 
         #161006-00018#25-E        
         LET g_xmdh_d_t.xmdh012_01 = g_xmdh_d[l_ac].xmdh012_01
      
      AFTER FIELD xmdh013_01
         CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
           RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
         #161006-00018#25-S
         LET l_inaa007 = '' 
         SELECT inaa007 INTO l_inaa007 FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = g_xmdh_d[l_ac].xmdh012_01
         IF l_inaa007 = '5' THEN
            LET g_xmdh_d[l_ac].xmdh013_01 = ' '
         ELSE
            IF g_xmdh_d[l_ac].xmdh013_01 = ' ' THEN
               LET g_xmdh_d[l_ac].xmdh013_01 = ''
            END IF            
         END IF  
         #161006-00018#25-E          
         IF NOT cl_null(g_xmdh_d[l_ac].xmdh013_01) THEN
            IF g_xmdh_d[l_ac].xmdh013_01 != g_xmdh_d_t.xmdh013_01 OR g_xmdh_d_t.xmdh013_01 IS NULL THEN
               IF NOT axmp540_01_chk_xmdh013(g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh012_01,
                                             g_xmdh_d[l_ac].xmdh013_01) THEN
                  LET g_xmdh_d[l_ac].xmdh013_01 = g_xmdh_d_t.xmdh013_01
                  CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
                    RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
                  NEXT FIELD CURRENT
               END IF             
            END IF
         END IF            
         LET g_xmdh_d_t.xmdh013_01 = g_xmdh_d[l_ac].xmdh013_01
      
      AFTER FIELD xmdh014_01
         IF NOT cl_null(g_xmdh_d[l_ac].xmdh014_01) THEN
            IF g_xmdh_d[l_ac].xmdh014_01 != g_xmdh_d_t.xmdh014_01 OR g_xmdh_d_t.xmdh014_01 IS NULL THEN 
               IF NOT  axmp540_01_chk_xmdh014(g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh012_01,
                                              g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh014_01) THEN
                  LET g_xmdh_d[l_ac].xmdh014_01 = g_xmdh_d_t.xmdh014_01
                  NEXT FIELD CURRENT                                              
               END IF                                              
            END IF
         END IF
         LET g_xmdh_d_t.xmdh014_01 = g_xmdh_d[l_ac].xmdh014_01

      ON ACTION controlp INFIELD xmdh012_01
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         #給予default值         
         LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012_01             
         LET g_qryparam.default2 = g_xmdh_d[l_ac].xmdh013_01
         LET g_qryparam.default3 = g_xmdh_d[l_ac].xmdh014_01
         LET g_qryparam.default4 = g_xmdh_d[l_ac].xmdh029_01
         #給予arg值
         LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006_01                      #料件
         LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007_01                      #產品特徵
         #呼叫開窗 
         CALL q_inag004_13() 
         #CALL q_inag004_1()                                                    
         #將開窗取得的值回傳到變數
         LET g_xmdh_d[l_ac].xmdh012_01 = g_qryparam.return1                      
         LET g_xmdh_d[l_ac].xmdh013_01 = g_qryparam.return2
         LET g_xmdh_d[l_ac].xmdh014_01 = g_qryparam.return3
         LET g_xmdh_d[l_ac].xmdh029_01 = g_qryparam.return4 
         #顯示到畫面上         
         DISPLAY g_xmdh_d[l_ac].xmdh012_01 TO xmdh012_01                         
         DISPLAY g_xmdh_d[l_ac].xmdh013_01 TO xmdh013_01
         DISPLAY g_xmdh_d[l_ac].xmdh014_01 TO xmdh014_01
         DISPLAY g_xmdh_d[l_ac].xmdh029_01 TO xmdh029_01           
         CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
         CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
         NEXT FIELD xmdh012_01          
         
      ON ACTION controlp INFIELD xmdh013_01
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         #給予default值         
         LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012_01             
         LET g_qryparam.default2 = g_xmdh_d[l_ac].xmdh013_01
         LET g_qryparam.default3 = g_xmdh_d[l_ac].xmdh014_01
         LET g_qryparam.default4 = g_xmdh_d[l_ac].xmdh029_01
         #給予arg值
         LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006_01                      #料件
         LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007_01                      #產品特徵
         #呼叫開窗 
         CALL q_inag004_13() 
         #CALL q_inag005_5()                                                    
         #將開窗取得的值回傳到變數
         LET g_xmdh_d[l_ac].xmdh012_01 = g_qryparam.return1                      
         LET g_xmdh_d[l_ac].xmdh013_01 = g_qryparam.return2
         LET g_xmdh_d[l_ac].xmdh014_01 = g_qryparam.return3
         LET g_xmdh_d[l_ac].xmdh029_01 = g_qryparam.return4 
         #顯示到畫面上         
         DISPLAY g_xmdh_d[l_ac].xmdh012_01 TO xmdh012_01                         
         DISPLAY g_xmdh_d[l_ac].xmdh013_01 TO xmdh013_01
         DISPLAY g_xmdh_d[l_ac].xmdh014_01 TO xmdh014_01
         DISPLAY g_xmdh_d[l_ac].xmdh029_01 TO xmdh029_01           
         CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
         CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
         NEXT FIELD xmdh013_01             
        
   END INPUT  

END DIALOG

DIALOG axmp540_01_construct()
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_sql      STRING
    
        CONSTRUCT g_wc ON xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdc012,xmdc001,imaf141
             FROM xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdc012,xmdc001,imaf141

            BEFORE CONSTRUCT
              CALL cl_qbe_init()
             
             #倉庫/庫位             
            ON ACTION controlp INFIELD xmdc028            
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa001_6()                          
               DISPLAY g_qryparam.return1 TO xmdc028  
               NEXT FIELD xmdc028                    

            #庫存標籤
            ON ACTION controlp INFIELD inac003          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '220'
               CALL q_oocq002_1()
               DISPLAY g_qryparam.return1 TO inac003    
               NEXT FIELD CURRENT
            
            #客戶
            ON ACTION controlp INFIELD xmda004          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pmaastus = 'Y' " 
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmda004
               NEXT FIELD xmda004
            
            #訂單編號
            ON ACTION controlp INFIELD xmdadocno        
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " xmdastus = 'Y' "
               CALL q_xmdadocno()
               DISPLAY g_qryparam.return1 TO xmdadocno
               NEXT FIELD xmdadocno
               
            #客戶訂購單號
            ON ACTION controlp INFIELD xmda033
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "xmdastus = 'Y'"
               CALL q_xmda033()
               DISPLAY g_qryparam.return1 TO xmda033
               NEXT FIELD xmda033

           #業務人員
            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       
               DISPLAY g_qryparam.return1 TO xmda002  
               NEXT FIELD xmda002                    
         

            #料件 
            ON ACTION controlp INFIELD xmdc001          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET l_sql = ''
               CALL s_control_get_sql("imaa001",'6','3',g_user,g_dept) RETURNING l_success,l_sql
               IF l_success THEN
                  LET g_qryparam.where = l_sql CLIPPED
               END IF
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO xmdc001
               NEXT FIELD xmdc001
            
            #採購分群
            ON ACTION controlp INFIELD imaf141          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()
               DISPLAY g_qryparam.return1 TO imaf141
               NEXT FIELD imaf141
         END CONSTRUCT
END DIALOG

DIALOG axmp540_01_input()
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_flag     LIKE type_t.num5
    DEFINE l_ooef004  LIKE ooef_t.ooef004    
    
    
         INPUT g_xmdk_m.xmdkdocno,g_xmdk_m.xmdk003,g_xmdk_m.xmdkdocdt FROM xmdkdocno,xmdk003,xmdkdocdt ATTRIBUTE(WITHOUT DEFAULTS)

               ON ACTION controlp INFIELD xmdkdocno
                      INITIALIZE g_qryparam.* TO NULL
                      LET g_qryparam.state = 'i'
                      LET g_qryparam.reqry = FALSE
                      #給予arg
                      LET l_ooef004 = ''
                      SELECT ooef004 INTO l_ooef004
                        FROM ooef_t
                       WHERE ooefent = g_enterprise
                         AND ooef001 = g_site
                         AND ooefstus = 'Y'
                      LET g_qryparam.arg1 = l_ooef004
                      LET g_qryparam.arg2 = 'axmt540'
                      CALL q_ooba002_1()                                             #呼叫開窗

                      LET g_xmdk_m.xmdkdocno = g_qryparam.return1          #將開窗取得的值回傳到變數
                      DISPLAY g_xmdk_m.xmdkdocno TO xmdkdocno              #顯示到畫面上
                      CALL s_aooi200_get_slip_desc(g_xmdk_m.xmdkdocno)
                           RETURNING g_xmdk_m.xmdkdocno_desc
                      DISPLAY g_xmdk_m.xmdkdocno_desc  TO xmdkdocno_desc
                      NEXT FIELD xmdkdocno
                      
                  ON ACTION controlp INFIELD xmdk003
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE         
                     LET g_qryparam.default1 = g_xmdk_m.xmdk003             #給予default值         
                     CALL q_ooag001()                                #呼叫開窗         
                     LET g_xmdk_m.xmdk003 = g_qryparam.return1              #將開窗取得的值回傳到變數         
                     DISPLAY g_xmdk_m.xmdk003 TO xmdk003              #顯示到畫面上         
                     CALL axmp540_01_xmdk003_ref(g_xmdk_m.xmdk003) 
                     NEXT FIELD xmdk003                          #返回原欄位


                      
               AFTER FIELD xmdkdocno
                  CALL s_aooi200_get_slip_desc(g_xmdk_m.xmdkdocno)
                    RETURNING g_xmdk_m.xmdkdocno_desc
                  DISPLAY g_xmdk_m.xmdkdocno_desc  TO xmdkdocno_desc
                  IF NOT cl_null(g_xmdk_m.xmdkdocno) THEN
                     #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
                     CALL s_control_chk_doc('1',g_xmdk_m.xmdkdocno,'2',g_user,g_dept,'','')
                          RETURNING l_success,l_flag
                     IF l_success THEN
                        IF NOT l_flag THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'axm-00015'
                           LET g_errparam.extend = g_xmdk_m.xmdkdocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        NEXT FIELD CURRENT
                     END IF

                     IF NOT s_aooi200_chk_slip(g_site,'',g_xmdk_m.xmdkdocno,'axmt540') THEN
                        CALL s_aooi200_get_slip_desc(g_xmdk_m.xmdkdocno)
                             RETURNING g_xmdk_m.xmdkdocno_desc
                        DISPLAY g_xmdk_m.xmdkdocno_desc  TO xmdkdocno_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
               AFTER FIELD xmdk003                    
                  CALL axmp540_01_xmdk003_ref(g_xmdk_m.xmdk003) 
                  IF NOT cl_null(g_xmdk_m.xmdk003) THEN              
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_xmdk_m.xmdk003
                     #160318-00025#22  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                     #160318-00025#22  by 07900 --add-end                     
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_ooag001") THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
            
         END INPUT 
END DIALOG

DIALOG axmp540_01_input02()
DEFINE  l_inaa007   LIKE inaa_t.inaa007  #161006-00018#25

   INPUT ARRAY g_xmdh2_d FROM s_detail2_axmp540_01.*
         ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
        
      BEFORE INPUT
         LET g_current_page = 2
         
      BEFORE ROW                 
         
         LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2_axmp540_01")
         LET l_ac = g_detail2_idx
         LET g_xmdh2_d_t.* = g_xmdh2_d[l_ac].*
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b()          
         
      ON CHANGE sel_02
         IF g_xmdh2_d[l_ac].sel_02 = 'Y' THEN
            LET g_xmdh2_d[l_ac].xmdh017_02 = g_xmdh2_d[l_ac].xmdh016_02
         ELSE
             LET g_xmdh2_d[l_ac].xmdh017_02 = 0
         END IF         
         
      AFTER FIELD sel_02
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b()   
         
      AFTER FIELD xmdh017_02
         IF g_xmdh2_d[l_ac].xmdh017_02 >  g_xmdh2_d[l_ac].xmdh016_02 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axm-00364"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_xmdh2_d[l_ac].xmdh017_02 = g_xmdh2_d_t.xmdh017_02
            NEXT FIELD CURRENT
         END IF  
         LET g_xmdh2_d_t.xmdh017_02 = g_xmdh2_d[l_ac].xmdh017_02 

      AFTER FIELD xmdh012_02
         CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02) RETURNING g_xmdh2_d[l_ac].xmdh012_02_desc
         IF NOT cl_null(g_xmdh2_d[l_ac].xmdh012_02) THEN
            IF g_xmdh2_d[l_ac].xmdh012_02 != g_xmdh2_d_t.xmdh012_02 OR g_xmdh2_d_t.xmdh012_02 IS NULL THEN
               IF NOT axmp540_01_chk_xmdh012(g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh012_02) THEN
                  LET g_xmdh2_d[l_ac].xmdh012_02 = g_xmdh2_d_t.xmdh012_02
                  CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02) RETURNING g_xmdh2_d[l_ac].xmdh012_02_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
         #161006-00018#25-S
         CALL axmp540_01_set_entry_b()
         CALL axmp540_01_set_no_entry_b() 
         #161006-00018#25-E          
         LET  g_xmdh2_d_t.xmdh012_02 = g_xmdh2_d[l_ac].xmdh012_02 
      
      AFTER FIELD xmdh013_02
         CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02) 
           RETURNING g_xmdh2_d[l_ac].xmdh013_02_desc
         #161006-00018#25-S
         LET l_inaa007 = '' 
         SELECT inaa007 INTO l_inaa007 FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = g_xmdh2_d[l_ac].xmdh012_02
         IF l_inaa007 = '5' THEN
            LET g_xmdh2_d[l_ac].xmdh013_02 = ' '
         ELSE
            IF g_xmdh2_d[l_ac].xmdh013_02 = ' ' THEN
               LET g_xmdh2_d[l_ac].xmdh013_02 = ''
            END IF            
         END IF  
         #161006-00018#25-E             
         IF NOT cl_null(g_xmdh2_d[l_ac].xmdh013_02) THEN
            IF g_xmdh2_d[l_ac].xmdh013_02 != g_xmdh2_d_t.xmdh013_02 OR g_xmdh2_d_t.xmdh013_02 IS NULL THEN
               IF NOT axmp540_01_chk_xmdh013(g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh012_02,
                                             g_xmdh2_d[l_ac].xmdh013_02) THEN
                  LET g_xmdh2_d[l_ac].xmdh013_02 = g_xmdh2_d_t.xmdh013_02
                  CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02) 
                    RETURNING g_xmdh2_d[l_ac].xmdh013_02_desc
                  NEXT FIELD CURRENT
               END IF                
            END IF
         END IF            
         LET  g_xmdh2_d_t.xmdh013_02 = g_xmdh2_d[l_ac].xmdh013_02
      
      AFTER FIELD xmdh014_02
         IF NOT cl_null(g_xmdh2_d[l_ac].xmdh014_02) THEN
            IF g_xmdh2_d[l_ac].xmdh014_02 != g_xmdh2_d_t.xmdh014_02 OR g_xmdh2_d_t.xmdh014_02 IS NULL THEN 
               IF NOT  axmp540_01_chk_xmdh014(g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh012_02,
                                              g_xmdh2_d[l_ac].xmdh013_02,g_xmdh2_d[l_ac].xmdh014_02) THEN
                  LET g_xmdh2_d[l_ac].xmdh014_02 = g_xmdh2_d_t.xmdh014_02
                  NEXT FIELD CURRENT                                              
               END IF                                             
            END IF
         END IF
         LET g_xmdh2_d_t.xmdh014_02 = g_xmdh2_d[l_ac].xmdh014_02         

      ON ACTION controlp INFIELD xmdh012_02
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE  
         #給予default值
         LET g_qryparam.default1 = g_xmdh2_d[l_ac].xmdh012_02            
         LET g_qryparam.default2 = g_xmdh2_d[l_ac].xmdh013_02
         LET g_qryparam.default3 = g_xmdh2_d[l_ac].xmdh014_02
         LET g_qryparam.default4 = g_xmdh2_d[l_ac].xmdh029_02  
         #給予arg值      
         LET g_qryparam.arg1 = g_xmdh2_d[l_ac].xmdh006_02                      #料件
         LET g_qryparam.arg2 = g_xmdh2_d[l_ac].xmdh007_02                      #產品特徵
         #CALL q_inag004_1()                                                             
         CALL q_inag004_13()  
         #將開窗取得的值回傳到變數         
         LET g_xmdh2_d[l_ac].xmdh012_02 = g_qryparam.return1                     
         LET g_xmdh2_d[l_ac].xmdh013_02 = g_qryparam.return2
         LET g_xmdh2_d[l_ac].xmdh014_02 = g_qryparam.return3
         LET g_xmdh2_d[l_ac].xmdh029_02 = g_qryparam.return4 
         #顯示到畫面上         
         DISPLAY g_xmdh2_d[l_ac].xmdh012_02 TO xmdh012_02                         
         DISPLAY g_xmdh2_d[l_ac].xmdh013_02 TO xmdh013_02
         DISPLAY g_xmdh2_d[l_ac].xmdh014_02 TO xmdh014_02
         DISPLAY g_xmdh2_d[l_ac].xmdh029_02 TO xmdh029_02           
         CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02) RETURNING g_xmdh2_d[l_ac].xmdh012_02_desc
         CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02) RETURNING g_xmdh2_d[l_ac].xmdh013_02_desc
         NEXT FIELD xmdh012_02          
         
      ON ACTION controlp INFIELD xmdh013_02               
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE  
         #給予default值
         LET g_qryparam.default1 = g_xmdh2_d[l_ac].xmdh012_02            
         LET g_qryparam.default2 = g_xmdh2_d[l_ac].xmdh013_02
         LET g_qryparam.default3 = g_xmdh2_d[l_ac].xmdh014_02
         LET g_qryparam.default4 = g_xmdh2_d[l_ac].xmdh029_02  
         #給予arg值      
         LET g_qryparam.arg1 = g_xmdh2_d[l_ac].xmdh006_02                      #料件
         LET g_qryparam.arg2 = g_xmdh2_d[l_ac].xmdh007_02                      #產品特徵
         #CALL q_inag005_5()                                                             
         CALL q_inag004_13()  
         #將開窗取得的值回傳到變數         
         LET g_xmdh2_d[l_ac].xmdh012_02 = g_qryparam.return1                     
         LET g_xmdh2_d[l_ac].xmdh013_02 = g_qryparam.return2
         LET g_xmdh2_d[l_ac].xmdh014_02 = g_qryparam.return3
         LET g_xmdh2_d[l_ac].xmdh029_02 = g_qryparam.return4 
         #顯示到畫面上         
         DISPLAY g_xmdh2_d[l_ac].xmdh012_02 TO xmdh012_02                         
         DISPLAY g_xmdh2_d[l_ac].xmdh013_02 TO xmdh013_02
         DISPLAY g_xmdh2_d[l_ac].xmdh014_02 TO xmdh014_02
         DISPLAY g_xmdh2_d[l_ac].xmdh029_02 TO xmdh029_02           
         CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02) RETURNING g_xmdh2_d[l_ac].xmdh012_02_desc
         CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02) RETURNING g_xmdh2_d[l_ac].xmdh013_02_desc
         NEXT FIELD xmdh013_02  
          
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="axmp540_01.other_function" readonly="Y" >}

PUBLIC FUNCTION axmp540_01(--)
   #add-point:input段變數傳入
   p_wc
   #end add-point
   )
   DEFINE p_wc       STRING
   DEFINE l_sql      STRING
   DEFINE l_sql01    STRING
   DEFINE l_sql02    STRING
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_slip     LIKE ooba_t.ooba001    #單別  
   DEFINE l_slip2    LIKE ooba_t.ooba001    #單別 
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_xmdk_d   RECORD 
          source    LIKE type_t.chr10,         #來源1訂單2出通單                   
          docno     LIKE xmdh_t.xmdhdocno,     #單號
          seq       LIKE xmdh_t.xmdhseq,       #項次
          seq1      LIKE xmdh_t.xmdhseq,       #項序
          seq2      LIKE xmdh_t.xmdhseq,       #分批序
          xmdadocdt LIKE xmda_t.xmdadocdt,     #訂單日期
          xmda004   LIKE xmda_t.xmda004,       #客戶
          xmda002   LIKE xmda_t.xmda002,       #業務員
          xmda033   LIKE xmda_t.xmda033,       #客戶訂購單號
          xmdc012   LIKE xmdc_t.xmdc012        #約定交貨日
          END RECORD    
   DEFINE  l_ship         LIKE xmdl_t.xmdl018       #未出貨數量
   DEFINE  l_qua_sql     STRING
   DEFINE  l_doc_wc      STRING
   
   DEFINE l_xmdd014  LIKE xmdd_t.xmdd014   
   DEFINE l_xmda028  LIKE xmda_t.xmda028   #161230-00019#5

   
   IF cl_null(p_wc) THEN
      LET p_wc = '1=1'
   END IF
   LET g_docno = g_xmdk_m.xmdkdocno
   
   #清空tmptable
   DELETE FROM p540_01_xmdh
   DELETE FROM p540_01_xmdh2
   DELETE FROM p540_01_tmp 
   
  #--160414-00002#2--add--(S)
   #抓取未確認的出貨單出貨數量
   LET l_qua_sql = "SELECT SUM(COALESCE(xmdl018,0)) FROM xmdk_t,xmdl_t",
               " WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               "   AND xmdkent = ",g_enterprise,
               "   AND xmdkstus NOT IN ('X','S') "
               
   #先查看出貨單別是否有和出通單勾稽
   IF cl_get_doc_para(g_enterprise,g_site,g_docno,'D-BAS-0062') = 'Y' THEN    #出貨單與出通單勾稽
      #撈出通單資料
      LET p_wc = cl_replace_str(p_wc,'xmdc028','xmdh012')
      LET p_wc = cl_replace_str(p_wc,'xmdc012','xmdd011')
      LET p_wc = cl_replace_str(p_wc,'xmdc001','xmdh006')
      
      LET l_sql = "SELECT     'N',  xmdg005,    '2',xmdhdocno,xmdhseq, ",
                  "       xmdh001,xmdgdocdt,xmdg002,  xmdh002,xmdh003, ",
                  "       xmdh004,  xmda033,xmdh005,  xmdh006,xmdh007, ",
                  "       xmdh009,  xmdh010,xmdh015,  xmdd011,      0, ",
                  #xmdh017實際出通數量-xmdh030已轉出貨數量
                  #161205-00025#15-s-mod
#                  "       nvl(xmdh017,0) - nvl(xmdh030,0),0, ",
                  "       nvl(xmdh017,0) - nvl(xmdh030,0) - ",
                  "       COALESCE((SELECT SUM(xmdl018) ",
                  "                   FROM xmdk_t,xmdl_t ",
                  "                  WHERE xmdkent = xmdlent ",
                  "                    AND xmdkdocno = xmdldocno ",
                  "                    AND xmdkent = ",g_enterprise,
                  "                    AND xmdkstus NOT IN ('X','S') ",
                  "                    AND xmdl001 = xmdhdocno ",
                  "                    AND xmdl002 = xmdhseq ),0) l_qua ,",
                  " 0, ",
                  #161205-00025#15-e-mod
                  "       xmdh012,  xmdh013,xmdh014, ",
                  "       xmdh029 ",
                  "      ,xmda028 ",   #161230-00019#5
                  "      ,xmdddocno ",   #161205-00025#15
                  "  FROM xmda_t,xmdd_t,xmdg_t,xmdh_t ",
                  "  LEFT JOIN imaf_t ON imafent = xmdhent AND imafsite = xmdhsite AND imaf001 = xmdh006 ",
                  "  LEFT JOIN inac_t ON inacent = xmdhent AND inacsite = xmdhsite AND inac001 = xmdh012 AND inac002 = xmdh013 ", 
                  " WHERE xmdaent = xmddent AND xmdadocno = xmdddocno ",                  
                  "   AND xmdgent = xmdhent AND xmdgdocno = xmdhdocno ",
                  "   AND xmddent = xmdhent AND xmdddocno = xmdh001 AND xmddseq = xmdh002 AND xmddseq1 = xmdh003 AND xmddseq2 = xmdh004 ",
                  "   AND xmdgent = ",g_enterprise,
                  "   AND xmdgsite = '",g_site,"' ",
                  "   AND xmdgstus = 'Y' ",
                  "   AND nvl(xmdh017,0) - nvl(xmdh030,0) > 0 ",
                  #161205-00025#15-s-mod
#                  "   AND ",p_wc,
#                  " ORDER BY xmdddocno,xmdhseq "
                  "   AND ",p_wc
      LET l_sql = "SELECT     'N',  xmdg005,    '2',xmdhdocno,xmdhseq, ",
                  "       xmdh001,xmdgdocdt,xmdg002,  xmdh002,xmdh003, ",
                  "       xmdh004,  xmda033,xmdh005,  xmdh006,xmdh007, ",
                  "       xmdh009,  xmdh010,xmdh015,  xmdd011,      0, ",
                  "         l_qua,        0,xmdh012,  xmdh013,xmdh014, ",
                  "       xmdh029,  xmda028 ",
                  "  FROM ( ",l_sql,") ",
                  " WHERE l_qua > 0 ",
                  " ORDER BY xmdddocno,xmdhseq "  
                  #161205-00025#15-e-mod

      #抓取未確認的出貨單出貨數量
#      LET l_qua_sql = l_qua_sql,"AND xmdl001 = ? AND xmdl002 = ?"   #161205-00025#15 mark
   
   ELSE
      CALL axmp540_01_doc_wc() RETURNING l_doc_wc      
      #撈訂單資料
      LET l_sql ="SELECT       'N',  xmda004,    '1',     '',      '', ",
                 "       xmdddocno,xmdadocdt,xmda002,xmddseq,xmddseq1, ",
                 "        xmddseq2,  xmda033,xmdc019,xmdc001, xmdc002, ",
                 "         xmdc004,  xmdc005,xmdd004,xmdd011,       0, ",
                 #xmdd006分批訂購數量-xmdd014已出貨量+xmdd016銷退換貨數量+xmdd034已簽退數量
                 #161205-00025#15-s-mod
                 "        nvl(xmdd006,0) - nvl(xmdd014,0) + nvl(xmdd016,0) + nvl(xmdd034,0) - ",
                 "       COALESCE((SELECT SUM(xmdl018) ",
                 "                   FROM xmdk_t,xmdl_t ",
                 "                  WHERE xmdkent = xmdlent ",
                 "                    AND xmdkdocno = xmdldocno ",
                 "                    AND xmdkent = ",g_enterprise,
                 "                    AND xmdkstus NOT IN ('X','S') ",
                 "                    AND xmdl003 = xmdddocno ",
                 "                    AND xmdl004 = xmddseq ",
                 "                    AND xmdl005 = xmddseq1 ",
                 "                    AND xmdl006 = xmddseq2 ),0) l_qua ,",
                 #161205-00025#15-e-mod
                 "        0,xmdc028,xmdc029, xmdc030, ",
                 "       xmdc057",
                 "      ,xmda028 ",   #161230-00019#5
                 "  FROM xmda_t,xmdc_t,xmdd_t",
                 " WHERE xmdaent = xmdcent AND xmdadocno = xmdcdocno ",
                 "   AND xmdcent = xmddent AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq ",
                 "   AND xmdaent = ",g_enterprise,
                 "   AND xmdasite = '",g_site,"' ",
                 "   AND xmdastus = 'Y' ",
                 "   AND xmda005 <> '5' ",   #需排捈訂單性質為'5'預先訂單
                 "   AND xmdc045 = '1' ",    #[T.訂單單身明細檔].[C.狀態碼]='1'                
                 "   AND nvl(xmdd006,0) - nvl(xmdd014,0) + nvl(xmdd016,0) + nvl(xmdd034,0) > 0 ",
                 #161205-00025#15-s-mod
#                 "   AND ",p_wc,"AND ",l_doc_wc,
#                 " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "
                 "   AND ",p_wc,"AND ",l_doc_wc                 
      LET l_sql ="SELECT       'N',  xmda004,    '1',     '',      '', ",
                 "       xmdddocno,xmdadocdt,xmda002,xmddseq,xmddseq1, ",
                 "        xmddseq2,  xmda033,xmdc019,xmdc001, xmdc002, ",
                 "         xmdc004,  xmdc005,xmdd004,xmdd011,       0, ",
                 "          l_qua ,        0,xmdc028,xmdc029, xmdc030, ",
                 "       xmdc057  ,  xmda028 ",
                 "  FROM ( ",l_sql,") ",
                 " WHERE l_qua > 0 ",
                 " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "
                 #161205-00025#15-e-mod

      #抓取未確認的出貨單出貨數量
#      LET l_qua_sql = l_qua_sql,"AND xmdl003 = ? AND xmdl004 = ? AND xmdl005 = ? AND xmdl006 = ?"   #161205-00025#15 mark
   END IF   
   
   PREPARE p540_01_prep FROM l_sql
   DECLARE p540_01_curs CURSOR FOR p540_01_prep 


#   PREPARE p540_01_prep03 FROM l_qua_sql   #161205-00025#15 mark
   

   INITIALIZE g_xmdl_d.* TO NULL
   #161109-00085#10-s
   #FOREACH p540_01_curs INTO g_xmdl_d.*
   FOREACH p540_01_curs 
   INTO g_xmdl_d.sel,g_xmdl_d.xmda004,g_xmdl_d.source,g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
        g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
        g_xmdl_d.xmdl006,g_xmdl_d.xmda033,g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
        g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
        g_xmdl_d.qua,g_xmdl_d.xmdl018,g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
        #161230-00019#5-s-mod
#        g_xmdl_d.xmdl052
        g_xmdl_d.xmdl052,l_xmda028
        #161230-00019#5-e-mod
   #161109-00085#10-e
     #161205-00025#15-s-mark
#     LET l_xmdd014 = 0
#     IF cl_get_doc_para(g_enterprise,g_site,g_docno,'D-BAS-0062') = 'N' THEN
#         
#         EXECUTE p540_01_prep03 USING g_xmdl_d.xmdl003,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,g_xmdl_d.xmdl006 INTO l_xmdd014
#     ELSE        
#         EXECUTE p540_01_prep03 USING g_xmdl_d.xmdl001,g_xmdl_d.xmdl002 INTO l_xmdd014
#     END IF
#     IF cl_null(l_xmdd014) THEN LET l_xmdd014 = 0 END IF
#     #調整待出貨數量，需扣掉出貨單未過帳之單據
#     LET g_xmdl_d.qua = g_xmdl_d.qua - l_xmdd014
#     IF g_xmdl_d.qua < = 0 THEN 
#        INITIALIZE g_xmdl_d.* TO NULL
#        CONTINUE FOREACH            
#     END IF  
     #161205-00025#15-e-mark
     #逾期天數
     LET g_xmdl_d.days = g_today - g_xmdl_d.xmdc012  
     IF g_xmdl_d.xmdc012 <= g_today THEN
        #待出貨資料
                
        #mod--161109-00085#10-s
        #INSERT INTO p540_01_xmdh VALUES (g_xmdl_d.*)        
        INSERT INTO p540_01_xmdh (sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                  xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                  xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                  xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                  xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                  #161230-00019#5-s-mod
#                                  xmdh029)
                                  xmdh029,xmda028)
                                  #161230-00019#5-e-mod
        VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
                #161230-00019#5-s-mod
#                g_xmdl_d.xmdl052)
                g_xmdl_d.xmdl052,l_xmda028)
                #161230-00019#5-e-mod
        #mod--161109-00085#10-e        
     ELSE   
        #未來出貨資料
        #mod--161109-00085#10-s
        #INSERT INTO p540_01_xmdh2 VALUES (g_xmdl_d.*)
        INSERT INTO p540_01_xmdh2(sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                  xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                  xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                  xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                  xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                  #161230-00019#5-s-mod
#                                  xmdh029)
                                  xmdh029,xmda028)
                                  #161230-00019#5-e-mod
        VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
                #161230-00019#5-s-mod
#                g_xmdl_d.xmdl052)
                g_xmdl_d.xmdl052,l_xmda028)
                #161230-00019#5-e-mod
        #mod--161109-00085#10-e        
     END IF        
   END FOREACH

  #--160414-00002#2--add--(E)
  

  #--160414-00002#2--mark--(S)   
  #LET l_sql = "SELECT        '',xmdddocno,xmddseq,xmddseq1,xmddseq2, ",
  #            "       xmdadocdt,  xmda004,xmda002, xmda033, xmdd011 ",
  #            "  FROM xmda_t,xmdc_t ",
  #            "  LEFT OUTER JOIN xmdd_t  ON xmddent = xmdcent AND xmdddocno = xmdcdocno AND xmddseq = xmdcseq ",
  #            "  LEFT OUTER JOIN imaf_t  ON imafent = xmdcent AND imafsite = xmdcsite AND imaf001 = xmdc001 ",
  #            "  LEFT OUTER JOIN inac_t  ON inacent = xmdcent AND inacsite = xmdcsite AND inac001 = xmdc028 AND inac002 = xmdc029 ",
  #            " WHERE xmdaent = '",g_enterprise,"' ",
  #            "   AND xmdasite = '",g_site,"' ",
  #            "   AND xmdaent = xmdcent ",
  #            "   AND xmdadocno = xmdcdocno ",                                                 
  #            "   AND xmdastus = 'Y' ",                                                      
  #            "   AND xmda005 <> '5' ",                            #需排捈訂單性質為'5'預先訂單
  #            "   AND xmdc045 = '1' ",                             #[T.訂單單身明細檔].[C.狀態碼]='1'                
  #            "   AND  ",p_wc        
  #               
  ##待出貨資料                
  #LET l_sql01 = l_sql, "   AND xmdd011 <= '",g_today,"' ",          #約定交貨日期 <= 今天  
  #              " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "                 
  ##未來出貨資料
  #LET l_sql02 = l_sql, "   AND xmdd011 > '",g_today,"' ",           #約定交貨日期 > 今天
  #             " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "                     
  #
  #
  #PREPARE p540_01_prep FROM l_sql01
  #DECLARE p540_01_curs CURSOR FOR p540_01_prep    
  #
  #PREPARE p540_01_prep02 FROM l_sql02
  #DECLARE p540_01_curs02 CURSOR FOR p540_01_prep02
  #
  #
  ##待出貨資料
  #INITIALIZE l_xmdk_d.* TO NULL
  #FOREACH p540_01_curs INTO l_xmdk_d.*
  #    INITIALIZE g_xmdl_d.* TO NULL
  #    LET g_xmdl_d.sel = 'N'                
  #    LET g_xmdl_d.xmdadocdt = l_xmdk_d.xmdadocdt              #訂單日期
  #    LET g_xmdl_d.xmda002 = l_xmdk_d.xmda002                  #業務人員
  #    LET g_xmdl_d.xmda004 = l_xmdk_d.xmda004                  #訂單客戶
  #    LET g_xmdl_d.xmda033 = l_xmdk_d.xmda033                  #客戶訂購單號
  #    LET g_xmdl_d.xmdc012 = l_xmdk_d.xmdc012                  #約定交貨日
  #    LET g_xmdl_d.days = g_today - g_xmdl_d.xmdc012           #逾期天數 
  #    LET g_xmdl_d.xmdl018 = g_xmdl_d.qua                      #本次出貨量
  #    
  #    #出貨單與出通單勾稽
  #    IF cl_get_doc_para(g_enterprise,g_site,g_docno,'D-BAS-0062') = 'Y' THEN
  #       #由訂單抓取出通單 
  #       IF NOT axmp540_01_get_xmdg('1',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #          INITIALIZE g_xmdl_d.* TO NULL
  #          CONTINUE FOREACH 
  #       END IF                     
  #    ELSE 
  #       CALL s_aooi200_get_slip(l_xmdk_d.docno) RETURNING l_success,l_slip    #取單別      
  #       #訂單是否需走出通單流程
  #       IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0077') = 'Y' THEN
  #          #由訂單抓取出通單 
  #          IF NOT axmp540_01_get_xmdg('1',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #             INITIALIZE g_xmdl_d.* TO NULL
  #             CONTINUE FOREACH 
  #          END IF
  #       ELSE             
  #          #抓取訂單
  #          LET l_xmdk_d.source = '1'
  #          IF NOT axmp540_01_get_xmda('1',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #             INITIALIZE g_xmdl_d.* TO NULL
  #             CONTINUE FOREACH 
  #          END IF                          
  #       END IF                                               
  #    END IF
  #END FOREACH  
  #
  ##未來出貨資料
  #INITIALIZE l_xmdk_d.* TO NULL
  #FOREACH p540_01_curs02 INTO l_xmdk_d.*
  #    INITIALIZE g_xmdl_d.* TO NULL
  #    LET g_xmdl_d.sel = 'N'  
  #
  #    LET g_xmdl_d.xmdadocdt = l_xmdk_d.xmdadocdt              #訂單日期
  #    LET g_xmdl_d.xmda002 = l_xmdk_d.xmda002                  #業務人員
  #    LET g_xmdl_d.xmda004 = l_xmdk_d.xmda004                  #訂單客戶
  #    LET g_xmdl_d.xmda033 = l_xmdk_d.xmda033                  #客戶訂購單號       
  #    LET g_xmdl_d.xmdc012 = l_xmdk_d.xmdc012                  #約定交貨日
  #    
  #    LET g_xmdl_d.days = g_today - g_xmdl_d.xmdc012           #逾期天數 
  #    LET g_xmdl_d.xmdl018 = g_xmdl_d.qua                      #本次出貨量
  #    
  #    #出貨單與出通單勾稽
  #    IF cl_get_doc_para(g_enterprise,g_site,g_docno,'D-BAS-0062') = 'Y' THEN
  #       #由訂單抓取出通單          
  #       IF NOT axmp540_01_get_xmdg('2',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #          INITIALIZE g_xmdl_d.* TO NULL
  #          CONTINUE FOREACH 
  #       END IF        
  #    ELSE
  #       CALL s_aooi200_get_slip(l_xmdk_d.docno) RETURNING l_success,l_slip    #取單別      
  #       #訂單是否需走出通單流程
  #       IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0077') = 'Y' THEN 
  #          #由訂單抓取出通單              
  #          IF NOT axmp540_01_get_xmdg('2',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #             INITIALIZE g_xmdl_d.* TO NULL
  #             CONTINUE FOREACH 
  #          END IF             
  #       ELSE
  #          #抓取訂單
  #          LET l_xmdk_d.source = '1'
  #          IF NOT axmp540_01_get_xmda('2',l_xmdk_d.docno,l_xmdk_d.seq,l_xmdk_d.seq1,l_xmdk_d.seq2) THEN
  #             INITIALIZE g_xmdl_d.* TO NULL
  #             CONTINUE FOREACH 
  #          END IF            
  #       END IF        
  #    END IF            
  #
  #END FOREACH   
  #--160414-00002#2--(E)
   

END FUNCTION
#畫面初始設定
PUBLIC FUNCTION axmp540_01_init()
   LET g_xmdk_m.xmdk003 = g_user
   LET g_xmdk_m.xmdkdocdt = cl_get_current()
   CALL axmp540_01_xmdk003_ref(g_xmdk_m.xmdk003) 
   DISPLAY BY NAME g_xmdk_m.xmdk003,g_xmdk_m.xmdkdocdt
   CALL cl_set_combo_scc("source_01","3020")
   CALL cl_set_combo_scc("source_02","3020")
   CALL cl_set_combo_scc("xmdh005_01","2055")
   CALL cl_set_combo_scc("xmdh005_02","2055")
END FUNCTION
#建立table
PUBLIC FUNCTION axmp540_01_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   CREATE TEMP TABLE p540_01_xmdh(                        #待出貨資料                   
                    sel           VARCHAR(1),
                    xmda004       VARCHAR(10),                 
                    source        VARCHAR(1), 
                    xmdhdocno     VARCHAR(20),
                    xmdhseq       INTEGER,                    
                    xmdh001       VARCHAR(20),
                    xmdadocdt     DATE,
                    xmda002       VARCHAR(20),
                    xmdh002       INTEGER,
                    xmdh003       INTEGER,
                    xmdh004       INTEGER,
                    xmda033       VARCHAR(20),
                    xmdh005       VARCHAR(10),
                    xmdh006       VARCHAR(40),
                    xmdh007       VARCHAR(256),
                    xmdh009       VARCHAR(10),
                    xmdh010       VARCHAR(10),
                    xmdh015       VARCHAR(10),
                    xmdc012       DATE,
                    days          SMALLINT,              
                    xmdh016       DECIMAL(20,6),
                    xmdh017       DECIMAL(20,6),                 
                    xmdh012       VARCHAR(10),
                    xmdh013       VARCHAR(10),
                    xmdh014       VARCHAR(30),
                    xmdh029       VARCHAR(30),
                    xmda028       VARCHAR(20))        #161230-00019#5 add xmda028
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p540_01_xmdh'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF                    

   CREATE TEMP TABLE p540_01_xmdh2(                        #未來出貨資料    
                    sel           VARCHAR(1),
                    xmda004       VARCHAR(10),                 
                    source        VARCHAR(1), 
                    xmdhdocno     VARCHAR(20),
                    xmdhseq       INTEGER,                    
                    xmdh001       VARCHAR(20),
                    xmdadocdt     DATE,
                    xmda002       VARCHAR(20),
                    xmdh002       INTEGER,
                    xmdh003       INTEGER,
                    xmdh004       INTEGER,
                    xmda033       VARCHAR(20),
                    xmdh005       VARCHAR(10),
                    xmdh006       VARCHAR(40),
                    xmdh007       VARCHAR(256),
                    xmdh009       VARCHAR(10),
                    xmdh010       VARCHAR(10),
                    xmdh015       VARCHAR(10),
                    xmdc012       DATE,
                    days          SMALLINT,              
                    xmdh016       DECIMAL(20,6),
                    xmdh017       DECIMAL(20,6),                 
                    xmdh012       VARCHAR(10),
                    xmdh013       VARCHAR(10),
                    xmdh014       VARCHAR(30),
                    xmdh029       VARCHAR(30),
                    xmda028       VARCHAR(20))        #161230-00019#5 add xmda028
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p540_01_xmdh2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF  
 
   CREATE TEMP TABLE p540_01_tmp(                             #出貨資料(底稿)
                    type          VARCHAR(1),                 #類型：1待出資料2未來出貨資料         
                    source        VARCHAR(10),                #來源單據：1訂單2出通單               
                    docno         VARCHAR(20),            #訂單單號/出通單單號
                    seq           INTEGER,              #訂單項次/出通單項次
                    xmdl005       INTEGER,              #訂單項序
                    xmdl006       INTEGER,              #訂單分批序
                    xmdl008       VARCHAR(40),              #出貨量
                    xmdl014       VARCHAR(10),              #庫位
                    xmdl015       VARCHAR(10),              #儲位
                    xmdl016       VARCHAR(30),              #批號
                    xmdl052       VARCHAR(30),              #庫存管理特徵
                    linkno        SMALLINT)                 #匯總後單頭和單身link_no

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p540_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   #160120-00002#4 s983961--add(s)
   CREATE TEMP TABLE p540_tmp01(            #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
      xmdhdocno             VARCHAR(20),      #出通單單號
      xmdhseq               INTEGER,        #出通單項次
      xmdh001               VARCHAR(20),        #訂單單號
      xmdhseq1              INTEGER,        #訂單項次
      xmdhseq2              INTEGER,        #訂單項序
      xmdhseq3              INTEGER     #訂單分批序
      )
   #160120-00002#4 s983961--add(e)   
   RETURN r_success   
END FUNCTION

PUBLIC FUNCTION axmp540_01_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   DROP TABLE p540_01_xmdh;
   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p540_01_xmdh'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
    
   DROP TABLE p540_01_xmdh2;
   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p540_01_xmdh2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE p540_01_tmp;
   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p540_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF      
   
   #160120-00002#4 s983961--add(s)
   DROP TABLE p540_tmp01            #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
   #160120-00002#4 s983961--add(e)
   
   RETURN r_success
END FUNCTION
#採購人員顯示
PRIVATE FUNCTION axmp540_01_xmdk003_ref(p_xmdk003)
DEFINE p_xmdk003      LIKE xmdk_t.xmdk003
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdk003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET g_xmdk_m.xmdk003_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_xmdk_m.xmdk003_desc
END FUNCTION
#寫入底稿
PUBLIC FUNCTION axmp540_01_save()
   DEFINE i     LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_cnt   LIKE type_t.num10  #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_flag  LIKE type_t.chr1
   #160120-00002#4 s983961--add(s)
   DEFINE l_sql       STRING
   DEFINE l_where     STRING
   DEFINE l_sql_cho   LIKE type_t.num5
   DEFINE l_xmdhdocno LIKE xmdh_t.xmdhdocno
   DEFINE l_xmdhseq   LIKE xmdh_t.xmdhseq
   DEFINE l_xmdh001   LIKE xmdh_t.xmdh001
   DEFINE l_xmdhseq1  LIKE xmdh_t.xmdh002
   DEFINE l_xmdhseq2  LIKE xmdh_t.xmdh003
   DEFINE l_xmdhseq3  LIKE xmdh_t.xmdh004
   #160120-00002#4 s983961--add(e)

   
   #用來判斷是否有資料被寫入 
   LET l_flag = 'N'

   #如果畫面上沒有資料的話，就不必實做寫入底稿的動作 
   IF g_xmdh_d.getLength() = 0 AND g_xmdh2_d.getLength() = 0 THEN
      RETURN
   END IF   
   
   #將待出貨資料寫入
   FOR i = 1 TO g_xmdh_d.getLength()
       #未勾選不需寫入底稿
       IF g_xmdh_d[i].sel_01 = 'N' THEN
          CONTINUE FOR
       END IF 
       #將勾選的資料寫入出貨底稿中       
       CASE g_xmdh_d[i].source_01 
         WHEN '1' #訂單
           INSERT INTO  p540_01_tmp(   type, source,  docno,    seq,xmdl005,
                                    xmdl006,xmdl008,xmdl014,xmdl015,xmdl016,
                                    xmdl052,linkno)
                  VALUES('1',g_xmdh_d[i].source_01,g_xmdh_d[i].xmdh001_01,g_xmdh_d[i].xmdh002_01,g_xmdh_d[i].xmdh003_01,
                          g_xmdh_d[i].xmdh004_01,g_xmdh_d[i].xmdh017_01,g_xmdh_d[i].xmdh012_01,g_xmdh_d[i].xmdh013_01,g_xmdh_d[i].xmdh014_01,
                          g_xmdh_d[i].xmdh029_01,0) 
           #160120-00002#4 s983961--add(s)  
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM p540_tmp01                 #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
            WHERE xmdh001 = g_xmdh_d[i].xmdh001_01
              AND xmdhseq1  = g_xmdh_d[i].xmdh002_01
              AND xmdhseq2  = g_xmdh_d[i].xmdh003_01
              AND xmdhseq3  = g_xmdh_d[i].xmdh004_01
           IF cl_null(l_cnt) OR l_cnt = 0 THEN
              INSERT INTO p540_tmp01(xmdh001,xmdhseq1,xmdhseq2,xmdhseq3)           #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01 
              VALUES(g_xmdh_d[i].xmdh001_01,g_xmdh_d[i].xmdh002_01,g_xmdh_d[i].xmdh003_01,g_xmdh_d[i].xmdh004_01)
           END IF
           #160120-00002#4 s983961--add(e)                        
         WHEN '2' #出通單
           INSERT INTO  p540_01_tmp(   type, source,  docno,    seq,
                                    xmdl008,xmdl014,xmdl015,xmdl016,
                                    xmdl052,linkno)
                  VALUES('1',g_xmdh_d[i].source_01,g_xmdh_d[i].xmdhdocno_01,g_xmdh_d[i].xmdhseq_01,
                          g_xmdh_d[i].xmdh017_01,g_xmdh_d[i].xmdh012_01,g_xmdh_d[i].xmdh013_01,g_xmdh_d[i].xmdh014_01,
                          g_xmdh_d[i].xmdh029_01,0)      
           #160120-00002#4 s983961--add(s)  
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM p540_tmp01             #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01 
            WHERE xmdhdocno = g_xmdh_d[i].xmdhdocno_01
              AND xmdhseq   = g_xmdh_d[i].xmdhseq_01
           IF cl_null(l_cnt) OR l_cnt = 0 THEN
              INSERT INTO p540_tmp01(xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3)           #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01 
              VALUES(g_xmdh_d[i].xmdhdocno_01,g_xmdh_d[i].xmdhseq_01,g_xmdh_d[i].xmdh001_01,g_xmdh_d[i].xmdh002_01,g_xmdh_d[i].xmdh003_01,g_xmdh_d[i].xmdh004_01)
           END IF
           #160120-00002#4 s983961--add(e)                                   
       END CASE
       LET l_flag = 'Y'                            
   END FOR
    
   
   #將未來出貨資料寫入
   FOR i = 1 TO g_xmdh2_d.getLength()
       #未勾選不需寫入底稿
       IF g_xmdh2_d[i].sel_02 = 'N' THEN
          CONTINUE FOR
       END IF
       #將勾選的資料寫入出貨底稿中
       CASE g_xmdh2_d[i].source_02  
         WHEN '1'          #訂單
           INSERT INTO  p540_01_tmp(   type, source,  docno,    seq,xmdl005,
                                    xmdl006,xmdl008,xmdl014,xmdl015,xmdl016,
                                    xmdl052,linkno)
                 VALUES('2',g_xmdh2_d[i].source_02,g_xmdh2_d[i].xmdh001_02,g_xmdh2_d[i].xmdh002_02,g_xmdh2_d[i].xmdh003_02,
                        g_xmdh2_d[i].xmdh004_02,g_xmdh2_d[i].xmdh017_02,g_xmdh2_d[i].xmdh012_02,g_xmdh2_d[i].xmdh013_02,g_xmdh2_d[i].xmdh014_02,
                        g_xmdh2_d[i].xmdh029_02,0)    
           #160120-00002#4 s983961--add(s)  
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM p540_tmp01                                                     #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
            WHERE xmdh001 = g_xmdh2_d[i].xmdh001_02
              AND xmdhseq1  = g_xmdh2_d[i].xmdh002_02
              AND xmdhseq2  = g_xmdh2_d[i].xmdh003_02
              AND xmdhseq3  = g_xmdh2_d[i].xmdh004_02
           IF cl_null(l_cnt) OR l_cnt = 0 THEN
              INSERT INTO p540_tmp01(xmdh001,xmdhseq1,xmdhseq2,xmdhseq3)         #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
              VALUES(g_xmdh2_d[i].xmdh001_02,g_xmdh2_d[i].xmdh002_02,g_xmdh2_d[i].xmdh003_02,g_xmdh2_d[i].xmdh004_02)
           END IF
           #160120-00002#4 s983961--add(e)                                     
         WHEN '2'          #出通單
           INSERT INTO  p540_01_tmp(   type, source,  docno,    seq,
                                    xmdl008,xmdl014,xmdl015,xmdl016,
                                    xmdl052,linkno)
                 VALUES('2',g_xmdh2_d[i].source_02,g_xmdh2_d[i].xmdhdocno_02,g_xmdh2_d[i].xmdhseq_02,
                        g_xmdh2_d[i].xmdh017_02,g_xmdh2_d[i].xmdh012_02,g_xmdh2_d[i].xmdh013_02,g_xmdh2_d[i].xmdh014_02,
                        g_xmdh2_d[i].xmdh029_02,0)  
           #160120-00002#4 s983961--add(s)  
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM p540_tmp01                              #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
            WHERE xmdhdocno = g_xmdh2_d[i].xmdhdocno_02
              AND xmdhseq   = g_xmdh2_d[i].xmdhseq_02
           IF cl_null(l_cnt) OR l_cnt = 0 THEN        
              INSERT INTO p540_tmp01(xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3)   #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
              VALUES(g_xmdh2_d[i].xmdhdocno_02,g_xmdh2_d[i].xmdhseq_02,g_xmdh2_d[i].xmdh001_02,g_xmdh2_d[i].xmdh002_02,g_xmdh2_d[i].xmdh003_02,g_xmdh2_d[i].xmdh004_02)
           END IF
           #160120-00002#4 s983961--add(e)                               
      END CASE                        
      LET l_flag = 'Y'     
   END FOR
   
   #mark--160706-00037#12 By shiun--(S)
#   #160120-00002#4 20160217 by s983961--add(s)
#   #訂單
#   LET l_sql = "SELECT xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
#               "  FROM p540_tmp01 ",        #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
#               " WHERE xmdhdocno IS NULL ",
#               " ORDER BY xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
#   PREPARE axmp540_lock_prep FROM l_sql
#   DECLARE axmp540_lock_curs CURSOR FOR axmp540_lock_prep
#
#   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
#            "  FROM xmdd_t ",
#            " WHERE "   
#   LET l_where = ''
#   FOREACH axmp540_lock_curs INTO l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3     
#        IF cl_null(l_where) THEN
#           LET l_where = "(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"'  AND xmddent = '",g_enterprise,"')"
#        ELSE
#           LET l_where = l_where," OR ","(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"'  AND xmddent = '",g_enterprise,"')"
#        END IF         
#   END FOREACH   
#
#   LET l_sql = l_sql,l_where," FOR UPDATE "
#   PREPARE axmp540_lock_body_prep FROM l_sql 
#   DECLARE axmp540_lock_body_curs CURSOR FOR axmp540_lock_body_prep
#   OPEN axmp540_lock_body_curs
#   
#   #出通單
#   LET l_sql = ''
#   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
#               "  FROM p540_tmp01 ",            #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
#               " WHERE xmdhdocno IS NOT NULL ",
#               " ORDER BY xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
#   PREPARE axmp540_lock2_prep FROM l_sql
#   DECLARE axmp540_lock2_curs CURSOR FOR axmp540_lock2_prep
#   
#   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004 ",
#                 "  FROM xmdh_t ",
#                 " WHERE "       
#                 
#   LET l_where = ''
#   LET l_xmdh001 = ''
#   LET l_xmdhseq1 = ''
#   LET l_xmdhseq2 = ''
#   LET l_xmdhseq3 = ''
#   FOREACH axmp540_lock2_curs INTO l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3     
#      IF cl_null(l_where) THEN
#         LET l_where = "(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"'  AND xmdhent = '",g_enterprise,"')"
#      ELSE
#         LET l_where = l_where," OR ","(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"'  AND xmdhent = '",g_enterprise,"')"
#      END IF 
#   END FOREACH   
#
#   LET l_sql = l_sql,l_where," FOR UPDATE "
#   PREPARE axmp540_lock2_body_prep FROM l_sql 
#   DECLARE axmp540_lock2_body_curs CURSOR FOR axmp540_lock2_body_prep
#   OPEN axmp540_lock2_body_curs   
#   #160120-00002#4 20160217 by s983961--add(e)  
   #mark--160706-00037#12 By shiun--(E)
   
   #有資料寫入 要提示user資料寫入底稿成功 
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("axm-00327")   #出貨資料(底稿)寫入成功！  
   END IF   
END FUNCTION
#查看出貨(底稿)
PUBLIC FUNCTION axmp540_01_b_fill_tmp()
   DEFINE l_sql     STRING
   DEFINE l_ac_t    LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_docno   LIKE xmdh_t.xmdh001
   DEFINE l_seq     LIKE xmdh_t.xmdh002
   DEFINE l_seq2    LIKE xmdh_t.xmdh003
   DEFINE l_seq3    LIKE xmdh_t.xmdh004
   DEFINE l_xmda028 LIKE xmda_t.xmda028   #161230-00019#5
   DEFINE l_pmak003 LIKE pmak_t.pmak003   #161230-00019#5
   INITIALIZE g_xmdh_d TO NULL
    
   #待出貨資料
   
   #160414-00002#2--mark(S)
   #LET l_sql = "SELECT 'N', ",
   #            "        source,  docno,    seq,xmdl005,xmdl006, ",
   #            "       xmdl008,xmdl014,xmdl015,xmdl016,xmdl052 ",
   #            "  FROM p540_01_tmp ",
   #            " WHERE type = '1' ",             #待出貨資料
   #            " ORDER BY source,docno,seq,xmdl005,xmdl006 "                  
   #160414-00002#2--mark(E)            
   
   #160414-00002#2--add(S)            
   LET l_sql = "SELECT 'N', ",
               "        source,  docno,    seq,xmdl005,xmdl006, ",
               "       xmdl008,xmdl014,xmdl015,xmdl016,xmdl052, ",
               "       t7.inayl003,t8.inab003 ",
               "  FROM p540_01_tmp ",
               "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdl014 AND t7.inayl002='"||g_dlang||"' ",
               "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdl014 AND t8.inab002=xmdl015  ",                              
               " WHERE type = '1' ",             #待出貨資料
               " ORDER BY source,docno,seq,xmdl005,xmdl006 "                 
   #160414-00002#2--add(E)            
               
   PREPARE axmp540_xmdh_tmp_pr FROM l_sql
   DECLARE axmp540_xmdh_tmp_cs CURSOR FOR axmp540_xmdh_tmp_pr
   LET l_ac_t = l_ac
   LET l_ac = 1
   
   
   #160414-00002#2--add(S)
   LET l_sql = "SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009, ",
               "       xmdh010,xmdh015,xmdc012,days,xmdh016, ",
               "       xmdh029,xmda002,xmda033,xmdadocdt, ",
               "       t1.pmaal004,t2.ooag011,t3.imaal003,t3.imaal004,t5.oocql004,t6.oocal003",
               "      ,xmda028 ",   #161230-00019#5
               "  FROM p540_01_xmdh ",
               "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
               "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
               "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
               "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",               
               " WHERE source = ? ",
               "   AND xmdh001 = ? ",
               "   AND xmdh002 = ? ",
               "   AND xmdh003 = ? ",
               "   AND xmdh004 = ? "
   PREPARE axmp540_xmdh_tmp_pr03 FROM l_sql


   LET l_sql = "SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009, ",
               "       xmdh010,xmdh015,xmdc012,days,xmdh016, ",
               "       xmdh029,xmda002,xmda033,xmdadocdt, ",
               "       t1.pmaal004,t2.ooag011,t3.imaal003,t3.imaal004,t5.oocql004,t6.oocal003",
               "      ,xmda028 ",   #161230-00019#5
               "  FROM p540_01_xmdh ",
               "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
               "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
               "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
               "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",               
               " WHERE source = ? ",
               "   AND xmdhdocno = ? ",
               "   AND xmdhseq = ? "
   PREPARE axmp540_xmdh_tmp_pr04 FROM l_sql

  #160414-00002#2--add(E)    
   
   
  #160414-00002#2--mark(S)
  #FOREACH axmp540_xmdh_tmp_cs INTO g_xmdh_d[l_ac].sel_01,
  #                                 g_xmdh_d[l_ac].source_01,l_docno,l_seq,l_seq2,l_seq3, 
  #                                 g_xmdh_d[l_ac].xmdh017_01,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh014_01,
  #                                 g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01_desc
  #160414-00002#2--mark(E)
    
   #160414-00002#2--add(S)
    FOREACH axmp540_xmdh_tmp_cs INTO g_xmdh_d[l_ac].sel_01,
                                     g_xmdh_d[l_ac].source_01,l_docno,l_seq,l_seq2,l_seq3, 
                                     g_xmdh_d[l_ac].xmdh017_01,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh014_01,
                                     g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01_desc
   #160414-00002#2--add(E) 
                                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp540_xmdh_tmp_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
      IF g_xmdh_d[l_ac].source_01 = '1' THEN              #1訂單
         LET g_xmdh_d[l_ac].xmdh001_01 = l_docno
         LET g_xmdh_d[l_ac].xmdh002_01 = l_seq
         LET g_xmdh_d[l_ac].xmdh003_01 = l_seq2
         LET g_xmdh_d[l_ac].xmdh004_01 = l_seq3
         
        #160414-00002#2--mark(S)
        #SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009,
        #       xmdh010,xmdh015,xmdc012,days,xmdh016,
        #       xmdh029,xmda002,xmda033,xmdadocdt
        #  INTO g_xmdh_d[l_ac].xmda004_01,g_xmdh_d[l_ac].xmdh005_01,g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh009_01,
        #       g_xmdh_d[l_ac].xmdh010_01,g_xmdh_d[l_ac].xmdh015_01,g_xmdh_d[l_ac].xmdc012_01,g_xmdh_d[l_ac].days_01,g_xmdh_d[l_ac].xmdh016_01,
        #       g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmda002_01,g_xmdh_d[l_ac].xmda033_01,g_xmdh_d[l_ac].xmdadocdt_01
        #  FROM p540_01_xmdh
        # WHERE source = g_xmdh_d[l_ac].source_01
        #   AND xmdh001 = g_xmdh_d[l_ac].xmdh001_01
        #   AND xmdh002 = g_xmdh_d[l_ac].xmdh002_01 
        #   AND xmdh003 = g_xmdh_d[l_ac].xmdh003_01
        #   AND xmdh004 = g_xmdh_d[l_ac].xmdh004_01 
        #160414-00002#2--mark(E)
         
        #160414-00002#2--add(S)   
         LET l_xmda028 = ''   #161230-00019#5
         EXECUTE axmp540_xmdh_tmp_pr03 USING g_xmdh_d[l_ac].source_01,g_xmdh_d[l_ac].xmdh001_01,g_xmdh_d[l_ac].xmdh002_01,g_xmdh_d[l_ac].xmdh003_01,g_xmdh_d[l_ac].xmdh004_01 
            INTO g_xmdh_d[l_ac].xmda004_01,g_xmdh_d[l_ac].xmdh005_01,g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh009_01,
                 g_xmdh_d[l_ac].xmdh010_01,g_xmdh_d[l_ac].xmdh015_01,g_xmdh_d[l_ac].xmdc012_01,g_xmdh_d[l_ac].days_01,g_xmdh_d[l_ac].xmdh016_01,
                 g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmda002_01,g_xmdh_d[l_ac].xmda033_01,g_xmdh_d[l_ac].xmdadocdt_01,
                 g_xmdh_d[l_ac].xmda004_01_desc,g_xmdh_d[l_ac].xmda002_01_desc,g_xmdh_d[l_ac].imaal003_01,g_xmdh_d[l_ac].imaal004_01,g_xmdh_d[l_ac].xmdh009_01_desc,g_xmdh_d[l_ac].xmdh015_01_desc                 
                ,l_xmda028   #161230-00019#5
        #160414-00002#2--add(E)       
      ELSE
         LET g_xmdh_d[l_ac].xmdhdocno_01 = l_docno
         LET g_xmdh_d[l_ac].xmdhseq_01 = l_seq
         
        #160414-00002#2--mark(S)          
        #SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009,
        #       xmdh010,xmdh015,xmdc012,days,xmdh016,
        #       xmdh029,xmda002,xmda033,xmdadocdt,xmdh001,
        #       xmdh002,xmdh003,xmdh004
        #  INTO g_xmdh_d[l_ac].xmda004_01,g_xmdh_d[l_ac].xmdh005_01,g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh009_01,
        #       g_xmdh_d[l_ac].xmdh010_01,g_xmdh_d[l_ac].xmdh015_01,g_xmdh_d[l_ac].xmdc012_01,g_xmdh_d[l_ac].days_01,g_xmdh_d[l_ac].xmdh016_01,
        #       g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmda002_01,g_xmdh_d[l_ac].xmda033_01,g_xmdh_d[l_ac].xmdadocdt_01,g_xmdh_d[l_ac].xmdh001_01,
        #       g_xmdh_d[l_ac].xmdh002_01,g_xmdh_d[l_ac].xmdh003_01,g_xmdh_d[l_ac].xmdh004_01
        #  FROM p540_01_xmdh
        # WHERE source = g_xmdh_d[l_ac].source_01
        #   AND xmdhdocno = g_xmdh_d[l_ac].xmdhdocno_01
        #   AND xmdhseq = g_xmdh_d[l_ac].xmdhseq_01
        #160414-00002#2--mark(E)
         
        #160414-00002#2--add(S)   
         LET l_xmda028 = ''   #161230-00019#5
         EXECUTE axmp540_xmdh_tmp_pr04 USING g_xmdh_d[l_ac].source_01,g_xmdh_d[l_ac].xmdhdocno_01,g_xmdh_d[l_ac].xmdhseq_01
            INTO g_xmdh_d[l_ac].xmda004_01,g_xmdh_d[l_ac].xmdh005_01,g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh009_01,
                 g_xmdh_d[l_ac].xmdh010_01,g_xmdh_d[l_ac].xmdh015_01,g_xmdh_d[l_ac].xmdc012_01,g_xmdh_d[l_ac].days_01,g_xmdh_d[l_ac].xmdh016_01,
                 g_xmdh_d[l_ac].xmdh029_01,g_xmdh_d[l_ac].xmda002_01,g_xmdh_d[l_ac].xmda033_01,g_xmdh_d[l_ac].xmdadocdt_01,
                 g_xmdh_d[l_ac].xmda004_01_desc,g_xmdh_d[l_ac].xmda002_01_desc,g_xmdh_d[l_ac].imaal003_01,g_xmdh_d[l_ac].imaal004_01,g_xmdh_d[l_ac].xmdh009_01_desc,g_xmdh_d[l_ac].xmdh015_01_desc                 
                ,l_xmda028   #161230-00019#5
        #160414-00002#2--add(E)       
      END IF    
      #161230-00019#5-s-add
      IF NOT cl_null(l_xmda028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(l_xmda028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdh_d[l_ac].xmda004_01_desc = l_pmak003
         END IF
      END IF
      #161230-00019#5-e-add
      CALL axmp540_01_detail_show("'1'")  
        
      LET l_ac = l_ac + 1
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
    END FOREACH
    LET g_detail_cnt = l_ac - 1      
    CALL g_xmdh_d.deleteElement(l_ac)
    LET l_ac = l_ac_t
    CLOSE axmp540_xmdh_tmp_cs
    FREE axmp540_xmdh_tmp_pr
   
    #未來出貨資料
    INITIALIZE g_xmdh2_d TO NULL

   #160414-00002#2--mark(S)
   #LET l_sql = "SELECT 'N', ",
   #            "        source,  docno,    seq,xmdl005,xmdl006, ",
   #            "       xmdl008,xmdl014,xmdl015,xmdl016,xmdl052 ",
   #            "  FROM p540_01_tmp ",
   #            " WHERE type = '2' ",             
   #            " ORDER BY source,docno,seq,xmdl005,xmdl006 "         
   #160414-00002#2--mark(E)             

   #160414-00002#2--add(S)            
   LET l_sql = "SELECT 'N', ",
               "        source,  docno,    seq,xmdl005,xmdl006, ",
               "       xmdl008,xmdl014,xmdl015,xmdl016,xmdl052, ",
               "       t7.inayl003,t8.inab003 ",
               "  FROM p540_01_tmp ",
               "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdl014 AND t7.inayl002='"||g_dlang||"' ",
               "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdl014 AND t8.inab002=xmdl015  ",                              
               " WHERE type = '2' ",            
               " ORDER BY source,docno,seq,xmdl005,xmdl006 "                 
   #160414-00002#2--add(E)                 
    PREPARE axmp540_xmdh2_tmp_pr FROM l_sql
    DECLARE axmp540_xmdh2_tmp_cs CURSOR FOR axmp540_xmdh2_tmp_pr
    LET l_ac_t = l_ac
    LET l_ac = 1
    
   #160414-00002#2--add(S)
   LET l_sql = "SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009, ",
               "       xmdh010,xmdh015,xmdc012,days,xmdh016, ",
               "       xmdh029,xmda002,xmda033,xmdadocdt, ",
               "       t1.pmaal004,t2.ooag011,t3.imaal003,t3.imaal004,t5.oocql004,t6.oocal003",
               "      ,xmda028 ",   #161230-00019#5
              #"  FROM p540_02_xmdh ",          #160801-00041#1 mark
               "  FROM p540_01_xmdh2 ",         #160801-00041#1
               "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
               "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
               "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
               "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",               
               " WHERE source = ? ",
               "   AND xmdh001 = ? ",
               "   AND xmdh002 = ? ",
               "   AND xmdh003 = ? ",
               "   AND xmdh004 = ? "
   PREPARE axmp540_xmdh_tmp_pr05 FROM l_sql


   LET l_sql = "SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009, ",
               "       xmdh010,xmdh015,xmdc012,days,xmdh016, ",
               "       xmdh029,xmda002,xmda033,xmdadocdt, ",
               "       t1.pmaal004,t2.ooag011,t3.imaal003,t3.imaal004,t5.oocql004,t6.oocal003",
               "      ,xmda028 ",   #161230-00019#5
              #"  FROM p540_02_xmdh ",          #160801-00041#1 mark
               "  FROM p540_01_xmdh2 ",         #160801-00041#1
               "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
               "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
               "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
               "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",               
               " WHERE source = ? ",
               "   AND xmdhdocno = ? ",
               "   AND xmdhseq = ? "
   PREPARE axmp540_xmdh_tmp_pr06 FROM l_sql

   #160414-00002#2--add(E)       
    
   #160414-00002#2--mark(S)
   #FOREACH axmp540_xmdh2_tmp_cs INTO g_xmdh2_d[l_ac].sel_02,
   #                                  g_xmdh2_d[l_ac].source_02,l_docno,l_seq,l_seq2,l_seq3, 
   #                                  g_xmdh2_d[l_ac].xmdh017_02,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02,g_xmdh2_d[l_ac].xmdh014_02,
   #                                  g_xmdh2_d[l_ac].xmdh029_02
   #160414-00002#2--mark(E)  
   #160414-00002#2--add(S)
    FOREACH axmp540_xmdh2_tmp_cs INTO g_xmdh2_d[l_ac].sel_02,
                                      g_xmdh2_d[l_ac].source_02,l_docno,l_seq,l_seq2,l_seq3, 
                                      g_xmdh2_d[l_ac].xmdh017_02,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02,g_xmdh2_d[l_ac].xmdh014_02,
                                      g_xmdh2_d[l_ac].xmdh029_02,g_xmdh2_d[l_ac].xmdh012_02_desc,g_xmdh2_d[l_ac].xmdh013_02_desc
   #160414-00002#2--add(E)    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp540_xmdh_tmp_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
      IF g_xmdh2_d[l_ac].source_02 = '1' THEN              #1訂單
         LET g_xmdh2_d[l_ac].xmdh001_02 = l_docno
         LET g_xmdh2_d[l_ac].xmdh002_02 = l_seq
         LET g_xmdh2_d[l_ac].xmdh003_02 = l_seq2
         LET g_xmdh2_d[l_ac].xmdh004_02 = l_seq3
        
        #160414-00002#2--mark(S) 
        #SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009,
        #       xmdh010,xmdh015,xmdc012,days,xmdh016,
        #       xmdh029,xmda002,xmda033,xmdadocdt
        #  INTO g_xmdh2_d[l_ac].xmda004_02,g_xmdh2_d[l_ac].xmdh005_02,g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh009_02,
        #       g_xmdh2_d[l_ac].xmdh010_02,g_xmdh2_d[l_ac].xmdh015_02,g_xmdh2_d[l_ac].xmdc012_02,g_xmdh2_d[l_ac].days_02,g_xmdh2_d[l_ac].xmdh016_02,
        #       g_xmdh2_d[l_ac].xmdh029_02,g_xmdh2_d[l_ac].xmda002_02,g_xmdh2_d[l_ac].xmda033_02,g_xmdh2_d[l_ac].xmdadocdt_02
        #  FROM p540_01_xmdh2
        # WHERE source = g_xmdh2_d[l_ac].source_02
        #   AND xmdh001 = g_xmdh2_d[l_ac].xmdh001_02
        #   AND xmdh002 = g_xmdh2_d[l_ac].xmdh002_02 
        #   AND xmdh003 = g_xmdh2_d[l_ac].xmdh003_02
        #   AND xmdh004 = g_xmdh2_d[l_ac].xmdh004_02   
        #160414-00002#2--mark(E)             
        
        #160414-00002#2--add(S)   
         LET l_xmda028 = ''   #161230-00019#5
         EXECUTE axmp540_xmdh_tmp_pr05 USING g_xmdh2_d[l_ac].source_02,g_xmdh2_d[l_ac].xmdh001_02,g_xmdh2_d[l_ac].xmdh002_02,g_xmdh2_d[l_ac].xmdh003_02,g_xmdh2_d[l_ac].xmdh004_02 
            INTO g_xmdh2_d[l_ac].xmda004_02,g_xmdh2_d[l_ac].xmdh005_02,g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh009_02,
                 g_xmdh2_d[l_ac].xmdh010_02,g_xmdh2_d[l_ac].xmdh015_02,g_xmdh2_d[l_ac].xmdc012_02,g_xmdh2_d[l_ac].days_02,g_xmdh2_d[l_ac].xmdh016_02,
                 g_xmdh2_d[l_ac].xmdh029_02,g_xmdh2_d[l_ac].xmda002_02,g_xmdh2_d[l_ac].xmda033_02,g_xmdh2_d[l_ac].xmdadocdt_02,
                 g_xmdh2_d[l_ac].xmda004_02_desc,g_xmdh2_d[l_ac].xmda002_02_desc,g_xmdh2_d[l_ac].imaal003_02,g_xmdh2_d[l_ac].imaal004_02,g_xmdh2_d[l_ac].xmdh009_02_desc,g_xmdh2_d[l_ac].xmdh015_02_desc                 
                ,l_xmda028   #161230-00019#5
        #160414-00002#2--add(E)         
      ELSE
         LET g_xmdh2_d[l_ac].xmdhdocno_02 = l_docno
         LET g_xmdh2_d[l_ac].xmdhseq_02 = l_seq        
        #160414-00002#2--mark(S)          
        #SELECT xmda004,xmdh005,xmdh006,xmdh007,xmdh009,
        #       xmdh010,xmdh015,xmdc012,days,xmdh016,
        #       xmdh029,xmda002,xmda033,xmdadocdt,xmdh001,
        #       xmdh002,xmdh003,xmdh004
        #  INTO g_xmdh2_d[l_ac].xmda004_02,g_xmdh2_d[l_ac].xmdh005_02,g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh009_02,
        #       g_xmdh2_d[l_ac].xmdh010_02,g_xmdh2_d[l_ac].xmdh015_02,g_xmdh2_d[l_ac].xmdc012_02,g_xmdh2_d[l_ac].days_02,g_xmdh2_d[l_ac].xmdh016_02,
        #       g_xmdh2_d[l_ac].xmdh029_02,g_xmdh2_d[l_ac].xmda002_02,g_xmdh2_d[l_ac].xmda033_02,g_xmdh2_d[l_ac].xmdadocdt_02,g_xmdh2_d[l_ac].xmdh001_02,
        #       g_xmdh2_d[l_ac].xmdh002_02,g_xmdh2_d[l_ac].xmdh003_02,g_xmdh2_d[l_ac].xmdh004_02
        #  FROM p540_01_xmdh2
        # WHERE source = g_xmdh2_d[l_ac].source_02
        #   AND xmdhdocno = g_xmdh2_d[l_ac].xmdhdocno_02
        #   AND xmdhseq = g_xmdh2_d[l_ac].xmdhseq_02        
        #160414-00002#2--mark(E)             
        
        #160414-00002#2--add(S)   
         LET l_xmda028 = ''   #161230-00019#5
         EXECUTE axmp540_xmdh_tmp_pr06 USING g_xmdh2_d[l_ac].source_02,g_xmdh2_d[l_ac].xmdhdocno_02,g_xmdh2_d[l_ac].xmdhseq_02
            INTO g_xmdh2_d[l_ac].xmda004_02,g_xmdh2_d[l_ac].xmdh005_02,g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh009_02,
                 g_xmdh2_d[l_ac].xmdh010_02,g_xmdh2_d[l_ac].xmdh015_02,g_xmdh2_d[l_ac].xmdc012_02,g_xmdh2_d[l_ac].days_02,g_xmdh2_d[l_ac].xmdh016_02,
                 g_xmdh2_d[l_ac].xmdh029_02,g_xmdh2_d[l_ac].xmda002_02,g_xmdh2_d[l_ac].xmda033_02,g_xmdh2_d[l_ac].xmdadocdt_02,
                 g_xmdh2_d[l_ac].xmda004_02_desc,g_xmdh2_d[l_ac].xmda002_02_desc,g_xmdh2_d[l_ac].imaal003_02,g_xmdh2_d[l_ac].imaal004_02,g_xmdh2_d[l_ac].xmdh009_02_desc,g_xmdh2_d[l_ac].xmdh015_02_desc                 
                ,l_xmda028   #161230-00019#5
        #160414-00002#2--add(E)         
      END IF        
      #161230-00019#5-s-add
      IF NOT cl_null(l_xmda028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(l_xmda028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdh2_d[l_ac].xmda004_02_desc = l_pmak003
         END IF
      END IF
      #161230-00019#5-e-add
      CALL axmp540_01_detail_show("'2'")  
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF     
    END FOREACH
    LET g_detail2_cnt = l_ac - 1             
    CALL g_xmdh2_d.deleteElement(l_ac)
    LET l_ac = l_ac_t
    CLOSE axmp540_xmdh2_tmp_cs
    FREE axmp540_xmdh2_tmp_pr   
END FUNCTION
#單身顯示
PUBLIC FUNCTION axmp540_01_b_fill()
   DEFINE l_sql    STRING
   DEFINE l_ac_t   LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_cnt    LIKE type_t.num5
   #160120-00002#4 s983961--add(s)
   DEFINE l_xmdddocno LIKE xmdh_t.xmdhdocno
   DEFINE l_xmddseq   LIKE xmdh_t.xmdhseq
   DEFINE l_xmddseq1  LIKE xmdh_t.xmdh002
   DEFINE l_xmddseq2  LIKE xmdh_t.xmdh003
   #160120-00002#4 s983961--add(e)
   #add--160706-00037#5 By shiun--(S)
   DEFINE l_xmdhdocno LIKE xmdh_t.xmdhdocno #出通單號
   DEFINE l_xmdhseq   LIKE xmdh_t.xmdhseq
   DEFINE l_xmdh001   LIKE xmdh_t.xmdh001   #訂單單號
   DEFINE l_xmdhseq1  LIKE xmdh_t.xmdh002
   DEFINE l_xmdhseq2  LIKE xmdh_t.xmdh003
   DEFINE l_xmdhseq3  LIKE xmdh_t.xmdh004
   #add--160706-00037#5 By shiun--(E)
   DEFINE r_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#3 add
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   DEFINE l_sql1           STRING                                    #161207-00033#3 add
   INITIALIZE g_xmdh_d TO NULL    
    ##160414-00002#2--mark(S)
    #待出貨資料
    #LET l_sql = "SELECT     sel,xmda004,       '', source,xmdhdocno, ", 
    #            "       xmdhseq,xmdh001,xmdadocdt,xmda002,       '', ",
    #            "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
    #            "       xmdh006,     '',       '',xmdh007,       '', ",
    #            "       xmdh009,     '',  xmdh010,xmdh015,       '', ",
    #            "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
    #            "            '',xmdh013,       '',xmdh014,  xmdh029  ",
    #            "  FROM p540_01_xmdh ",             
    #            " ORDER BY days DESC" 
    #PREPARE axmp540_sel_xmdh_pr FROM l_sql
    #DECLARE axmp540_sel_xmdh_cs CURSOR FOR axmp540_sel_xmdh_pr   
    #LET l_ac_t = l_ac    
    #LET l_ac = 1        
    #160414-00002#2-mark(E)
    
    
    #160414-00002#2--add(S)效能改善
    #待出貨資料

    LET l_sql = "SELECT     sel,xmda004,t1.pmaal004, source,xmdhdocno, ",
                "       xmdhseq,xmdh001,xmdadocdt,xmda002,t2.ooag011, ",
                "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
                "       xmdh006,t3.imaal003,t3.imaal004,xmdh007,       '', ",
                "       xmdh009,t5.oocql004,  xmdh010,xmdh015,t6.oocal003, ",
                "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
                "       t7.inayl003,xmdh013,t8.inab003,xmdh014,  xmdh029  ",             
                "  FROM p540_01_xmdh ",
                "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
                "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
                "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
                "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
                "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
                "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdh012 AND t7.inayl002='"||g_dlang||"' ",
                "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdh012 AND t8.inab002=xmdh013  ",                
                "  WHERE source = '1' ",
                "    AND xmdh001||xmdh002||xmdh003||xmdh004 NOT IN      ",
                "        (SELECT docno||seq||xmdl005||xmdl006 FROM p540_01_tmp ",    
                "          WHERE type = '1' AND source = '1')         ",                
                "UNION ",
                "SELECT     sel,xmda004,t1.pmaal004, source,xmdhdocno, ",
                "       xmdhseq,xmdh001,xmdadocdt,xmda002,t2.ooag011, ",
                "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
                "       xmdh006,t3.imaal003,t3.imaal004,xmdh007,       '', ",
                "       xmdh009,t5.oocql004,  xmdh010,xmdh015,t6.oocal003, ",
                "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
                "       t7.inayl003,xmdh013,t8.inab003,xmdh014,  xmdh029  ",                
                "  FROM p540_01_xmdh ",
                "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
                "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
                "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
                "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
                "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
                "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdh012 AND t7.inayl002='"||g_dlang||"' ",
                "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdh012 AND t8.inab002=xmdh013  ",                 
                "  WHERE source = '2' ",  
                "    AND xmdhdocno||xmdhseq NOT IN      ",
                "        (SELECT docno||seq FROM p540_01_tmp ",    
                "          WHERE type = '1' AND source = '2')         ",                 
                " ORDER BY days DESC" 
    PREPARE axmp540_sel_xmdh_pr FROM l_sql
    DECLARE axmp540_sel_xmdh_cs CURSOR FOR axmp540_sel_xmdh_pr
    
    
    LET l_ac_t = l_ac    
    LET l_ac = 1    
    
     LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ", 
                 "  FROM xmdd_t ", 
                 " WHERE xmddent = '",g_enterprise,"' ", 
                 "   AND xmdddocno = ? ",
                 "   AND xmddseq   = ? ",
                 "   AND xmddseq1  = ? ",
                 "   AND xmddseq2  = ? ",
                 "   FOR UPDATE SKIP LOCKED " 
     PREPARE axmp540_01_chk_locked_xmdd_prep FROM l_sql  

     #mod--160706-00037#5 By shiun--(S)
    #LET l_sql = " SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002 ", 
     LET l_sql = " SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004 ", 
     #mod--160706-00037#5 By shiun--(E)
                 "   FROM xmdh_t ", 
                 "  WHERE xmdhent   = '",g_enterprise,"' ", 
                 "    AND xmdhdocno = ? ",
                 "    AND xmdhseq   = ? ",
#                 "    AND xmdh001  = ? ",   #160706-00037#5 mark
#                 "    AND xmdh002  = ? ",   #160706-00037#5 mark
#                 "    AND xmdh003  = ? ",   #160706-00037#5 mark
#                 "    AND xmdh004  = ? ",   #160706-00037#5 mark
                 "    FOR UPDATE SKIP LOCKED " 
     PREPARE axmp540_01_chk_locked_prep FROM l_sql
    #160414-00002#2--add(E)效能改善
    #161207-00033#3-s add
    LET l_sql1 = "SELECT pmaa004 FROM pmaa_t        ",
               " WHERE pmaaent ='",g_enterprise,"'",
               "   AND pmaa001 = ?  "
    PREPARE axmp540_pb FROM l_sql1
    #161207-00033#3-e add
    #161109-00085#10-s
    #FOREACH axmp540_sel_xmdh_cs INTO g_xmdh_d[l_ac].* 
    FOREACH axmp540_sel_xmdh_cs 
    INTO  g_xmdh_d[l_ac].sel_01,g_xmdh_d[l_ac].xmda004_01,g_xmdh_d[l_ac].xmda004_01_desc,g_xmdh_d[l_ac].source_01,g_xmdh_d[l_ac].xmdhdocno_01,
          g_xmdh_d[l_ac].xmdhseq_01,g_xmdh_d[l_ac].xmdh001_01,g_xmdh_d[l_ac].xmdadocdt_01,g_xmdh_d[l_ac].xmda002_01,g_xmdh_d[l_ac].xmda002_01_desc,
          g_xmdh_d[l_ac].xmdh002_01,g_xmdh_d[l_ac].xmdh003_01,g_xmdh_d[l_ac].xmdh004_01,g_xmdh_d[l_ac].xmda033_01,g_xmdh_d[l_ac].xmdh005_01,
          g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].imaal003_01,g_xmdh_d[l_ac].imaal004_01,g_xmdh_d[l_ac].xmdh007_01,g_xmdh_d[l_ac].xmdh007_01_desc,
          g_xmdh_d[l_ac].xmdh009_01,g_xmdh_d[l_ac].xmdh009_01_desc,g_xmdh_d[l_ac].xmdh010_01,g_xmdh_d[l_ac].xmdh015_01,g_xmdh_d[l_ac].xmdh015_01_desc,
          g_xmdh_d[l_ac].xmdc012_01,g_xmdh_d[l_ac].days_01,g_xmdh_d[l_ac].xmdh016_01,g_xmdh_d[l_ac].xmdh017_01,g_xmdh_d[l_ac].xmdh012_01,
          g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh013_01_desc,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01                            
    #161109-00085#10-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp540_sel_xmdh_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
      
      #160120-00002#4 s983961--add(s)  
      #訂單的略過 
      IF g_xmdh_d[l_ac].source_01 = '1' THEN 
         LET l_xmdddocno = '' 
         LET l_xmddseq   = '' 
         LET l_xmddseq1  = '' 
         LET l_xmddseq2  = ''  
         
         #160414-00002#2--mark(S)         
         #LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ", 
         #            "  FROM xmdd_t ", 
         #            " WHERE xmddent = '",g_enterprise,"' ", 
         #            "   AND xmdddocno = '",g_xmdh_d[l_ac].xmdh001_01,"' ", 
         #            "   AND xmddseq   = '",g_xmdh_d[l_ac].xmdh002_01,"' ", 
         #            "   AND xmddseq1  = '",g_xmdh_d[l_ac].xmdh003_01,"' ", 
         #            "   AND xmddseq2  = '",g_xmdh_d[l_ac].xmdh004_01,"' ", 
         #            "   FOR UPDATE SKIP LOCKED " 
         #PREPARE axmp540_01_chk_locked_xmdd_prep FROM l_sql 
         #EXECUTE axmp540_01_chk_locked_xmdd_prep INTO l_xmdddocno,l_xmddseq, 
         #                                             l_xmddseq1,l_xmddseq2          
         #160414-00002#2--mark(E)
         
         
         #160414-00002#2--add(S)
         EXECUTE axmp540_01_chk_locked_xmdd_prep USING g_xmdh_d[l_ac].xmdh001_01,g_xmdh_d[l_ac].xmdh002_01,g_xmdh_d[l_ac].xmdh003_01,g_xmdh_d[l_ac].xmdh004_01
            INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2 
         #160414-00002#2--add(E)   
         
         
         IF cl_null(l_xmdddocno) AND cl_null(l_xmddseq) AND 
            cl_null(l_xmddseq1) AND cl_null(l_xmddseq2)  THEN 
            CONTINUE FOREACH 
         END IF 
      END IF 
      
      #出通單的略過       
      IF g_xmdh_d[l_ac].source_01 = '2' THEN 
        #mod--160706-00037#5 By shiun--(S)
        #LET l_xmdddocno = '' 
        #LET l_xmddseq   = '' 
        #LET l_xmddseq1  = '' 
        #LET l_xmddseq2  = ''          
         LET l_xmdhdocno = ''
         LET l_xmdhseq   = ''
         LET l_xmdh001  = ''
         LET l_xmdhseq1 = ''
         LET l_xmdhseq2 = ''
         LET l_xmdhseq3 = ''
        #mod--160706-00037#5 By shiun--(E)
         
        #160414-00002#2--mark(S)         
        #LET l_sql = " SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002 ", 
        #            "   FROM xmdh_t ", 
        #            "  WHERE xmdhent   = '",g_enterprise,"' ", 
        #            "    AND xmdhdocno = '",g_xmdh_d[l_ac].xmdhdocno_01,"' ", 
        #            "    AND xmdhseq   = '",g_xmdh_d[l_ac].xmdhseq_01,"' ",
        #            "    AND xmdh001  = '",g_xmdh_d[l_ac].xmdh001_01,"' ",    
        #            "    AND xmdh002  = '",g_xmdh_d[l_ac].xmdh002_01,"' ",
        #            "    AND xmdh003  = '",g_xmdh_d[l_ac].xmdh003_01,"' ",                  
        #            "    AND xmdh004  = '",g_xmdh_d[l_ac].xmdh004_01,"' ",                                    
        #            "    FOR UPDATE SKIP LOCKED " 
        #PREPARE axmp540_01_chk_locked_prep FROM l_sql 
        #EXECUTE axmp540_01_chk_locked_prep INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2           
        #160414-00002#2--mark(E)
        
         
         #160414-00002#2--add(S)
#        EXECUTE axmp540_01_chk_locked_prep USING g_xmdh_d[l_ac].xmdhdocno_01,g_xmdh_d[l_ac].xmdhseq_01,g_xmdh_d[l_ac].xmdh001_01,g_xmdh_d[l_ac].xmdh002_01,
#                                                 g_xmdh_d[l_ac].xmdh003_01,g_xmdh_d[l_ac].xmdh004_01         
         EXECUTE axmp540_01_chk_locked_prep USING g_xmdh_d[l_ac].xmdhdocno_01,g_xmdh_d[l_ac].xmdhseq_01      
           #INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2                       #160706-00037#5 mark By shiun
            INTO l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3  #160706-00037#5 mod By shiun
         #160414-00002#2--add(E)
        #mod--160706-00037#5 By shiun--(S)
        #IF cl_null(l_xmdddocno) AND cl_null(l_xmddseq) AND cl_null(l_xmddseq1) AND cl_null(l_xmddseq2)  THEN 
         IF cl_null(l_xmdhdocno) OR cl_null(l_xmdhseq) THEN
        #mod--160706-00037#5 By shiun--(E)
            CONTINUE FOREACH 
         END IF 
      END IF 
      #160120-00002#4 s983961--add(e) 
      
      #160414-00002#2--mark(S)      
      ##排除已在底稿的資料
      #LET l_cnt = 0
      #CASE g_xmdh_d[l_ac].source_01
      #  WHEN '1'                   #訂單      
      #    SELECT COUNT(*) INTO l_cnt
      #      FROM p540_01_tmp
      #     WHERE type = '1'
      #       AND docno = g_xmdh_d[l_ac].xmdh001_01
      #       AND seq = g_xmdh_d[l_ac].xmdh002_01
      #       AND xmdl005 = g_xmdh_d[l_ac].xmdh003_01
      #       AND xmdl006 = g_xmdh_d[l_ac].xmdh004_01
      #  WHEN '2'
      #    SELECT COUNT(*) INTO l_cnt
      #      FROM p540_01_tmp
      #     WHERE type = '1'
      #       AND docno = g_xmdh_d[l_ac].xmdhdocno_01
      #       AND seq  = g_xmdh_d[l_ac].xmdhseq_01      
      #END CASE
      #
      #IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
      #   CONTINUE FOREACH         
      #END IF      
      #160414-00002#2--mark(E)
      #161207-00033#3-s add
      LET l_pmaa004 = ''   #161230-00019#5
      EXECUTE axmp540_pb USING g_xmdh_d[l_ac].xmda004_01 INTO l_pmaa004
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #一次性交易對象全名
         CALL s_desc_axm_get_oneturn_guest_desc('1',g_xmdh_d[l_ac].xmdh001_01)
              RETURNING r_pmak003
         
         IF NOT cl_null(r_pmak003) THEN
            LET g_xmdh_d[l_ac].xmda004_01_desc = r_pmak003
         END IF
      END IF
      #161207-00033#3-e add  
      CALL axmp540_01_detail_show("'1'")  

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      
    END FOREACH   

    CALL g_xmdh_d.deleteElement(l_ac)
    LET g_detail_cnt = l_ac - 1  
    LET l_ac = l_ac_t
    CLOSE axmp540_sel_xmdh_cs
    FREE axmp540_sel_xmdh_pr   
    
    
    #未來出貨資料
    INITIALIZE g_xmdh2_d TO NULL
    
    #160414-00002#2--mark(S)   
    #LET l_sql = "SELECT     sel,xmda004,       '', source,xmdhdocno, ", 
    #            "       xmdhseq,xmdh001,xmdadocdt,xmda002,       '', ",
    #            "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
    #            "       xmdh006,     '',       '',xmdh007,       '', ",
    #            "       xmdh009,     '',  xmdh010,xmdh015,       '', ",
    #            "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
    #            "            '',xmdh013,       '',xmdh014,  xmdh029  ",
    #            "  FROM p540_01_xmdh2 ",               
    #            " ORDER BY days DESC" 
    #REPARE axmp540_sel_xmdh2_pr FROM l_sql
    #ECLARE axmp540_sel_xmdh2_cs CURSOR FOR axmp540_sel_xmdh2_pr
    #160414-00002#2--mark(E)
   
   
   #160414-00002#2--add--(S)
    LET l_sql = "SELECT     sel,xmda004,t1.pmaal004, source,xmdhdocno, ",
                "       xmdhseq,xmdh001,xmdadocdt,xmda002,t2.ooag011, ",
                "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
                "       xmdh006,t3.imaal003,t3.imaal004,xmdh007,       '', ",
                "       xmdh009,t5.oocql004,  xmdh010,xmdh015,t6.oocal003, ",
                "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
                "       t7.inayl003,xmdh013,t8.inab003,xmdh014,  xmdh029  ",               
                "  FROM p540_01_xmdh2 ",
                "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
                "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
                "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
                "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
                "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
                "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdh012 AND t7.inayl002='"||g_dlang||"' ",
                "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdh012 AND t8.inab002=xmdh013  ",                
                "  WHERE source = '1' ",
                "    AND xmdh001||xmdh002||xmdh003||xmdh004 NOT IN      ",
                "        (SELECT docno||seq||xmdl005||xmdl006 FROM p540_01_tmp ",    
                "          WHERE type = '2' AND source = '1')         ",                
                "UNION ",
                "SELECT     sel,xmda004,t1.pmaal004, source,xmdhdocno, ",
                "       xmdhseq,xmdh001,xmdadocdt,xmda002,t2.ooag011, ",
                "       xmdh002,xmdh003,  xmdh004,xmda033,  xmdh005, ",
                "       xmdh006,t3.imaal003,t3.imaal004,xmdh007,       '', ",
                "       xmdh009,t5.oocql004,  xmdh010,xmdh015,t6.oocal003, ",
                "       xmdc012,   days,  xmdh016,xmdh017,  xmdh012, ",
                "       t7.inayl003,xmdh013,t8.inab003,xmdh014,  xmdh029  ",                
                "  FROM p540_01_xmdh2 ",
                "    LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
                "    LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmda002  ",               
                "    LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdh006 AND t3.imaal002='"||g_dlang||"' ",
                "    LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
                "    LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
                "    LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=xmdh012 AND t7.inayl002='"||g_dlang||"' ",
                "    LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite='"||g_site||"' AND t8.inab001=xmdh012 AND t8.inab002=xmdh013  ",                 
                "  WHERE source = '2' ",  
                "    AND xmdhdocno||xmdhseq NOT IN      ",
                "        (SELECT docno||seq FROM p540_01_tmp ",    
                "          WHERE type = '2' AND source = '2')         ",                 
                " ORDER BY days DESC"                 
   PREPARE axmp540_sel_xmdh2_pr FROM l_sql
   DECLARE axmp540_sel_xmdh2_cs CURSOR FOR axmp540_sel_xmdh2_pr   
   #160414-00002#2--add--(E)
   
   
   LET l_ac_t = l_ac
   LET l_ac = 1
   #161109-00085#10-s
   #FOREACH axmp540_sel_xmdh2_cs INTO g_xmdh2_d[l_ac].* 
   FOREACH axmp540_sel_xmdh2_cs 
   INTO  g_xmdh2_d[l_ac].sel_02,g_xmdh2_d[l_ac].xmda004_02,g_xmdh2_d[l_ac].xmda004_02_desc,g_xmdh2_d[l_ac].source_02,g_xmdh2_d[l_ac].xmdhdocno_02,
         g_xmdh2_d[l_ac].xmdhseq_02,g_xmdh2_d[l_ac].xmdh001_02,g_xmdh2_d[l_ac].xmdadocdt_02,g_xmdh2_d[l_ac].xmda002_02,g_xmdh2_d[l_ac].xmda002_02_desc, 
         g_xmdh2_d[l_ac].xmdh002_02,g_xmdh2_d[l_ac].xmdh003_02,g_xmdh2_d[l_ac].xmdh004_02,g_xmdh2_d[l_ac].xmda033_02,g_xmdh2_d[l_ac].xmdh005_02,
         g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].imaal003_02,g_xmdh2_d[l_ac].imaal004_02,g_xmdh2_d[l_ac].xmdh007_02,g_xmdh2_d[l_ac].xmdh007_02_desc,
         g_xmdh2_d[l_ac].xmdh009_02,g_xmdh2_d[l_ac].xmdh009_02_desc,g_xmdh2_d[l_ac].xmdh010_02,g_xmdh2_d[l_ac].xmdh015_02,g_xmdh2_d[l_ac].xmdh015_02_desc,
         g_xmdh2_d[l_ac].xmdc012_02,g_xmdh2_d[l_ac].days_02,g_xmdh2_d[l_ac].xmdh016_02,g_xmdh2_d[l_ac].xmdh017_02,g_xmdh2_d[l_ac].xmdh012_02,
         g_xmdh2_d[l_ac].xmdh012_02_desc,g_xmdh2_d[l_ac].xmdh013_02,g_xmdh2_d[l_ac].xmdh013_02_desc,g_xmdh2_d[l_ac].xmdh014_02,g_xmdh2_d[l_ac].xmdh029_02
   #161109-00085#10-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp540_sel_xmdh2_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF   
      

      #160120-00002#4 s983961--add(s)  
      #訂單的略過 
      IF g_xmdh2_d[l_ac].source_02 = '1' THEN 
         LET l_xmdddocno = '' 
         LET l_xmddseq   = '' 
         LET l_xmddseq1  = '' 
         LET l_xmddseq2  = ''  
         
         #160414-00002#2--mark(S)
         #LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ", 
         #            "  FROM xmdd_t ", 
         #            " WHERE xmddent = '",g_enterprise,"' ", 
         #            "   AND xmdddocno = '",g_xmdh_d[l_ac].xmdh001_01,"' ", 
         #            "   AND xmddseq   = '",g_xmdh_d[l_ac].xmdh002_01,"' ", 
         #            "   AND xmddseq1  = '",g_xmdh_d[l_ac].xmdh003_01,"' ", 
         #            "   AND xmddseq2  = '",g_xmdh_d[l_ac].xmdh004_01,"' ", 
         #            "   FOR UPDATE SKIP LOCKED " 
         #PREPARE axmp540_02_chk_locked_xmdd_prep FROM l_sql 
         #EXECUTE axmp540_02_chk_locked_xmdd_prep INTO l_xmdddocno,l_xmddseq, 
         #                                             l_xmddseq1,l_xmddseq2          
         #160414-00002#2--mark(E)
         
         
         #160414-00002#2--add(S)
         EXECUTE axmp540_01_chk_locked_xmdd_prep USING g_xmdh2_d[l_ac].xmdh001_02,g_xmdh2_d[l_ac].xmdh002_02,g_xmdh2_d[l_ac].xmdh003_02,g_xmdh2_d[l_ac].xmdh004_02
            INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2 
         #160414-00002#2--add(E)   
         
         IF cl_null(l_xmdddocno) AND cl_null(l_xmddseq) AND 
            cl_null(l_xmddseq1) AND cl_null(l_xmddseq2)  THEN 
            CONTINUE FOREACH 
         END IF 
      END IF 
      
      #出通單的略過 
      IF g_xmdh2_d[l_ac].source_02 = '2' THEN 
        #mod--160706-00037#5 By shiun--(S)
        #LET l_xmdddocno = '' 
        #LET l_xmddseq   = '' 
        #LET l_xmddseq1  = '' 
        #LET l_xmddseq2  = ''          
         LET l_xmdhdocno = ''
         LET l_xmdhseq   = ''
         LET l_xmdh001  = ''
         LET l_xmdhseq1 = ''
         LET l_xmdhseq2 = ''
         LET l_xmdhseq3 = ''
        #mod--160706-00037#5 By shiun--(E)
         
         #160414-00002#2--mark(S)         
         #LET l_sql = " SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002 ", 
         #            "   FROM xmdh_t ", 
         #            "  WHERE xmdhent   = '",g_enterprise,"' ", 
         #            "    AND xmdhdocno = '",g_xmdh2_d[l_ac].xmdhdocno_02,"' ", 
         #            "    AND xmdhseq   = '",g_xmdh2_d[l_ac].xmdhseq_02,"' ",
         #            "    AND xmdh001  = '",g_xmdh2_d[l_ac].xmdh001_02,"' ",    
         #            "    AND xmdh002  = '",g_xmdh2_d[l_ac].xmdh002_02,"' ",
         #            "    AND xmdh003  = '",g_xmdh2_d[l_ac].xmdh003_02,"' ",                  
         #            "    AND xmdh004  = '",g_xmdh2_d[l_ac].xmdh004_02,"' ",                                    
         #            "    FOR UPDATE SKIP LOCKED " 
         #PREPARE axmp540_02_chk_locked_prep FROM l_sql 
         #EXECUTE axmp540_02_chk_locked_prep INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2           
         #160414-00002#2--mark(E)
         
         
         #160414-00002#2--add(S)
#        EXECUTE axmp540_01_chk_locked_prep USING g_xmdh2_d[l_ac].xmdhdocno_02,g_xmdh2_d[l_ac].xmdhseq_02,g_xmdh2_d[l_ac].xmdh001_02,g_xmdh2_d[l_ac].xmdh002_02,
#                                                 g_xmdh2_d[l_ac].xmdh003_02,g_xmdh2_d[l_ac].xmdh004_02
         EXECUTE axmp540_01_chk_locked_prep USING g_xmdh2_d[l_ac].xmdhdocno_02,g_xmdh2_d[l_ac].xmdhseq_02
           #INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2                       #160706-00037#5 mark By shiun
            INTO l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3  #160706-00037#5 mod By shiun
         #160414-00002#2--add(E)
        #mod--160706-00037#5 By shiun--(S)
        #IF cl_null(l_xmdddocno) AND cl_null(l_xmddseq) AND cl_null(l_xmddseq1) AND cl_null(l_xmddseq2)  THEN 
         IF cl_null(l_xmdhdocno) OR cl_null(l_xmdhseq) THEN
        #mod--160706-00037#5 By shiun--(E)
            CONTINUE FOREACH 
         END IF 
      END IF                    
      #160120-00002#4 s983961--add(e) 
      
      
      #160414-00002#2--mark(S)
      ##排除已在底稿的資料
      #LET l_cnt = 0
      #CASE g_xmdh2_d[l_ac].source_02
      #  WHEN '1'                   #訂單      
      #    SELECT COUNT(*) INTO l_cnt
      #      FROM p540_01_tmp
      #     WHERE type = '2'
      #       AND docno = g_xmdh2_d[l_ac].xmdh001_02
      #       AND seq = g_xmdh2_d[l_ac].xmdh002_02
      #       AND xmdl005 = g_xmdh2_d[l_ac].xmdh003_02
      #       AND xmdl006 = g_xmdh2_d[l_ac].xmdh004_02
      #  WHEN '2'
      #    SELECT COUNT(*) INTO l_cnt
      #      FROM p540_01_tmp
      #     WHERE type = '2'
      #       AND docno = g_xmdh2_d[l_ac].xmdhdocno_02
      #       AND seq  = g_xmdh2_d[l_ac].xmdhseq_02      
      #END CASE
      #IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
      #   CONTINUE FOREACH         
      #END IF      
      #160414-00002#2--mark(E)
     #161207-00033#3-s add
     LET l_pmaa004 = ''   #161230-00019#5
     EXECUTE axmp540_pb USING g_xmdh2_d[l_ac].xmda004_02 INTO l_pmaa004
     IF l_pmaa004 = '2' THEN   #2.一次性交易對象
        #一次性交易對象全名
        CALL s_desc_axm_get_oneturn_guest_desc('1',g_xmdh2_d[l_ac].xmdh001_02)
             RETURNING r_pmak003
        
        IF NOT cl_null(r_pmak003) THEN
           LET g_xmdh2_d[l_ac].xmda004_02_desc = r_pmak003
        END IF
     END IF
     #161207-00033#3-e add    
      CALL axmp540_01_detail_show("'2'")   
    
     LET l_ac = l_ac + 1
     IF l_ac > g_max_rec THEN
        INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
        EXIT FOREACH
     END IF     
  
   END FOREACH 
   
   CALL g_xmdh2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1
   LET l_ac = l_ac_t
   CLOSE axmp540_sel_xmdh2_cs
   FREE axmp540_sel_xmdh2_pr   

END FUNCTION
#刪除底稿
PUBLIC FUNCTION axmp540_01_del_tmp()
  DEFINE i       LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
  DEFINE l_flag  LIKE type_t.chr1 

  
   #用來判斷是否有資料被刪除 
   LET l_flag = 'N'

  FOR i = 1 TO g_xmdh_d.getLength()
      IF g_xmdh_d[i].sel_01 = 'Y' THEN
         IF g_xmdh_d[i].source_01 = '1' THEN 
            DELETE FROM p540_01_tmp
             WHERE type = '1'                             #已出貨資料
               AND source = g_xmdh_d[i].source_01
               AND docno = g_xmdh_d[i].xmdh001_01
               AND seq = g_xmdh_d[i].xmdh002_01
               AND xmdl005 = g_xmdh_d[i].xmdh003_01
               AND xmdl006 = g_xmdh_d[i].xmdh004_01 
            #160120-00002#4 20160216 by s983961--add(s)  
            DELETE FROM p540_tmp01       #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
             WHERE xmdh001 = g_xmdh_d[i].xmdh001_01
               AND xmdhseq1 = g_xmdh_d[i].xmdh002_01
               AND xmdhseq2 = g_xmdh_d[i].xmdh003_01
               AND xmdhseq3 = g_xmdh_d[i].xmdh004_01  
            #160120-00002#4 20160216 by s983961--add(e)     
         ELSE
            DELETE FROM p540_01_tmp
             WHERE type = '1'                             #已出貨資料
               AND source = g_xmdh_d[i].source_01
               AND docno = g_xmdh_d[i].xmdhdocno_01
               AND seq = g_xmdh_d[i].xmdhseq_01        
         END IF         
         LET l_flag = 'Y'    
      END IF
  END FOR 
  
  FOR i = 1 TO g_xmdh2_d.getLength()
      IF g_xmdh2_d[i].sel_02 = 'Y' THEN
         IF g_xmdh2_d[i].source_02 = '1' THEN
            DELETE FROM p540_01_tmp
             WHERE type = '2'                             #待出貨資料
               AND source = g_xmdh2_d[i].source_02
               AND docno = g_xmdh2_d[i].xmdh001_02
               AND seq = g_xmdh2_d[i].xmdh002_02
               AND xmdl005 = g_xmdh2_d[i].xmdh003_02
               AND xmdl006 = g_xmdh2_d[i].xmdh004_02
         ELSE
            DELETE FROM p540_01_tmp
             WHERE type = '2'                             #待出貨資料
              AND source = g_xmdh2_d[i].source_02
              AND docno = g_xmdh2_d[i].xmdhdocno_02
              AND seq = g_xmdh2_d[i].xmdhseq_02        
         END IF         
         LET l_flag = 'Y'    
      END IF
  END FOR  
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("axm-00328")   #出貨資料(底稿)資料已刪除！  
   END IF    
END FUNCTION
#底稿資料確認
PUBLIC FUNCTION axmp540_01_tmp_chk()
DEFINE l_cnt         LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   #確認底稿是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM p540_01_tmp
   
   IF l_cnt = 0 THEN
       CALL cl_ask_pressanykey("axm-00329")   #尚未產生出貨資料(底稿)！
       LET r_success = FALSE
       RETURN r_success       
   END IF
   
   RETURN r_success       

END FUNCTION
#設定右方button的顯示與隱藏
PUBLIC FUNCTION axmp540_01_set_act_visible()

    CALL cl_set_comp_visible("all_c_sel",FALSE)           #客戶全選
    CALL cl_set_comp_visible("all_o_sel",FALSE)           #訂單全選
    CALL cl_set_comp_visible("all_un_sel",FALSE)          #取消全選
    CALL cl_set_comp_visible("see_tmp",FALSE)             #檢示底稿
    CALL cl_set_comp_visible("sel_mode",FALSE)            #出貨資料 
    CALL cl_set_comp_visible("del_tmp",FALSE)             #刪除底稿 
    CALL cl_set_comp_visible("save",FALSE)                #出貨資料寫入 
    
  CASE g_mode
     WHEN 'i'
         CALL cl_set_comp_visible("all_c_sel",TRUE)           #客戶全選
         CALL cl_set_comp_visible("all_o_sel",TRUE)           #訂單全選
         CALL cl_set_comp_visible("all_un_sel",TRUE)          #取消全選
         CALL cl_set_comp_visible("see_tmp",TRUE)             #檢示底稿
         CALL cl_set_comp_visible("save",TRUE)                #出貨資料寫入
        
     WHEN 'd'
         CALL cl_set_comp_visible("sel_mode",TRUE)            #出貨資料 
         CALL cl_set_comp_visible("del_tmp",TRUE)             #刪除底稿
         CALL cl_set_comp_visible("all_c_sel",TRUE)           #客戶全選
         CALL cl_set_comp_visible("all_o_sel",TRUE)           #訂單全選
         CALL cl_set_comp_visible("all_un_sel",TRUE)          #取消全選         
  END  CASE
  
END FUNCTION

PRIVATE FUNCTION axmp540_01_set_entry_b()
   CALL cl_set_comp_entry("xmdh017_01,xmdh012_01,xmdh013_01,xmdh014_01,xmdh029_01",TRUE)     #本次出貨數、庫位、儲位、批號、庫存管理特徵
   CALL cl_set_comp_entry("xmdh017_02,xmdh012_02,xmdh013_02,xmdh014_02,xmdh029_02",TRUE)     #本次出貨數、庫位、儲位、批號、庫存管理特徵
END FUNCTION

PRIVATE FUNCTION axmp540_01_set_no_entry_b()
   DEFINE l_flag     LIKE type_t.chr1       #是否可分批出貨
   DEFINE l_xmdh011  LIKE xmdh_t.xmdh011    #多庫儲批出貨
   DEFINE l_xmdh012  LIKE xmdh_t.xmdh012    #限定庫位
   DEFINE l_xmdh013  LIKE xmdh_t.xmdh013    #限定儲位
   DEFINE l_xmdh014  LIKE xmdh_t.xmdh014    #限定批號
   DEFINE l_xmdh029  LIKE xmdh_t.xmdh029    #庫存管理特徵
   DEFINE l_imaf015  LIKE imaf_t.imaf015
   DEFINE l_imaf061  LIKE imaf_t.imaf061    #庫存批號控管方式
   DEFINE l_imaf113  LIKE imaf_t.imaf113   
   DEFINE l_imaf055  LIKE imaf_t.imaf055
#161006-00018#25-S
DEFINE l_flag2     LIKE type_t.num5
DEFINE l_ooac002   LIKE ooac_t.ooac002
DEFINE l_ooac004   LIKE ooac_t.ooac004
DEFINE l_inaa007   LIKE inaa_t.inaa007
#161006-00018#25-E

   LET l_flag = ''
   LET l_xmdh011 = ''
   LET l_xmdh012 = ''
   LET l_xmdh013 = ''  
   LET l_xmdh014 = '' 
   LET l_xmdh029 = ''
   LET l_imaf015 = ''
   LET l_imaf061 = ''
   LET l_imaf113 = ''   

  #161006-00018#25-S
  CALL s_aooi200_get_slip(g_xmdk_m.xmdkdocno) RETURNING l_flag2,l_ooac002
  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004         
  #161006-00018#25-E
    
   IF g_current_page = 1 THEN    #待出貨頁籤
      IF g_mode = 'd' OR g_xmdh_d[l_ac].sel_01 = 'N' THEN                                #底稿模式不需開啟庫儲批
         CALL cl_set_comp_entry("xmdh017_01,xmdh012_01,xmdh013_01,xmdh014_01,xmdh029_01",FALSE)     #本次出貨數、庫位、儲位、批號
      END IF    
      IF g_mode = 'i' AND g_xmdh_d[l_ac].sel_01 = 'Y' THEN
         IF g_xmdh_d[l_ac].source_01 = '1' THEN   #訂單
            CALL axmp540_01_get_xmdc_xmdh('1',g_xmdh_d[l_ac].xmdh001_01,g_xmdh_d[l_ac].xmdh002_01)
              RETURNING l_flag,l_xmdh011,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029
            
            IF l_flag = 'N' THEN                             #不允許部分交貨，則不能修改數量
               CALL cl_set_comp_entry("xmdh017_01",FALSE)
            END IF   
         ELSE                                     #出通單
            CALL axmp540_01_get_xmdc_xmdh('2',g_xmdh_d[l_ac].xmdhdocno_01,g_xmdh_d[l_ac].xmdhseq_01)
              RETURNING l_flag,l_xmdh011,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029
                          
            IF l_flag = 'N' THEN                             #出貨單控管為"一對一"，則不能修改數量
               CALL cl_set_comp_entry("xmdh017_01",FALSE)
            END IF                       
             IF l_xmdh011 = 'Y' THEN                         #若使用多倉儲批，不能限定庫儲批
                CALL cl_set_comp_entry("xmdh012_01,xmdh013_01,xmdh014_01,xmdh029_01",FALSE)    
             END IF
         END IF
         #是否已有限定庫儲批   
         IF NOT cl_null(l_xmdh012) THEN
            IF l_ooac004 = 'N' THEN  #161006-00018#25
               CALL cl_set_comp_entry("xmdh012_01",FALSE)
            END IF                   #161006-00018#25
            IF NOT cl_null(l_xmdh013) THEN
               IF l_ooac004 = 'N' THEN  #161006-00018#25
                  CALL cl_set_comp_entry("xmdh013_01",FALSE)
               END IF                   #161006-00018#25   
               IF NOT cl_null(l_xmdh014) THEN
                  IF l_ooac004 = 'N' THEN  #161006-00018#25
                     CALL cl_set_comp_entry("xmdh014_01",FALSE)
                  END IF                   #161006-00018#25      
               END IF
            END IF
         END IF
         IF NOT cl_null(l_xmdh029) THEN
            CALL cl_set_comp_entry("xmdh029_01",FALSE)
         END IF
         CALL axmp540_01_get_imaf(g_xmdh_d[l_ac].xmdh006_01)     
           RETURNING l_imaf015,l_imaf061,l_imaf113,l_imaf055
         #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
         IF l_imaf061 NOT MATCHES '[13]' THEN
            LET g_xmdh_d[l_ac].xmdh014_01 = ' '
            CALL cl_set_comp_entry("xmdh014_01",FALSE)
         END IF         
         IF l_imaf055 = '2' THEN
            CALL cl_set_comp_entry("xmdh029_01",FALSE)
         END IF
      END IF      
   ELSE     #未出貨頁籤
      IF g_mode = 'd' OR g_xmdh2_d[l_ac].sel_02 = 'N' THEN                                         #底稿模式不需開啟庫儲批
         CALL cl_set_comp_entry("xmdh017_02,xmdh012_02,xmdh013_02,xmdh014_02,xmdh029_02",FALSE)     #本次出貨數、庫位、儲位、批號
      END IF    
      IF g_mode = 'i' AND g_xmdh2_d[l_ac].sel_02 = 'Y' THEN
         IF g_xmdh2_d[l_ac].source_02 = '1' THEN   #訂單
            CALL axmp540_01_get_xmdc_xmdh('1',g_xmdh2_d[l_ac].xmdh001_02,g_xmdh2_d[l_ac].xmdh002_02)
              RETURNING l_flag,l_xmdh011,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029
            IF l_flag = 'N' THEN                             #不允許部分交貨，則不能修改數量
               CALL cl_set_comp_entry("xmdh017_02",FALSE)
            END IF   
         ELSE                                     #出通單
            CALL axmp540_01_get_xmdc_xmdh('2',g_xmdh2_d[l_ac].xmdhdocno_02,g_xmdh2_d[l_ac].xmdhseq_02)
              RETURNING l_flag,l_xmdh011,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029
                          
            IF l_flag = 'N' THEN                             #出貨單控管為"一對一"，則不能修改數量
               CALL cl_set_comp_entry("xmdh017_02",FALSE)
            END IF                       
             IF l_xmdh011 = 'Y' THEN                         #若使用多倉儲批，不能限定庫儲批
                CALL cl_set_comp_entry("xmdh012_02,xmdh013_02,xmdh014_02,xmdh029_02",FALSE)    
             END IF
         END IF
         #是否已有限定庫儲批   
         IF NOT cl_null(l_xmdh012) THEN
            IF l_ooac004 = 'N' THEN  #161006-00018#25
               CALL cl_set_comp_entry("xmdh012_02",FALSE)
            END IF   
            IF NOT cl_null(l_xmdh013) THEN
               IF l_ooac004 = 'N' THEN  #161006-00018#25
                  CALL cl_set_comp_entry("xmdh013_02",FALSE)
               END IF #161006-00018#25
               IF NOT cl_null(l_xmdh014) THEN
                  IF l_ooac004 = 'N' THEN  #161006-00018#25
                     CALL cl_set_comp_entry("xmdh014_02",FALSE)
                  END IF    #161006-00018#25 
               END IF
            END IF
         END IF      
         IF NOT cl_null(l_xmdh029) THEN
            CALL cl_set_comp_entry("xmdl029_02",FALSE)
         END IF
         CALL axmp540_01_get_imaf(g_xmdh2_d[l_ac].xmdh006_02)     
           RETURNING l_imaf015,l_imaf061,l_imaf113,l_imaf055
         #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
         IF l_imaf061 NOT MATCHES '[13]' THEN
            LET g_xmdh2_d[l_ac].xmdh014_02 = ' '
            CALL cl_set_comp_entry("xmdh014_02",FALSE)
         END IF  
         IF l_imaf055 = '2' THEN
            CALL cl_set_comp_entry("xmdh029_02",FALSE)
         END IF
      END IF         
   END IF
    
    #161006-00018#25-S
    LET l_inaa007 = '' 
    SELECT inaa007 INTO l_inaa007 FROM inaa_t
     WHERE inaaent = g_enterprise
       AND inaasite = g_site
       AND inaa001 = g_xmdh_d[l_ac].xmdh012_01
    IF l_inaa007 = '5' THEN
       CALL cl_set_comp_entry("xmdh013_01",FALSE)
    END IF  
    LET l_inaa007 = ''    
    SELECT inaa007 INTO l_inaa007 FROM inaa_t
     WHERE inaaent = g_enterprise
       AND inaasite = g_site
       AND inaa001 = g_xmdh2_d[l_ac].xmdh012_02
    IF l_inaa007 = '5' THEN
       CALL cl_set_comp_entry("xmdh013_02",FALSE)
    END IF       
    #161006-00018#25-E   
    
END FUNCTION
#ref說明顯示
PRIVATE FUNCTION axmp540_01_detail_show(p_page)
   DEFINE p_page      STRING
   DEFINE l_success   LIKE type_t.num5
   
   IF p_page.getIndexOf("'1'",1) > 0 THEN
     ##--160414-00002#2--mark--(S) 
      #CALL s_desc_get_trading_partner_abbr_desc(g_xmdh_d[l_ac].xmda004_01)   #客戶
      #  RETURNING g_xmdh_d[l_ac].xmda004_01_desc
      #  
      #CALL s_desc_get_person_desc(g_xmdh_d[l_ac].xmda002_01)  #業務人員
      #  RETURNING g_xmdh_d[l_ac].xmda002_01_desc        
      #
      #CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006_01)   #品名、規格
      #  RETURNING g_xmdh_d[l_ac].imaal003_01,g_xmdh_d[l_ac].imaal004_01 
     ##--160414-00002#2--mark--(E)    
      CALL s_feature_description(g_xmdh_d[l_ac].xmdh006_01,g_xmdh_d[l_ac].xmdh007_01)
           RETURNING l_success,g_xmdh_d[l_ac].xmdh007_01_desc
     ##--160414-00002#2--mark--(S) 
     #CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015_01)   #單位
     #  RETURNING g_xmdh_d[l_ac].xmdh015_01_desc
     #    # CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01)  #庫位
     #  RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
     #
     #CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) #儲位
     #  RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
     ##--160414-00002#2--mark--(E) 
   END IF

   IF p_page.getIndexOf("'2'",1) > 0 THEN
     #--160414-00002#2--mark--(S) 
     #CALL s_desc_get_trading_partner_abbr_desc(g_xmdh2_d[l_ac].xmda004_02)   #客戶
     #  RETURNING g_xmdh2_d[l_ac].xmda004_02_desc 
     #
     #CALL s_desc_get_person_desc(g_xmdh2_d[l_ac].xmda002_02)  #業務人員
     #  RETURNING g_xmdh2_d[l_ac].xmda002_02_desc  
     #  
     #CALL s_desc_get_item_desc(g_xmdh2_d[l_ac].xmdh006_02)   #品名、規格
     #  RETURNING g_xmdh2_d[l_ac].imaal003_02,g_xmdh2_d[l_ac].imaal004_02 
     #--160414-00002#2--mark--(E) 
      CALL s_feature_description(g_xmdh2_d[l_ac].xmdh006_02,g_xmdh2_d[l_ac].xmdh007_02)
           RETURNING l_success,g_xmdh2_d[l_ac].xmdh007_02_desc
     #--160414-00002#2--mark--(S)       
     #CALL s_desc_get_unit_desc(g_xmdh2_d[l_ac].xmdh015_02)   #單位
     #  RETURNING g_xmdh2_d[l_ac].xmdh015_02_desc 
     #    
     #CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02)  #庫位
     # RETURNING g_xmdh2_d[l_ac].xmdh012_02_desc   
     #    
     #CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdh012_02,g_xmdh2_d[l_ac].xmdh013_02) #儲位
     # RETURNING g_xmdh2_d[l_ac].xmdh013_02_desc 
     #--160414-00002#2--mark--(S)   
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 抓取料件據點進銷存檔相關設定
# Memo...........:
# Usage..........: CALL axmp540_01_get_imaf(p_imaf001)
#                  RETURNING r_imaf015、r_imaf061、r_imaf113、r_imaf055
# Input parameter: p_imaf001   料件編號
# Return code....: r_imaf015   參考單位
#                : r_imaf061   庫存批號控管方式
#                : r_imaf113   銷售計價單位
#                : r_imaf055   庫存管理特徵
# Date & Author..: 2014/07/03 By Polly
# Modify.........: 2014/10/16 by stellar
################################################################################
PUBLIC FUNCTION axmp540_01_get_imaf(p_imaf001)
DEFINE p_imaf001   LIKE imaf_t.imaf001
DEFINE r_imaf015   LIKE imaf_t.imaf015
DEFINE r_imaf061   LIKE imaf_t.imaf061
DEFINE r_imaf113   LIKE imaf_t.imaf113
DEFINE r_imaf055   LIKE imaf_t.imaf055

      LET r_imaf015 = ''
      LET r_imaf061 = ''
      LET r_imaf113 = ''
      SELECT imaf015,imaf061,imaf113,imaf055
        INTO r_imaf015,r_imaf061,r_imaf113,r_imaf055
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = p_imaf001
         
     RETURN r_imaf015,r_imaf061,r_imaf113,r_imaf055

END FUNCTION

################################################################################
# Descriptions...: 抓取訂單/出通單庫儲批相關設定
# Memo...........:
# Usage..........: CALL axmp540_01_get_xmdc_xmdh(p_source,p_docno,p_seq)
#                  RETURNING r_flag、r_xmdh011、r_xmdh012、r_xmdh013、r_xmdh014、r_xmdh029
# Input parameter: p_source      單據來源1：訂單2：出通單
#                : p_docno       訂單單號/出通單單號
#                : p_seq         訂單項次/出通單項次
# Return code....: r_flag        Y：可修改出貨數量/N不可修改出貨數量
#                : r_xmdh011     多庫儲批出貨
#                : r_xmdh012     限定庫位
#                : r_xmdh013     限定儲位
#                : r_xmdh014     限定批號
#                : r_xmdh029     庫存管理特徵
# Date & Author..: 2014/07/03 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_01_get_xmdc_xmdh(p_source,p_docno,p_seq)
DEFINE p_source         LIKE type_t.chr1
DEFINE p_docno          LIKE xmdc_t.xmdcdocno
DEFINE p_seq            LIKE xmdc_t.xmdcdocno
DEFINE r_flag           LIKE type_t.chr1        #是否可分批出貨
DEFINE r_xmdh011        LIKE xmdh_t.xmdh011     #多庫儲批出貨
DEFINE r_xmdh012        LIKE xmdh_t.xmdh012     #限定庫位
DEFINE r_xmdh013        LIKE xmdh_t.xmdh013     #限定儲位
DEFINE r_xmdh014        LIKE xmdh_t.xmdh012     #限定批號
DEFINE r_xmdh029        LIKE xmdh_t.xmdh029     #庫存管理特徵
DEFINE l_slip     LIKE ooba_t.ooba001
DEFINE l_success  LIKE type_t.num5

   LET r_flag = ''
   LET r_xmdh011 = ''
   LET r_xmdh012 = ''
   LET r_xmdh013 = ''  
   LET r_xmdh014 = '' 
   LET r_xmdh029 = ''
   
   IF p_source = '1' THEN      #訂單
      SELECT xmdc022,xmdc028,xmdc029,xmdc030,xmdc057
        INTO r_flag,r_xmdh012,r_xmdh013,r_xmdh014,r_xmdh029
        FROM xmdc_t
       WHERE xmdcent = g_enterprise
         AND xmdcsite = g_site
         AND xmdcdocno = p_docno 
         AND xmdcseq = p_seq
      IF cl_null(r_flag) THEN              
         LET r_flag = 'N'
      END IF            
   ELSE                        #出通單
      CALL s_aooi200_get_slip(p_docno) RETURNING l_success,l_slip       
      IF l_success THEN
         IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0060') = '1' THEN          #出通轉出貨單控管為"一對一"
            LET r_flag = 'N'
         END IF
      END IF         
      SELECT xmdh011,xmdh012,xmdh013,xmdh014,xmdh029
        INTO r_xmdh011,r_xmdh012,r_xmdh013,r_xmdh014,r_xmdh029
        FROM xmdh_t
       WHERE xmdhent = g_enterprise
         AND xmdhsite = g_site
         AND xmdhdocno = p_docno
         AND xmdhseq = p_seq  
   END IF
   RETURN r_flag,r_xmdh011,r_xmdh012,r_xmdh013,r_xmdh014,r_xmdh029
END FUNCTION
################################################################################
# Descriptions...: 庫位檢核
# Usage..........: CALL axmp540_01_chk_xmdh012(p_xmdh006,p_xmdh007,p_xmdh012)
# Input parameter: p_xmdh006    料件編號
#                : p_xmdh007    產品特徵
#                : p_xmdh012    庫位 
# Return code....: r_success
# Date & Author..: 140703 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_01_chk_xmdh012(p_xmdh006,p_xmdh007,p_xmdh012)
DEFINE p_xmdh006   LIKE xmdh_t.xmdh006
DEFINE p_xmdh007   LIKE xmdh_t.xmdh007
DEFINE p_xmdh012   LIKE xmdh_t.xmdh012
DEFINE r_success   LIKE type_t.num5
   LET r_success = TRUE
   IF NOT cl_null(p_xmdh012) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = p_xmdh012
      #160318-00025#22  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
      #160318-00025#22  by 07900 --add-end 
      IF NOT cl_chk_exist("v_inaa001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 儲位檢核
# Usage..........: CALL axmp540_01_chk_xmdh013(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013)
# Input parameter: p_xmdh006    料件編號
#                : p_xmdh007    產品特徵
#                : p_xmdh012    庫位 
#                : p_xmdh013    儲位 
# Return code....: r_success
# Date & Author..: 140703 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_01_chk_xmdh013(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013)
DEFINE p_xmdh006   LIKE xmdh_t.xmdh006
DEFINE p_xmdh007   LIKE xmdh_t.xmdh007
DEFINE p_xmdh012   LIKE xmdh_t.xmdh012
DEFINE p_xmdh013   LIKE xmdh_t.xmdh013
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(p_xmdh013) THEN
      IF cl_null(p_xmdh012) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00126'    #庫位不可為空
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = p_xmdh012
      LET g_chkparam.arg3 = p_xmdh013
      IF NOT cl_chk_exist("v_inab002_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success

END FUNCTION
################################################################################
# Descriptions...: 批號檢核
# Usage..........: CALL axmp540_01_chk_xmdh014(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014)
# Input parameter: p_xmdh006    料件編號
#                : p_xmdh007    產品特徵
#                : p_xmdh012    庫位 
#                : p_xmdh013    儲位 
#                : p_xmdh014    批號 
# Return code....: r_success
# Date & Author..: 140703 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_01_chk_xmdh014(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014)
DEFINE p_xmdh006   LIKE xmdh_t.xmdh006
DEFINE p_xmdh007   LIKE xmdh_t.xmdh007
DEFINE p_xmdh012   LIKE xmdh_t.xmdh012
DEFINE p_xmdh013   LIKE xmdh_t.xmdh013
DEFINE p_xmdh014   LIKE xmdh_t.xmdh014
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_xmdh014) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = p_xmdh006
      LET g_chkparam.arg3 = p_xmdh007
      LET g_chkparam.arg4 = p_xmdh014
      IF NOT cl_chk_exist("v_inad001_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 在揀量檢核
# Memo...........:
# Usage..........: CALL axmp540_01_inan_chk(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017)
#                  RETURNING TRUE OR FALSE
# Input parameter: p_xmdh006   料件編號
#                : p_xmdh007   產品特徵
#                : p_xmdh012   限定庫位
#                : p_xmdh013   限定儲位
#                : p_xmdh014   限定批號
#                : p_xmdh029   庫存管理特徵
#                : p_xmdh015   單位
#                : p_xmdh017   數量
#                : p_xmdl003   訂單單號 #160408-00035#9-add
#                : p_xmdl004   訂單項次 #160408-00035#9-add
# Return code....: TRUE OR FALSE   

# Date & Author..: 20140703 By Polly
# Modify.........:#160408-00035#9 add-p_xmdl003,p_xmdl004
################################################################################
PUBLIC FUNCTION axmp540_01_inan_chk(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdl003,p_xmdl004)
DEFINE p_xmdh006    LIKE xmdh_t.xmdh006
DEFINE p_xmdh007    LIKE xmdh_t.xmdh007
DEFINE p_xmdh012    LIKE xmdh_t.xmdh012
DEFINE p_xmdh013    LIKE xmdh_t.xmdh013
DEFINE p_xmdh014    LIKE xmdh_t.xmdh014
DEFINE p_xmdh029    LIKE xmdh_t.xmdh029
DEFINE p_xmdh015    LIKE xmdh_t.xmdh015
DEFINE p_xmdh017    LIKE xmdh_t.xmdh017
DEFINE p_xmdl003    LIKE xmdl_t.xmdl003 #160408-00035#9-add
DEFINE p_xmdl004    LIKE xmdl_t.xmdl004 #160408-00035#9-add
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5
 
   CALL s_inventory_check_inan(g_site,p_xmdh006,p_xmdh007,p_xmdh029,p_xmdh012,
                               p_xmdh013,p_xmdh014,p_xmdh015,p_xmdh017,g_docno,
                               '0','0',p_xmdl003,p_xmdl004) #160408-00035#9-add-p_xmdl003,p_xmdl004
     RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN FALSE
      IF l_flag = 0 THEN
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE  

END FUNCTION

################################################################################
# Descriptions...: 抓取出通單資料
# Memo...........:
# Usage..........: CALL axmp540_01_get_xmdg(p_type,p_docno,p_seq,p_seq1,p_seq2)
#                  RETURNING r_success
# Input parameter: p_type     1待出資料2未來出資料
#                : p_docno    單號
#                : p_seq      項次
#                : p_seq1     項序
#                : p_seq2     分批序
# Return code....: r_success
#                : 
# Date & Author..: 2014/08/22 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_01_get_xmdg(p_type,p_docno,p_seq,p_seq1,p_seq2)
   DEFINE  p_type         LIKE type_t.chr1
   DEFINE  p_source       LIKE type_t.chr10         #來源1訂單2出通單                   
   DEFINE  p_docno        LIKE xmdh_t.xmdhdocno     #單號
   DEFINE  p_seq          LIKE xmdh_t.xmdhseq       #項次
   DEFINE  p_seq1         LIKE xmdh_t.xmdhseq       #項序
   DEFINE  p_seq2         LIKE xmdh_t.xmdhseq       #分批序
   DEFINE  r_success      LIKE type_t.num5
   DEFINE  l_cnt          LIKE type_t.num10         #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE  l_ship         LIKE xmdl_t.xmdl018       #未出貨數量
   DEFINE  l_sql          STRING
   DEFINE  l_xmda028      LIKE xmda_t.xmda028   #161230-00019#5-s-mod

   
   LET r_success = TRUE
   
   LET g_xmdl_d.source = '2'                         #單據來源2出通單  
   #由訂單抓取出通單
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xmdh_t,xmdg_t
    WHERE xmdgent = g_enterprise
      AND xmdgsite = g_site
      AND xmdgent = xmdhent
      AND xmdgdocno = xmdhdocno
      AND xmdh001 = p_docno        #訂單單號
      AND xmdh002 = p_seq          #訂單項次
      AND xmdh003 = p_seq1         #訂單項序
      AND xmdh004 = p_seq2         #訂單分批序
      AND xmdg001 <> '5'
      AND xmdgstus = 'Y'               
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF     
   LET g_xmdl_d.xmdl003 = p_docno   #訂單單號
   LET g_xmdl_d.xmdl004 = p_seq     #訂單項次
   LET g_xmdl_d.xmdl005 = p_seq1    #訂單項序
   LET g_xmdl_d.xmdl006 = p_seq2    #訂單分批序 
        
   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh005,xmdh006,xmdh007, ",
               "       xmdh009,xmdh010,xmdh015,xmdh012,xmdh013, ",
               "       xmdh014,xmdh029 ",
               "  FROM xmdh_t,xmdg_t ",
               " WHERE xmdgent = '",g_enterprise,"' ",
               "   AND xmdgsite = '",g_site,"' ",
               "   AND xmdgent = xmdhent ",
               "   AND xmdgdocno = xmdhdocno ",
               "   AND xmdh001 = '",p_docno,"' ",         #訂單單號
               "   AND xmdh002 = '",p_seq,"' ",           #訂單項次
               "   AND xmdh003 = '",p_seq1,"' ",          #訂單項序
               "   AND xmdh004 = '",p_seq2,"' ",          #訂單分批序
               "   AND xmdg001 <> '5' ",
               "   AND xmdgstus = 'Y' "
   PREPARE p540_01_xmdh_pr FROM l_sql
   DECLARE p540_01_xmdh_cs CURSOR FOR p540_01_xmdh_pr
   
   FOREACH p540_01_xmdh_cs INTO g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                                g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,g_xmdl_d.xmdl017,g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,
                                g_xmdl_d.xmdl016,g_xmdl_d.xmdl052
                                          
        #待出貨數量
        LET g_xmdl_d.qua = 0   
        LET l_ship = 0      
        CALL s_axmt540_get_max_ship_qty('1','','',g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,'','') #可出貨的出貨數量
          RETURNING l_ship,g_xmdl_d.qua
        IF g_xmdl_d.qua < = 0 THEN     
           LET r_success = FALSE
           RETURN r_success
        ELSE
           #161230-00019#5-s-add
           LET l_xmda028 = ''
           SELECT xmda028 INTO l_xmda028
             FROM xmda_t
            WHERE xmdaent = g_enterprise
              AND xmdadocno = p_docno
           #161230-00019#5-e-add
           
           IF p_type = '1' THEN
              #mod--161109-00085#10-s
              #INSERT INTO p540_01_xmdh VALUES (g_xmdl_d.*)                      
              INSERT INTO p540_01_xmdh (sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                        xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                        xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                        xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                        xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                        #161230-00019#5-s-mod
#                                        xmdh029)
                                        xmdh029,xmda028)
                                        #161230-00019#5-e-mod                                        
              VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                      g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                      g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                      g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                      g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
                      #161230-00019#5-s-mod
#                      g_xmdl_d.xmdl052)
                      g_xmdl_d.xmdl052,l_xmda028)
                      #161230-00019#5-e-mod
              #mod--161109-00085#10-e        
           ELSE       
              #mod--161109-00085#10-s
              #INSERT INTO p540_01_xmdh2 VALUES (g_xmdl_d.*)         
              INSERT INTO p540_01_xmdh2(sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                        xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                        xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                        xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                        xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                        #161230-00019#5-s-mod
#                                        xmdh029)
                                        xmdh029,xmda028)
                                        #161230-00019#5-e-mod 
              VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                      g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                      g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                      g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                      g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
                      #161230-00019#5-s-mod
#                      g_xmdl_d.xmdl052)
                      g_xmdl_d.xmdl052,l_xmda028)
                      #161230-00019#5-e-mod
              #mod--161109-00085#10-e               
           END IF
        END IF      
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 抓取訂單資料
# Memo...........:
# Usage..........: CALL axmp540_01_get_xmda(p_type,p_docno,p_seq,p_seq1,p_seq2)
#                  RETURNING r_success
# Input parameter: p_type     1待出資料2未來出
#                : p_docno    單號
#                : p_seq      項次
#                : p_seq1     項序
#                : p_seq2     分批序
# Return code....: r_success
#                : 
# Date & Author..: 2014/08/22 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_01_get_xmda(p_type,p_docno,p_seq,p_seq1,p_seq2)
   DEFINE  p_type         LIKE type_t.chr1
   DEFINE  p_docno        LIKE xmdh_t.xmdhdocno     #單號
   DEFINE  p_seq          LIKE xmdh_t.xmdhseq       #項次
   DEFINE  p_seq1         LIKE xmdh_t.xmdhseq       #項序
   DEFINE  p_seq2         LIKE xmdh_t.xmdhseq       #分批序
   DEFINE  l_ship         LIKE xmdl_t.xmdl018       #未出貨數量
   DEFINE  r_success      LIKE type_t.num5
   DEFINE  l_xmda028      LIKE xmda_t.xmda028   #161230-00019#5-s-mod
   
      LET r_success = TRUE
      LET g_xmdl_d.source = '1'                 #來源單據：訂單  
      LET g_xmdl_d.xmdl003 = p_docno            #訂單單號
      LET g_xmdl_d.xmdl004 = p_seq              #訂單項次
      LET g_xmdl_d.xmdl005 = p_seq1             #訂單項序
      LET g_xmdl_d.xmdl006 = p_seq2             #訂單分批序
      
      #待出貨數量
      LET g_xmdl_d.qua = 0
      LET l_ship = 0      
      CALL s_axmt540_get_max_ship_qty('2','','',p_docno,p_seq,p_seq1,p_seq2)
        RETURNING l_ship,g_xmdl_d.qua                 
      IF g_xmdl_d.qua < = 0 THEN    
         LET r_success = FALSE
         RETURN r_success              
      END IF 
      SELECT xmdd003,xmdd001,xmdd002, xmdc004, xmdc005,
             xmdd004,xmdc028,xmdc029, xmdc030, xmdc057
        INTO g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,
             g_xmdl_d.xmdl017,g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,g_xmdl_d.xmdl052
        FROM xmdd_t,xmdc_t
       WHERE xmddent = xmdcent
         AND xmdddocno = xmdcdocno
         AND xmddseq = xmdcseq       
         AND xmddent = g_enterprise
         AND xmdddocno = p_docno
         AND xmddseq = p_seq
         AND xmddseq1 = p_seq1
         AND xmddseq2 = p_seq2

        
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = "SELECT xmda_t"
        LET g_errparam.code   = SQLCA.sqlcode
        LET g_errparam.popup  = FALSE
        CALL cl_err()
        LET r_success = FALSE
        RETURN r_success    
     ELSE
        #161230-00019#5-s-add
        LET l_xmda028 = ''
        SELECT xmda028 INTO l_xmda028
          FROM xmda_t
         WHERE xmdaent = g_enterprise
           AND xmdadocno = p_docno
        #161230-00019#5-e-add
        
        IF p_type = '1' THEN
        #mod--161109-00085#10-s
        #INSERT INTO p540_01_xmdh VALUES (g_xmdl_d.*)        
        INSERT INTO p540_01_xmdh(sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                 xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                 xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                 xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                 xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                 #161230-00019#5-s-mod
#                                 xmdh029)
                                 xmdh029,xmda028)
                                 #161230-00019#5-e-mod
        VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
               #161230-00019#5-s-mod
#               g_xmdl_d.xmdl052)
               g_xmdl_d.xmdl052,l_xmda028)
               #161230-00019#5-e-mod
        #mod--161109-00085#10-e               
        ELSE
        #mod--161109-00085#10-s
        #INSERT INTO p540_01_xmdh2 VALUES (g_xmdl_d.*)        
        INSERT INTO p540_01_xmdh2(sel,    xmda004,  source, xmdhdocno,xmdhseq,
                                  xmdh001,xmdadocdt,xmda002,xmdh002,  xmdh003,
                                  xmdh004,xmda033,  xmdh005,xmdh006,  xmdh007,
                                  xmdh009,xmdh010,  xmdh015,xmdc012,  days,
                                  xmdh016,xmdh017,  xmdh012,xmdh013,  xmdh014,
                                  #161230-00019#5-s-mod
#                                 xmdh029)
                                 xmdh029,xmda028)
                                 #161230-00019#5-e-mod
        VALUES (g_xmdl_d.sel,    g_xmdl_d.xmda004,  g_xmdl_d.source, g_xmdl_d.xmdl001,g_xmdl_d.xmdl002,
                g_xmdl_d.xmdl003,g_xmdl_d.xmdadocdt,g_xmdl_d.xmda002,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
                g_xmdl_d.xmdl006,g_xmdl_d.xmda033,  g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,
                g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,  g_xmdl_d.xmdl017,g_xmdl_d.xmdc012,g_xmdl_d.days,
                g_xmdl_d.qua,    g_xmdl_d.xmdl018,  g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,
                #161230-00019#5-s-mod
#               g_xmdl_d.xmdl052)
               g_xmdl_d.xmdl052,l_xmda028)
               #161230-00019#5-e-mod
        #mod--161109-00085#10-e               
        END IF   
     END IF        
                   
     RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 全選、取消全選功能
# Memo...........:
# Usage..........: CALL axmp540_01_sel(p_type)
#                  RETURNING
# Input parameter: p_type   類型CS：客戶全選 OS：訂單全選 AS：全選 S：單選 US：取消單選 UA：取消全選
# Return code....: 
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_01_sel(p_type)
DEFINE  p_type  LIKE type_t.chr5  #CS：客戶全選 OS：訂單全選 AS：全選 S：單選 US：取消單選 UA：取消全選
DEFINE  i       LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 

   WHENEVER ERROR CONTINUE

   IF g_current_page = '1' THEN
      #ming 20151109 add -----(S) 
      IF g_xmdh_d.getLength() <= 0 THEN 
         RETURN 
      END IF 
      #ming 20151109 add -----(E) 
      
      CASE p_type
        WHEN 'CS'
          #客戶全選
          FOR i = 1 TO g_xmdh_d.getLength()
              IF g_xmdh_d[i].xmda004_01 = g_xmdh_d[g_detail_idx].xmda004_01 THEN
                 LET g_xmdh_d[i].sel_01 = 'Y'
                 #本次出貨量=待出貨數量
                 LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016_01             
              END IF
          END FOR
        WHEN 'OS'
          #訂單全選
          FOR i = 1 TO g_xmdh_d.getLength()
              IF g_xmdh_d[i].xmdh001_01 = g_xmdh_d[g_detail_idx].xmdh001_01 THEN
                 LET g_xmdh_d[i].sel_01 = 'Y'
                 #本次出貨量=待出貨數量
                 LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016_01             
              END IF
          END FOR
        WHEN 'AS'
          #全選
          FOR i = 1 TO g_xmdh_d.getLength()
              LET g_xmdh_d[i].sel_01 = 'Y'
              #本次出貨量=待出貨數量
              LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016_01             
          END FOR         
        WHEN 'S'
          #單選
          LET g_xmdh_d[g_detail_idx].sel_01 = 'Y'
          #本次出貨量=待出貨數量
          LET g_xmdh_d[g_detail_idx].xmdh017_01 = g_xmdh_d[g_detail_idx].xmdh016_01               
        WHEN 'US'
          #取消單選
          LET g_xmdh_d[g_detail_idx].sel_01 = 'N'
          LET g_xmdh_d[g_detail_idx].xmdh017_01 = 0          
        WHEN 'UA'
          #取消全選
          FOR i = 1 TO g_xmdh_d.getLength()
              LET g_xmdh_d[i].sel_01 = 'N'
              LET g_xmdh_d[i].xmdh017_01 = 0            
          END FOR
      END CASE
      
      DISPLAY ARRAY g_xmdh_d TO s_detail1_axmp540_01.* ATTRIBUTE(COUNT=g_detail_cnt)
         BEFORE DISPLAY
            EXIT DISPLAY
      END DISPLAY      
   ELSE
      #ming 20151109 add -----(S) 
      IF g_xmdh2_d.getLength() <= 0 THEN 
         RETURN 
      END IF 
      #ming 20151109 add -----(E) 
      CASE p_type
        WHEN 'CS'
          #客戶全選
          FOR i = 1 TO g_xmdh2_d.getLength()
              IF g_xmdh2_d[i].xmda004_02 = g_xmdh2_d[g_detail2_idx].xmda004_02 THEN
                 LET g_xmdh2_d[i].sel_02 = 'Y'
                 #本次出貨量=待出貨數量
                 LET g_xmdh2_d[i].xmdh017_02 = g_xmdh2_d[i].xmdh016_02             
              END IF
          END FOR  
        WHEN 'OS'
          #訂單全選
          FOR i = 1 TO g_xmdh2_d.getLength()
              IF g_xmdh2_d[i].xmdh001_02 = g_xmdh2_d[g_detail2_idx].xmdh001_02 THEN
                 LET g_xmdh2_d[i].sel_02 = 'Y'
                 #本次出貨量=待出貨數量
                 LET g_xmdh2_d[i].xmdh017_02 = g_xmdh2_d[i].xmdh016_02             
              END IF
          END FOR
        WHEN 'AS'
          #全選
           FOR i = 1 TO g_xmdh2_d.getLength()
              LET g_xmdh2_d[i].sel_02 = 'Y'
              #本次出貨量=待出貨數量
              LET g_xmdh2_d[i].xmdh017_02 = g_xmdh2_d[i].xmdh016_02             
          END FOR       
        WHEN 'S'
          #單選
          LET g_xmdh2_d[g_detail2_idx].sel_02 = 'Y'
          #本次出貨量=待出貨數量
          LET g_xmdh2_d[g_detail2_idx].xmdh017_02 = g_xmdh2_d[g_detail2_idx].xmdh016_02               
        WHEN 'US'
          #取消單選
          LET g_xmdh2_d[g_detail2_idx].sel_02 = 'N'
          LET g_xmdh2_d[g_detail2_idx].xmdh017_02 = 0          
        WHEN 'UA'
          #取消全選
          FOR i = 1 TO g_xmdh2_d.getLength()
              LET g_xmdh2_d[i].sel_02 = 'N'
              LET g_xmdh2_d[i].xmdh017_02 = 0            
          END FOR
      END CASE   
      DISPLAY ARRAY g_xmdh2_d TO s_detail2_axmp540_01.* ATTRIBUTE(COUNT=g_detail2_cnt)
        BEFORE DISPLAY
          EXIT DISPLAY
    END DISPLAY 
   END IF  


END FUNCTION

################################################################################
# Descriptions...: 串單別
# Memo...........:
# Usage..........: CALL axmp540_01_doc_wc()
#                  RETURNING r_doc_wc
# Input parameter: 
# Return code....: r_doc_wc  單別條件
# Date & Author..: 160414-00002#2 By 02040 
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_01_doc_wc()

   DEFINE  l_doc_sql     STRING
   DEFINE  l_doc_flag    LIKE type_t.chr1
   DEFINE  l_doc         LIKE ooba_t.ooba001
   DEFINE  l_ooef004     LIKE ooef_t.ooef004
   DEFINE  r_doc_wc      STRING
   
   

   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   #串單別WHERE條件，只撈D-BAS-0077 = 'N'
   LET l_doc_sql = " SELECT DISTINCT ooba002 ",
                   "   FROM ooba_t,oobl_t,ooac_t",
                   "  WHERE oobaent = ooblent AND ooba002 = oobl001 AND oobl002 = 'axmt500' ",
                   "    AND oobaent = ooacent AND ooba001 = ooac001 AND ooba002 = ooac002 ",
                   "    AND oobaent = ",g_enterprise,
                   "     AND ooba001 = '",l_ooef004,"' ",
                   "    AND oobastus = 'Y' ",
                   "    AND ooac003 = 'D-BAS-0077' AND ooac004 = 'N' "
   PREPARE p540_01_doc_p FROM l_doc_sql
   DECLARE p540_01_doc_c CURSOR FOR p540_01_doc_p
   
   LET r_doc_wc = ''   
   LET l_doc_flag = 'N'
   FOREACH p540_01_doc_c INTO l_doc
     IF l_doc_flag = 'N' THEN
        LET l_doc_flag = 'Y'
        LET r_doc_wc = " ( xmdadocno LIKE '%",l_doc,"%' "
     ELSE          
       LET r_doc_wc = r_doc_wc," OR xmdadocno LIKE '%",l_doc,"%' "
     END IF
   END FOREACH
   IF cl_null(r_doc_wc) THEN
      LET r_doc_wc = ' 1=1'
   ELSE
      LET r_doc_wc = r_doc_wc CLIPPED,")"
   END IF

   RETURN r_doc_wc

END FUNCTION

 
{</section>}
 
