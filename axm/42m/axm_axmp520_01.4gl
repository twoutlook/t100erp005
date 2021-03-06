#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp520_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-09-26 11:58:43), PR版次:0014(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: axmp520_01
#+ Description: 待出貨資料
#+ Creator....: 02040(2015-06-05 10:14:54)
#+ Modifier...: 06948 -SD/PR- 00000
 
{</section>}
 
{<section id="axmp520_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#35   2016/04/15 BY pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#23   2016/08/15 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   axmp520_lock_b_t--> axmp520_tmp01
#160808-00016#1    2016/08/18 By 02097     修正金额计算方式
#160913-00033#1    2016/09/26 By 06948     約定交貨日改抓xmdd011 (xmdc012 -> xmdd011)，調整axmp520、axmp520_01規格畫面及程式
#160706-00037#12   2016/10/24 By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#161101-00013#1    2016/11/01 By fionchen  調整計算剩餘出通量問題
#161109-00085#10   2016/11/10 By lienjunqi 整批調整系統星號寫法
#170104-00066#3    2017/01/06 By Rainy     筆數相關變數由num5放大至num10
#161006-00018#24   2017/01/16 By 02040     增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
#161230-00019#4    2017/02/06 By shiun     引導式作業一次性交易對象處理，需加上對象識別碼為匯總條件，一次性交易對象不同識別碼者需拆單
#161205-00025#14   2017/02/09 By shiun     效能調整
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../axm/4gl/axmp520_01.inc"
GLOBALS "../../axm/4gl/axmp520_02.inc"
#end add-point
 
{</section>}
 
{<section id="axmp520_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
                    
 TYPE type_g_xmdh_d RECORD
             sel            LIKE type_t.chr1,                    #選擇
             xmda004        LIKE xmda_t.xmda004,                 #客戶
             xmda004_desc   LIKE type_t.chr500,
             xmdh001        LIKE xmdh_t.xmdh001,                 #訂單單號
             xmdadocdt      LIKE xmda_t.xmdadocdt,               #訂單日期
             xmda002        LIKE xmda_t.xmda002,                 #業務員
             xmda002_desc   LIKE type_t.chr500,                 
             xmdh002        LIKE xmdh_t.xmdh002,                 #訂單項次
             xmdh003        LIKE xmdh_t.xmdh003,                 #訂單項序
             xmdh004        LIKE xmdh_t.xmdh004,                 #訂單分批序
             xmda033        LIKE xmda_t.xmda033,                 #客戶訂購單號
             xmdh005        LIKE xmdh_t.xmdh005,                 #子件特性
             xmdh006        LIKE xmdh_t.xmdh006,
             imaal003       LIKE imaal_t.imaal003,
             imaal004       LIKE imaal_t.imaal004,
             xmdh007        LIKE xmdh_t.xmdh007,
             xmdh007_desc   LIKE type_t.chr500,
             xmdh009        LIKE xmdh_t.xmdh009,
             xmdh009_desc   LIKE type_t.chr500,
             xmdh010        LIKE xmdh_t.xmdh010,
             xmdh015        LIKE xmdh_t.xmdh015,
             xmdh015_desc   LIKE type_t.chr500,
            #xmdc012        LIKE xmdc_t.xmdc012,       #160913-00033#1 mark
             xmdd011        LIKE xmdd_t.xmdd011,       #160913-00033#1 add
             days           LIKE type_t.num5,                     #逾期天數
             xmdh016        LIKE xmdh_t.xmdh016,
             xmdh017_01    LIKE xmdh_t.xmdh017,
             xmdh012_01    LIKE xmdh_t.xmdh012,
             xmdh012_01_desc  LIKE type_t.chr500,
             xmdh013_01    LIKE xmdh_t.xmdh013,
             xmdh013_01_desc  LIKE type_t.chr500,
             xmdh014_01    LIKE xmdh_t.xmdh014,
             xmdh029_01    LIKE xmdh_t.xmdh029
                           END RECORD

   
DEFINE g_rec_b             LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_xmdh_d            DYNAMIC ARRAY OF type_g_xmdh_d
DEFINE g_xmdh_d_t          type_g_xmdh_d
DEFINE l_ac                LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_xmda028           LIKE xmda_t.xmda028   #161230-00019#4
#end add-point
 
{</section>}
 
{<section id="axmp520_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmp520_01.other_dialog" >}

DIALOG axmp520_01_input01()

     INPUT ARRAY g_xmdh_d FROM s_detail1_axmp520.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                    INSERT ROW = FALSE,
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)
    
       BEFORE INPUT
          LET g_current_page = 1
          
       BEFORE ROW             
          LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_axmp520")
          LET l_ac = g_detail_idx
          LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*
          CALL axmp520_01_set_entry_b()
          CALL axmp520_01_set_no_entry_b()          
          
       ON CHANGE sel
          IF g_xmdh_d[l_ac].sel = 'Y' THEN
             LET g_xmdh_d[l_ac].xmdh017_01 = g_xmdh_d[l_ac].xmdh016
          ELSE
              LET g_xmdh_d[l_ac].xmdh017_01 = 0
          END IF
          CALL axmp520_01_set_entry_b()
          CALL axmp520_01_set_no_entry_b()       
      
       AFTER FIELD sel
          CALL axmp520_01_set_entry_b()
          CALL axmp520_01_set_no_entry_b() 
         
       AFTER FIELD xmdh017_01
          IF g_xmdh_d[l_ac].xmdh017_01 >  g_xmdh_d[l_ac].xmdh016 THEN
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
          LET g_xmdh_d[l_ac].xmdh012_01_desc = ''
          IF NOT cl_null(g_xmdh_d[l_ac].xmdh012_01) THEN
             IF g_xmdh_d[l_ac].xmdh012_01 != g_xmdh_d_t.xmdh012_01 OR g_xmdh_d_t.xmdh012_01 IS NULL THEN
                IF NOT axmp540_01_chk_xmdh012(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012_01) THEN
                   LET g_xmdh_d[l_ac].xmdh012_01 = g_xmdh_d_t.xmdh012_01
                   CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) 
                     RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
                   NEXT FIELD CURRENT
                END IF
             END IF
             CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) 
               RETURNING g_xmdh_d[l_ac].xmdh012_01_desc             
          END IF
          LET g_xmdh_d_t.xmdh012_01 = g_xmdh_d[l_ac].xmdh012_01
       
       AFTER FIELD xmdh013_01
          LET g_xmdh_d[l_ac].xmdh013_01_desc = ''            
          IF NOT cl_null(g_xmdh_d[l_ac].xmdh013_01) THEN
             IF g_xmdh_d[l_ac].xmdh013_01 != g_xmdh_d_t.xmdh013_01 OR g_xmdh_d_t.xmdh013_01 IS NULL THEN
                IF NOT axmp540_01_chk_xmdh013(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012_01,
                                              g_xmdh_d[l_ac].xmdh013_01) THEN
                   LET g_xmdh_d[l_ac].xmdh013_01 = g_xmdh_d_t.xmdh013_01
                   CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
                     RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
                   NEXT FIELD CURRENT
                END IF             
             END IF
             CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
               RETURNING g_xmdh_d[l_ac].xmdh013_01_desc             
          END IF            
          LET g_xmdh_d_t.xmdh013_01 = g_xmdh_d[l_ac].xmdh013_01
       
       AFTER FIELD xmdh014_01
          IF NOT cl_null(g_xmdh_d[l_ac].xmdh014_01) THEN
             IF g_xmdh_d[l_ac].xmdh014_01 != g_xmdh_d_t.xmdh014_01 OR g_xmdh_d_t.xmdh014_01 IS NULL THEN 
                IF NOT axmp540_01_chk_xmdh014(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012_01,
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
          LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006                      #料件
          LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007                      #產品特徵
          #呼叫開窗 
          CALL q_inag004_13() 
          #將開窗取得的值回傳到變數
          LET g_xmdh_d[l_ac].xmdh012_01 = g_qryparam.return1                      
          LET g_xmdh_d[l_ac].xmdh013_01 = g_qryparam.return2
          LET g_xmdh_d[l_ac].xmdh014_01 = g_qryparam.return3
          LET g_xmdh_d[l_ac].xmdh029_01 = g_qryparam.return4 
          #顯示到畫面上         
          CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) 
            RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
          CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
            RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
          DISPLAY BY NAME g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01,
                          g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01_desc
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
          LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006                      #料件
          LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007                      #產品特徵
          #呼叫開窗 
          CALL q_inag004_13() 
          #將開窗取得的值回傳到變數
          LET g_xmdh_d[l_ac].xmdh012_01 = g_qryparam.return1                      
          LET g_xmdh_d[l_ac].xmdh013_01 = g_qryparam.return2
          LET g_xmdh_d[l_ac].xmdh014_01 = g_qryparam.return3
          LET g_xmdh_d[l_ac].xmdh029_01 = g_qryparam.return4 
          #顯示到畫面上         
          CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01) 
            RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
          CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
            RETURNING g_xmdh_d[l_ac].xmdh013_01_desc
          DISPLAY BY NAME g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01,
                          g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01_desc
          NEXT FIELD xmdh013_01                     
    END INPUT  
    
