#+ Version..: T100-ERP-1.00.00(版次:1) Build-000720
#+ 
#+ Filename...: adzp168_01
#+ Description: 樹狀設定
#+ Creator....: tsai_yen(12/11/20)
#+ Modifier...: 
#+ Buildtype..: 

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"


#單身 type 宣告

#PRIVATE TYPE type_g_dzef_d RECORD   #資料表欄位參考檔
#   dzef006   LIKE dzef_t.dzef006,   #取值Table
#   dzef007   LIKE dzef_t.dzef007,   #取值參考欄位
#   dzef008   LIKE dzef_t.dzef008    #取值欄位
#   END RECORD

#模組變數(Module Variables)
DEFINE g_dzff_d_t           type_g_dzff_d
DEFINE g_dzff_d_arr_t       DYNAMIC ARRAY OF type_g_dzff_d   #修改前備份全部資料
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                  #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10
DEFINE l_ac                 LIKE type_t.num5        #目前處理的ARRAY CNT
DEFINE g_curr_diag          ui.Dialog               #Current Dialog
DEFINE g_temp_idx           LIKE type_t.num5        #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num5        #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5        #單身 總筆數(所有資料)
#DEFINE g_table_idx          LIKE type_t.num10       #使用的Table index
#DEFINE g_dzfe002            LIKE dzfe_t.dzfe002     #使用的節點類型(ex.Tree,提速檔)
DEFINE g_dzff003            LIKE dzff_t.dzff003     #4fd tag name (s_browse,s_detail1)
DEFINE g_tableid            LIKE dzea_t.dzea001     #節點名稱: 資料表代碼
#END add-point

DEFINE g_p_form_idx    LIKE type_t.num10     #Tree在畫面結構的index
DEFINE g_dzfq016         LIKE dzfq_t.dzfq016              #樹狀結構類別(recu_01:遞迴單檔樹狀/ recu_02:遞迴主從表樹狀/ type_01:階層分類樹狀)
---

#+ 作業開始
FUNCTION adzp168_01(p_form_idx)
#adzp168_01(p_table_idx,p_dzfe002,p_dzff003)
   DEFINE p_form_idx    LIKE type_t.num10     #Tree在畫面結構的index
   #DEFINE p_table_idx   LIKE type_t.num10     #使用的Table index
   #DEFINE p_dzfe002     LIKE dzfe_t.dzfe002   #使用的節點類型
   #DEFINE p_dzff003     LIKE dzff_t.dzff003   #4fd tag name (s_browse,s_detail1)

   LET g_sql = "DELETE adzp168t3 WHERE dzff001=? AND dzff002=? AND dzff003=?"
   PREPARE adzp168t3_del_pre01 FROM g_sql

   #LET g_sql = "SELECT DISTINCT dzff009 FROM adzp168t3 WHERE dzff001=? AND dzff002=? AND dzff003=?"
   #PREPARE adzp168_01_dzff009_pre01 FROM g_sql

   LET g_sql = "INSERT INTO adzp168t3(dzff001,dzff002,dzff003,dzff004,dzff005,",
                                           " dzff006,dzff007,dzff008)",
               " VALUES(?,?,?,?,? ,?,?,?)"
   PREPARE adzp168_01_dzff_ins_pre FROM g_sql
   
      LET g_p_form_idx = p_form_idx
      #LET g_table_idx = p_table_idx
      #LET g_dzfe002 = p_dzfe002
      LET g_dzff003 = g_form_tree[g_p_form_idx].dzfr007 CLIPPED #p_dzff003


      CALL adzp168_01_s01_dialog()


END FUNCTION

#+ 樹狀結構類別資料初始化
PRIVATE FUNCTION adzp168_01_s01_init()
   CALL sadzp168_1_set_combo_scc_dzfq016('dzfq016','115')   #樹狀結構類別

   #EXECUTE adzp168_01_dzff009_pre01 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003 INTO g_dzfq016
   LET g_dzfq016 = g_dzfq_m.dzfq016
   IF cl_null(g_dzfq016) THEN
      LET g_dzfq016 = "recu_01"   #遞迴單檔樹狀
   ELSE
      LET g_dzfq016 = g_dzfq016 CLIPPED
   END IF
