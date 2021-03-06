#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp580_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2017-02-14 19:03:03), PR版次:0008(2017-02-14 19:09:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000068
#+ Filename...: axmp580_01
#+ Description: 引導式簽收處理作業-待簽收資料
#+ Creator....: 04543(2014-10-08 11:42:25)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="axmp580_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160727-00019#24  2016/08/15 By 08742      系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                          Mod   axmp580_lock_b_t --> axmp580_tmp01
#160809-00031#1   2016/08/16  By 02097     bug fix
#160816-00001#11  2016/08/17  By 08734     抓取理由碼改CALL sub
#161207-00033#3   2016/12/23  By08992     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#170104-00066#3   2017/01/06  By Rainy     筆數相關變數由num5放大至num10
##160706-00037#6  2017/01/13  By shiun     調整axmp580_tmp01為axmp580_tmp_a
#170111-00026#6   2017/01/16  By 08993     修改模組變數quantity為xmdl_t.xmdl018
#161230-00019#6   2017/02/02  By shiun     引導式作業一次性交易對象處理，顯示一次性交易對象名稱
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS
   DEFINE g_axmp580_01_input_type   LIKE type_t.chr1
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="axmp580_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_xmdl RECORD
                   sel                  LIKE type_t.chr1,
                   xmdk007              LIKE xmdk_t.xmdk007,
                   xmdk007_desc         LIKE pmaal_t.pmaal004,
                   xmdk047              LIKE xmdk_t.xmdk047,   #一次性交易對象識別碼   #161230-00019#6
                   xmdk003              LIKE xmdk_t.xmdk003,
                   xmdk003_desc         LIKE ooag_t.ooag011,
                   xmdkdocdt            LIKE xmdk_t.xmdkdocdt,
                   xmdkdocno            LIKE xmdk_t.xmdkdocno,
                   xmdlseq              LIKE xmdl_t.xmdlseq,
                   xmdl003              LIKE xmdl_t.xmdl003,
                   xmdl004              LIKE xmdl_t.xmdl004,
                   xmdl005              LIKE xmdl_t.xmdl005,
                   xmdl006              LIKE xmdl_t.xmdl006,
                   xmda033              LIKE xmda_t.xmda033,   #150116新增"客戶訂購單號"                   
                   xmdl007              LIKE xmdl_t.xmdl007,
                   xmdl008              LIKE xmdl_t.xmdl008,
                   xmdl008_desc         LIKE imaal_t.imaal003,
                   xmdl008_desc_desc    LIKE imaal_t.imaal004,
                   xmdl009              LIKE xmdl_t.xmdl009,
                   xmdl009_desc         LIKE type_t.chr500,
                   xmdl011              LIKE xmdl_t.xmdl011,
                   xmdl011_desc         LIKE oocql_t.oocql004,
                   xmdl012              LIKE xmdl_t.xmdl012,
                   xmdl017              LIKE xmdl_t.xmdl017,
                   xmdl017_desc         LIKE oocal_t.oocal003,
                   xmdd012              LIKE xmdd_t.xmdd012,
                   days                 LIKE type_t.num5,
#                   quantity             LIKE type_t.num5,     #170111-00026#6 mark
                   quantity             LIKE xmdl_t.xmdl018,   #170111-00026#6 add
                   xmdl018              LIKE xmdl_t.xmdl018,
                   xmdl081              LIKE xmdl_t.xmdl081,
                   xmdl084              LIKE xmdl_t.xmdl084,
                   xmdl084_desc         LIKE oocql_t.oocql004,
                   xmdl019              LIKE xmdl_t.xmdl019,
                   xmdl019_desc         LIKE oocql_t.oocql003,
                   xmdl020              LIKE xmdl_t.xmdl020,
                   xmdl082              LIKE xmdl_t.xmdl082,
                   xmdl013              LIKE xmdl_t.xmdl013,
                   xmdl014              LIKE xmdl_t.xmdl014,
                   xmdl014_desc         LIKE inayl_t.inayl003,
                   xmdl015              LIKE xmdl_t.xmdl015,
                   xmdl015_desc         LIKE inab_t.inab003,
                   xmdl016              LIKE xmdl_t.xmdl016,
                   xmdl052              LIKE xmdl_t.xmdl052                  
                       END RECORD
                              
DEFINE g_xmdl_d    DYNAMIC ARRAY OF type_xmdl
DEFINE g_xmdl_d_o  type_xmdl

DEFINE g_xmdl2_d   DYNAMIC ARRAY OF type_xmdl
DEFINE g_xmdl2_d_o type_xmdl

DEFINE l_ac        LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_idx       LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_rec_b     LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_rec_b2    LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 

DEFINE g_qty       LIKE xmdl_t.xmdl018
DEFINE g_current_page  LIKE type_t.chr1
#end add-point
 
{</section>}
 