END DIALOG

DIALOG axmp520_01_construct()
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_sql      STRING

       #160913-00033#1 --- mark (S)
       #CONSTRUCT g_wc ON xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdc012,xmdc001,imaf141
       #     FROM xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdc012,xmdc001,imaf141
       #160913-00033#1 --- mark (E)
       #160913-00033#1 --- add (S)
        CONSTRUCT g_wc ON xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdd011,xmdc001,imaf141
             FROM xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033,xmdd011,xmdc001,imaf141
       #160913-00033#1 --- add (E)

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

DIALOG axmp520_01_input()
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_flag     LIKE type_t.num5
    DEFINE l_ooef004  LIKE ooef_t.ooef004    

         INPUT g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg002,g_xmdg_m.xmdgdocdt FROM xmdgdocno,xmdg002,xmdgdocdt ATTRIBUTE(WITHOUT DEFAULTS)

              ON ACTION controlp INFIELD xmdgdocno
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                     LET l_ooef004 = ''
                     SELECT ooef004 INTO l_ooef004
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_site
                        AND ooefstus = 'Y'
                     LET g_qryparam.arg1 = l_ooef004
                     LET g_qryparam.arg2 = 'axmt520'
                     CALL q_ooba002_1()                     
                     LET g_xmdg_m.xmdgdocno = g_qryparam.return1       
                     DISPLAY g_xmdg_m.xmdgdocno TO xmdgdocno           
                     CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno)
                       RETURNING g_xmdg_m.xmdgdocno_desc
                     DISPLAY g_xmdg_m.xmdgdocno_desc  TO xmdgdocno_desc
                     NEXT FIELD xmdgdocno
                     
                 ON ACTION controlp INFIELD xmdg002
                    INITIALIZE g_qryparam.* TO NULL
                    LET g_qryparam.state = 'i'
                    LET g_qryparam.reqry = FALSE         
                    LET g_qryparam.default1 = g_xmdg_m.xmdg002     
                    CALL q_ooag001()                               
                    LET g_xmdg_m.xmdg002 = g_qryparam.return1      
                    DISPLAY g_xmdg_m.xmdg002 TO xmdg002            
                    CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) 
                      RETURNING g_xmdg_m.xmdg002_desc 
                    DISPLAY BY NAME g_xmdg_m.xmdg002_desc  
                    NEXT FIELD xmdg002                         
           
           
                     
              AFTER FIELD xmdgdocno
                 LET g_xmdg_m.xmdgdocno_desc = ''
                 DISPLAY BY NAME g_xmdg_m.xmdgdocno_desc                                 
                 IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
                    #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
                    CALL s_control_chk_doc('1',g_xmdg_m.xmdgdocno,'2',g_user,g_dept,'','')
                         RETURNING l_success,l_flag
                    IF l_success THEN
                       IF NOT l_flag THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'axm-00015'
                          LET g_errparam.extend = g_xmdg_m.xmdgdocno
                          LET g_errparam.popup = TRUE
                          CALL cl_err()           
                          NEXT FIELD CURRENT
                       END IF
                    ELSE
                       NEXT FIELD CURRENT
                    END IF           
                    IF NOT s_aooi200_chk_slip(g_site,'',g_xmdg_m.xmdgdocno,'axmt520') THEN
                       NEXT FIELD CURRENT
                    END IF
                    CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno)
                      RETURNING g_xmdg_m.xmdgdocno_desc
                    DISPLAY g_xmdg_m.xmdgdocno_desc  TO xmdgdocno_desc               
                 END IF
                 
              AFTER FIELD xmdg002      
                 LET g_xmdg_m.xmdg002_desc = ''
                 DISPLAY BY NAME g_xmdg_m.xmdg002_desc
                 IF NOT cl_null(g_xmdg_m.xmdg002) THEN              
                    INITIALIZE g_chkparam.* TO NULL
                    LET g_chkparam.arg1 = g_xmdg_m.xmdg002             
                    #160318-00025#35  2016/05/15  by pengxin  add(S)
                    LET g_errshow = TRUE #是否開窗 
                    LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                    #160318-00025#35  2016/05/15  by pengxin  add(E)
                    IF NOT cl_chk_exist("v_ooag001") THEN
                       NEXT FIELD CURRENT
                    END IF
                    CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc
                    DISPLAY BY NAME g_xmdg_m.xmdg002_desc                    
                 END IF
            
         END INPUT 
