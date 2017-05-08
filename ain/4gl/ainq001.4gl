#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq001.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-10-21 11:18:06), PR版次:0007(2016-12-29 18:29:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000078
#+ Filename...: ainq001
#+ Description: 庫存查詢
#+ Creator....: 00845(2014-07-16 23:19:01)
#+ Modifier...: 02295 -SD/PR- 01534
 
{</section>}
 
{<section id="ainq001.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...NO.160202-00005#1 By lixh 20160506  标签类型语言别显示有误
#+ Modifier...NO.160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#+ Modifier...NO.161103-00037#1 By lixh 库存管理标签标签都会重复显示
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
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
         name             LIKE type_t.chr100,
         cnt              LIKE type_t.num5,
         inag009          LIKE inag_t.inag009,
         inag006          LIKE inag_t.inag006,
         inag002          LIKE inag_t.inag002,
         inag002_desc     LIKE type_t.chr500,
         inag003          LIKE inag_t.inag003,
         inag018          LIKE inag_t.inag018,
         inag010          LIKE inag_t.inag010,
         inag011          LIKE inag_t.inag011,
         inag012          LIKE inag_t.inag012,
         inag019          LIKE inag_t.inag019,
         inag020          LIKE inag_t.inag020,
         inag016          LIKE inag_t.inag016,
         inag022          LIKE inag_t.inag022,
         pid              LIKE type_t.chr100,
         id               LIKE type_t.chr100,
         exp              LIKE type_t.chr100,
         isnode           LIKE type_t.chr100
                    END RECORD

DEFINE g_oocq       DYNAMIC ARRAY OF RECORD
         oocq005          LIKE oocq_t.oocq005,
         oocq002          LIKE oocq_t.oocq002,
         oocql004         LIKE oocql_t.oocql004
                    END RECORD
DEFINE g_oocq2      DYNAMIC ARRAY OF RECORD
         oocq005_2          LIKE oocq_t.oocq005,
         oocq002_2          LIKE oocq_t.oocq002,
         oocql004_2         LIKE oocql_t.oocql004
                    END RECORD
DEFINE g_oocq1      DYNAMIC ARRAY OF RECORD
         type             LIKE type_t.chr1,
         oocq002_1        LIKE oocq_t.oocq002,
         oocql004_1       LIKE oocql_t.oocql004
                    END RECORD
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_rec_b               LIKE type_t.num5
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_WC                  STRING
DEFINE g_tag                 LIKE type_t.chr300
DEFINE g_itemtag             LIKE type_t.chr300
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_current_row         LIKE type_t.num5         #Browser所在筆數
DEFINE g_current_sw          LIKE type_t.num5         #Browser所在筆數用開關
DEFINE gdig_curr          ui.Dialog
DEFINE g_forupd_sql          STRING
DEFINE g_success             LIKE type_t.num5

DEFINE g_sel              DYNAMIC ARRAY OF RECORD
          oocq002           LIKE oocq_t.oocq002
                          END RECORD
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="ainq001.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE ainq001_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq001 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainq001_init()
 
      #進入選單 Menu (='N')
      CALL ainq001_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_ainq001
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="ainq001.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ainq001_ui_dialog()
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc        LIKE type_t.chr200
   DEFINE l_source     LIKE type_t.chr200
   DEFINE   l_dnd     ui.DragDrop
   DEFINE ls_cnt      LIKE type_t.num5    #判別是否為離開作業
   DEFINE l_no        LIKE type_t.num5


  CALL ainq001_oocq()
  CALL ainq001_oocq2()

  DIALOG ATTRIBUTES(UNBUFFERED=TRUE)


   DISPLAY ARRAY g_oocq TO s_oocq.* ATTRIBUTE(COUNT=g_rec_b)
       BEFORE DISPLAY
           #CALL DIALOG.setCellAttributes(g_oocq)
            CALL DIALOG.setSelectionMode("s_oocq", 1)
      BEFORE ROW

      ON DRAG_START(l_dnd)       #啟動拖拉 (source區)
            LET l_source="down"     #標示來源為   從上至下的拖拉
            LET l_ac = ARR_CURR()

        ON DRAG_OVER(l_dnd)        #拖入本區每一行(target) 都會觸發的action
            IF l_source == "down" THEN
               CALL l_dnd.setOperation(NULL)
            ELSE
               CALL l_dnd.setOperation("move")      #標註拖拉功能的處理方法
                                                    #NULL(不做),move(搬移),copy(複製)
               CALL l_dnd.setFeedback("insert")     #標註拖過來時,本區畫面對應方法
                                                    #insert(兩行之間),select(選定行反藍),all(兩者都要)
            END IF
        ON DROP(l_dnd)             #拖動完成target區的處理 (拖入本區的處理) 也就是 zz -> gbi 的處理
            IF l_source == "up" AND l_ac >0  THEN
               DELETE FROM oocq_tmp WHERE oocq002_t = g_oocq1[l_ac].oocq002_1 AND type =g_oocq1[l_ac].type
               CALL ainq001_array2_b_fill()  #更新 zz DISPLAY ARRAY內容
               CALL ainq001_tag_str()
               CALL ainq001_tree()           #更新 tree內容
               LET l_ac = 0
            END IF

   END DISPLAY

   DISPLAY ARRAY g_oocq2 TO s_oocq2.* ATTRIBUTE(COUNT=g_rec_b)

      BEFORE ROW

      ON DRAG_START(l_dnd)       #啟動拖拉 (source區)
            LET l_source="down1"     #標示來源為   從上至下的拖拉
            LET l_ac = ARR_CURR()

        ON DRAG_OVER(l_dnd)        #拖入本區每一行(target) 都會觸發的action
            IF l_source == "down1" THEN
               CALL l_dnd.setOperation(NULL)
            ELSE
               CALL l_dnd.setOperation("move")      #標註拖拉功能的處理方法
                                                    #NULL(不做),move(搬移),copy(複製)
               CALL l_dnd.setFeedback("insert")     #標註拖過來時,本區畫面對應方法
                                                    #insert(兩行之間),select(選定行反藍),all(兩者都要)
            END IF
        ON DROP(l_dnd)             #拖動完成target區的處理 (拖入本區的處理) 也就是 zz -> gbi 的處理
            IF l_source == "up" AND l_ac >0  THEN
               DELETE FROM oocq_tmp WHERE oocq002_t = g_oocq1[l_ac].oocq002_1 AND type =g_oocq1[l_ac].type
               CALL ainq001_array2_b_fill()  #更新 zz DISPLAY ARRAY內容
               CALL ainq001_tag_str()
               CALL ainq001_tree()           #更新 tree內容
               LET l_ac = 0
            END IF

   END DISPLAY

   DISPLAY ARRAY g_oocq1 TO s_oocq1.* ATTRIBUTE(COUNT=g_rec_b)
      BEFORE ROW

      ON DRAG_START(l_dnd)       #啟動拖拉 (source區)
            LET l_source="up"     #標示來源為   從上至下的拖拉
            LET l_ac = ARR_CURR()

        ON DRAG_OVER(l_dnd)        #拖入本區每一行(target) 都會觸發的action
            IF l_source == "up" THEN
               CALL l_dnd.setOperation(NULL)
            ELSE
               CALL l_dnd.setOperation("move")      #標註拖拉功能的處理方法
                                                    #NULL(不做),move(搬移),copy(複製)
               CALL l_dnd.setFeedback("insert")     #標註拖過來時,本區畫面對應方法
                                                    #insert(兩行之間),select(選定行反藍),all(兩者都要)
            END IF
        ON DROP(l_dnd)             #拖動完成target區的處理 (拖入本區的處理) 也就是 zz -> gbi 的處理
            IF l_source == "down" AND l_ac >0  THEN
               IF l_ac > 0 THEN
                  SELECT COUNT(*) INTO ls_cnt FROM oocq_tmp
                   WHERE  oocq002_t = g_oocq[l_ac].oocq002 AND type = '1'
                  IF ls_cnt > 0 THEN
                     MESSAGE "Repeat Data"
                  ELSE
                      CALL ainq001_sellist()
                    
                     CALL ainq001_array2_b_fill()  #更新 zz DISPLAY ARRAY內容
                     CALL ainq001_tag_str()
                     CALL ainq001_tree()           #更新 tree內容
                  END IF
               END IF
               LET l_ac = 0
            END IF
            IF l_source == "down1" AND l_ac >0  THEN
               IF l_ac > 0 THEN
                  SELECT COUNT(*) INTO ls_cnt FROM oocq_tmp
                   WHERE  oocq002_t = g_oocq2[l_ac].oocq002_2 AND type ='2'
                  IF ls_cnt > 0 THEN
                     MESSAGE "Repeat Data"
                  ELSE
                      SELECT oocq004 INTO l_no FROM oocq_t WHERE oocq001=213 AND oocq002=g_oocq2[l_ac].oocq002_2
                         AND oocqent = g_enterprise
                      INSERT INTO oocq_tmp(type,oocq002_t,oocql004_t,oocq004_t)
                                   VALUES('2',g_oocq2[l_ac].oocq002_2,g_oocq2[l_ac].oocql004_2,l_no)
                     CALL ainq001_array2_b_fill()  #更新 zz DISPLAY ARRAY內容
                     CALL ainq001_tag_str()
                     CALL ainq001_tree()           #更新 tree內容
                  END IF
               END IF
               LET l_ac = 0
            END IF
   END DISPLAY

   DISPLAY ARRAY g_tree TO s_tree.* ATTRIBUTE(COUNT=g_rec_b)
      BEFORE ROW
   END DISPLAY

   BEFORE DIALOG
         LET gdig_curr = ui.DIALOG.getCurrent()
   CALL cl_set_act_visible("accept,cancel", FALSE)
      ON ACTION exit
         EXIT DIALOG

      ON ACTION close
         EXIT DIALOG

      ON ACTION cancel
         EXIT DIALOG

      ON ACTION filter
         CALL ainq001_filter()


      &include "main_menu.4gl"
       #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
         


   END DIALOG

END FUNCTION

PRIVATE FUNCTION ainq001_array2_b_fill()
    DEFINE  l_sql        STRING
    DEFINE  l_ac         LIKE type_t.num5


     CALL g_oocq1.clear()

         LET l_sql = "SELECT type,oocq002_t,oocql004_t ",
                     "  FROM oocq_tmp "
         PREPARE ainq001_pre1 FROM l_sql
         DECLARE ainq001_cs1 CURSOR FOR ainq001_pre1

         LET l_ac =  1
         FOREACH ainq001_cs1 INTO g_oocq1[l_ac].type,g_oocq1[l_ac].oocq002_1,g_oocq1[l_ac].oocql004_1
            LET l_ac = l_ac + 1
         END FOREACH
         LET l_ac = g_oocq1.getLength()
         CALL g_oocq1.deleteElement(l_ac)

END FUNCTION

PRIVATE FUNCTION ainq001_filter()

    CONSTRUCT  g_wc ON inag009,inag010 FROM s_tree[1].inag009,s_tree[1].inag010
    CONSTRUCT  g_wc ON oocq002_1 FROM s_oocq1[1].oocq001_1

END FUNCTION

PRIVATE FUNCTION ainq001_oocq()
    DEFINE  l_sql        STRING
    DEFINE  l_ac         LIKE type_t.num5


     CALL g_oocq1.clear()
         LET l_sql = "SELECT DISTINCT oocq005,oocq002,oocql004 ",   #161103-00037#1
                     "  FROM oocq_t LEFT JOIN oocql_t ON oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 ='",g_dlang,"'",
                     " WHERE oocq001 =220  ",
                     "  AND oocqent = '",g_enterprise,"'",
                    " ORDER BY oocq002 "
         PREPARE ainq001_pre FROM l_sql
         DECLARE ainq001_cs CURSOR FOR ainq001_pre

         LET l_ac =  1
         FOREACH ainq001_cs INTO g_oocq[l_ac].oocq005,g_oocq[l_ac].oocq002,g_oocq[l_ac].oocql004
            LET l_ac = l_ac + 1
         END FOREACH
         LET l_ac = g_oocq.getLength()
         CALL g_oocq.deleteElement(l_ac)
         DROP TABLE oocq_tmp
         CREATE TEMP TABLE oocq_tmp(
                type            LIKE type_t.chr1,
                oocq002_t       LIKE oocq_t.oocq002,
                oocql004_t      LIKE oocql_t.oocql004,
                oocq004_t       LIKE type_t.num5)


END FUNCTION

PRIVATE FUNCTION ainq001_oocq2()
    DEFINE  l_sql        STRING
    DEFINE  l_ac         LIKE type_t.num5


     CALL g_oocq2.clear()
         LET l_sql = "SELECT oocq005,oocq002,oocql004 ",
                     "  FROM oocq_t LEFT JOIN oocql_t ON oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 ='",g_dlang,"'",
                     " WHERE oocq001 =213  ",
                     "  AND oocqent = '",g_enterprise,"'",
                     " ORDER BY oocq002 "
         PREPARE ainq001_pre7 FROM l_sql
         DECLARE ainq001_cs7 CURSOR FOR ainq001_pre7

         LET l_ac =  1
         FOREACH ainq001_cs7 INTO g_oocq2[l_ac].oocq005_2,g_oocq2[l_ac].oocq002_2,g_oocq2[l_ac].oocql004_2
            LET l_ac = l_ac + 1
         END FOREACH
         LET l_ac = g_oocq2.getLength()
         CALL g_oocq2.deleteElement(l_ac)
         DROP TABLE imaa_tmp
         CREATE TEMP TABLE imaa_tmp(
                imaa001        LIKE imaa_t.imaa001)

END FUNCTION

PRIVATE FUNCTION ainq001_tag_str()
    DEFINE  l_sql        STRING
    DEFINE  l_ac         LIKE type_t.num5
    DEFINE  l_oocq002    LIKE oocq_t.oocq002
    DEFINE  l_no         LIKE type_t.num5

         LET l_sql = "SELECT oocq002_t,oocq004_t ",
                     "  FROM oocq_tmp ",
                     "  WHERE type ='1' "

         PREPARE ainq001_pre6 FROM l_sql
         DECLARE ainq001_cs6 CURSOR FOR ainq001_pre6
        
         CALL s_aooi310_init_tagb('2') RETURNING g_success,g_tag
         FOREACH ainq001_cs6 INTO l_oocq002,l_no
            CALL s_aooi310_set_tagb('2',l_oocq002,g_tag) RETURNING g_success,g_tag
         END FOREACH
         #130529-00001 by stellar modify -----(S)
#         SELECT COUNT(*) INTO l_ac FROM oocq_tmp WHERE type = '1' 
         SELECT COUNT(*) INTO l_ac FROM oocq_tmp
         IF l_ac = 0 OR l_ac IS NULL THEN
            LET g_tag = NULL
         END IF

#         LET l_sql = "SELECT oocq002_t,oocq004_t ",
#                     "  FROM oocq_tmp ",
#                     "  WHERE type ='2' "
#
#         PREPARE ainq001_pre8 FROM l_sql
#         DECLARE ainq001_cs8 CURSOR FOR ainq001_pre8
#
#         CALL s_aooi310_init_tagb(2) RETURNING g_success,g_itemtag
#         FOREACH ainq001_cs8 INTO l_oocq002,l_no
#             CALL s_aooi310_set_tagb('1',l_oocq002,g_itemtag) RETURNING g_success,g_itemtag 
#         END FOREACH
#         SELECT COUNT(*) INTO l_ac FROM oocq_tmp  WHERE type ='2'
#         IF l_ac = 0 OR l_ac IS NULL THEN
#            LET g_itemtag = NULL
#         END IF
         #130529-00001 by stellar modify -----(E)

END FUNCTION

PRIVATE FUNCTION ainq001_tree()

   CALL g_tree.clear()

   CALL ainq001_tree_fill()
END FUNCTION

PRIVATE FUNCTION ainq001_tree_fill()
DEFINE l_pid    LIKE inag_t.inag001,
       l_id     LIKE inag_t.inag001,
       l_name   LIKE type_t.chr300,
       i        LIKE type_t.num10,
       l_sql    STRING
DEFINE  l_ac         LIKE type_t.num5
DEFINE l_inag004        LIKE inag_t.inag004
DEFINE l_inag004_t      LIKE inag_t.inag004
DEFINE l_inag005        LIKE inag_t.inag005
DEFINE l_inag005_t      LIKE inag_t.inag005
DEFINE l_success        LIKE type_t.num5
#130529-00001 by stellar add ----- (S)
DEFINE l_inag001        LIKE inag_t.inag001
DEFINE l_itemtag        LIKE type_t.num5
#130529-00001 by stellar add ----- (E)

   LET l_sql = "SELECT inag004 ",
               "  FROM inag_t,imaa_t ",
               "  WHERE inag023 LIKE ?",
               "   AND inagent ='",g_enterprise,"'",
               "   AND inagsite ='",g_site,"'",
               "   AND inagent = imaaent ",
               "   AND inag001 = imaa001 ",
               "   AND inag008 > 0 ",
               " GROUP BY inag004 ORDER BY inag004 "
   PREPARE ainq001_pre3 FROM l_sql
   DECLARE ainq001_cs3 CURSOR FOR ainq001_pre3

   LET l_sql = "SELECT inag005 ",
               "  FROM inag_t,imaa_t ",
               " WHERE inag004 =? ",
               "   AND inag023 LIKE ? ",
                "   AND inagent ='",g_enterprise,"'",
               "   AND inagsite ='",g_site,"'",
               "   AND inag008 > 0 ",
               "   AND inagent = imaaent ",
               "   AND inag001 = imaa001 ",
               " GROUP BY inag005 ORDER BY inag005 "
   PREPARE ainq001_pre4 FROM l_sql
   DECLARE ainq001_cs4 CURSOR FOR ainq001_pre4

   LET l_sql = "SELECT inag009,inag001,inag006,inag002,inag003,inag018,inag010,inag011,",
               " inag012,inag019,inag020,inag016,inag022 ",
               "  FROM inag_t,imaa_t ",
               " WHERE inag004=? AND inag005=? ",
               "   AND inagent ='",g_enterprise,"'",
               "   AND inagsite ='",g_site,"'",
               "   AND inag008 > 0 ",
               "   AND inagent = imaaent ",
               "   AND inag001 = imaa001 ",
               " ORDER BY inag001 "
   PREPARE ainq001_pre5 FROM l_sql
   DECLARE ainq001_cs5 CURSOR FOR ainq001_pre5

   LET l_sql = "SELECT COUNT(*),SUM(inag009)",
               "  FROM inag_t,imaa_t ",
               " WHERE inag004=? ",
               "   AND inag023 LIKE ? ",
               "   AND inagent ='",g_enterprise,"'",
               "   AND inagsite ='",g_site,"'",
               "   AND inag008 > 0 ",
               "   AND inagent = imaaent ",
               "   AND inag001 = imaa001 "

   PREPARE ainq001_pre9 FROM l_sql
   DECLARE ainq001_cs9 CURSOR FOR ainq001_pre9

   LET l_sql = "SELECT COUNT(*),SUM(inag009)",
               "  FROM inag_t,imaa_t ",
               " WHERE inag004=? ",
               "   AND inag005 =? ",
               "   AND inag023 LIKE ? ",
               "   AND inagent ='",g_enterprise,"'",
               "   AND inagsite ='",g_site,"'",
               "   AND inag008 > 0 ",
               "   AND inagent = imaaent ",
               "   AND inag001 = imaa001 "
   PREPARE ainq001_pre10 FROM l_sql
   DECLARE ainq001_cs10 CURSOR FOR ainq001_pre10
   LET l_ac = 1
   FOREACH ainq001_cs3 USING g_tag INTO l_inag004
         LET l_inag004_t = l_inag004
         
         #130529-00001 by stellar add ----- (S)
         LET l_sql = "SELECT inag001 ",
                     "  FROM inag_t,imaa_t ",
                     " WHERE inag023 LIKE '",g_tag,"'",
                     "   AND inag004 = '",l_inag004,"'",
                     "   AND inagent ='",g_enterprise,"'",
                     "   AND inagsite ='",g_site,"'",
                     "   AND inagent = imaaent ",
                     "   AND inag001 = imaa001 ",
                     "   AND inag008 > 0 ",
                     " GROUP BY inag001 ORDER BY inag001 "
         PREPARE ainq001_inag001_pre FROM l_sql
         DECLARE ainq001_inag001_cs CURSOR FOR ainq001_inag001_pre
         
         LET l_itemtag = FALSE
         FOREACH ainq001_inag001_cs INTO l_inag001
            IF ainq001_chk_itemtag(l_inag001) THEN
               LET l_itemtag = TRUE
               EXIT FOREACH
            END IF
         END FOREACH
         IF NOT l_itemtag THEN
            CONTINUE FOREACH
         END IF
         #130529-00001 by stellar add ----- (E)
         
         LET l_name = NULL
         SELECT inayl003 INTO l_name FROM inayl_t WHERE inaylent=g_enterprise AND inayl001=l_inag004 AND inayl002 = g_dlang #160905-00007#4 by 08172 add ent
         LET g_tree[l_ac].name = l_inag004,"(",l_name,")"
         SELECT COUNT(*),SUM(inag009) INTO g_tree[l_ac].cnt,g_tree[l_ac].inag009 FROM inag_t WHERE inag004 = l_inag004_t AND inagent = g_enterprise #160905-00007#4 by 08172 add ent
         OPEN ainq001_cs9 USING l_inag004_t,g_tag
         FETCH ainq001_cs9 INTO g_tree[l_ac].cnt,g_tree[l_ac].inag009
         LET g_tree[l_ac].pid = '0'
         LET g_tree[l_ac].id = l_inag004
         LET g_tree[l_ac].exp = TRUE
         LET g_tree[l_ac].isnode = TRUE
         LET l_ac = l_ac + 1

         FOREACH ainq001_cs4 USING l_inag004_t,g_tag INTO l_inag005
           
            #130529-00001 by stellar add ----- (S)
            LET l_sql = "SELECT inag001 ",
                        "  FROM inag_t,imaa_t ",
                        " WHERE inag004 = '",l_inag004_t,"'",
                        "   AND inag005 = '",l_inag005,"'",
                        "   AND inag023 LIKE '",g_tag,"'",
                        "   AND inagent ='",g_enterprise,"'",
                        "   AND inagsite ='",g_site,"'",
                        "   AND inag008 > 0 ",
                        "   AND inagent = imaaent ",
                        "   AND inag001 = imaa001 ",
                        " GROUP BY inag001 ORDER BY inag001 "
            PREPARE ainq001_inag001_pre1 FROM l_sql
            DECLARE ainq001_inag001_cs1 CURSOR FOR ainq001_inag001_pre1
            
            LET l_itemtag = FALSE
            FOREACH ainq001_inag001_cs1 INTO l_inag001
               IF ainq001_chk_itemtag(l_inag001) THEN
                  LET l_itemtag = TRUE
                  EXIT FOREACH
               END IF
            END FOREACH
            IF NOT l_itemtag THEN
               CONTINUE FOREACH
            END IF
            #130529-00001 by stellar add ----- (E)
         
            IF NOT cl_null(l_inag005)  THEN
               LET l_inag005_t = l_inag005
               LET l_name = NULL
               SELECT inab003 INTO l_name FROM inab_t WHERE inab001=l_inag004 AND inab002=l_inag005 AND inabent = g_enterprise #160905-00007#4 by 08172 add ent
               LET g_tree[l_ac].name = l_inag005,"(",l_name,")"
               SELECT COUNT(*),SUM(inag009) INTO g_tree[l_ac].cnt,g_tree[l_ac].inag009 FROM inag_t
                      WHERE inag004 = l_inag004 AND inag005 = l_inag005
                        AND inagent = g_enterprise #160905-00007#4 by 08172 add ent
               OPEN ainq001_cs10 USING l_inag004,l_inag005,g_tag
               FETCH ainq001_cs10 INTO g_tree[l_ac].cnt,g_tree[l_ac].inag009
               LET g_tree[l_ac].pid = l_inag004
               LET g_tree[l_ac].id = l_inag005
               LET g_tree[l_ac].exp = TRUE
               LET g_tree[l_ac].isnode = TRUE
               LET l_ac = l_ac + 1
            END IF

               FOREACH ainq001_cs5 USING l_inag004,l_inag005 INTO g_tree[l_ac].inag009,g_tree[l_ac].name,
                       g_tree[l_ac].inag006,
                       g_tree[l_ac].inag002,g_tree[l_ac].inag003,g_tree[l_ac].inag018,g_tree[l_ac].inag010,g_tree[l_ac].inag011,
                       g_tree[l_ac].inag012,g_tree[l_ac].inag019,g_tree[l_ac].inag020,g_tree[l_ac].inag016,
                       g_tree[l_ac].inag022
                    
                    #130529-00001 by stellar modify -----(S)
                    IF NOT ainq001_chk_itemtag(g_tree[l_ac].name) THEN
                       CONTINUE FOREACH
                    END IF
                    #130529-00001 by stellar modify -----(E)
                       
                    CALL s_feature_description(g_tree[l_ac].name,g_tree[l_ac].inag002)
                         RETURNING l_success,g_tree[l_ac].inag002_desc
                         
                    LET l_name = NULL
                    SELECT imaal003 INTO l_name FROM imaal_t WHERE imaal001= g_tree[l_ac].name
                       AND imaalent = g_enterprise   #160905-00007#4 by 08172
                       AND imaal002 = g_dlang   #161103-00037#1
                    LET g_tree[l_ac].name = g_tree[l_ac].name,"(",l_name,")"
                    IF cl_null(l_inag005) THEN
                        LET g_tree[l_ac].pid = l_inag004
                    ELSE
                       LET g_tree[l_ac].pid = l_inag005
                    END IF
                    LET g_tree[l_ac].id = g_tree[l_ac].name
                    LET g_tree[l_ac].exp = TRUE
                    LET g_tree[l_ac].isnode = FALSE
                    
                    LET l_ac = l_ac + 1
                END FOREACH
         END FOREACH
   END FOREACH

   LET l_ac = g_tree.getLength()

   CALL g_tree.deleteElement(l_ac)
  
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
PRIVATE FUNCTION ainq001_sellist()
   DEFINE li_i, li_j LIKE type_t.num5
   DEFINE l_no       LIKE oocq_t.oocq004

   CALL g_sel.clear()
   LET li_j = 1

   FOR li_i = 1 TO g_oocq.getLength()
       IF gdig_curr.isRowSelected("s_oocq", li_i) THEN
          SELECT oocq004 INTO l_no FROM oocq_t WHERE oocq001=220 AND oocq002=g_oocq[li_i].oocq002
           AND oocqent = g_enterprise
                      INSERT INTO oocq_tmp(type,oocq002_t,oocql004_t,oocq004_t)
                                   VALUES('1',g_oocq[li_i].oocq002,g_oocq[li_i].oocql004,l_no)
        # # 被選擇, 但一定要是單頭資料
        # IF g_oea[li_i].pid IS NULL THEN
        #    LET g_sel[li_j].oea01 = g_oea[li_i].name
        #    LET li_j = li_j + 1
        # END IF
       END IF
   END FOR
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
PRIVATE FUNCTION ainq001_init()

END FUNCTION

################################################################################
# Descriptions...: 檢查料件標籤
# Memo...........:
# Usage..........: CALL ainq001_chk_itemtag(p_item)
#                  RETURNING r_success
# Input parameter: p_item         料件編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20160129 By stellar for #130529-00001
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq001_chk_itemtag(p_item)
DEFINE p_item            LIKE imaa_t.imaa001
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_imal002         LIKE imal_t.imal002

   LET r_success = TRUE
   CALL cl_set_combo_scc('type','3089')  #160202-00005#1
   LET l_sql = "SELECT oocq002_t FROM oocq_tmp WHERE type = '2' ",
               " MINUS ",
               "SELECT imal002 FROM imal_t WHERE imalent = ",g_enterprise," AND imal001 = '",p_item,"'"
   PREPARE ainq001_chk_itemtag_pre FROM l_sql
   DECLARE ainq001_chk_itemtag_cs CURSOR FOR ainq001_chk_itemtag_pre
   
   FOREACH ainq001_chk_itemtag_cs INTO l_imal002
      LET r_success = FALSE
      EXIT FOREACH
   END FOREACH
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