END FUNCTION

#+ 設定樹狀結構類別
PRIVATE FUNCTION adzp168_01_s01_dialog()
   DEFINE l_img_dir       STRING
   DEFINE l_str           STRING

   LET l_img_dir = "formtplpic/treeclass/"

   OPEN WINDOW w_adzp168_01_s01 WITH FORM cl_ap_formpath("adz","adzp168_01_s01")

   CALL adzp168_01_s01_init()

   LET l_str = l_img_dir CLIPPED,"ra_treeclass_",g_dzfq016 CLIPPED,"_1"
   DISPLAY l_str TO img_treeclass1
   LET l_str = l_img_dir CLIPPED,"ra_treeclass_",g_dzfq016 CLIPPED,"_2"
   DISPLAY l_str TO img_treeclass2

   LET g_action_choice=" "
   INPUT g_dzfq016 FROM dzfq016 ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE dzfq016
         LET l_str = l_img_dir CLIPPED,"ra_treeclass_",g_dzfq016 CLIPPED,"_1"
         DISPLAY l_str TO img_treeclass1
         LET l_str = l_img_dir CLIPPED,"ra_treeclass_",g_dzfq016 CLIPPED,"_2"
         DISPLAY l_str TO img_treeclass2

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT INPUT

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT INPUT

      ON ACTION step_next
         LET g_action_choice="step_next"
         IF sadzp168_1_dzfq016_chk(g_dzfq016,TRUE) THEN 
            CALL adzp168_01_ui_dialog()
            CASE g_action_choice
               WHEN " "   #從另一個視窗回來若是空值,表示要離開
                  EXIT INPUT
            END CASE
         END IF 
         
   END INPUT

   CLOSE WINDOW w_adzp168_01_s01
END FUNCTION

#+ 畫面資料初始化
PRIVATE FUNCTION adzp168_01_init()
   #LET g_tableid = g_form_tree[g_p_form_idx].dzfr009 CLIPPED  #g_tbtree[g_table_idx].b_tableid CLIPPED
   LET g_tableid = g_tbtree[2].b_tableid   #先不檢查資料表代碼,都使用主表當Tree的資料表

   LET g_sql = "UPDATE adzp168t3",
               " SET dzff004 = ?,dzff005 = ?,dzff006 = ?,dzff007 = ?",
                " WHERE  dzff001 = ?",
                   " AND dzff002 = ?",
                   " AND dzff003 = ?",
                   " AND dzff004 = ?"
   PREPARE adzp168_01_dzff_tmp_upd_pre FROM g_sql

   LET g_sql = "SELECT dzff006 FROM adzp168t3",
               " WHERE dzff001=? AND dzff002=? AND dzff003=?",
                 " AND dzff005 = ?"
   PREPARE adzp168_01_dzff_table_pre FROM g_sql

   #資料表主檔cnt
   LET g_sql = "SELECT COUNT(dzea001) FROM dzea_t WHERE dzea001 = ?"
   PREPARE adzp168_01_dzea_cnt_pre FROM g_sql

   #欄位主檔cnt
   LET g_sql = "SELECT COUNT(dzeb001) FROM dzeb_t WHERE dzeb001 = ? AND dzeb002 = ?"
   PREPARE adzp168_01_dzeb_cnt_pre FROM g_sql

   #r.t預設值
   LET g_sql = "SELECT dzeq006,dzeq007,dzeq008,dzeq009 FROM dzeq_t",
               " WHERE dzeq001 = ?"
   PREPARE adzp168_01_dzeq_pre FROM g_sql
   DECLARE adzp168_01_dzeq_curs CURSOR FOR adzp168_01_dzeq_pre

   CALL sadzp168_1_dzff_default(g_dzff003,g_dzfq016)
   CALL adzp168_01_cb_dzff005()
END FUNCTION


#+ 選單功能實際執行處
PRIVATE FUNCTION adzp168_01_ui_dialog()
   OPEN WINDOW w_adzp168_01 WITH FORM cl_ap_formpath("adz","adzp168_01")
   CALL adzp168_01_init()

   LET g_wc2 = "1=1"
   CALL adzp168_01_m_fill(g_wc2)
   CALL adzp168_01_modify() #先直接使用input模式,不用Menu

   CLOSE WINDOW w_adzp168_01