END DIALOG

 
{</section>}
 
{<section id="axmp520_01.other_function" readonly="Y" >}

PUBLIC FUNCTION axmp520_01(--)
   #add-point:input段變數傳入
   p_wc
   #end add-point
   )
   DEFINE p_wc       STRING
   DEFINE l_sql      STRING
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_slip     LIKE ooba_t.ooba001    #單別  
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_xmdh016  LIKE xmdh_t.xmdh016
   DEFINE l_xmda_d RECORD             
            xmda004      LIKE xmda_t.xmda004,                 
            xmdh001      LIKE xmdh_t.xmdh001,
            xmdadocdt    LIKE xmda_t.xmdadocdt,
            xmda002      LIKE xmda_t.xmda002,
            xmdh002      LIKE xmdh_t.xmdh002,
            xmdh003      LIKE xmdh_t.xmdh003,
            xmdh004      LIKE xmdh_t.xmdh004,
            xmda033      LIKE xmda_t.xmda033,
            xmdh005      LIKE xmdh_t.xmdh005,
            xmdh006      LIKE xmdh_t.xmdh006,
            xmdh007      LIKE xmdh_t.xmdh007,
            xmdh009      LIKE xmdh_t.xmdh009,
            xmdh010      LIKE xmdh_t.xmdh010,
            xmdh015      LIKE xmdh_t.xmdh015,
           #xmdc012      LIKE xmdc_t.xmdc012,       #160913-00033#1 mark
            xmdd011      LIKE xmdd_t.xmdd011,       #160913-00033#1 add
            days         LIKE type_t.num5,              
            xmdh016      LIKE xmdh_t.xmdh016,
            xmdh017      LIKE xmdh_t.xmdh017,                 
            xmdh012      LIKE xmdh_t.xmdh012,
            xmdh013      LIKE xmdh_t.xmdh013,
            xmdh014      LIKE xmdh_t.xmdh014,
            xmdh029      LIKE xmdh_t.xmdh029
                   END RECORD 
   DEFINE l_xmdd006      LIKE xmdd_t.xmdd006     #161101-00013#1 add
   DEFINE l_xmdd016      LIKE xmdd_t.xmdd016     #161101-00013#1 add   


   WHENEVER ERROR CONTINUE

   IF cl_null(p_wc) THEN
      LET p_wc = '1=1'
   END IF

   #清空tmptable
   DELETE FROM p520_01_xmdh
   DELETE FROM p520_01_tmp 

   LET l_sql = "SELECT  xmda004,xmdadocno,xmdadocdt,xmda002,xmddseq, ",
               "       xmddseq1, xmddseq2,  xmda033,xmdd003,xmdd001, ",
              #"        xmdd002,  xmdc004,  xmdc005,xmdd004,xmdc012, ",      #160913-00033#1 mark
               "        xmdd002,  xmdc004,  xmdc005,xmdd004,xmdd011, ",      #160913-00033#1 add
              #"              0,COALESCE(xmdd006,0)-COALESCE(xmdd016,0)+COALESCE(xmdd031,0), ",    #160808-00016#1 mark
               #161205-00025#14-s-mod
#               "              0,COALESCE(xmdd006,0)-COALESCE(xmdd031,0)+COALESCE(xmdd016,0), ",    #160808-00016#1
               "              0,COALESCE(xmdd006,0)+COALESCE(xmdd016,0)- ",
               "                COALESCE((SELECT SUM(xmdh016) ",
               "                           FROM xmdh_t,xmdg_t ",
               "                          WHERE xmdhent = ",g_enterprise,
               "                            AND xmdhsite = '",g_site,"' ",
               "                            AND xmdh001 = xmdadocno ",
               "                            AND xmdh002 = xmddseq ",
               "                            AND xmdh003 = xmddseq1 ",
               "                            AND xmdh004 = xmddseq2 ",
               "                            AND xmdgent = xmdhent ",
               "                            AND xmdgsite = xmdhsite ",
               "                            AND xmdgdocno = xmdhdocno ",
               "                            AND xmdgstus <> 'X'),0) l_xmdh016, ",
               #161205-00025#14-e-mod
               "              0,  xmdc028,  xmdc029,xmdc030,xmdc057  ",
               "       ,xmdd006,xmdd016 ",                  #161101-00013#1 add
               "       ,xmda028 ",                          #161230-00019#4 add
               "       ,xmdddocno ",                        #161205-00025#14 add
               "  FROM xmda_t,xmdc_t ",
               "  LEFT OUTER JOIN xmdd_t  ON xmddent = xmdcent AND xmdddocno = xmdcdocno AND xmddseq = xmdcseq ",
               "  LEFT OUTER JOIN imaf_t  ON imafent = xmdcent AND imafsite = xmdcsite AND imaf001 = xmdc001 ",
               "  LEFT OUTER JOIN inac_t  ON inacent = xmdcent AND inacsite = xmdcsite AND inac001 = xmdc028 AND inac002 = xmdc029 ",
               " WHERE xmdaent = '",g_enterprise,"' ",
               "   AND xmdasite = '",g_site,"' ",
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",                                                 
               "   AND xmdastus = 'Y' ",                                                      
               "   AND xmda005 <> '5' ",                            #需排捈訂單性質為'5'預先訂單
               "   AND xmdc045 = '1' ",                             #[T.訂單單身明細檔].[C.狀態碼]='1'                
               "   AND  ",p_wc        
   #161205-00025#14-s-add
   LET l_sql = "SELECT  xmda004,xmdadocno,xmdadocdt,xmda002,xmddseq, ",
               "       xmddseq1, xmddseq2,  xmda033,xmdd003,xmdd001, ",
               "        xmdd002,  xmdc004,  xmdc005,xmdd004,xmdd011, ",
               "              0,l_xmdh016,        0,xmdc028,xmdc029, ",
               "        xmdc030,  xmdc057,  xmdd006,xmdd016,xmda028 ",
               "  FROM ( ",l_sql,") ",
               " WHERE l_xmdh016 > 0 ",
   #161205-00025#14-e-add
               " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "    
                                
   PREPARE p520_01_prep FROM l_sql
   DECLARE p520_01_curs CURSOR FOR p520_01_prep    
   
  
   INITIALIZE l_xmda_d TO NULL
  #FOREACH p520_01_curs INTO l_xmda_d.*                           #161101-00013#1 mark
  #mod--161109-00085#10-s
   #FOREACH p520_01_curs INTO l_xmda_d.*,l_xmdd006,l_xmdd016       #161101-00013#1 add
   FOREACH p520_01_curs INTO l_xmda_d.xmda004,l_xmda_d.xmdh001,l_xmda_d.xmdadocdt,l_xmda_d.xmda002,l_xmda_d.xmdh002,
                             l_xmda_d.xmdh003,l_xmda_d.xmdh004,l_xmda_d.xmda033,l_xmda_d.xmdh005,l_xmda_d.xmdh006,
                             l_xmda_d.xmdh007,l_xmda_d.xmdh009,l_xmda_d.xmdh010,l_xmda_d.xmdh015,l_xmda_d.xmdd011,
                             l_xmda_d.days,l_xmda_d.xmdh016,l_xmda_d.xmdh017,l_xmda_d.xmdh012,l_xmda_d.xmdh013,
                             l_xmda_d.xmdh014,l_xmda_d.xmdh029,l_xmdd006,l_xmdd016      
                             ,g_xmda028   #161230-00019#4 add
  #mod--161109-00085#10-e     
       CALL s_aooi200_get_slip(l_xmda_d.xmdh001) RETURNING l_success,l_slip    #取單別 
       IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0077') = 'N' THEN
          INITIALIZE l_xmda_d TO NULL
          CONTINUE FOREACH 
       END IF
       #161205-00025#14-s-mark