{<section id="axmp580_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmp580_01.other_dialog" >}
#待簽收資料的INPUT
DIALOG axmp580_01_input()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_gzcb004     LIKE gzcb_t.gzcb004
   
   INPUT ARRAY g_xmdl_d FROM s_detail1_axmp580_01.*
      ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
               
      BEFORE INPUT
         LET g_current_page = '1'

      BEFORE ROW
         LET l_ac = DIALOG.getCurrentRow("s_detail1_axmp580_01")
         LET g_xmdl_d_o.* = g_xmdl_d[l_ac].*
         CALL axmp580_01_set_entry_b()
         CALL axmp580_01_set_no_entry_b()
          
      ON CHANGE sel_d1_01
         IF g_axmp580_01_input_type = '1' THEN
            #數量預設
            CALL axmp580_01_xmdl_default(l_ac)
             
            LET g_xmdl_d_o.sel = g_xmdl_d[l_ac].sel
         END IF

      AFTER FIELD xmdl018_d1_01
         IF g_axmp580_01_input_type = '1' THEN
            IF NOT cl_null(g_xmdl_d[l_ac].xmdl018) THEN
               IF g_xmdl_d[l_ac].xmdl018 <> g_xmdl_d_o.xmdl018 OR cl_null(g_xmdl_d_o.xmdl018) THEN
                
                  IF NOT cl_ap_chk_Range(g_xmdl_d[l_ac].xmdl018,"0.000","1","","","azz-00079",1) THEN
                     LET g_xmdl_d[l_ac].xmdl018 = g_xmdl_d_o.xmdl018
                   
                     NEXT FIELD xmdl018_d1_01
                  END IF
                
                  LET g_qty = 0
                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl018) THEN
                     LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl018
                  END IF

                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl081) THEN
                     LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl081
                  END IF

                  #簽收數量檢查
                  IF g_qty > g_xmdl_d[l_ac].quantity THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00225'    #簽收簽退量不可大於可轉簽收簽退量("出貨量" - "已簽收量" - "已簽退量")
                     LET g_errparam.extend = g_qty
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xmdl_d[l_ac].xmdl018 = g_xmdl_d_o.xmdl018
                   
                     NEXT FIELD xmdl018_d1_01
                  END IF
                   
                  #推算參考數量
                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl008) AND NOT cl_null(g_xmdl_d[l_ac].xmdl017) AND
                     NOT cl_null(g_xmdl_d[l_ac].xmdl019) AND NOT cl_null(g_xmdl_d[l_ac].xmdl018) THEN
                            
                     CALL s_aooi250_convert_qty(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl018)
                     RETURNING l_success,g_xmdl_d[l_ac].xmdl020
                  ELSE
                     LET g_xmdl_d[l_ac].xmdl020 = ''
                  END IF

               END IF                
            END IF
             
            LET g_xmdl_d_o.xmdl018 = g_xmdl_d[l_ac].xmdl018
            LET g_xmdl_d_o.xmdl020 = g_xmdl_d[l_ac].xmdl020
         END IF

      AFTER FIELD xmdl081_d1_01
         IF g_axmp580_01_input_type = '1' THEN
            IF NOT cl_null(g_xmdl_d[l_ac].xmdl081) THEN
               IF g_xmdl_d[l_ac].xmdl081 <> g_xmdl_d_o.xmdl081 OR cl_null(g_xmdl_d_o.xmdl081) THEN
            
                  IF NOT cl_ap_chk_Range(g_xmdl_d[l_ac].xmdl081,"0.000","1","","","azz-00079",1) THEN
                     LET g_xmdl_d[l_ac].xmdl081 = g_xmdl_d_o.xmdl081
                     
                     NEXT FIELD xmdl081_d1_01
                  END IF
                  
                  LET g_qty = 0
                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl018) THEN
                     LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl018
                  END IF
          
                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl081) THEN
                     LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl081
                  END IF
          
                  #簽收數量檢查
                  IF g_qty > g_xmdl_d[l_ac].quantity THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00225'    #簽收簽退量不可大於可轉簽收簽退量("出貨量" - "已簽收量" - "已簽退量")
                     LET g_errparam.extend = g_qty
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
          
                     LET g_xmdl_d[l_ac].xmdl081 = g_xmdl_d_o.xmdl081
                     
                     NEXT FIELD xmdl081_d1_01
                  END IF
                  
                  #推算參考數量
                  IF NOT cl_null(g_xmdl_d[l_ac].xmdl008) AND NOT cl_null(g_xmdl_d[l_ac].xmdl017) AND
                     NOT cl_null(g_xmdl_d[l_ac].xmdl019) AND NOT cl_null(g_xmdl_d[l_ac].xmdl081) THEN
                           
                     CALL s_aooi250_convert_qty(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl081)
                     RETURNING l_success,g_xmdl_d[l_ac].xmdl082
                  ELSE
                     LET g_xmdl_d[l_ac].xmdl082 = ''
                  END IF    
                  
               END IF                
            END IF
            
            LET g_xmdl_d_o.xmdl081 = g_xmdl_d[l_ac].xmdl081
            LET g_xmdl_d_o.xmdl082 = g_xmdl_d[l_ac].xmdl082
         END IF

      AFTER FIELD xmdl084_d1_01
         IF g_axmp580_01_input_type = '1' THEN
            CALL axmp580_01_reason_ref(g_xmdl_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl_d[l_ac].xmdl084_desc
          
            IF NOT cl_null(g_xmdl_d[l_ac].xmdl084) THEN
               IF g_xmdl_d[l_ac].xmdl084 <> g_xmdl_d_o.xmdl084 OR cl_null(g_xmdl_d_o.xmdl084) THEN
                
                  IF NOT axmp580_01_reason_chk(g_xmdl_d[l_ac].xmdl084,'axmt590') THEN
                     LET g_xmdl_d[l_ac].xmdl084 = g_xmdl_d_o.xmdl084
                     CALL axmp580_01_reason_ref(g_xmdl_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl_d[l_ac].xmdl084_desc
                     
                     NEXT FIELD xmdl084_d1_01
                  END IF
                  
               END IF
            END IF
            
            LET g_xmdl_d_o.xmdl084 = g_xmdl_d[l_ac].xmdl084
         END IF

      AFTER FIELD xmdl020_d1_01
          IF NOT cl_null(g_xmdl_d[l_ac].xmdl020) THEN
             #參考數量取位
             CALL s_aooi250_take_decimals(g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl020) RETURNING l_success,g_xmdl_d[l_ac].xmdl020
          END IF
          
          LET g_xmdl_d_o.xmdl020 = g_xmdl_d[l_ac].xmdl020

      AFTER FIELD xmdl082_d1_01
          IF NOT cl_null(g_xmdl_d[l_ac].xmdl082) THEN                
             #參考數量取位
             CALL s_aooi250_take_decimals(g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl082) RETURNING l_success,g_xmdl_d[l_ac].xmdl082
          END IF 
          
          LET g_xmdl_d_o.xmdl082 = g_xmdl_d[l_ac].xmdl082

      ON ACTION controlp INFIELD xmdl084_d1_01
          #開窗i段
          LET l_gzcb004 = ''
          #160816-00001#11  2016/08/17  By 08734 Mark
        #  SELECT gzcb004
        #    INTO l_gzcb004
        #    FROM gzcb_t
        #   WHERE gzcb001 = '24'
        #     AND gzcb002 = 'axmt590'
          LET l_gzcb004 = s_fin_get_scc_value('24','axmt590','2')  #160816-00001#11  2016/08/17  By 08734 add

          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.reqry = FALSE

          LET g_qryparam.default1 = g_xmdl_d[l_ac].xmdl084             #給予default值

#          CALL s_control_get_doc_sql('oocq002',g_xmdk_m.xmdkdocno,'8') RETURNING l_success,l_where
#          IF l_success THEN
#             LET g_qryparam.where = l_where
#          END IF

          #給予arg
          LET g_qryparam.arg1 = l_gzcb004

          CALL q_oocq002()                                #呼叫開窗
          LET g_xmdl_d[l_ac].xmdl084 = g_qryparam.return1              #將開窗取得的值回傳到變數

          DISPLAY g_xmdl_d[l_ac].xmdl084 TO xmdl084_d1_01              #顯示到畫面上

          CALL axmp580_01_reason_ref(g_xmdl_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl_d[l_ac].xmdl084_desc
          NEXT FIELD xmdl084_d1_01

      ON ROW CHANGE 
         IF g_axmp580_01_input_type = '1' THEN
            IF g_xmdl_d[l_ac].sel = 'Y' THEN
               LET g_qty = 0
               IF NOT cl_null(g_xmdl_d[l_ac].xmdl018) THEN
                  LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl018
               END IF

               IF NOT cl_null(g_xmdl_d[l_ac].xmdl081) THEN
                  LET g_qty = g_qty + g_xmdl_d[l_ac].xmdl081
               END IF             
            
               IF g_qty = 0 THEN
                  LET g_xmdl_d[l_ac].sel = 'N'
               END IF
               
               LET g_xmdl_d_o.sel = g_xmdl_d[l_ac].sel
            END IF
         END IF
         
      ON ACTION selall_xmdk007
         FOR g_idx = 1 TO g_xmdl_d.getLength()
            IF g_xmdl_d[g_idx].xmdk007 = g_xmdl_d[l_ac].xmdk007 THEN
               LET g_xmdl_d[g_idx].sel = 'Y'
               
               #數量預設
               CALL axmp580_01_xmdl_default(g_idx)

            END IF
         END FOR
         
      ON ACTION selall_xmdkdocno
         FOR g_idx = 1 TO g_xmdl_d.getLength()
            IF g_xmdl_d[g_idx].xmdkdocno = g_xmdl_d[l_ac].xmdkdocno THEN
               LET g_xmdl_d[g_idx].sel = 'Y'

               #數量預設
               CALL axmp580_01_xmdl_default(g_idx)

            END IF
         END FOR
         
      ON ACTION unselall
         FOR g_idx = 1 TO g_xmdl_d.getLength()
            LET g_xmdl_d[g_idx].sel = 'N'
            
            #數量預設
            CALL axmp580_01_xmdl_default(g_idx)
         END FOR
         
      ON ACTION delete_data
         CALL axmp580_01_delete_data()
         CALL axmp580_01_b_fill2()
         
      
   END INPUT

END DIALOG
#未來簽收資料的INPUT
DIALOG axmp580_01_input2()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_gzcb004     LIKE gzcb_t.gzcb004
   
   INPUT ARRAY g_xmdl2_d FROM s_detail2_axmp580_01.*
      ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
               
      BEFORE INPUT                  
         LET g_current_page = '2'

      BEFORE ROW
         #第二頁籤隱藏，跳回第一頁籤
         IF g_axmp580_01_input_type = '2' THEN
            NEXT FIELD sel_d1_01
         END IF      
      
         LET l_ac = DIALOG.getCurrentRow("s_detail2_axmp580_01")
         LET g_xmdl2_d_o.* = g_xmdl2_d[l_ac].*
         CALL axmp580_01_set_entry_b()
         CALL axmp580_01_set_no_entry_b()

      ON CHANGE sel_d2_01
         IF g_axmp580_01_input_type = '1' THEN
            #數量預設
            CALL axmp580_01_xmdl2_default(l_ac)  
         END IF

      AFTER FIELD xmdl018_d2_01
         IF g_axmp580_01_input_type = '1' THEN
            IF NOT cl_null(g_xmdl2_d[l_ac].xmdl018) THEN
               IF g_xmdl2_d[l_ac].xmdl018 <> g_xmdl2_d_o.xmdl018 OR cl_null(g_xmdl2_d_o.xmdl018) THEN
            
                  IF NOT cl_ap_chk_Range(g_xmdl2_d[l_ac].xmdl018,"0.000","1","","","azz-00079",1) THEN
                     LET g_xmdl2_d[l_ac].xmdl018 = g_xmdl2_d_o.xmdl018
                      
                     NEXT FIELD xmdl018_d2_01
                  END IF
                   
                  LET g_qty = 0
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl018) THEN
                     LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl018
                  END IF
                  
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl081) THEN
                     LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl081
                  END IF
                  
                  #簽收數量檢查
                  IF g_qty > g_xmdl2_d[l_ac].quantity THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00225'    #簽收簽退量不可大於可轉簽收簽退量("出貨量" - "已簽收量" - "已簽退量")
                     LET g_errparam.extend = g_qty
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_xmdl2_d[l_ac].xmdl018 = g_xmdl2_d_o.xmdl018
                      
                     NEXT FIELD xmdl018_d2_01
                  END IF

                  #推算參考數量
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[l_ac].xmdl017) AND
                     NOT cl_null(g_xmdl2_d[l_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[l_ac].xmdl018) THEN
                            
                     CALL s_aooi250_convert_qty(g_xmdl2_d[l_ac].xmdl008,g_xmdl2_d[l_ac].xmdl017,g_xmdl2_d[l_ac].xmdl019,g_xmdl2_d[l_ac].xmdl018)
                     RETURNING l_success,g_xmdl2_d[l_ac].xmdl020
                  ELSE
                     LET g_xmdl2_d[l_ac].xmdl020 = ''
                  END IF
                   
               END IF
            END IF
             
            LET g_xmdl2_d_o.xmdl018 = g_xmdl2_d[l_ac].xmdl018
            LET g_xmdl2_d_o.xmdl020 = g_xmdl2_d[l_ac].xmdl020
         END IF

      AFTER FIELD xmdl081_d2_01
         IF g_axmp580_01_input_type = '1' THEN
            IF NOT cl_null(g_xmdl2_d[l_ac].xmdl081) THEN
               IF g_xmdl2_d[l_ac].xmdl081 <> g_xmdl2_d_o.xmdl081 OR cl_null(g_xmdl2_d_o.xmdl081) THEN
           
                  IF NOT cl_ap_chk_Range(g_xmdl2_d[l_ac].xmdl081,"0.000","1","","","azz-00079",1) THEN
                     LET g_xmdl2_d[l_ac].xmdl081 = g_xmdl2_d_o.xmdl081
                    
                     NEXT FIELD xmdl081_d2_01
                  END IF
                 
                  LET g_qty = 0
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl018) THEN
                     LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl018
                  END IF
                
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl081) THEN
                     LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl081
                  END IF
                
                  #簽收數量檢查
                  IF g_qty > g_xmdl2_d[l_ac].quantity THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00225'    #簽收簽退量不可大於可轉簽收簽退量("出貨量" - "已簽收量" - "已簽退量")
                     LET g_errparam.extend = g_qty
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET g_xmdl2_d[l_ac].xmdl081 = g_xmdl2_d_o.xmdl081
                    
                     NEXT FIELD xmdl081_d2_01
                  END IF
                 
                  #推算參考數量
                  IF NOT cl_null(g_xmdl2_d[l_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[l_ac].xmdl017) AND
                     NOT cl_null(g_xmdl2_d[l_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[l_ac].xmdl081) THEN
                          
                     CALL s_aooi250_convert_qty(g_xmdl2_d[l_ac].xmdl008,g_xmdl2_d[l_ac].xmdl017,g_xmdl2_d[l_ac].xmdl019,g_xmdl2_d[l_ac].xmdl081)
                     RETURNING l_success,g_xmdl2_d[l_ac].xmdl082
                  ELSE
                     LET g_xmdl2_d[l_ac].xmdl082 = ''
                  END IF                    
                 
               END IF
            END IF
           
            LET g_xmdl2_d_o.xmdl081 = g_xmdl2_d[l_ac].xmdl081
            LET g_xmdl2_d_o.xmdl082 = g_xmdl2_d[l_ac].xmdl082
         END IF

      AFTER FIELD xmdl084_d2_01
         IF g_axmp580_01_input_type = '1' THEN        
            CALL axmp580_01_reason_ref(g_xmdl2_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl2_d[l_ac].xmdl084_desc
            
            IF NOT cl_null(g_xmdl2_d[l_ac].xmdl084) THEN
               IF g_xmdl2_d[l_ac].xmdl084 <> g_xmdl2_d_o.xmdl084 OR cl_null(g_xmdl2_d_o.xmdl084) THEN
                          
                  IF NOT axmp580_01_reason_chk(g_xmdl2_d[l_ac].xmdl084,'axmt590') THEN
                     LET g_xmdl2_d[l_ac].xmdl084 = g_xmdl2_d_o.xmdl084
                     CALL axmp580_01_reason_ref(g_xmdl2_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl2_d[l_ac].xmdl084_desc
                     
                     NEXT FIELD xmdl084_d2_01
                  END IF
                  
               END IF
            END IF
            
            LET g_xmdl2_d_o.xmdl084 = g_xmdl2_d[l_ac].xmdl084
         END IF

      AFTER FIELD xmdl020_d2_01
         IF NOT cl_null(g_xmdl2_d[l_ac].xmdl020) THEN
            #參考數量取位
            CALL s_aooi250_take_decimals(g_xmdl2_d[l_ac].xmdl019,g_xmdl2_d[l_ac].xmdl020) RETURNING l_success,g_xmdl2_d[l_ac].xmdl020
         END IF

         LET g_xmdl2_d_o.xmdl020 = g_xmdl2_d[l_ac].xmdl020

      AFTER FIELD xmdl082_d2_01
         IF NOT cl_null(g_xmdl2_d[l_ac].xmdl082) THEN                
            #參考數量取位
            CALL s_aooi250_take_decimals(g_xmdl2_d[l_ac].xmdl019,g_xmdl2_d[l_ac].xmdl082) RETURNING l_success,g_xmdl2_d[l_ac].xmdl082
         END IF 

         LET g_xmdl2_d_o.xmdl082 = g_xmdl2_d[l_ac].xmdl082

      ON ACTION controlp INFIELD xmdl084_d2_01
         #開窗i段
         LET l_gzcb004 = ''
         #160816-00001#11  2016/08/17  By 08734 Mark
       #  SELECT gzcb004
       #    INTO l_gzcb004
       #    FROM gzcb_t
       #   WHERE gzcb001 = '24'
       #     AND gzcb002 = 'axmt590'
        LET l_gzcb004 = s_fin_get_scc_value('24','axmt590','2')  #160816-00001#11  2016/08/17  By 08734 add

         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_xmdl2_d[l_ac].xmdl084             #給予default值

#         CALL s_control_get_doc_sql('oocq002',g_xmdk_m.xmdkdocno,'8') RETURNING l_success,l_where
#         IF l_success THEN
#            LET g_qryparam.where = l_where
#         END IF

         #給予arg
         LET g_qryparam.arg1 = l_gzcb004

         CALL q_oocq002()                                #呼叫開窗
         LET g_xmdl2_d[l_ac].xmdl084 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY g_xmdl2_d[l_ac].xmdl084 TO xmdl084_d2_01              #顯示到畫面上

         CALL axmp580_01_reason_ref(g_xmdl2_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl2_d[l_ac].xmdl084_desc
         NEXT FIELD xmdl084_d2_01

      ON ROW CHANGE 
         IF g_axmp580_01_input_type = '1' THEN
            IF g_xmdl2_d[l_ac].sel = 'Y' THEN
               LET g_qty = 0
               IF NOT cl_null(g_xmdl2_d[l_ac].xmdl018) THEN
                  LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl018
               END IF

               IF NOT cl_null(g_xmdl2_d[l_ac].xmdl081) THEN
                  LET g_qty = g_qty + g_xmdl2_d[l_ac].xmdl081
               END IF             
             
               IF g_qty = 0 THEN
                  LET g_xmdl2_d[l_ac].sel = 'N'
               END IF
                
               LET g_xmdl2_d_o.sel = g_xmdl2_d[l_ac].sel
            END IF
         END IF

      ON ACTION selall_xmdk007
         FOR g_idx = 1 TO g_xmdl2_d.getLength()
            IF g_xmdl2_d[g_idx].xmdk007 = g_xmdl2_d[l_ac].xmdk007 THEN
               LET g_xmdl2_d[g_idx].sel = 'Y'
                
               #數量預設
               CALL axmp580_01_xmdl2_default(g_idx)

            END IF
         END FOR

      ON ACTION selall_xmdkdocno
         FOR g_idx = 1 TO g_xmdl2_d.getLength()
            IF g_xmdl2_d[g_idx].xmdkdocno = g_xmdl2_d[l_ac].xmdkdocno THEN
               LET g_xmdl2_d[g_idx].sel = 'Y'
               
               #數量預設
               CALL axmp580_01_xmdl2_default(g_idx)

            END IF
         END FOR

      ON ACTION unselall
         FOR g_idx = 1 TO g_xmdl2_d.getLength()
            LET g_xmdl2_d[g_idx].sel = 'N'
             
            #數量預設
            CALL axmp580_01_xmdl2_default(g_idx)
         END FOR
          
      ON ACTION delete_data
         CALL axmp580_01_delete_data()
         CALL axmp580_01_b_fill2()
          
       
   END INPUT

END DIALOG

 
{</section>}
 
{<section id="axmp580_01.other_function" readonly="Y" >}

PUBLIC FUNCTION axmp580_01_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT axmp580_01_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE axmp580_01_temp(
      xmdk007               VARCHAR(10),
      xmdk047               VARCHAR(20),        #一次性交易對象識別碼   #161230-00019#6 
      xmdk003               VARCHAR(20),
      xmdkdocdt             DATE,
      xmdkdocno             VARCHAR(20),
      xmdlseq               INTEGER,
      xmdl003               VARCHAR(20),
      xmdl004               INTEGER,
      xmdl005               INTEGER,
      xmdl006               INTEGER,
      xmda033               VARCHAR(20),        #150116新增"客戶訂購單號"
      xmdl007               VARCHAR(10),
      xmdl008               VARCHAR(40),
      xmdl009               VARCHAR(256),
      xmdl011               VARCHAR(10),
      xmdl012               VARCHAR(10),
      xmdl017               VARCHAR(10),
      xmdd012               DATE,
      xmdl018               DECIMAL(20,6),
      xmdl081               DECIMAL(20,6),
      xmdl084               VARCHAR(10),
      xmdl019               VARCHAR(10),
      xmdl020               DECIMAL(20,6),
      xmdl082               DECIMAL(20,6),
      xmdl013               VARCHAR(1),
      xmdl014               VARCHAR(10),
      xmdl015               VARCHAR(10),
      xmdl016               VARCHAR(30),
      xmdl052               VARCHAR(30)
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmp580_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #160120-00002#5 s983961--add(s)
   #160706-00037#6-s-mod-20170113
#   CREATE TEMP TABLE axmp580_tmp01(         #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
   CREATE TEMP TABLE axmp580_tmp_a(
      xmdldocno             VARCHAR(20),
      xmdlseq               INTEGER
   )
   #160706-00037#6-e-mod-20170113
   #160120-00002#5 s983961--add(e)

   RETURN r_success
END FUNCTION

PUBLIC FUNCTION axmp580_01_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE axmp580_01_temp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmp580_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#5 s983961--add(s)
   #160706-00037#6-s-mod-20170113
#   DROP TABLE axmp580_tmp01;        #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
   DROP TABLE axmp580_tmp_a;
   #160706-00037#6-e-mod-20170113
   #160120-00002#5 s983961--add(e)
   
   RETURN r_success
END FUNCTION

# 畫面資料初始化
PUBLIC FUNCTION axmp580_01_init()
   CALL cl_set_combo_scc('xmdl007_d1_01','2055')
   CALL cl_set_combo_scc('xmdl007_d2_01','2055')
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdl009_d1_01,xmdl009_d1_01_desc,
                                xmdl009_d2_01,xmdl009_d2_01_desc",FALSE)
   END IF

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("xmdl019_d1_01,xmdl019_d1_01_desc,xmdl020_d1_01,xmdl082_d1_01,
                                xmdl019_d2_01,xmdl019_d2_01_desc,xmdl020_d2_01,xmdl082_d2_01",FALSE)
   END IF

END FUNCTION

#顯示對出貨資料查詢的結果
PUBLIC FUNCTION axmp580_01_b_fill(p_wc)
   DEFINE p_wc         STRING
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy    
   #160120-00002#1 s983961--add(s)
   DEFINE l_xmdldocno       LIKE xmdl_t.xmdldocno  
   DEFINE l_xmdlseq         LIKE xmdl_t.xmdlseq   
   #160120-00002#1 s983961--add(e)
   DEFINE r_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#3 add
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   DEFINE l_sql1           STRING                                    #161207-00033#3 add
   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF

   #顯示"未來簽收資料"頁籤   #150214 earl
   CALL cl_set_comp_visible("page02_axmp580_01",TRUE)

   #--detail1--待簽收資料
   #161230-00019#6-s-mod
#   LET l_sql = "SELECT UNIQUE 'N',xmdk007,'',xmdk003,'',xmdkdocdt,xmdkdocno,",
   LET l_sql = "SELECT UNIQUE 'N',xmdk007,'',xmdk047,xmdk003,'',xmdkdocdt,xmdkdocno,",
   #161230-00019#6-e-mod 
               "              xmdlseq,xmdl003,xmdl004,xmdl005,xmdl006,",
               "              xmda033,",   #150116新增"客戶訂購單號"
               "              xmdl007,",
               "              xmdl008,'','',xmdl009,'',xmdl011,'',xmdl012,xmdl017,'',",
               "              xmdd012,'','','','',",
               "              xmdl084,'',xmdl019,'','','',",
               "              xmdl013,xmdl014,'',xmdl015,'',xmdl016,xmdl052",
               "  FROM xmdl_t LEFT OUTER JOIN xmdd_t ON xmddent = xmdlent AND xmdddocno = xmdl003",
               "                                    AND xmddseq = xmdl004 AND xmddseq1 = xmdl005 AND xmddseq2 = xmdl006",
               "              LEFT OUTER JOIN xmdk_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
               "              LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imafsite = xmdlsite AND imaf001 = xmdl008",
               "              LEFT OUTER JOIN xmda_t ON xmdaent = xmdlent AND xmdadocno = xmdl003",   #150116新增"客戶訂購單號"
               "              LEFT OUTER JOIN xmdc_t ON xmdcent = xmdlent AND xmdcdocno = xmdl003 AND xmdcseq = xmdl004",   #150204新增"預計簽收日"
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdksite = '",g_site,"'",
               "   AND xmdk000 IN ('1','2')",
               "   AND xmdk002 = '3'",
               "   AND xmdkstus = 'S'",
               #2015/02/14 by stellar modify ----- (S)
               #與檢視底稿的條件一樣
#               "   AND (xmdd012 <= '",g_today CLIPPED,"' OR xmdd012 IS NULL)",
               " AND (xmdd012 <= '",g_today CLIPPED,"') ",
               #2015/02/14 by stellar modify ----- (E)
               "   AND ",p_wc CLIPPED,
               "   AND xmdkdocno NOT IN (SELECT UNIQUE xmdl001 FROM xmdk_t,xmdl_t",
               "                          WHERE xmdkent = xmdlent AND xmdlent = ",g_enterprise,
               "                            AND xmdkdocno = xmdldocno",
               "                            AND xmdk000 = '4'",
               "                            AND xmdkstus = 'N' AND xmdl001 IS NOT NULL)",       #160809-00031#1
               " ORDER BY xmdk007,xmdkdocno,xmdlseq"
   
   PREPARE axmp580_01_sel_d1 FROM l_sql
   DECLARE axmp580_01_b_fill_curs_d1 CURSOR FOR axmp580_01_sel_d1
   #161207-00033#3-s add
   LET l_sql1 = "SELECT pmaa004 FROM pmaa_t        ",
               " WHERE pmaaent ='",g_enterprise,"'",
               "   AND pmaa001 = ?  "
   PREPARE axmp580_pb FROM l_sql1
   #161207-00033#3-e add
   CALL g_xmdl_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH axmp580_01_b_fill_curs_d1 INTO g_xmdl_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp580_01_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      #160120-00002#5 s983961--add(s)   
      #檢查請購單的資料是否已經被lock 
      LET l_xmdldocno = '' 
      LET l_xmdlseq   = '' 
      LET l_sql = "SELECT xmdldocno,xmdlseq ", 
                  "  FROM xmdl_t ", 
                  " WHERE xmdlent   = '",g_enterprise,"' ", 
                  "   AND xmdldocno  = '",g_xmdl_d[l_ac].xmdkdocno,"' ", 
                  "   AND xmdlseq   = '",g_xmdl_d[l_ac].xmdlseq,"' ",               
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE axmp580_01_chk_locked_prep FROM l_sql 
      EXECUTE axmp580_01_chk_locked_prep INTO l_xmdldocno,l_xmdlseq               
      IF cl_null(l_xmdldocno) AND cl_null(l_xmdlseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#5 s983961--add(e) 
      
      IF NOT axmp580_01_chk_temp_data(g_xmdl_d[l_ac].xmdkdocno,g_xmdl_d[l_ac].xmdlseq) THEN
         CONTINUE FOREACH
      END IF

      #預設簽收數量
      CALL axmp580_01_default_quantity(g_xmdl_d[l_ac].xmdkdocno,g_xmdl_d[l_ac].xmdlseq,g_xmdl_d[l_ac].xmdl017)
      RETURNING g_xmdl_d[l_ac].quantity

      IF g_xmdl_d[l_ac].quantity <= 0 THEN
         CONTINUE FOREACH
      END IF

      #待簽收量
      LET g_xmdl_d[l_ac].xmdl018 = 0      

      #簽退數量
      LET g_xmdl_d[l_ac].xmdl081 = 0
      
      #參考數量
      IF NOT cl_null(g_xmdl_d[l_ac].xmdl019) THEN
         LET g_xmdl_d[l_ac].xmdl020 = 0      
         LET g_xmdl_d[l_ac].xmdl082 = 0
      END IF
      

      #Reference
      CALL axmp580_01_xmdl_ref()
      #161207-00033#3-s add
      EXECUTE axmp580_pb USING g_xmdl_d[l_ac].xmdk007 INTO l_pmaa004
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #161230-00019#6-s-mod
         #一次性交易對象全名
#         CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmdl_d[l_ac].xmdkdocno)
#              RETURNING r_pmak003
         LET r_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_xmdl_d[l_ac].xmdk047) 
           RETURNING r_pmak003
         #161230-00019#6-e-mod
         IF NOT cl_null(r_pmak003) THEN
            LET g_xmdl_d[l_ac].xmdk007_desc = r_pmak003
         END IF
         
      END IF
      #161207-00033#3-e add      
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
   
   LET g_rec_b = l_ac - 1
   CALL g_xmdl_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE axmp580_01_b_fill_curs_d1
   FREE axmp580_01_sel_d1
   
   #--detail2--
   #161230-00019#6-s-mod
#   LET l_sql = "SELECT UNIQUE 'N',xmdk007,'',xmdk003,'',xmdkdocdt,xmdkdocno,",
   LET l_sql = "SELECT UNIQUE 'N',xmdk007,'',xmdk047,xmdk003,'',xmdkdocdt,xmdkdocno,",
   #161230-00019#6-e-mod
               "              xmdlseq,xmdl003,xmdl004,xmdl005,xmdl006,",
               "              xmda033,",    #150116新增"客戶訂購單號"               
               "              xmdl007,",
               "              xmdl008,'','',xmdl009,'',xmdl011,'',xmdl012,xmdl017,'',",
               "              xmdd012,'','','','',",
               "              xmdl084,'',xmdl019,'','','',",
               "              xmdl013,xmdl014,'',xmdl015,'',xmdl016,xmdl052",
               "  FROM xmdl_t LEFT OUTER JOIN xmdd_t ON xmddent = xmdlent AND xmdddocno = xmdl003",
               "                                    AND xmddseq = xmdl004 AND xmddseq1 = xmdl005 AND xmddseq2 = xmdl006",
               "              LEFT OUTER JOIN xmdk_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
               "              LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imafsite = xmdlsite AND imaf001 = xmdl008",
               "              LEFT OUTER JOIN xmda_t ON xmdaent = xmdlent AND xmdadocno = xmdl003",   #150116新增"客戶訂購單號"
               "              LEFT OUTER JOIN xmdc_t ON xmdcent = xmdlent AND xmdcdocno = xmdl003 AND xmdcseq = xmdl004",   #150204新增"預計簽收日"
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdksite = '",g_site,"'",
               "   AND xmdk000 IN ('1','2')",
               "   AND xmdk002 = '3'",
               "   AND xmdkstus = 'S'",
               "   AND (xmdd012 > '",g_today CLIPPED,"' OR xmdd012 IS NULL)",
               "   AND ",p_wc CLIPPED,
               "   AND xmdkdocno NOT IN (SELECT UNIQUE xmdl001 FROM xmdk_t,xmdl_t",
               "                          WHERE xmdkent = xmdlent AND xmdlent = ",g_enterprise,
               "                            AND xmdkdocno = xmdldocno",
               "                            AND xmdk000 = '4'",
               "                            AND xmdkstus = 'N' AND xmdl001 IS NOT NULL)",          #160809-00031#1
               " ORDER BY xmdk007,xmdkdocno,xmdlseq"

   PREPARE axmp580_01_sel_d2 FROM l_sql
   DECLARE axmp580_01_b_fill_curs_d2 CURSOR FOR axmp580_01_sel_d2
   
   CALL g_xmdl2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH axmp580_01_b_fill_curs_d2 INTO g_xmdl2_d[l_ac].*
      #160120-00002#5 s983961--add(s)   
      #檢查請購單的資料是否已經被lock 
      LET l_xmdldocno = '' 
      LET l_xmdlseq   = '' 
      LET l_sql = "SELECT xmdldocno,xmdlseq ", 
                  "  FROM xmdl_t ", 
                  " WHERE xmdlent   = '",g_enterprise,"' ", 
                  "   AND xmdldocno  = '",g_xmdl2_d[l_ac].xmdkdocno,"' ", 
                  "   AND xmdlseq   = '",g_xmdl2_d[l_ac].xmdlseq,"' ",               
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE axmp580_01_chk_locked_prep2 FROM l_sql 
      EXECUTE axmp580_01_chk_locked_prep2 INTO l_xmdldocno,l_xmdlseq               
      IF cl_null(l_xmdldocno) AND cl_null(l_xmdlseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#5 s983961--add(e)       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp580_01_b_fill_curs_d2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF NOT axmp580_01_chk_temp_data(g_xmdl2_d[l_ac].xmdkdocno,g_xmdl2_d[l_ac].xmdlseq) THEN
         CONTINUE FOREACH
      END IF

      #預設簽收數量
      CALL axmp580_01_default_quantity(g_xmdl2_d[l_ac].xmdkdocno,g_xmdl2_d[l_ac].xmdlseq,g_xmdl2_d[l_ac].xmdl017)
      RETURNING g_xmdl2_d[l_ac].quantity

      IF g_xmdl2_d[l_ac].quantity <= 0 THEN
         CONTINUE FOREACH
      END IF

      #待簽收量
      LET g_xmdl2_d[l_ac].xmdl018 = 0
      LET g_xmdl2_d[l_ac].xmdl020 = 0

      #簽退數量
      LET g_xmdl2_d[l_ac].xmdl081 = 0
      LET g_xmdl2_d[l_ac].xmdl082 = 0
 
      #Reference
      CALL axmp580_01_xmdl2_ref()
      #161207-00033#3-s add
      EXECUTE axmp580_pb USING g_xmdl2_d[l_ac].xmdk007 INTO l_pmaa004
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #161230-00019#6-s-mod
         #一次性交易對象全名
#         CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmdl2_d[l_ac].xmdkdocno)
#              RETURNING r_pmak003
         LET r_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_xmdl2_d[l_ac].xmdk047) 
           RETURNING r_pmak003
         #161230-00019#6-e-mod
         IF NOT cl_null(r_pmak003) THEN
            LET g_xmdl2_d[l_ac].xmdk007_desc = r_pmak003
         END IF
      END IF
      #161207-00033#3-e add     
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

   LET g_rec_b2 = l_ac - 1
   CALL g_xmdl2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE axmp580_01_b_fill_curs_d2
   FREE axmp580_01_sel_d2
 
   CASE g_current_page
      WHEN '1'
         IF l_ac > g_xmdl_d.getLength() THEN
            LET l_ac = g_xmdl_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
      WHEN '2'
         IF l_ac > g_xmdl2_d.getLength() THEN
            LET l_ac = g_xmdl2_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF

   END CASE
END FUNCTION
#顯示收貨底稿資料
PUBLIC FUNCTION axmp580_01_b_fill2()
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   #161230-00019#6-s-add
   DEFINE r_pmak003    LIKE pmak_t.pmak003   #一次性交易對象名稱   
   DEFINE l_pmaa004    LIKE pmaa_t.pmaa004   #法人類型
   #161230-00019#6-e-add

   #隱藏"未來簽收資料"頁籤   #150214 earl
   CALL cl_set_comp_visible("page02_axmp580_01",FALSE)

   #--detail1--待簽收資料
   LET l_sql = "SELECT 'N',",
               #161230-00019#6-s-mod
#               "       xmdk007,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,",
               "       xmdk007,xmdk047,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,",
               #161230-00019#6-e-mod
               "       xmdl003,xmdl004,xmdl005,",
               "       xmdl006,",
               "       xmda033,",       #150116新增"客戶訂購單號"               
               "       xmdl007,xmdl008,xmdl009,",
               "       xmdl011,xmdl012,xmdl017,",
               "       xmdd012,",
               "       xmdl018,xmdl081,xmdl084,",
               "       xmdl019,xmdl020,xmdl082,",
               "       xmdl013,xmdl014,xmdl015,xmdl016,xmdl052",
               "  FROM axmp580_01_temp" #,   #2015/02/14 by stellar mark
#               " WHERE xmdd012 <= '",g_today CLIPPED,"'"   #2015/02/14 by stellar mark
               
   PREPARE axmp580_01_temp_sel_d1 FROM l_sql
   DECLARE axmp580_01_temp_b_fill_curs_d1 CURSOR FOR axmp580_01_temp_sel_d1

   #161230-00019#6-s-add
   LET l_sql = "SELECT pmaa004 FROM pmaa_t        ",
               " WHERE pmaaent ='",g_enterprise,"'",
               "   AND pmaa001 = ?  "
   PREPARE axmp580_pb2 FROM l_sql
   #161230-00019#6-e-add
   
   CALL g_xmdl_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH axmp580_01_temp_b_fill_curs_d1 INTO g_xmdl_d[l_ac].sel,
                                               #161230-00019#6-s-mod
#                                               g_xmdl_d[l_ac].xmdk007,g_xmdl_d[l_ac].xmdk003,g_xmdl_d[l_ac].xmdkdocdt,g_xmdl_d[l_ac].xmdkdocno,g_xmdl_d[l_ac].xmdlseq,
                                               g_xmdl_d[l_ac].xmdk007,g_xmdl_d[l_ac].xmdk047,g_xmdl_d[l_ac].xmdk003,g_xmdl_d[l_ac].xmdkdocdt,g_xmdl_d[l_ac].xmdkdocno,g_xmdl_d[l_ac].xmdlseq,
                                               #161230-00019#6-e-mod
                                               g_xmdl_d[l_ac].xmdl003,g_xmdl_d[l_ac].xmdl004,g_xmdl_d[l_ac].xmdl005,
                                               g_xmdl_d[l_ac].xmdl006,
                                               g_xmdl_d[l_ac].xmda033,    #150116新增"客戶訂購單號"                  
                                               g_xmdl_d[l_ac].xmdl007,g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009,
                                               g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012,g_xmdl_d[l_ac].xmdl017,
                                               g_xmdl_d[l_ac].xmdd012,
                                               g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl081,g_xmdl_d[l_ac].xmdl084,
                                               g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl020,g_xmdl_d[l_ac].xmdl082,
                                               g_xmdl_d[l_ac].xmdl013,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016,g_xmdl_d[l_ac].xmdl052
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:axmp580_01_temp_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #Reference
      CALL axmp580_01_xmdl_ref()
      
      #161230-00019#6-s-add
      EXECUTE axmp580_pb USING g_xmdl_d[l_ac].xmdk007 INTO l_pmaa004
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #161230-00019#6-s-mod
         #一次性交易對象全名
#         CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmdl_d[l_ac].xmdkdocno)
#              RETURNING r_pmak003
         LET r_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_xmdl_d[l_ac].xmdk047) 
           RETURNING r_pmak003
         #161230-00019#6-e-mod
         
         IF NOT cl_null(r_pmak003) THEN
            LET g_xmdl_d[l_ac].xmdk007_desc = r_pmak003
         END IF
      END IF
      #161230-00019#6-s-add

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
   
   CALL g_xmdl_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE axmp580_01_temp_b_fill_curs_d1
   FREE axmp580_01_temp_sel_d1

   #--detail2--
   LET l_sql = "SELECT 'N',",
               #161230-00019#6-s-mod
#               "       xmdk007,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,",
               "       xmdk007,xmdk047,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,",
               #161230-00019#6-e-mod
               "       xmdl003,xmdl004,xmdl005,",
               "       xmdl006,",
               "       xmda033,",           #150116新增"客戶訂購單號"
               "       xmdl007,xmdl008,xmdl009,",
               "       xmdl011,xmdl012,xmdl017,",
               "       xmdd012,",
               "       xmdl018,xmdl081,xmdl084,",
               "       xmdl019,xmdl020,xmdl082,",
               "       xmdl013,xmdl014,xmdl015,xmdl016,xmdl052",
               "  FROM axmp580_01_temp",
               " WHERE (xmdd012 > '",g_today CLIPPED,"' OR xmdd012 IS NULL)"

   PREPARE axmp580_01_temp_sel_d2 FROM l_sql
   DECLARE axmp580_01_temp_b_fill_curs_d2 CURSOR FOR axmp580_01_temp_sel_d2
   
   CALL g_xmdl2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   #2015/02/14 by stellar mark ----- (S)
   #檢視底稿時，把資料都顯示在待簽收資料的單身
#   FOREACH axmp580_01_temp_b_fill_curs_d2 INTO g_xmdl2_d[l_ac].sel,
#                                               g_xmdl2_d[l_ac].xmdk007,g_xmdl2_d[l_ac].xmdk003,g_xmdl2_d[l_ac].xmdkdocdt,g_xmdl2_d[l_ac].xmdkdocno,g_xmdl2_d[l_ac].xmdlseq,
#                                               g_xmdl2_d[l_ac].xmdl003,g_xmdl2_d[l_ac].xmdl004,g_xmdl2_d[l_ac].xmdl005,
#                                               g_xmdl2_d[l_ac].xmdl006,
#                                               g_xmdl2_d[l_ac].xmda033,     #150116新增"客戶訂購單號"
#                                               g_xmdl2_d[l_ac].xmdl007,g_xmdl2_d[l_ac].xmdl008,g_xmdl2_d[l_ac].xmdl009,
#                                               g_xmdl2_d[l_ac].xmdl011,g_xmdl2_d[l_ac].xmdl012,g_xmdl2_d[l_ac].xmdl017,
#                                               g_xmdl2_d[l_ac].xmdd012,
#                                               g_xmdl2_d[l_ac].xmdl018,g_xmdl2_d[l_ac].xmdl081,g_xmdl2_d[l_ac].xmdl084,
#                                               g_xmdl2_d[l_ac].xmdl019,g_xmdl2_d[l_ac].xmdl020,g_xmdl2_d[l_ac].xmdl082,
#                                               g_xmdl2_d[l_ac].xmdl013,g_xmdl2_d[l_ac].xmdl014,g_xmdl2_d[l_ac].xmdl015,g_xmdl2_d[l_ac].xmdl016,g_xmdl2_d[l_ac].xmdl052
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:axmp580_01_temp_b_fill_curs_d2"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#
#      #Reference
#      CALL axmp580_01_xmdl2_ref()
#
#      LET l_ac = l_ac + 1
#      IF l_ac > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code =  9035
#         LET g_errparam.extend =  ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#   END FOREACH
   #2015/02/14 by stellar mark ----- (E)
   
   CALL g_xmdl2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE axmp580_01_temp_b_fill_curs_d2
   FREE axmp580_01_temp_sel_d2

   CASE g_current_page
      WHEN '1'
         IF l_ac > g_xmdl_d.getLength() THEN
            LET l_ac = g_xmdl_d.getLength()
         END IF

      WHEN '2'
         IF l_ac > g_xmdl2_d.getLength() THEN
            LET l_ac = g_xmdl2_d.getLength()
         END IF
         
   END CASE
   
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF   
END FUNCTION

PUBLIC FUNCTION axmp580_01_save_data()
   DEFINE l_i     LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_msg   STRING
   DEFINE l_num   LIKE xmdl_t.xmdl018
   #160120-00002#5 s983961--add(s)
   DEFINE l_cnt       LIKE type_t.num10  #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_sql       STRING
   DEFINE l_xmdldocno LIKE xmdl_t.xmdldocno  
   DEFINE l_xmdlseq   LIKE xmdl_t.xmdlseq   
   DEFINE l_where     STRING
   #160120-00002#5 s983961--add(e)
   
   FOR l_i = 1 TO g_xmdl_d.getLength()
      IF g_xmdl_d[l_i].sel = 'Y' THEN
         #簽收數量
         IF cl_null(g_xmdl_d[l_i].xmdl018) THEN
            LET g_xmdl_d[l_i].xmdl018 = 0
         END IF
         #簽退數量
         IF cl_null(g_xmdl_d[l_i].xmdl081) THEN
            LET g_xmdl_d[l_i].xmdl081 = 0
         END IF         
         
         LET l_num = g_xmdl_d[l_i].xmdl018 + g_xmdl_d[l_i].xmdl081
      
         IF l_num > 0 THEN            
            #161230-00019#6-s-mod
#            INSERT INTO axmp580_01_temp (xmdk007,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,
            INSERT INTO axmp580_01_temp (xmdk007,xmdk047,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,
            #161230-00019#6-e-mod
                                         xmdl003,xmdl004,xmdl005,
                                         xmdl006,
                                         xmda033,    #150116新增"客戶訂購單號"
                                         xmdl007,xmdl008,xmdl009,
                                         xmdl011,xmdl012,xmdl017,
                                         xmdd012,
                                         xmdl018,xmdl081,xmdl084,
                                         xmdl019,xmdl020,xmdl082,
                                         xmdl013,xmdl014,xmdl015,xmdl016,xmdl052)
            #161230-00019#6-s-mod
#            VALUES(g_xmdl_d[l_i].xmdk007,g_xmdl_d[l_i].xmdk003,g_xmdl_d[l_i].xmdkdocdt,g_xmdl_d[l_i].xmdkdocno,g_xmdl_d[l_i].xmdlseq,
            VALUES(g_xmdl_d[l_i].xmdk007,g_xmdl_d[l_i].xmdk047,g_xmdl_d[l_i].xmdk003,g_xmdl_d[l_i].xmdkdocdt,g_xmdl_d[l_i].xmdkdocno,g_xmdl_d[l_i].xmdlseq,
            #161230-00019#6-e-mod
                   g_xmdl_d[l_i].xmdl003,g_xmdl_d[l_i].xmdl004,g_xmdl_d[l_i].xmdl005,
                   g_xmdl_d[l_i].xmdl006,
                   g_xmdl_d[l_i].xmda033,    #150116新增"客戶訂購單號"
                   g_xmdl_d[l_i].xmdl007,g_xmdl_d[l_i].xmdl008,g_xmdl_d[l_i].xmdl009,
                   g_xmdl_d[l_i].xmdl011,g_xmdl_d[l_i].xmdl012,g_xmdl_d[l_i].xmdl017,
                   g_xmdl_d[l_i].xmdd012,
                   g_xmdl_d[l_i].xmdl018,g_xmdl_d[l_i].xmdl081,g_xmdl_d[l_i].xmdl084,
                   g_xmdl_d[l_i].xmdl019,g_xmdl_d[l_i].xmdl020,g_xmdl_d[l_i].xmdl082,
                   g_xmdl_d[l_i].xmdl013,g_xmdl_d[l_i].xmdl014,g_xmdl_d[l_i].xmdl015,g_xmdl_d[l_i].xmdl016,g_xmdl_d[l_i].xmdl052)

            IF SQLCA.sqlcode != 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert axmp580_01_temp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               EXIT FOR
            END IF
         
            #160120-00002#5 s983961--add(s)  
            LET l_cnt = 0
            #160706-00037#6-s-mod-20170113
            SELECT COUNT(*) INTO l_cnt
#              FROM axmp580_tmp01               #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
              FROM axmp580_tmp_a
             WHERE xmdldocno = g_xmdl_d[l_i].xmdkdocno
               AND xmdlseq   = g_xmdl_d[l_i].xmdlseq
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
#               INSERT INTO axmp580_tmp01 VALUES(g_xmdl_d[l_i].xmdkdocno,g_xmdl_d[l_i].xmdlseq)        #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
               INSERT INTO axmp580_tmp_a VALUES(g_xmdl_d[l_i].xmdkdocno,g_xmdl_d[l_i].xmdlseq)
            END IF
            #160706-00037#6-e-mod-20170113
            #160120-00002#5 s983961--add(e)                 
         END IF
      END IF
   END FOR

   FOR l_i = 1 TO g_xmdl2_d.getLength()
      IF g_xmdl2_d[l_i].sel = 'Y' THEN
         #簽收數量
         IF cl_null(g_xmdl2_d[l_i].xmdl018) THEN
            LET g_xmdl2_d[l_i].xmdl018 = 0
         END IF
         #簽退數量
         IF cl_null(g_xmdl2_d[l_i].xmdl081) THEN
            LET g_xmdl2_d[l_i].xmdl081 = 0
         END IF 

         LET l_num = g_xmdl2_d[l_i].xmdl018 + g_xmdl2_d[l_i].xmdl081
      
         IF l_num > 0 THEN
            #161230-00019#6-s-mod
#            INSERT INTO axmp580_01_temp (xmdk007,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,
            INSERT INTO axmp580_01_temp (xmdk007,xmdk047,xmdk003,xmdkdocdt,xmdkdocno,xmdlseq,
            #161230-00019#6-e-mod
                                         xmdl003,xmdl004,xmdl005,
                                         xmdl006,
                                         xmda033,        #150116新增"客戶訂購單號"
                                         xmdl007,xmdl008,xmdl009,
                                         xmdl011,xmdl012,xmdl017,
                                         xmdd012,
                                         xmdl018,xmdl081,xmdl084,
                                         xmdl019,xmdl020,xmdl082,
                                         xmdl013,xmdl014,xmdl015,xmdl016,xmdl052)
            #161230-00019#6-s-mod
#            VALUES(g_xmdl2_d[l_i].xmdk007,g_xmdl2_d[l_i].xmdk003,g_xmdl2_d[l_i].xmdkdocdt,g_xmdl2_d[l_i].xmdkdocno,g_xmdl2_d[l_i].xmdlseq,
            VALUES(g_xmdl2_d[l_i].xmdk007,g_xmdl2_d[l_i].xmdk047,g_xmdl2_d[l_i].xmdk003,g_xmdl2_d[l_i].xmdkdocdt,g_xmdl2_d[l_i].xmdkdocno,g_xmdl2_d[l_i].xmdlseq,
            #161230-00019#6-e-mod
                   g_xmdl2_d[l_i].xmdl003,g_xmdl2_d[l_i].xmdl004,g_xmdl2_d[l_i].xmdl005,
                   g_xmdl2_d[l_i].xmdl006,
                   g_xmdl2_d[l_i].xmda033,        #150116新增"客戶訂購單號"
                   g_xmdl2_d[l_i].xmdl007,g_xmdl2_d[l_i].xmdl008,g_xmdl2_d[l_i].xmdl009,
                   g_xmdl2_d[l_i].xmdl011,g_xmdl2_d[l_i].xmdl012,g_xmdl2_d[l_i].xmdl017,
                   g_xmdl2_d[l_i].xmdd012,
                   g_xmdl2_d[l_i].xmdl018,g_xmdl2_d[l_i].xmdl081,g_xmdl2_d[l_i].xmdl084,
                   g_xmdl2_d[l_i].xmdl019,g_xmdl2_d[l_i].xmdl020,g_xmdl2_d[l_i].xmdl082,
                   g_xmdl2_d[l_i].xmdl013,g_xmdl2_d[l_i].xmdl014,g_xmdl2_d[l_i].xmdl015,g_xmdl2_d[l_i].xmdl016,g_xmdl2_d[l_i].xmdl052)

            IF SQLCA.sqlcode != 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert axmp580_01_temp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               EXIT FOR
            END IF
            
            #160120-00002#5 s983961--add(s)  
            LET l_cnt = 0
            #160706-00037#6-s-mod-20170113
            SELECT COUNT(*) INTO l_cnt
#              FROM axmp580_tmp01                #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01 
              FROM axmp580_tmp_a
             WHERE xmdldocno = g_xmdl_d[l_i].xmdkdocno
               AND xmdlseq   = g_xmdl_d[l_i].xmdlseq
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
#               INSERT INTO axmp580_tmp01 VALUES(g_xmdl2_d[l_i].xmdkdocno,g_xmdl2_d[l_i].xmdlseq)     #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01 
               INSERT INTO axmp580_tmp_a VALUES(g_xmdl2_d[l_i].xmdkdocno,g_xmdl2_d[l_i].xmdlseq)
            END IF
            #160706-00037#6-e-mod-20170113
            #160120-00002#5 s983961--add(e)           
         END IF
      END IF
   END FOR

END FUNCTION

PUBLIC FUNCTION axmp580_01_chk_temp_data(p_xmdkdocno,p_xmdlseq)
   DEFINE p_xmdkdocno      LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdlseq        LIKE xmdl_t.xmdlseq

   DEFINE r_success        LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM axmp580_01_temp
    WHERE xmdkdocno = p_xmdkdocno
      AND xmdlseq = p_xmdlseq
      
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION axmp580_01_delete_data()
   DEFINE l_i     LIKE type_t.num10       #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   
   FOR l_i = 1 TO g_xmdl_d.getLength()
      IF g_xmdl_d[l_i].sel = 'Y' THEN
         DELETE FROM axmp580_01_temp
          WHERE xmdkdocno = g_xmdl_d[l_i].xmdkdocno
            AND xmdlseq   = g_xmdl_d[l_i].xmdlseq
         #160120-00002#5 s983961--add(s)
         #160706-00037#6-s-mod-20170113
#         DELETE FROM axmp580_tmp01        #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01 
         DELETE FROM axmp580_tmp_a
          WHERE xmdldocno = g_xmdl_d[l_i].xmdkdocno
            AND xmdlseq   = g_xmdl_d[l_i].xmdlseq 
         #160706-00037#6-e-mod-20170113   
         #160120-00002#5 s983961--add(e)
      END IF
   END FOR

   FOR l_i = 1 TO g_xmdl2_d.getLength()
      IF g_xmdl2_d[l_i].sel = 'Y' THEN
         DELETE FROM axmp580_01_temp
          WHERE xmdkdocno = g_xmdl2_d[l_i].xmdkdocno
            AND xmdlseq   = g_xmdl2_d[l_i].xmdlseq
         #160120-00002#5 s983961--add(s)   
         #160706-00037#6-s-mod-20170113
#         DELETE FROM axmp580_tmp01        #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01 
         DELETE FROM axmp580_tmp_a
          WHERE xmdldocno = g_xmdl2_d[l_i].xmdkdocno
            AND xmdlseq   = g_xmdl2_d[l_i].xmdlseq   
         #160706-00037#6-e-mod-20170113
         #160120-00002#5 s983961--add(e)     
      END IF
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 待簽收數量
# Memo...........:
# Usage..........: CALL axmp580_01_default_quantity(p_xmdkdocno,p_xmdlseq,p_xmdl017)
#                  RETURNING r_xmdl018,r_xmdl020
# Input parameter: p_xmdkdocno    出貨單號
#                : p_xmdlseq      出貨項次
#                : p_xmdl017      出貨單位
# Return code....: r_xmdl018      待簽收數量
# Date & Author..: 2014/10/15 By earl
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp580_01_default_quantity(p_xmdkdocno,p_xmdlseq,p_xmdl017)
   DEFINE p_xmdkdocno   LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdlseq     LIKE xmdl_t.xmdlseq
   DEFINE p_xmdl017     LIKE xmdl_t.xmdl017
   DEFINE r_xmdl018     LIKE xmdl_t.xmdl018
   
   DEFINE l_success     LIKE type_t.num5

   #可轉簽收驗退量
   CALL s_axmt580_get_max_sign_qty(p_xmdkdocno,p_xmdlseq) RETURNING r_xmdl018

   #簽收數量取位
   CALL s_aooi250_take_decimals(p_xmdl017,r_xmdl018) RETURNING l_success,r_xmdl018

   RETURN r_xmdl018
        
END FUNCTION

PUBLIC FUNCTION axmp580_01_set_entry_b()
   CALL cl_set_comp_entry("xmdl018_d1_01,xmdl081_d1_01,xmdl084_d1_01,xmdl020_d1_01,xmdl082_d1_01",TRUE)
   CALL cl_set_comp_entry("xmdl018_d2_01,xmdl081_d2_01,xmdl084_d2_01,xmdl020_d2_01,xmdl082_d2_01",TRUE)   
END FUNCTION

PUBLIC FUNCTION axmp580_01_set_no_entry_b()
   IF g_axmp580_01_input_type = '2' THEN
      CALL cl_set_comp_entry("xmdl018_d1_01,xmdl081_d1_01,xmdl084_d1_01,xmdl020_d1_01,xmdl082_d1_01",FALSE)
      CALL cl_set_comp_entry("xmdl018_d2_01,xmdl081_d2_01,xmdl084_d2_01,xmdl020_d2_01,xmdl082_d2_01",FALSE)      
   END IF
   
   #不使用參考單位
   CASE g_current_page
      WHEN '1'
         IF cl_null(g_xmdl_d[l_ac].xmdl019) THEN
            CALL cl_set_comp_entry("xmdl020_d1_01,xmdl082_d1_01",FALSE)
         END IF
      
      WHEN '2'
         IF cl_null(g_xmdl2_d[l_ac].xmdl019) THEN
            CALL cl_set_comp_entry("xmdl020_d2_01,xmdl082_d2_01",FALSE)   
         END IF      
      
   END CASE

   
END FUNCTION

PUBLIC FUNCTION axmp580_01_delete_temp_table()
   DELETE FROM axmp580_01_temp
   
   #160120-00002#5 s983961--add(s)
   #160706-00037#6-s-mod-20170113
#   DELETE FROM axmp580_tmp01     #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
   DELETE FROM axmp580_tmp_a
   #160706-00037#6-e-mod-20170113
   #160120-00002#5 s983961--add(e)
END FUNCTION

PUBLIC FUNCTION axmp580_01()

END FUNCTION

PUBLIC FUNCTION axmp580_01_reason_ref(p_xmdl084,p_prog)
   DEFINE p_xmdl084     LIKE xmdl_t.xmdl084        #理由碼
   DEFINE p_prog        LIKE type_t.chr10          #程式代號
   DEFINE r_desc        LIKE oocql_t.oocql004      #說明
      
   LET r_desc = ''
      
   SELECT oocql004 INTO r_desc
     FROM oocql_t
    WHERE oocqlent = g_enterprise      
      AND oocql002 = p_xmdl084
      AND oocql003 = g_dlang
      AND oocql001 = (SELECT gzcb004
                        FROM gzcb_t
                       WHERE gzcb001 = '24'
                         AND gzcb002 = p_prog)
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 理由碼check
# Memo...........:
# Usage..........: CALL axmp580_01_reason_chk(p_xmdl084,p_prog)
#                  
# Input parameter: p_xmdl084   理由碼
#                : p_prog      程式代號
# Return code....: r_success   執行結果(TRUE/FALSE)
#                : 
# Date & Author..: 141016 By earl
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp580_01_reason_chk(p_xmdl084,p_prog)
   DEFINE p_xmdl084     LIKE xmdl_t.xmdl084
   DEFINE p_prog        LIKE type_t.chr10
   DEFINE l_gzcb004     LIKE gzcb_t.gzcb004
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_gzcb004 = ''
   #160816-00001#11  2016/08/17  By 08734 Mark
  # SELECT gzcb004
  #   INTO l_gzcb004
  #   FROM gzcb_t
  #  WHERE gzcb001 = '24'
  #    AND gzcb002 = p_prog
   LET l_gzcb004 = s_fin_get_scc_value('24',p_prog,'2')  #160816-00001#11  2016/08/17  By 08734 add
   
   CALL s_azzi650_chk_exist(l_gzcb004,p_xmdl084) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp580_01_xmdl_default(p_ac)
   DEFINE p_ac        LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_num       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   LET l_num = 0
   IF NOT cl_null(g_xmdl_d[p_ac].xmdl018) THEN
      LET l_num = l_num + g_xmdl_d[p_ac].xmdl018
   END IF
   
   IF NOT cl_null(g_xmdl_d[p_ac].xmdl081) THEN
      LET l_num = l_num + g_xmdl_d[p_ac].xmdl081
   END IF
      
   IF g_xmdl_d[p_ac].sel = 'Y' THEN
      IF l_num <= 0 THEN
         LET g_xmdl_d[p_ac].xmdl018 = g_xmdl_d[p_ac].quantity
         LET g_xmdl_d[p_ac].xmdl081 = 0

         #推算參考數量
         IF NOT cl_null(g_xmdl_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl_d[p_ac].xmdl017) AND
            NOT cl_null(g_xmdl_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl_d[p_ac].xmdl018) THEN
                  
            CALL s_aooi250_convert_qty(g_xmdl_d[p_ac].xmdl008,g_xmdl_d[p_ac].xmdl017,g_xmdl_d[p_ac].xmdl019,g_xmdl_d[p_ac].xmdl018)
            RETURNING l_success,g_xmdl_d[p_ac].xmdl020
         ELSE
            LET g_xmdl_d[p_ac].xmdl020 = ''
         END IF
      
         IF NOT cl_null(g_xmdl_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl_d[p_ac].xmdl017) AND
            NOT cl_null(g_xmdl_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl_d[p_ac].xmdl081) THEN
                  
            CALL s_aooi250_convert_qty(g_xmdl_d[p_ac].xmdl008,g_xmdl_d[p_ac].xmdl017,g_xmdl_d[p_ac].xmdl019,g_xmdl_d[p_ac].xmdl081)
            RETURNING l_success,g_xmdl_d[p_ac].xmdl082
         ELSE
            LET g_xmdl_d[p_ac].xmdl082 = ''
         END IF
         
      END IF
   ELSE
      LET g_xmdl_d[p_ac].xmdl018 = 0
      LET g_xmdl_d[p_ac].xmdl081 = 0
      
      #推算參考數量
      IF NOT cl_null(g_xmdl_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl_d[p_ac].xmdl017) AND
         NOT cl_null(g_xmdl_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl_d[p_ac].xmdl018) THEN
         
         LET g_xmdl_d[p_ac].xmdl020 = 0
      ELSE
         LET g_xmdl_d[p_ac].xmdl020 = ''
      END IF

      IF NOT cl_null(g_xmdl_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl_d[p_ac].xmdl017) AND
         NOT cl_null(g_xmdl_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl_d[p_ac].xmdl081) THEN
                  
         LET g_xmdl_d[p_ac].xmdl082 = 0
      ELSE
         LET g_xmdl_d[p_ac].xmdl082 = ''
      END IF

   END IF
   
   LET g_xmdl_d_o.xmdl018 = g_xmdl_d[p_ac].xmdl018
   LET g_xmdl_d_o.xmdl081 = g_xmdl_d[p_ac].xmdl081
   LET g_xmdl_d_o.xmdl020 = g_xmdl_d[p_ac].xmdl020
   LET g_xmdl_d_o.xmdl082 = g_xmdl_d[p_ac].xmdl082
END FUNCTION

PRIVATE FUNCTION axmp580_01_xmdl2_default(p_ac)
   DEFINE p_ac        LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_num       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   LET l_num = 0
   IF NOT cl_null(g_xmdl2_d[p_ac].xmdl018) THEN
      LET l_num = l_num + g_xmdl2_d[p_ac].xmdl018
   END IF
   
   IF NOT cl_null(g_xmdl2_d[p_ac].xmdl081) THEN
      LET l_num = l_num + g_xmdl2_d[p_ac].xmdl081
   END IF
      
   IF g_xmdl2_d[p_ac].sel = 'Y' THEN
      IF l_num <= 0 THEN
         LET g_xmdl2_d[p_ac].xmdl018 = g_xmdl2_d[p_ac].quantity
         LET g_xmdl2_d[p_ac].xmdl081 = 0

         #推算參考數量
         IF NOT cl_null(g_xmdl2_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl017) AND
            NOT cl_null(g_xmdl2_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl018) THEN
                  
            CALL s_aooi250_convert_qty(g_xmdl2_d[p_ac].xmdl008,g_xmdl2_d[p_ac].xmdl017,g_xmdl2_d[p_ac].xmdl019,g_xmdl2_d[p_ac].xmdl018)
            RETURNING l_success,g_xmdl2_d[p_ac].xmdl020
         ELSE
            LET g_xmdl2_d[p_ac].xmdl020 = ''
         END IF
      
         IF NOT cl_null(g_xmdl2_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl017) AND
            NOT cl_null(g_xmdl2_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl081) THEN
                  
            CALL s_aooi250_convert_qty(g_xmdl2_d[p_ac].xmdl008,g_xmdl2_d[p_ac].xmdl017,g_xmdl2_d[p_ac].xmdl019,g_xmdl2_d[p_ac].xmdl081)
            RETURNING l_success,g_xmdl2_d[p_ac].xmdl082
         ELSE
            LET g_xmdl2_d[p_ac].xmdl082 = ''
         END IF
         
      END IF
   ELSE
      LET g_xmdl2_d[p_ac].xmdl018 = 0
      LET g_xmdl2_d[p_ac].xmdl081 = 0
      
      #推算參考數量
      IF NOT cl_null(g_xmdl2_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl017) AND
         NOT cl_null(g_xmdl2_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl018) THEN
         
         LET g_xmdl2_d[p_ac].xmdl020 = 0
      ELSE
         LET g_xmdl2_d[p_ac].xmdl020 = ''
      END IF

      IF NOT cl_null(g_xmdl2_d[p_ac].xmdl008) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl017) AND
         NOT cl_null(g_xmdl2_d[p_ac].xmdl019) AND NOT cl_null(g_xmdl2_d[p_ac].xmdl081) THEN
                  
         LET g_xmdl2_d[p_ac].xmdl082 = 0
      ELSE
         LET g_xmdl2_d[p_ac].xmdl082 = ''
      END IF

   END IF
   
   LET g_xmdl2_d_o.xmdl018 = g_xmdl2_d[p_ac].xmdl018
   LET g_xmdl2_d_o.xmdl081 = g_xmdl2_d[p_ac].xmdl081
   LET g_xmdl2_d_o.xmdl020 = g_xmdl2_d[p_ac].xmdl020
   LET g_xmdl2_d_o.xmdl082 = g_xmdl2_d[p_ac].xmdl082
END FUNCTION

PRIVATE FUNCTION axmp580_01_xmdl_ref()
   DEFINE l_success    LIKE type_t.num5
   
   #客戶名稱
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdl_d[l_ac].xmdk007) RETURNING g_xmdl_d[l_ac].xmdk007_desc
   #業務人員
   CALL s_desc_get_person_desc(g_xmdl_d[l_ac].xmdk003) RETURNING g_xmdl_d[l_ac].xmdk003_desc
   #品名、規格
   CALL s_desc_get_item_desc(g_xmdl_d[l_ac].xmdl008) RETURNING g_xmdl_d[l_ac].xmdl008_desc,g_xmdl_d[l_ac].xmdl008_desc_desc
   #產品特徵
   CALL s_feature_description(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009) RETURNING l_success,g_xmdl_d[l_ac].xmdl009_desc
   #作業編號
   CALL s_desc_get_acc_desc('221',g_xmdl_d[l_ac].xmdl011) RETURNING g_xmdl_d[l_ac].xmdl011_desc
   #出貨單位
   CALL s_desc_get_unit_desc(g_xmdl_d[l_ac].xmdl017) RETURNING g_xmdl_d[l_ac].xmdl017_desc
   #逾期天數
   #CALL s_date_get_workdays(g_site,'','1',g_xmdl_d[l_ac].xmdd012,g_today) RETURNING g_xmdl_d[l_ac].days
   LET g_xmdl_d[l_ac].days = g_today - g_xmdl_d[l_ac].xmdd012
   #簽退理由碼
   CALL axmp580_01_reason_ref(g_xmdl_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl_d[l_ac].xmdl084_desc
   #參考單位
   CALL s_desc_get_unit_desc(g_xmdl_d[l_ac].xmdl019) RETURNING g_xmdl_d[l_ac].xmdl019_desc
   #庫位
   CALL s_desc_get_stock_desc(g_site,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc
   #儲位
   CALL s_desc_get_locator_desc(g_site,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc      
END FUNCTION

PRIVATE FUNCTION axmp580_01_xmdl2_ref()
   DEFINE l_success    LIKE type_t.num5
   
   #客戶名稱
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdl2_d[l_ac].xmdk007) RETURNING g_xmdl2_d[l_ac].xmdk007_desc
   #業務人員
   CALL s_desc_get_person_desc(g_xmdl2_d[l_ac].xmdk003) RETURNING g_xmdl2_d[l_ac].xmdk003_desc
   #品名、規格
   CALL s_desc_get_item_desc(g_xmdl2_d[l_ac].xmdl008) RETURNING g_xmdl2_d[l_ac].xmdl008_desc,g_xmdl2_d[l_ac].xmdl008_desc_desc
   #產品特徵
   CALL s_feature_description(g_xmdl2_d[l_ac].xmdl008,g_xmdl2_d[l_ac].xmdl009) RETURNING l_success,g_xmdl2_d[l_ac].xmdl009_desc
   #作業編號
   CALL s_desc_get_acc_desc('221',g_xmdl2_d[l_ac].xmdl011) RETURNING g_xmdl2_d[l_ac].xmdl011_desc
   #出貨單位
   CALL s_desc_get_unit_desc(g_xmdl2_d[l_ac].xmdl017) RETURNING g_xmdl2_d[l_ac].xmdl017_desc
   #逾期天數
   #CALL s_date_get_workdays(g_site,'','1',g_xmdl2_d[l_ac].xmdd012,g_today) RETURNING g_xmdl2_d[l_ac].days      
   #簽退理由碼
   CALL axmp580_01_reason_ref(g_xmdl2_d[l_ac].xmdl084,'axmt590') RETURNING g_xmdl2_d[l_ac].xmdl084_desc
   #參考單位
   CALL s_desc_get_unit_desc(g_xmdl2_d[l_ac].xmdl019) RETURNING g_xmdl2_d[l_ac].xmdl019_desc
   #庫位
   CALL s_desc_get_stock_desc(g_site,g_xmdl2_d[l_ac].xmdl014) RETURNING g_xmdl2_d[l_ac].xmdl014_desc
   #儲位
   CALL s_desc_get_locator_desc(g_site,g_xmdl2_d[l_ac].xmdl014,g_xmdl2_d[l_ac].xmdl015) RETURNING g_xmdl2_d[l_ac].xmdl015_desc      
END FUNCTION

 
{</section>}
 