END FUNCTION


#+ 單身陣列填充
PRIVATE FUNCTION adzp168_01_m_fill(p_wc2)              #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_dzeq          RECORD
      l_dzeq006           LIKE dzeq_t.dzeq006,
      l_dzeq007           LIKE dzeq_t.dzeq007,
      l_dzeq008           LIKE dzeq_t.dzeq008,
      l_dzeq009           LIKE dzeq_t.dzeq009
      END RECORD
   DEFINE l_speed_table   LIKE dzff_t.dzff006
   DEFINE l_dzfq016_t     LIKE dzfq_t.dzfq016     #樹狀結構類別舊值
   DEFINE l_dzff_d        type_g_dzff_d           #樹狀結構屬性設定檔
   DEFINE l_chk           BOOLEAN 

   #刪除不屬於此樹狀結構類別
   #LET g_sql = "DELETE adzp168t3 WHERE dzff001=? AND dzff002=? AND dzff003=? AND dzff005 NOT IN (",l_dzff005_sql CLIPPED,")"
   #PREPARE adzp168t3_del_pre02 FROM g_sql
   #EXECUTE adzp168t3_del_pre02 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003
   #IF SQLCA.sqlcode THEN
   #   CALL cl_err("del TMP:",SQLCA.sqlcode,1)
   #END IF

   #樹狀結構類別改變,要把設定清空
   #EXECUTE adzp168_01_dzff009_pre01 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003 INTO l_dzfq016_t
   LET l_dzfq016_t = g_dzfq_m.dzfq016
   IF g_dzfq016 <> l_dzfq016_t OR 
      (NOT cl_null(g_dzfq016) AND cl_null(l_dzfq016_t)) OR
      (cl_null(g_dzfq016) AND NOT cl_null(l_dzfq016_t)) THEN
      EXECUTE adzp168t3_del_pre01 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003   #刪除暫存檔dzff
   END IF

   LET g_dzfq_m.dzfq016 = g_dzfq016

   LET l_cnt = 0
   LET g_sql = "SELECT COUNT(dzff001) FROM adzp168t3 WHERE dzff001=? AND dzff002=? AND dzff003=? AND ", p_wc2 CLIPPED
   PREPARE adzp168_01_m_cnt FROM g_sql
   EXECUTE adzp168_01_m_cnt USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003 INTO l_cnt   #暫存檔dzff資料數

   IF l_cnt = 0 THEN   #沒有資料就取設定檔先新增預設
      #有可能換Table,所以要清空
      EXECUTE adzp168t3_del_pre01 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003   #刪除暫存檔dzff
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del TMP:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      #預設可設定的資料
      LET l_cnt = g_dzff_default.getLength()
      FOR l_i = 1 TO l_cnt
         EXECUTE adzp168_01_dzff_ins_pre USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003,g_dzff_default[l_i].dzff004,g_dzff_default[l_i].dzff005,
                                               g_dzff_default[l_i].dzff006,g_dzff_default[l_i].dzff007,g_dzff_default[l_i].dzff008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END FOR

      LET g_sql = "UPDATE adzp168t3",
                  " SET dzff006 = ?, dzff007 = ?",
                  " WHERE dzff001=? AND dzff002=? AND dzff003=?",
                    " AND dzff005=?",
                    #" AND dzff005 <> 'desc'",  #todo 是否設定desc
                    " AND ", p_wc2 CLIPPED
      PREPARE adzp168_01_dzeq_upd_pre FROM g_sql

      #預設值來自r.t
      FOREACH adzp168_01_dzeq_curs USING g_tableid INTO l_dzeq.*
         EXECUTE adzp168_01_dzeq_upd_pre USING l_dzeq.l_dzeq008,l_dzeq.l_dzeq009,
                                             g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003,
                                             l_dzeq.l_dzeq007
      END FOREACH

      #提速擋預設值來自r.t
      LET l_speed_table = NULL
      EXECUTE adzp168_01_dzff_table_pre USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003,'speed' INTO l_speed_table
      LET l_speed_table = l_speed_table CLIPPED
      IF NOT cl_null(l_speed_table) THEN
         FOREACH adzp168_01_dzeq_curs USING l_speed_table INTO l_dzeq.*
            EXECUTE adzp168_01_dzeq_upd_pre USING l_dzeq.l_dzeq008,l_dzeq.l_dzeq009,
                                                g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003,
                                                l_dzeq.l_dzeq007
         END FOREACH
      END IF
   END IF

   LET g_sql = "SELECT dzff001,dzff002,dzff003,dzff004,dzff005,dzff006,dzff007,dzff008",
               " FROM adzp168t3",
               " WHERE dzff001=? AND dzff002=? AND dzff003=?",
                 #" AND dzff005 <> 'desc'",  #todo 是否設定desc
                 " AND ", p_wc2 CLIPPED,
               " ORDER BY dzff004"
   PREPARE adzp168_01_m FROM g_sql
   DECLARE m_fill_curs CURSOR FOR adzp168_01_m

   LET g_sql = "SELECT dzff001,dzff002,dzff003,dzff004,dzff005,dzff006,dzff007,dzff008",
               " FROM adzp168t3",
               " WHERE dzff001=? AND dzff002=? AND dzff003=? AND dzff005=?"
   PREPARE adzp168_01_dzff005_01 FROM g_sql
   
   CALL g_dzff_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   MESSAGE "Searching!"

   #FOREACH m_fill_curs USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003
   #   INTO g_dzff_d[l_ac].dzff001,g_dzff_d[l_ac].dzff002,g_dzff_d[l_ac].dzff003,g_dzff_d[l_ac].dzff004,g_dzff_d[l_ac].dzff005,
   #        g_dzff_d[l_ac].dzff006,g_dzff_d[l_ac].dzff007,g_dzff_d[l_ac].dzff008

   #預設可設定的屬性
   LET l_chk = FALSE
   LET l_cnt = g_dzff_default.getLength()
   FOR l_i = 1 TO l_cnt 
      LET g_dzff_default[l_i].dzff005 = g_dzff_default[l_i].dzff005 CLIPPED
      EXECUTE adzp168_01_dzff005_01 USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003,g_dzff_default[l_i].dzff005
      INTO l_dzff_d.dzff001,l_dzff_d.dzff002,l_dzff_d.dzff003,l_dzff_d.dzff004,l_dzff_d.dzff005,
           l_dzff_d.dzff006,l_dzff_d.dzff007,l_dzff_d.dzff008

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOR:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOR
      END IF
      
      #去除來自暫存檔的空白
      LET g_dzff_d[l_ac].dzff001 = l_dzff_d.dzff001 CLIPPED #程式代號
      LET g_dzff_d[l_ac].dzff002 = l_dzff_d.dzff002 CLIPPED #識別碼版號
      LET g_dzff_d[l_ac].dzff003 = l_dzff_d.dzff003 CLIPPED #4fd tag name (s_browse,s_detail1)
      LET g_dzff_d[l_ac].dzff004 = l_i                      #編號
      LET g_dzff_d[l_ac].dzff005 = l_dzff_d.dzff005 CLIPPED #屬性(ex.描述desc,pid,id,type,提速檔speed,spid,sid,stype)
      LET g_dzff_d[l_ac].dzff006 = l_dzff_d.dzff006 CLIPPED #資料表代碼
      LET g_dzff_d[l_ac].dzff007 = l_dzff_d.dzff007 CLIPPED #欄位代號
      LET g_dzff_d[l_ac].dzff008 = l_dzff_d.dzff008 CLIPPED #使用標示 (s:標準/ c:客製)

      IF cl_null(g_dzff_d[l_ac].dzff005) THEN  #沒資料就給預設值
         LET g_dzff_d[l_ac].dzff001 = g_dzff_default[l_i].dzff001 CLIPPED
         LET g_dzff_d[l_ac].dzff002 = g_dzff_default[l_i].dzff002 CLIPPED
         LET g_dzff_d[l_ac].dzff003 = g_dzff_default[l_i].dzff003 CLIPPED
         LET g_dzff_d[l_ac].dzff004 = g_dzff_default[l_i].dzff004 CLIPPED
         LET g_dzff_d[l_ac].dzff005 = g_dzff_default[l_i].dzff005 CLIPPED
         LET g_dzff_d[l_ac].dzff006 = g_dzff_default[l_i].dzff006 CLIPPED
         LET g_dzff_d[l_ac].dzff007 = g_dzff_default[l_i].dzff007 CLIPPED
         LET g_dzff_d[l_ac].dzff008 = g_dzff_default[l_i].dzff008 CLIPPED
      END IF
      
      CALL adzp168_01_detail_show()

      LET l_ac = l_ac + 1
      #IF l_ac > g_max_rec THEN
      #   CALL cl_err( '', 9035, 0 )
      #   EXIT FOR
      #END IF

   END FOR

   #CALL g_dzff_d.deleteElement(l_ac)
   MESSAGE ""


   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