#       LET l_xmdh016 = 0
#       SELECT SUM(xmdh016) INTO l_xmdh016
#         FROM xmdh_t,xmdg_t
#        WHERE xmdhent = g_enterprise
#          AND xmdhsite = g_site
#          AND xmdh001 = l_xmda_d.xmdh001
#          AND xmdh002 = l_xmda_d.xmdh002
#          AND xmdh003 = l_xmda_d.xmdh003
#          AND xmdh004 = l_xmda_d.xmdh004
#          AND xmdgent = xmdhent
#          AND xmdgsite = xmdhsite
#          AND xmdgdocno = xmdhdocno
#          AND xmdgstus <> 'X'  #160804-00007 by whitney modify = 'N' ->  <> 'X'
#       IF cl_null(l_xmdh016) THEN LET l_xmdh016 = 0 END IF  
#       IF cl_null(l_xmdd006) THEN LET l_xmdd006 = 0 END IF         #161101-00013#1 add
#       IF cl_null(l_xmdd016) THEN LET l_xmdd016 = 0 END IF         #161101-00013#1 add       
#      #LET l_xmda_d.xmdh016 = l_xmda_d.xmdh016 - l_xmdh016         #161101-00013#1 mark
#       LET l_xmda_d.xmdh016 = l_xmdd006 - l_xmdh016 + l_xmdd016    #161101-00013#1 add       
#       IF l_xmda_d.xmdh016 <= 0 THEN
#          INITIALIZE l_xmda_d TO NULL
#          CONTINUE FOREACH 
#       END IF
       #161205-00025#14-e-mark
      #LET l_xmda_d.days = g_today - l_xmda_d.xmdc012           #逾期天數    #160913-00033#1 mark
       LET l_xmda_d.days = g_today - l_xmda_d.xmdd011           #逾期天數    #160913-00033#1 add


       #mod--161109-00085#10-s
       #INSERT INTO p520_01_xmdh VALUES (l_xmda_d.*)
       INSERT INTO p520_01_xmdh(xmda004,xmdh001,xmdadocdt,xmda002,xmdh002,
                                xmdh003,xmdh004,xmda033,xmdh005,xmdh006,xmdh007,
                                xmdh009,xmdh010,xmdh015,xmdd011,days,xmdh016,
                                #161230-00019#4-s-mod
#                                xmdh017,xmdh012,xmdh013,xmdh014,xmdh029) 
                                xmdh017,xmdh012,xmdh013,xmdh014,xmdh029,xmda028) 
                                #161230-00019#4-e-mod
       VALUES (l_xmda_d.xmda004,l_xmda_d.xmdh001,l_xmda_d.xmdadocdt,l_xmda_d.xmda002,l_xmda_d.xmdh002,
               l_xmda_d.xmdh003,l_xmda_d.xmdh004,l_xmda_d.xmda033,l_xmda_d.xmdh005,l_xmda_d.xmdh006,l_xmda_d.xmdh007,
               l_xmda_d.xmdh009,l_xmda_d.xmdh010,l_xmda_d.xmdh015,l_xmda_d.xmdd011,l_xmda_d.days,l_xmda_d.xmdh016,
               #161230-00019#4-s-mod
#               l_xmda_d.xmdh017,l_xmda_d.xmdh012,l_xmda_d.xmdh013,l_xmda_d.xmdh014,l_xmda_d.xmdh029)
               l_xmda_d.xmdh017,l_xmda_d.xmdh012,l_xmda_d.xmdh013,l_xmda_d.xmdh014,l_xmda_d.xmdh029,g_xmda028)
               #161230-00019#4-e-mod
          #mod--161109-00085#10-e
   
          END FOREACH  
   
END FUNCTION
#畫面初始設定
PUBLIC FUNCTION axmp520_01_init()
   WHENEVER ERROR CONTINUE   
   
   LET g_xmdg_m.xmdg002 = g_user
   CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc    
   LET g_xmdg_m.xmdgdocdt = cl_get_current()   
   DISPLAY BY NAME g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdgdocdt   
   CALL cl_set_combo_scc("xmdh005","2055")
   
END FUNCTION
#設定右方button的顯示與隱藏
PUBLIC FUNCTION axmp520_01_set_act_visible()

   WHENEVER ERROR CONTINUE

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
#建立temptable
PUBLIC FUNCTION axmp520_01_create_temp_table()
   DEFINE r_success         LIKE type_t.num5
  
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   CREATE TEMP TABLE p520_01_xmdh(                        #待出通資料                   
                    xmda004       VARCHAR(10),                 
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
                   #xmdc012      LIKE xmdc_t.xmdc012,       #160913-00033#1 mark
                    xmdd011       DATE,            #160913-00033#1 add
                    days          SMALLINT,              
                    xmdh016       DECIMAL(20,6),
                    xmdh017       DECIMAL(20,6),                 
                    xmdh012       VARCHAR(10),
                    xmdh013       VARCHAR(10),
                    xmdh014       VARCHAR(30),
                    xmdh029       VARCHAR(30),
                    xmda028       VARCHAR(20))            #161230-00019#4   add xmda028
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_01_xmdh'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   
   CREATE TEMP TABLE p520_01_tmp(                         #出通資料(底稿)        
                    xmdh001   VARCHAR(20),              #訂單單號
                    xmdh002   INTEGER,              #訂單項次
                    xmdh003   INTEGER,              #訂單項序
                    xmdh004   INTEGER,              #訂單分批序
                    xmdh017   DECIMAL(20,6),              #出通量
                    xmdh012   VARCHAR(10),              #庫位
                    xmdh013   VARCHAR(10),              #儲位
                    xmdh014   VARCHAR(30),              #批號
                    xmdh029   VARCHAR(30),              #庫存管理特徵
                    linkno    SMALLINT)                 #匯總後單頭和單身link_no

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   #160120-00002#1 s983961--add(s)
   CREATE TEMP TABLE axmp520_tmp01(           #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
      xmdcdocno               VARCHAR(20),
      xmdcseq                 INTEGER
   )
   #160120-00002#1 s983961--add(e)
   
   RETURN r_success   
END FUNCTION
#刪除TEMPTABLE
PUBLIC FUNCTION axmp520_01_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   DROP TABLE p520_01_xmdh;
  
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p520_01_xmdh'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
   DROP TABLE p520_01_tmp;
   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p520_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   
   #160120-00002#3 s983961--add(s) 
   DROP TABLE axmp520_tmp01;                 #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmp520_tmp01'         #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   #160120-00002#3 s983961--add(e) 
   RETURN r_success
END FUNCTION
#單身顯示
PUBLIC FUNCTION axmp520_01_b_fill()
   DEFINE l_sql       STRING
   DEFINE l_ac_t      LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_cnt       LIKE type_t.num5
   #160120-00002#1 s983961--add(s)   
   DEFINE l_where     STRING
   DEFINE l_xmdcdocno LIKE xmdc_t.xmdcdocno
   DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq 
   #160120-00002#1 s983961--add(e) 
   DEFINE l_xmda028   LIKE xmda_t.xmda028   #161230-00019#4

   WHENEVER ERROR CONTINUE

   INITIALIZE g_xmdh_d TO NULL
    
    #待出貨資料
    LET l_sql = "SELECT     'N',xmda004,     '',xmdh001,xmdadocdt, ", 
                "       xmda002,     '',xmdh002,xmdh003,  xmdh004, ",
                "       xmda033,xmdh005,xmdh006,     '',       '', ",
                "       xmdh007,     '',xmdh009,     '',  xmdh010, ",
               #"       xmdh015,     '',xmdc012,   days,  xmdh016, ",     #160913-00033#1 mark
                "       xmdh015,     '',xmdd011,   days,  xmdh016, ",     #160913-00033#1 add
                "       xmdh017,xmdh012,     '',xmdh013,       '', ",
                "       xmdh014,  xmdh029  ",
                "       ,xmda028 ",   #161230-00019#4 add
                "  FROM p520_01_xmdh ",   
                " WHERE xmdh001||xmdh002||xmdh003||xmdh004 ",
                "    NOT IN (SELECT xmdh001||xmdh002||xmdh003||xmdh004 FROM p520_01_tmp) ",  
                " ORDER BY days DESC" 
    PREPARE axmp520_sel_xmdh_pr FROM l_sql
    DECLARE axmp520_sel_xmdh_cs CURSOR FOR axmp520_sel_xmdh_pr
    LET l_ac_t = l_ac    
    LET l_ac = 1 
    #mod--161109-00085#10-s
    #FOREACH axmp520_sel_xmdh_cs INTO g_xmdh_d[l_ac].* 
    FOREACH axmp520_sel_xmdh_cs 
    INTO g_xmdh_d[l_ac].sel,g_xmdh_d[l_ac].xmda004,g_xmdh_d[l_ac].xmda004_desc,g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdadocdt,
         g_xmdh_d[l_ac].xmda002,g_xmdh_d[l_ac].xmda002_desc,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,      
         g_xmdh_d[l_ac].xmda033,g_xmdh_d[l_ac].xmdh005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].imaal003,g_xmdh_d[l_ac].imaal004,
         g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh007_desc,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh009_desc,g_xmdh_d[l_ac].xmdh010,
         g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh015_desc,g_xmdh_d[l_ac].xmdd011,g_xmdh_d[l_ac].days,
         g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh017_01,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01,
         #161230-00019#4-s-mod