END FUNCTION


#+ 資料修改
PRIVATE FUNCTION adzp168_01_modify()
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num5     #未取消的ARRAY CNT
   DEFINE l_n             LIKE type_t.num5     #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1     #單身鎖住否
   DEFINE p_cmd           LIKE type_t.chr1     #處理狀態
   DEFINE l_allow_insert  LIKE type_t.chr1     #可新增否
   DEFINE l_allow_delete  LIKE type_t.chr1
   DEFINE l_insert        LIKE type_t.num5     #輸入時判斷是否在inser狀態
   DEFINE l_keys          DYNAMIC ARRAY OF STRING
   DEFINE l_langs         DYNAMIC ARRAY OF STRING
   #DEFINE l_dzef_d        type_g_dzef_d        #資料表欄位參考檔
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_dzebl003      LIKE dzebl_t.dzebl003
   DEFINE l_dzeal003      LIKE dzeal_t.dzeal003
   DEFINE l_dzea003       LIKE dzea_t.dzea003
   DEFINE l_dzea007       LIKE dzea_t.dzea007
   DEFINE l_str           STRING
   DEFINE l_table1        LIKE dzff_t.dzff006
   DEFINE l_table2        LIKE dzff_t.dzff006
   DEFINE l_table3        LIKE dzff_t.dzff006
   DEFINE l_chk           BOOLEAN
   DEFINE l_dzff005       LIKE dzff_t.dzff005   #類別(ex.描述desc,pid,id,type,提速檔speed,spid,sid,stype)


   LET l_insert = FALSE
   LET g_action_choice = " "
   LET g_qryparam.state = 'i'

   LET l_allow_insert = cl_detail_input_auth('insert')
   LET l_allow_delete = cl_detail_input_auth('delete')

   INPUT ARRAY g_dzff_d WITHOUT DEFAULTS FROM s_detail1.*
         ATTRIBUTE (COUNT=g_detail_cnt,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW = FALSE,
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)   #先不允許增加屬性設定
      BEFORE INPUT
         IF g_detail_cnt != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF

         CALL g_dzff_d_arr_t.clear()
         LET l_cnt = g_dzff_d.getLength()
         FOR l_i = 1 TO l_cnt
            LET g_dzff_d_arr_t[l_i].* = g_dzff_d[l_i].*   #修改前備份全部資料
         END FOR

      BEFORE ROW
         LET p_cmd=''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'            #DEFAULT
         LET l_n  = ARR_COUNT()

         IF g_detail_cnt>=l_ac THEN
            #BEGIN WORK
            LET p_cmd='u'

            LET g_before_input_done = FALSE
            CALL adzp168_01_set_entry_b(p_cmd)
            CALL adzp168_01_set_no_entry_b(p_cmd)
            LET g_before_input_done = TRUE

            LET g_dzff_d_t.* = g_dzff_d[l_ac].*  #BACKUP

            CALL adzp168_01_detail_show()
            CALL cl_show_fld_cont()
         END IF
      
      AFTER ROW
         LET l_ac = ARR_CURR()
         LET l_ac_t = l_ac

         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            IF p_cmd='u' THEN
               LET g_dzff_d[l_ac].* = g_dzff_d_t.*
            END IF
            #CLOSE adzp168_01_bcl
            #ROLLBACK WORK
            EXIT INPUT
         END IF
         #CLOSE adzp168_01_bcl
         #COMMIT WORK

      ON CHANGE dzff006   #資料表代碼
         LET g_dzff_d[l_ac].dzff007 = NULL

      ON ACTION controlp INFIELD dzff006
         #CALL q_dzea001(FALSE, FALSE, g_dzff_d[l_ac].dzff006, NULL, NULL, NULL) RETURNING g_dzff_d[l_ac].dzff006,l_dzeal003,l_dzea003,l_dzea007
         #henry:20130304->修改開窗的參數設定
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         #LET l_str = g_lang
         #LET g_qryparam.where = "dzeal002=",l_str CLIPPED
         LET g_qryparam.default1 = g_dzff_d[l_ac].dzff006
         LET g_qryparam.default2 = NULL
         LET g_qryparam.default3 = NULL
         LET g_qryparam.default4 = NULL
         CALL q_dzea001()
         LET g_qryparam.where = NULL
         LET g_dzff_d[l_ac].dzff006 = g_qryparam.return1
         LET l_dzeal003 = g_qryparam.return2
         LET l_dzea003 = g_qryparam.return3
         LET l_dzea007 = g_qryparam.return4

         LET INT_FLAG = 0   #避免開窗按取消後誤判
         DISPLAY g_dzff_d[l_ac].dzff006 TO dzff006

      ON ACTION controlp INFIELD dzff007   #資料表欄位查詢
         LET g_qryparam.where = "dzeb001 = '",g_dzff_d[l_ac].dzff006 CLIPPED,"'"
         #CALL q_dzeb001(FALSE, FALSE, g_dzff_d[l_ac].dzff007, NULL) RETURNING g_dzff_d[l_ac].dzff007,l_dzebl003
         #henry:20130304->修改開窗的參數設定
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_dzff_d[l_ac].dzff007
         LET g_qryparam.default2 = NULL
         CALL q_dzeb001()
         LET g_dzff_d[l_ac].dzff007 = g_qryparam.return1
         LET l_dzebl003 = g_qryparam.return2

         LET INT_FLAG = 0   #避免開窗按取消後誤判
         LET g_qryparam.where = NULL
         DISPLAY g_dzff_d[l_ac].dzff007 TO dzff007

      ON ACTION step_pre
         LET g_action_choice="step_pre"
         EXIT INPUT

      #交談指令共用ACTION
      #&include "common_action.4gl"
      #   CONTINUE INPUT

      AFTER INPUT
         #更新暫存檔
         IF sadzp168_1_dzff_chk(FALSE,g_dzff003,g_dzfq016) THEN
            LET g_dzfq_m.dzfq016 = g_dzfq016
            
            DELETE FROM adzp168t3
               WHERE  dzff001 = g_dzff_d_t.dzff001
                  AND dzff002 = g_dzff_d_t.dzff002
                  AND dzff003 = g_dzff_d_t.dzff003
                  AND dzff008 = g_dzff_d_t.dzff008
                  
            LET l_cnt = g_dzff_d.getLength()
            FOR l_i = 1 TO l_cnt
               EXECUTE adzp168_01_dzff_ins_pre USING g_dzff_d[l_i].dzff001,g_dzff_d[l_i].dzff002,g_dzff_d[l_i].dzff003,g_dzff_d[l_i].dzff004,g_dzff_d[l_i].dzff005,
                                                     g_dzff_d[l_i].dzff006,g_dzff_d[l_i].dzff007,ms_dgenv
            
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "lib-00100"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzff_d[l_ac].dzff001
                  LET g_errparam.replace[2] ="dzff_t"
                  LET g_errparam.extend = ""
                  LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                  CALL cl_err()
                  #ROLLBACK WORK
               ELSE
                  MESSAGE 'INSERT O.K'
                  LET g_detail_cnt=g_detail_cnt+1
                  DISPLAY g_detail_cnt TO FORMONLY.cnt
                  CALL adzp168_01_detail_show()
               END IF
            END FOR 
         ELSE
            CONTINUE INPUT
         END IF 
   END INPUT

   #CLOSE adzp168_01_bcl
   #COMMIT WORK