#         g_xmdh_d[l_ac].xmdh013_01_desc,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01
         g_xmdh_d[l_ac].xmdh013_01_desc,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01,g_xmda028
         #161230-00019#4-e-mod
    #mod--161109-00085#10-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp520_sel_xmdh_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
      
      #160120-00002#1 s983961--add(s)  
      #檢查請購單的資料是否已經被lock 
      LET l_xmdcdocno = '' 
      LET l_xmdcseq = '' 

      
      LET l_sql = "SELECT xmdcdocno,xmdcseq ", 
                  "  FROM xmdc_t ", 
                  " WHERE xmdcent   = '",g_enterprise,"' ", 
                  "   AND xmdcdocno = '",g_xmdh_d[l_ac].xmdh001,"' ", 
                  "   AND xmdcseq = '",g_xmdh_d[l_ac].xmdh002,"' ", 
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE axmp520_01_chk_locked_prep FROM l_sql 
      EXECUTE axmp520_01_chk_locked_prep INTO l_xmdcdocno,l_xmdcseq
      IF cl_null(l_xmdcdocno) AND cl_null(l_xmdcseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#1 s983961--add(e)  
      
      CALL axmp520_01_detail_show()
      
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
    CLOSE axmp520_sel_xmdh_cs
    FREE axmp520_sel_xmdh_pr 
END FUNCTION

################################################################################
# Descriptions...: 選擇功能
# Memo...........:
# Usage..........: CALL axmp520_01_sel_action(p_type)
#                  RETURNING 
# Input parameter: p_type      類型 CS：客戶全選 OS：訂單全選 AS：全選 S：單選 US：取消單選 UA：取消全選 
# Return code....: 
# Date & Author..: 20150713 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_01_sel_action(p_type)
DEFINE p_type LIKE type_t.chr5
DEFINE i      LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 

   WHENEVER ERROR CONTINUE
   
    #CS：客戶全選  OS：訂單全選   AS：全選   S：單選   US：取消單選   UA：取消全選 
    IF g_detail_idx = 0 THEN
       RETURN
    END IF
    CASE p_type
      WHEN 'CS'    
        #客戶全選
        FOR i = 1 TO g_xmdh_d.getLength()
            IF g_xmdh_d[i].xmda004 = g_xmdh_d[g_detail_idx].xmda004 THEN
               LET g_xmdh_d[i].sel = 'Y'
               #本次出貨量=待出貨數量
               LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016             
            END IF
        END FOR
      WHEN 'OS'     
          #訂單全選
          FOR i = 1 TO g_xmdh_d.getLength()
              IF g_xmdh_d[i].xmdh001 = g_xmdh_d[g_detail_idx].xmdh001 THEN
                 LET g_xmdh_d[i].sel = 'Y'
                 #本次出貨量=待出貨數量
                 LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016             
              END IF
          END FOR
      WHEN 'AS'     
          #全選
          FOR i = 1 TO g_xmdh_d.getLength()
              LET g_xmdh_d[i].sel = 'Y'
              #本次出貨量=待出貨數量
              LET g_xmdh_d[i].xmdh017_01 = g_xmdh_d[i].xmdh016                          
          END FOR      
      WHEN 'S'     
          #單選
          LET g_xmdh_d[g_detail_idx].sel = 'Y'
          #本次出貨量=待出貨數量
          LET g_xmdh_d[g_detail_idx].xmdh017_01 = g_xmdh_d[g_detail_idx].xmdh016                          
      WHEN "UA"
          #取消全選
          FOR i = 1 TO g_xmdh_d.getLength()
              LET g_xmdh_d[i].sel = 'N'
              LET g_xmdh_d[i].xmdh017_01 = 0            
          END FOR    
      WHEN 'US'     
          #單選
          LET g_xmdh_d[g_detail_idx].sel = 'N'
          #本次出貨量=待出貨數量
          LET g_xmdh_d[g_detail_idx].xmdh017_01 = 0           
    END CASE      
    DISPLAY ARRAY g_xmdh_d TO s_detail1_axmp520.* ATTRIBUTE(COUNT=g_detail_cnt)
       BEFORE DISPLAY
         EXIT DISPLAY
    END DISPLAY       

END FUNCTION
#欄位開放設定
PUBLIC FUNCTION axmp520_01_set_entry_b()
   WHENEVER ERROR CONTINUE   
   
   CALL cl_set_comp_entry("xmdh017_01,xmdh012_01,xmdh013_01,xmdh014_01,xmdh029_01",TRUE)     #本次出貨數、庫位、儲位、批號、庫存管理特徵
END FUNCTION
#欄位關閉設定
PUBLIC FUNCTION axmp520_01_set_no_entry_b()
   DEFINE l_inaa007   LIKE inaa_t.inaa007
   DEFINE l_xmdc022   LIKE xmdc_t.xmdc022
   DEFINE l_xmdc028   LIKE xmdc_t.xmdc028
   DEFINE l_xmdc029   LIKE xmdc_t.xmdc029
   DEFINE l_xmdc030   LIKE xmdc_t.xmdc030
   DEFINE l_xmdcsite  LIKE xmdc_t.xmdcsite
  #161006-00018#24-s-add
   DEFINE l_flag2     LIKE type_t.num5
   DEFINE l_ooac002   LIKE ooac_t.ooac002
   DEFINE l_ooac004   LIKE ooac_t.ooac004
  #161006-00018#24-e-add   

   WHENEVER ERROR CONTINUE
   
     #161006-00018#24-s-add
      CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_flag2,l_ooac002
      CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
     #161006-00018#24-e-add

      IF g_mode = 'd' OR g_xmdh_d[l_ac].sel = 'N' THEN                                              #底稿模式不需開啟庫儲批
         CALL cl_set_comp_entry("xmdh017_01,xmdh012_01,xmdh013_01,xmdh014_01,xmdh029_01",FALSE)     #本次出貨數、庫位、儲位、批號
      END IF    
      IF g_mode = 'i' AND g_xmdh_d[l_ac].sel = 'Y' THEN

         LET l_xmdc022 = ''
         LET l_xmdc028 = ''
         LET l_xmdc029 = ''
         LET l_xmdc030 = ''
         LET l_xmdcsite = ''
         
         SELECT xmdc022,xmdc028,xmdc029,xmdc030,xmdcsite
           INTO l_xmdc022,l_xmdc028,l_xmdc029,l_xmdc030,l_xmdcsite
           FROM xmdd_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmddent AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq
          WHERE xmddent = g_enterprise
            AND xmdddocno = g_xmdh_d[l_ac].xmdh001
            AND xmddseq = g_xmdh_d[l_ac].xmdh002
            AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
            AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
         #不允許部分交貨，則不能修改數量
         IF l_xmdc022 = 'N' THEN
            LET g_xmdh_d[l_ac].xmdh017_01 = g_xmdh_d[l_ac].xmdh016 
            CALL cl_set_comp_entry("xmdh016_01",FALSE)
         END IF
        #161006-00018#24-s-mark 
        ##訂單是否已有限定庫儲批
        #IF NOT cl_null(l_xmdc028) THEN
        #   CALL cl_set_comp_entry("xmdh012_01",FALSE)
        #   IF NOT cl_null(l_xmdc029) THEN
        #      CALL cl_set_comp_entry("xmdh013_01",FALSE)
        #      IF NOT cl_null(l_xmdc030) THEN
        #         CALL cl_set_comp_entry("xmdh014_01",FALSE)
        #      END IF
        #   END IF
        #END IF
        #161006-00018#24-e-mark
        #161006-00018#24-s-add
         #訂單是否已有限定庫儲批
         IF NOT cl_null(l_xmdc028) THEN
            IF l_ooac004 = 'N' THEN  
               CALL cl_set_comp_entry("xmdh012_01",FALSE)
            END IF   
            IF NOT cl_null(l_xmdc029) THEN
               IF l_ooac004 = 'N' THEN
                  CALL cl_set_comp_entry("xmdh013_01",FALSE)
               END IF   
               IF NOT cl_null(l_xmdc030) THEN
                  IF l_ooac004 = 'N' THEN
                     CALL cl_set_comp_entry("xmdh014_01",FALSE)
                  END IF   
               END IF
            END IF
         END IF
        #161006-00018#24-e-add        
         LET l_inaa007 = ''
         SELECT inaa007 INTO l_inaa007
           FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = l_xmdcsite
            AND inaa001 = g_xmdh_d[l_ac].xmdh012_01
         #儲位控管若為5.不使用儲位控管，則不能維護儲位
         IF l_inaa007 = '5' THEN
            CALL cl_set_comp_entry("xmdh013_01",FALSE)
         END IF
      END IF     
END FUNCTION

################################################################################
# Descriptions...: 寫入底稿
# Memo...........:
# Usage..........: CALL axmp520_01_save_temp()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_01_save_temp()
   DEFINE i     LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_cnt   LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_flag  LIKE type_t.chr1
   #160120-00002#3 s983961--add(s)
   DEFINE l_sql       STRING
   DEFINE l_xmdcdocno LIKE xmdc_t.xmdcdocno
   DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq 
   DEFINE l_where     STRING
   #160120-00002#3 s983961--add(e)
   WHENEVER ERROR CONTINUE
    
   #用來判斷是否有資料被寫入 
   LET l_flag = 'N'

   #如果畫面上沒有資料的話，就不必實做寫入底稿的動作 
   IF g_xmdh_d.getLength() = 0 THEN
      CALL cl_ask_pressanykey("asf-00230")   #無資料處理! 
      RETURN
   END IF   
   
   #將待出貨資料寫入
   FOR i = 1 TO g_xmdh_d.getLength()
       #未勾選不需寫入底稿
       IF g_xmdh_d[i].sel = 'N' THEN
          CONTINUE FOR
       END IF 
       #將勾選的資料寫入出貨底稿中       
       INSERT INTO p520_01_tmp(xmdh001,xmdh002,xmdh003,xmdh004,xmdh017,
                                xmdh012,xmdh013,xmdh014,xmdh029,linkno)
         VALUES(g_xmdh_d[i].xmdh001   ,g_xmdh_d[i].xmdh002   ,g_xmdh_d[i].xmdh003   ,g_xmdh_d[i].xmdh004   ,g_xmdh_d[i].xmdh017_01,
                g_xmdh_d[i].xmdh012_01,g_xmdh_d[i].xmdh013_01,g_xmdh_d[i].xmdh014_01,g_xmdh_d[i].xmdh029_01,0)
       #160120-00002#3 s983961--add(s) 
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM axmp520_tmp01            #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
        WHERE xmdcdocno = g_xmdh_d[i].xmdh001
          AND xmdcseq   = g_xmdh_d[i].xmdh002
       IF cl_null(l_cnt) OR l_cnt = 0 THEN
          #161109-00085#10-s
          #INSERT INTO axmp520_tmp01 VALUES(g_xmdh_d[i].xmdh001,g_xmdh_d[i].xmdh002)     #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
          INSERT INTO axmp520_tmp01(xmdcdocno,xmdcseq) VALUES(g_xmdh_d[i].xmdh001,g_xmdh_d[i].xmdh002)
          #161109-00085#10-e         
       END IF
       #160120-00002#3 s983961--add(e)
       LET l_flag = 'Y'                            
   END FOR   
   #mark--160706-00037#12 By shiun--(S)
#   #160120-00002#3 s983961--add(s)
#   LET l_sql = "SELECT DISTINCT xmdcdocno,xmdcseq ",
#               "  FROM axmp520_tmp01 ",       #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
#               " ORDER BY xmdcdocno,xmdcseq  "
#   PREPARE axmp520_lock_prep FROM l_sql
#   DECLARE axmp520_lock_curs CURSOR FOR axmp520_lock_prep
#
#   LET l_sql = "SELECT xmdcdocno,xmdcseq ",
#               "  FROM xmdc_t ",
#               " WHERE "
#
#   LET l_where = ''
#   FOREACH axmp520_lock_curs INTO l_xmdcdocno,l_xmdcseq
#      IF cl_null(l_where) THEN
#         LET l_where = "(xmdcdocno = '",l_xmdcdocno,"' AND xmdcseq = '",l_xmdcseq,"') "
#      ELSE
#         LET l_where = l_where," OR ","(xmdcdocno = '",l_xmdcdocno,"' AND xmdcseq = '",l_xmdcseq,"' ) "
#      END IF
#   END FOREACH
#   
#   LET l_sql = l_sql,l_where," FOR UPDATE "
#   PREPARE axmp520_lock_body_prep FROM l_sql 
#   DECLARE axmp520_lock_body_curs CURSOR FOR axmp520_lock_body_prep
#   OPEN axmp520_lock_body_curs
#   #160120-00002#3 s983961--add(e)
   #mark--160706-00037#12 By shiun--(E)
   
   #有資料寫入 要提示user資料寫入底稿成功 
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("axm-00327")   #出貨資料(底稿)寫入成功！ 
   ELSE
      CALL cl_ask_pressanykey("apm-00481")   #未勾選任何資料！！     
   END IF     
END FUNCTION

################################################################################
# Descriptions...: 顯示出通底稿資料
# Memo...........:
# Usage..........: CALL axmp520_01_b_fill_tmp()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_01_b_fill_tmp()
   DEFINE l_sql       STRING
   DEFINE l_ac_t      LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   INITIALIZE g_xmdh_d TO NULL


   LET l_sql = "SELECT       'N',b.xmda004,       '',a.xmdh001,b.xmdadocdt, ", 
               "       b.xmda002,       '',a.xmdh002,a.xmdh003,  a.xmdh004,",
               "       b.xmda033,b.xmdh005,b.xmdh006,       '',         '', ",
               "       b.xmdh007,       '',b.xmdh009,       '',  b.xmdh010, ",
              #"       b.xmdh015,       '',b.xmdc012,   b.days,  b.xmdh016, ",   #160913-00033#1 mark
               "       b.xmdh015,       '',b.xmdd011,   b.days,  b.xmdh016, ",   #160913-00033#1 add
               "       a.xmdh017,a.xmdh012,       '',a.xmdh013,       '', ",
               "       a.xmdh014,a.xmdh029  ",
               "       ,b.xmda028 ",   #161230-00019#4 add
               "  FROM p520_01_tmp a,p520_01_xmdh b ",                 
               " WHERE a.xmdh001 = b.xmdh001 ",
               "   AND a.xmdh002 = b.xmdh002 ",
               "   AND a.xmdh003 = b.xmdh003 ",
               "   AND a.xmdh004 = b.xmdh004 "
   PREPARE axmp520_tmp_pr FROM l_sql
   DECLARE axmp520_tmp_cs CURSOR FOR axmp520_tmp_pr
   LET l_ac_t = l_ac
   LET l_ac = 1
    
    #mod--161109-00085#10-s
    #FOREACH axmp520_tmp_cs INTO g_xmdh_d[l_ac].*
    FOREACH axmp520_tmp_cs
    INTO g_xmdh_d[l_ac].sel,g_xmdh_d[l_ac].xmda004,g_xmdh_d[l_ac].xmda004_desc,g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdadocdt,
         g_xmdh_d[l_ac].xmda002,g_xmdh_d[l_ac].xmda002_desc,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,      
         g_xmdh_d[l_ac].xmda033,g_xmdh_d[l_ac].xmdh005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].imaal003,g_xmdh_d[l_ac].imaal004,
         g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh007_desc,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh009_desc,g_xmdh_d[l_ac].xmdh010,
         g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh015_desc,g_xmdh_d[l_ac].xmdd011,g_xmdh_d[l_ac].days,
         g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh017_01,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh012_01_desc,g_xmdh_d[l_ac].xmdh013_01,
         #161230-00019#4-s-mod