END FUNCTION


#+ 顯示相關資料
PRIVATE FUNCTION adzp168_01_detail_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #END add-point

   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #END add-point

   #帶出預設欄位之值

   #讀入ref值


   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #END add-point

END FUNCTION


#+ 單身欄位開啟設定
PRIVATE FUNCTION adzp168_01_set_entry_b(p_cmd)
   DEFINE l_cnt   LIKE type_t.num5

   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #END add-point

   #IF p_cmd = "a" AND ( NOT g_before_input_done ) THEN
   #   CALL cl_set_comp_entry("dzff004,dzff005",TRUE)
   #END IF

   IF p_cmd = "u" AND ( NOT g_before_input_done ) THEN
      #來自預設的設定資料不可改編號和類別,確保順序與樣版相同
      #LET g_sql = "SELECT COUNT(dzfe004) FROM dzfe_t WHERE dzfe001 = ? AND dzfe002 = ? AND dzfe003 = ? AND dzfe004 = ?"
      #PREPARE adzp168_01_set_entry_b_pre01 FROM g_sql
      #EXECUTE adzp168_01_set_entry_b_pre01 USING g_dzfa_m.dzfa005,g_dzfe002,g_dzff_d[l_ac].dzff004,g_dzff_d[l_ac].dzff005 INTO l_cnt
      #IF l_cnt > 0 THEN
      #   CALL cl_set_comp_entry("dzff004,dzff005",FALSE)
      #ELSE
      #   CALL cl_set_comp_entry("dzff004,dzff005",TRUE)
      #END IF

      #IF g_dzff_d[l_ac].dzff005 = "desc" OR g_dzff_d[l_ac].dzff005 = "speed" THEN
      #   CALL cl_set_comp_entry("dzff006",TRUE)
      #ELSE
      #   CALL cl_set_comp_entry("dzff006",FALSE)
      #END IF

      IF g_dzff_d[l_ac].dzff005 = "speed" THEN
         CALL cl_set_comp_entry("dzff007",FALSE)
      ELSE
         CALL cl_set_comp_entry("dzff007",TRUE)
      END IF
   END IF