#         g_xmdh_d[l_ac].xmdh013_01_desc,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01
         g_xmdh_d[l_ac].xmdh013_01_desc,g_xmdh_d[l_ac].xmdh014_01,g_xmdh_d[l_ac].xmdh029_01,g_xmda028
         #161230-00019#4-e-mod
    #mod--161109-00085#10-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp520_sel_xmdh_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    

      CALL axmp520_01_detail_show()

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
    CLOSE axmp520_tmp_cs
    FREE axmp520_tmp_pr

END FUNCTION

################################################################################
# Descriptions...: 刪除底稿
# Memo...........:
# Usage..........: CALL axmp520_01_del_tmp()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_01_del_tmp()
  DEFINE i       LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
  DEFINE l_flag  LIKE type_t.chr1 

   WHENEVER ERROR CONTINUE

   #用來判斷是否有資料被刪除 
   LET l_flag = 'N'

   FOR i = 1 TO g_xmdh_d.getLength()
       IF g_xmdh_d[i].sel = 'Y' THEN
          DELETE FROM p520_01_tmp
           WHERE xmdh001 = g_xmdh_d[i].xmdh001
             AND xmdh002 = g_xmdh_d[i].xmdh002
             AND xmdh003 = g_xmdh_d[i].xmdh003
             AND xmdh004 = g_xmdh_d[i].xmdh004 
          #160120-00002#3 s983961--add(s)    
          DELETE FROM axmp520_tmp01       #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
           WHERE xmdcdocno = g_xmdh_d[i].xmdh001
            AND xmdcseq = g_xmdh_d[i].xmdh002 
          #160120-00002#3 s983961--add(e)   
          LET l_flag = 'Y'     
       END IF         
   END FOR 
  
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("axm-00328")   #出貨資料(底稿)資料已刪除！  
   ELSE
      CALL cl_ask_pressanykey("apm-00481")   #未勾選任何資料！！    
   END IF  
  