END FUNCTION


#+ 單身欄位關閉設定
PRIVATE FUNCTION adzp168_01_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry.define"/>}
   #END add-point

   IF p_cmd = "u" AND ( NOT g_before_input_done ) AND g_chkey = "N" THEN
      CALL cl_set_comp_entry("",FALSE)
   END IF

END FUNCTION


#add-point:自定義元件(Function)
{<point name="other.function"/>}
#END add-point

PRIVATE FUNCTION adzp168_01_cb_dzff005()
   DEFINE l_dzff005_cb_val     LIKE dzff_t.dzff002
   DEFINE ls_values       STRING                          #ComboBox values
   DEFINE ls_items        STRING                          #ComboBox items
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5

   LET l_cnt = g_dzff_default.getLength()
   FOR l_i = 1 TO l_cnt
      IF l_i = 1 THEN
         LET ls_values = g_dzff_default[l_i].dzff005 CLIPPED
         LET ls_items = g_dzff_default[l_i].dzff005 CLIPPED
      ELSE
         LET ls_values = ls_values CLIPPED, ",", g_dzff_default[l_i].dzff005 CLIPPED
         LET ls_items = ls_items CLIPPED, ",", g_dzff_default[l_i].dzff005 CLIPPED
      END IF
   END FOR

   CALL cl_set_combo_items("dzff005", ls_values, ls_items)
END FUNCTION


#+ 暫存檔編號(流水號) - for新增資料
PRIVATE FUNCTION adzp168_01_tmp_new_dzff004()
   DEFINE l_dzff004   LIKE dzff_t.dzff004

   #編號(流水號)
   LET g_sql = "SELECT MAX(dzff004) FROM adzp168t3 WHERE dzff001=? AND dzff002=? AND dzff003=?"
   PREPARE adzp168_01_tmp_new_dzff004_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   EXECUTE adzp168_01_tmp_new_dzff004_pre USING g_dzfq_m.dzfq004,g_ver_dzag003,g_dzff003 INTO l_dzff004
   IF l_dzff004 IS NULL THEN   #ORACLE直至8i才提供CASE WHEN
      LET l_dzff004 = 1
   ELSE
      LET l_dzff004 = l_dzff004 + 1
   END IF

   RETURN l_dzff004
END FUNCTION