END FUNCTION

################################################################################
# Descriptions...: 說明顯示
# Memo...........:
# Usage..........: CALL axmp520_01_detail_show()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_01_detail_show()
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_pmak003   LIKE pmak_t.pmak003   #161230-00019#4
      
      #客戶      
      CALL s_desc_get_trading_partner_abbr_desc(g_xmdh_d[l_ac].xmda004)   
        RETURNING g_xmdh_d[l_ac].xmda004_desc
      #161230-00019#4-s-add
      IF NOT cl_null(g_xmda028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_xmda028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdh_d[l_ac].xmda004_desc = l_pmak003
         END IF
      END IF
      #161230-00019#4-e-add
      #業務人員   
      CALL s_desc_get_person_desc(g_xmdh_d[l_ac].xmda002)  
        RETURNING g_xmdh_d[l_ac].xmda002_desc        
      #品名、規格
      CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006)   
        RETURNING g_xmdh_d[l_ac].imaal003,g_xmdh_d[l_ac].imaal004 
        
      CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
           RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
      #單位
      CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015)   
        RETURNING g_xmdh_d[l_ac].xmdh015_desc
      #庫位
      CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012_01)  
        RETURNING g_xmdh_d[l_ac].xmdh012_01_desc
      #儲位
      CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012_01,g_xmdh_d[l_ac].xmdh013_01) 
        RETURNING g_xmdh_d[l_ac].xmdh013_01_desc


END FUNCTION

################################################################################
# Descriptions...: 檢查出貨底稿是否有資料
# Memo...........:
# Usage..........: CALL axmp520_01_tmp_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 20150714 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_01_tmp_chk()
DEFINE l_cnt         LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE r_success     LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   #確認底稿是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM p520_01_tmp
   
   IF l_cnt = 0 THEN
       CALL cl_ask_pressanykey("axm-00329")   #尚未產生出貨資料(底稿)！
       LET r_success = FALSE
       RETURN r_success       
   END IF
   
   RETURN r_success  
END FUNCTION
################################################################################
# Descriptions...: 在揀量檢核
# Memo...........:
# Usage..........: CALL axmp520_01_inan_chk(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017)
#                  RETURNING TRUE OR FALSE
# Input parameter: p_xmdh006   料件編號
#                : p_xmdh007   產品特徵
#                : p_xmdh012   限定庫位
#                : p_xmdh013   限定儲位
#                : p_xmdh014   限定批號
#                : p_xmdh029   庫存管理特徵
#                : p_xmdh015   單位
#                : p_xmdh017   數量
#                : p_xmdh001   訂單單號 #160408-00035#9-add
#                : p_xmdh002   訂單項次 #160408-00035#9-add
# Return code....: TRUE OR FALSE
# Date & Author..: 20150831 By Polly
# Modify.........: #160408-00035#9 add-p_xmdh001,p_xmdh002
################################################################################
PUBLIC FUNCTION axmp520_01_inan_chk(p_xmdh006,p_xmdh007,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdh001,p_xmdh002)
DEFINE p_xmdh006    LIKE xmdh_t.xmdh006
DEFINE p_xmdh007    LIKE xmdh_t.xmdh007
DEFINE p_xmdh012    LIKE xmdh_t.xmdh012
DEFINE p_xmdh013    LIKE xmdh_t.xmdh013
DEFINE p_xmdh014    LIKE xmdh_t.xmdh014
DEFINE p_xmdh029    LIKE xmdh_t.xmdh029
DEFINE p_xmdh015    LIKE xmdh_t.xmdh015
DEFINE p_xmdh017    LIKE xmdh_t.xmdh017
DEFINE p_xmdh001    LIKE xmdh_t.xmdh001  #160408-00035#9-add
DEFINE p_xmdh002    LIKE xmdh_t.xmdh002  #160408-00035#9-add
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   CALL s_inventory_check_inan(g_site,p_xmdh006,p_xmdh007,p_xmdh029,p_xmdh012,
                               p_xmdh013,p_xmdh014,p_xmdh015,p_xmdh017,g_xmdg_m.xmdgdocno,
                               '0','0',p_xmdh001,p_xmdh002) #160408-00035#9-add-p_xmdh001,p_xmdh002
     RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN FALSE
      IF l_flag = 0 THEN
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
END FUNCTION

 
{</section>}
 
