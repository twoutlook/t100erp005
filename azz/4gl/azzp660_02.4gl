#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp660_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-10-28 11:30:05), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: azzp660_02
#+ Description: 表格資料處理
#+ Creator....: 03079(2016-02-18 15:01:44)
#+ Modifier...: 04441 -SD/PR- 00000
 
{</section>}
 
{<section id="azzp660_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160615-00006#1  2016/06/16  By ming     增加gzan_t的欄位 
#160620-00026#1  2016/06/28  By ming     增加action與function讓user能修改鍵值
#161024-00005#2  2016/10/28  By Whitney  add gzam008 不匯出，同上表格資料一併新增
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../azz/4gl/azzp660.inc"
#end add-point
 
{</section>}
 
{<section id="azzp660_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_dzea_m RECORD
       dzea001          LIKE dzea_t.dzea001, 
       dzea001_desc     LIKE type_t.chr1000
       END RECORD

DEFINE g_dzea_m        type_g_dzea_m  #單頭變數宣告


DEFINE g_tbtree     DYNAMIC ARRAY OF RECORD
                       tableid     LIKE dzea_t.dzea001,     #節點名稱：資料表代碼 
                       pid         LIKE type_t.chr100,      #父節點id 
                       id          LIKE type_t.chr100,      #節點id 
                       hasc        BOOLEAN,                 #是否有子節點 0:否 1:是 
                       exp         BOOLEAN,                 #是否展開 0:不展開 1:展開 
                       level       LIKE type_t.num5,        #階層 
                       tablename   LIKE dzeal_t.dzeal003,   #資料表名稱 
                       table_type  LIKE dzea_t.dzea004,     #檔案類型 
                       table_flag  LIKE type_t.chr1         #不匯出，同上表格資料一併新增  #161024-00005#2
                    END RECORD
DEFINE g_tbtree_idx   LIKE type_t.num10
DEFINE l_table_flag_o LIKE type_t.chr1  #161024-00005#2
#end add-point
 
{</section>}
 
{<section id="azzp660_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzp660_02.other_dialog" >}

################################################################################
# Descriptions...: Table輸入 
# Memo...........:
# Usage..........: CALL azzp660_02_input01()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
DIALOG azzp660_02_input01()
   INPUT BY NAME g_dzea_m.dzea001
      BEFORE INPUT

      AFTER INPUT

      AFTER FIELD dzea001 
         CALL azzp660_02_get_table_name(g_dzea_m.dzea001)
              RETURNING g_dzea_m.dzea001_desc
         DISPLAY BY NAME g_dzea_m.dzea001_desc

         IF NOT cl_null(g_dzea_m.dzea001) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_dzea_m.dzea001
            IF NOT cl_chk_exist("v_dzea001_1") THEN
               NEXT FIELD CURRENT
            END IF
         END IF
      
      ON ACTION controlp INFIELD dzea001 
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = 'i' 
         LET g_qryparam.reqry = FALSE 
         CALL q_dzea001_2() 
         LET g_dzea_m.dzea001 = g_qryparam.return1 
         DISPLAY BY NAME g_dzea_m.dzea001 
         
         CALL azzp660_02_get_table_name(g_dzea_m.dzea001)
              RETURNING g_dzea_m.dzea001_desc
         DISPLAY BY NAME g_dzea_m.dzea001_desc
         
         NEXT FIELD dzea001 
   END INPUT
END DIALOG

################################################################################
# Descriptions...: Table Tree顯示 
# Memo...........:
# Usage..........: CALL azzp660_02_display01()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
DIALOG azzp660_02_display01()
   DEFINE l_cnt     LIKE type_t.num5

   DISPLAY ARRAY g_tbtree TO s_p660_02_tree_detail1.* ATTRIBUTE(COUNT = g_tbtree.getLength())
      BEFORE DISPLAY
         LET l_cnt = g_tbtree.getLength()
         IF l_cnt >= 1 THEN
            LET g_tbtree_idx = 1
            CALL DIALOG.setCurrentRow("s_p660_02_tree_detail1",g_tbtree_idx)
         END IF

      BEFORE ROW
         LET g_tbtree_idx = DIALOG.getCurrentRow("s_p660_02_tree_detail1")

      #161024-00005#2-s
      ON ACTION upd_table_flag
         IF g_tbtree[g_tbtree_idx].table_flag = 'N' THEN
            LET g_tbtree[g_tbtree_idx].table_flag = 'Y'
         ELSE
            LET g_tbtree[g_tbtree_idx].table_flag = 'N'
         END IF
         UPDATE gzam_t SET gzam008 = g_tbtree[g_tbtree_idx].table_flag
          WHERE gzam001 = g_gzal.gzal001
            AND gzam002 = g_gzal.gzal002
            AND gzam003 = g_tbtree[g_tbtree_idx].tableid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'upd gzam_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      #161024-00005#2-e
   END DISPLAY

END DIALOG

 
{</section>}
 
{<section id="azzp660_02.other_function" readonly="Y" >}

PUBLIC FUNCTION azzp660_02_init()

   CALL cl_set_combo_scc("table_type","256")
   
END FUNCTION

PUBLIC FUNCTION azzp660_02_set_entry(p_cmd)
   #add-point:set_entry段define(客製用)

   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point

   #add-point:Function前置處理

   #end add-point

   #IF p_cmd = "a" THEN
   #   CALL cl_set_comp_entry("dzea001",TRUE)
   #   #根據azzi850使用者身分開關特定欄位
   #   IF NOT cl_null(g_no_entry) THEN
   #      CALL cl_set_comp_entry(g_no_entry,TRUE)
   #   END IF
   #   #add-point:set_entry段欄位控制
   #
   #   #end add-point
   #END IF

   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("dzea001",TRUE)
   CALL cl_set_comp_visible("add_table",TRUE)
   CALL cl_set_comp_visible("del_table",TRUE)
   #end add-point

END FUNCTION

PUBLIC FUNCTION azzp660_02_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用)

   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point

   #add-point:Function前置處理

   #end add-point

   #IF p_cmd = 'u' AND g_chkey = 'N' THEN
   #   CALL cl_set_comp_entry("dzea001",FALSE)
   #   #根據azzi850使用者身分開關特定欄位
   #   IF NOT cl_null(g_no_entry) THEN
   #      CALL cl_set_comp_entry(g_no_entry,FALSE)
   #   END IF
   #   #add-point:set_no_entry段欄位控制
   #
   #   #end add-point
   #END IF

   #add-point:set_no_entry段欄位控制後
   IF FGL_GETENV("DGENV") = 's' THEN
      IF g_gzal.gzal002 != "standard" THEN
         CALL cl_set_comp_entry("dzea001",FALSE)
         CALL cl_set_comp_visible("add_table",FALSE)
         CALL cl_set_comp_visible("del_table",FALSE)
      END IF
   ELSE
      IF g_gzal.gzal002 = "standard" THEN
         CALL cl_set_comp_entry("dzea001",FALSE)
         CALL cl_set_comp_visible("add_table",FALSE)
         CALL cl_set_comp_visible("del_table",FALSE)
      END IF
   END IF
   #end add-point

END FUNCTION

################################################################################
# Descriptions...: 建立Temp Table 
# Memo...........:
# Usage..........: CALL azzp660_02_create_temp_table()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_create_temp_table()
   CREATE TEMP TABLE p660_02_t1(
      gzam003        LIKE gzam_t.gzam003,     #表格編號 
      gzam004        LIKE gzam_t.gzam004      #上層表格編號((pid) 
   ); 
END FUNCTION

################################################################################
# Descriptions...: 移除Temp Table 
# Memo...........:
# Usage..........: CALL azzp660_02_drop_temp_table()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_drop_temp_table()
   DROP TABLE p660_02_t1;
END FUNCTION

################################################################################
# Descriptions...: 把Table加入Tree 
# Memo...........:
# Usage..........: CALL azzp660_02_add_table()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_add_table()
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_chk        LIKE type_t.num5
   DEFINE l_tbtree_cnt LIKE type_t.num5
   DEFINE ls_id_seq    STRING
   DEFINE l_str        STRING
   DEFINE l_str2       STRING
   DEFINE l_tok        base.StringTokenizer
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_k          LIKE type_t.num5
   DEFINE ls_pid       STRING
   DEFINE l_j          LIKE type_t.num5 
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_gzam005    LIKE gzam_t.gzam005
   DEFINE l_gzam006    LIKE gzam_t.gzam006
   DEFINE l_gzam007    LIKE gzam_t.gzam007 
   DEFINE l_sql        STRING
   DEFINE l_dzeb002    LIKE dzeb_t.dzeb002
   DEFINE l_dzeb005    LIKE dzeb_t.dzeb005

   IF NOT cl_null(g_dzea_m.dzea001) THEN 
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_dzea_m.dzea001
      IF NOT cl_chk_exist("v_dzea001_1") THEN
         RETURN
      END IF
      
      CALL azzp660_02_set_table_key(g_gzal.gzal001,g_gzal.gzal002,g_dzea_m.dzea001)
           RETURNING l_success,l_gzam005,l_gzam006,l_gzam007
      IF NOT l_success THEN
         RETURN
      END IF
   
      LET l_chk = TRUE

      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM dzea_t
       WHERE dzea001 = g_dzea_m.dzea001
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'adz-00050'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_dzea_m.dzea001
         CALL cl_err() 
         
         RETURN
      END IF 
      
      FOR l_i = 1 TO g_tbtree.getLength() 
         IF g_dzea_m.dzea001 = g_tbtree[l_i].tableid THEN 
            LET l_chk = FALSE 
            EXIT FOR 
         END IF 
      END FOR 
      
      IF NOT l_chk THEN 
         RETURN 
      END IF 

      IF l_chk THEN
         LET l_tbtree_cnt = g_tbtree.getLength()
         LET l_i = l_tbtree_cnt + 1

         IF l_tbtree_cnt = 0 THEN
            LET g_tbtree[l_i].tableid = g_dzea_m.dzea001 
            #取得table的多語言資料 
            CALL azzp660_02_get_table_name(g_tbtree[l_i].tableid)
                 RETURNING g_tbtree[l_i].tablename 
            #取得table的檔案類型 
            CALL azzp660_02_get_table_type(g_tbtree[l_i].tableid)
                 RETURNING g_tbtree[l_i].table_type
            LET g_tbtree[l_i].pid = "0"
            LET g_tbtree[l_i].id  = "0.1"
            LET g_tbtree[l_i].hasc = FALSE 
            LET g_tbtree[l_i].exp  = FALSE
            LET g_tbtree[l_i].level = 1
            LET g_tbtree[l_i].table_flag = 'N'  #161024-00005#2
            LET g_tbtree_idx = l_i 
            
            #根節點，無上層 
            INSERT INTO gzam_t(gzam001,gzam002,gzam003,gzam004,
                               gzam005,gzam006,gzam007,gzam008)    #161024-00005#2
                        VALUES(g_gzal.gzal001,g_gzal.gzal002,g_tbtree[l_i].tableid,'',
                               l_gzam005,l_gzam006,l_gzam007,g_tbtree[l_i].table_flag)  #161024-00005#2
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins gzam_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF

         ELSE
            IF l_tbtree_cnt = 1 THEN
               LET g_tbtree_idx = 1
               #CALL DIALOG.setCurrentRow("s_p660_02_tree_detail1",g_tbtree_idx) 
            END IF 
            
            IF l_tbtree_cnt > 0 AND (cl_null(g_tbtree_idx) OR g_tbtree_idx <= 0) THEN
               LET g_tbtree_idx = 1
            END IF

            #加入節點 
            IF g_tbtree_idx > 0 AND g_tbtree_idx <= l_tbtree_cnt THEN
               LET ls_pid = g_tbtree[g_tbtree_idx].id
            END IF


            LET ls_id_seq = NULL
            LET l_str     = NULL
            IF g_tbtree[g_tbtree_idx].hasc THEN
               FOR l_n = 1 TO l_tbtree_cnt
                  IF g_tbtree[l_n].pid = g_tbtree[g_tbtree_idx].id THEN
                     LET l_str = g_tbtree[l_n].id
                  END IF
               END FOR
            ELSE
               LET ls_id_seq = "1"
            END IF 
            
            IF cl_null(ls_id_seq) THEN
               LET l_k = 0
               LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,".","",TRUE)
               WHILE l_tok.hasMoreTokens()
                  LET ls_id_seq = l_tok.nextToken()
               END WHILE
               LET l_k = ls_id_seq.trim()
               LET ls_id_seq = l_k + 1
            END IF

            #父節點 
            LET g_tbtree[g_tbtree_idx].hasc = TRUE
            LET g_tbtree[g_tbtree_idx].exp  = TRUE

            #新增節點 
            LET l_j = 0
            LET l_str = ls_pid CLIPPED || "."
            FOR l_n = 1 TO l_tbtree_cnt
               LET l_str2 = g_tbtree[l_n].id
               IF l_str2.getIndexOf(l_str,1) = 1 THEN
                  LET l_j = l_n
               END IF
            END FOR

            IF l_j = 0 THEN
               LET l_i = g_tbtree_idx + 1     #加在父節點後面  
            ELSE
               LET l_i = l_j + 1              #加在父節點的下節點之後  
            END IF 
            
            IF g_tbtree_idx < l_tbtree_cnt THEN
               CALL g_tbtree.insertElement(l_i)
            END IF

            LET g_tbtree[l_i].tableid = g_dzea_m.dzea001 
            #取得table的多語言資料 
            CALL azzp660_02_get_table_name(g_tbtree[l_i].tableid)
                 RETURNING g_tbtree[l_i].tablename 
            #取得table的檔案類型  
            CALL azzp660_02_get_table_type(g_tbtree[l_i].tableid)
                 RETURNING g_tbtree[l_i].table_type
            LET g_tbtree[l_i].pid     = ls_pid
            LET g_tbtree[l_i].id      = g_tbtree[g_tbtree_idx].id CLIPPED || "." || ls_id_seq CLIPPED
            LET g_tbtree[l_i].hasc    = FALSE
            LET g_tbtree[l_i].exp     = FALSE
            LET g_tbtree[l_i].level   = g_tbtree[g_tbtree_idx].level + 1
            LET g_tbtree[l_i].table_flag = 'N'  #161024-00005#2

            INSERT INTO gzam_t(gzam001,gzam002,gzam003,gzam004,
                               gzam005,gzam006,gzam007,gzam008)    #161024-00005#2
                        VALUES(g_gzal.gzal001,g_gzal.gzal002,g_tbtree[l_i].tableid,
                               g_tbtree[g_tbtree_idx].tableid,
                               l_gzam005,l_gzam006,l_gzam007,g_tbtree[l_i].table_flag)  #161024-00005#2
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins gzam_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         END IF
         
         LET l_sql = "SELECT dzeb002,dzeb005 ",
                     "  FROM dzeb_t ",
                     " WHERE dzeb001 = '",g_tbtree[l_i].tableid,"' ",
                     " ORDER BY dzeb021 "
         PREPARE azzp660_02_get_dzeb_prep FROM l_sql
         DECLARE azzp660_02_get_dzeb_curs CURSOR FOR azzp660_02_get_dzeb_prep

         FOREACH azzp660_02_get_dzeb_curs INTO l_dzeb002,l_dzeb005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF

            #160615-00006#1 20160616 modify by ming -----(S) 
            #INSERT INTO gzan_t(gzan001,gzan002,gzan003,gzan004,
            #                   gzan005,gzan006,gzan007,gzan008,
            #                   gzan009,gzan010,gzan011,gzan012,
            #                   gzan013,gzan014,gzan015,gzan016)
            #            VALUES(g_gzal.gzal001,g_gzal.gzal002,g_tbtree[l_i].tableid,
            #                   l_dzeb002,'N','','','',l_dzeb005,'','','','',
            #                   '','','')
            INSERT INTO gzan_t(gzan001,gzan002,gzan003,gzan004,
                               gzan005,gzan006,gzan007,gzan008,
                               gzan009,gzan010,gzan011,gzan012,
                               gzan013,gzan014,gzan015,gzan016, 
                               gzan017,gzan018,gzan019)
                        VALUES(g_gzal.gzal001,g_gzal.gzal002,g_tbtree[l_i].tableid,
                               l_dzeb002,'N','','','',l_dzeb005,'','','','',
                               '','','','','N','N')
            #160615-00006#1 20160616 modify by ming -----(E) 
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins gzan_t'
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         END FOREACH
      END IF

   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除Tree中的Table 
# Memo...........:
# Usage..........: CALL azzp660_02_del_table()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_del_table()
   DEFINE l_tbtree_cnt     LIKE type_t.num5
   DEFINE ls_id            STRING
   DEFINE ls_pid           STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_str            STRING
   DEFINE l_str2           STRING
   DEFINE l_i              LIKE type_t.num5
   #ming 20160615 add -----(S) 
   DEFINE l_success        LIKE type_t.num5
   #ming 20160615 add -----(E) 

   LET l_tbtree_cnt = g_tbtree.getLength() 
   
   #ming 20160615 add -----(S) 
   #刪除的動作加入transaction 
   LET l_success = TRUE
   CALL s_transaction_begin()
   #ming 20160615 add -----(E) 

   IF g_tbtree_idx > 0 AND g_tbtree_idx <= l_tbtree_cnt THEN
      IF cl_ask_confirm_parm("adz-00064","") THEN      #是否刪除此筆資料 
         LET ls_id = g_tbtree[g_tbtree_idx].id
         LET ls_pid = g_tbtree[g_tbtree_idx].pid
         LET l_str = ls_id CLIPPED || "."

         #刪除本節點 
         #刪除目前節點的資料 
         DELETE FROM gzam_t WHERE gzam001 = g_gzal.gzal001
                              AND gzam002 = g_gzal.gzal002
                              AND gzam003 = g_tbtree[g_tbtree_idx].tableid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'del gzam_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err() 
            #ming 20160615 add -----(S) 
            LET l_success = FALSE
            #ming 20160615 add -----(E) 
         END IF
         
         DELETE FROM gzan_t WHERE gzan001 = g_gzal.gzal001 
                              AND gzan002 = g_gzal.gzal002 
                              AND gzan003 = g_tbtree[g_tbtree_idx].tableid 
         IF SQLCA.sqlcode THEN 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'del gzan_t' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            #ming 20160615 add -----(S) 
            LET l_success = FALSE
            #ming 20160615 add -----(E) 
         END IF 
         
         DELETE FROM gzao_t WHERE gzao001 = g_gzal.gzal001
                              AND gzao002 = g_gzal.gzal002
                              AND gzao003 = g_tbtree[g_tbtree_idx].tableid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'del gzao_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #ming 20160615 add -----(S) 
            LET l_success = FALSE
            #ming 20160615 add -----(E) 
         END IF

         DELETE FROM gzap_t WHERE gzap001 = g_gzal.gzal001
                              AND gzap002 = g_gzal.gzal002
                              AND gzap003 = g_tbtree[g_tbtree_idx].tableid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'del gzap_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #ming 20160615 add -----(S) 
            LET l_success = FALSE
            #ming 20160615 add -----(E) 
         END IF

         CALL g_tbtree.deleteElement(g_tbtree_idx)

         LET l_tbtree_cnt = g_tbtree.getLength()
         IF l_tbtree_cnt > 0 THEN
            LET l_cnt = 0    #兄弟數 
            FOR l_n = 1 TO l_tbtree_cnt
               IF ls_pid = g_tbtree[l_n].pid THEN    #有相同父節點的  
                  LET l_cnt = l_cnt + 1 
                  LET g_tbtree_idx = l_n
               END IF
            END FOR

            FOR l_i = l_tbtree_cnt TO 1 STEP -1
               #父節點無子 
               IF g_tbtree[l_i].id = ls_pid AND l_cnt = 0 THEN
                  LET g_tbtree[l_i].hasc = FALSE
                  LET g_tbtree[l_i].exp  = FALSE
                  LET g_tbtree_idx = l_i
               END IF

               #刪子節點 
               LET l_str2 = g_tbtree[l_i].id
               IF l_str2.getIndexOf(l_str,1) = 1 THEN 
                  DELETE FROM gzam_t WHERE gzam001 = g_gzal.gzal001
                                       AND gzam002 = g_gzal.gzal002
                                       AND gzam003 = g_tbtree[l_i].tableid
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'del gzam_t'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                     #ming 20160615 add -----(S) 
                     LET l_success = FALSE
                     #ming 20160615 add -----(E)
                  END IF 
                  
                  DELETE FROM gzan_t WHERE gzan001 = g_gzal.gzal001 
                                       AND gzan002 = g_gzal.gzal002 
                                       AND gzan003 = g_tbtree[l_i].tableid 
                  IF SQLCA.sqlcode THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'del gzan_t' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()  
                     #ming 20160615 add -----(S) 
                     LET l_success = FALSE
                     #ming 20160615 add -----(E)
                  END IF 
                  
                  DELETE FROM gzao_t WHERE gzao001 = g_gzal.gzal001
                                       AND gzao002 = g_gzal.gzal002
                                       AND gzao003 = g_tbtree[l_i].tableid
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'del gzao_t'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                     #ming 20160615 add -----(S) 
                     LET l_success = FALSE
                     #ming 20160615 add -----(E)
                  END IF

                  DELETE FROM gzap_t WHERE gzap001 = g_gzal.gzal001
                                       AND gzap002 = g_gzal.gzal002
                                       AND gzap003 = g_tbtree[l_i].tableid
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'del gzap_t'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                     #ming 20160615 add -----(S) 
                     LET l_success = FALSE
                     #ming 20160615 add -----(E)
                  END IF
               
                  CALL g_tbtree.deleteElement(l_i)
               END IF
            END FOR
         END IF

      END IF
   END IF 
   
   #ming 20160615 add -----(S) 
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #ming 20160615 add -----(E) 
                  
END FUNCTION

################################################################################
# Descriptions...: 取得Table名稱 
# Memo...........:
# Usage..........: CALL azzp660_02_get_table_name(p_dzea001)
#                  RETURNING r_dzeal003
# Input parameter: p_dzea001:Table代號
# Return code....: r_dzeal003:表格名稱
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_get_table_name(p_dzea001)
   DEFINE p_dzea001     LIKE dzea_t.dzea001
   DEFINE r_dzeal003    LIKE dzeal_t.dzeal003

   LET r_dzeal003 = ''

   IF cl_null(p_dzea001) THEN
      RETURN r_dzeal003
   END IF

   SELECT dzeal003 INTO r_dzeal003
     FROM dzeal_t
    WHERE dzeal001 = p_dzea001
      AND dzeal002 = g_lang

   RETURN r_dzeal003
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp660_02_save_temp_gzam()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_save_temp_gzam()
   #此function 可能不需要了 
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_j        LIKE type_t.num5
   DEFINE l_up_table LIKE dzeal_t.dzeal003
   
   

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM gzam_t
    WHERE gzam001 = g_gzal.gzal001
      AND gzam002 = g_gzal.gzal002

   IF l_cnt > 0 THEN
      DELETE FROM gzam_t WHERE gzam001 = g_gzal.gzal001 
                           AND gzam002 = g_gzal.gzal002 
   END IF

   FOR l_i = 1 TO g_tbtree.getLength()
      #如果pid(上層節點)是0的話，代表為第一筆資料，所以不用再向上找上層 
      IF g_tbtree[l_i].pid <> '0' THEN
         FOR l_j = 1 TO g_tbtree.getLength()
            #自已不用跟自己比 
            IF l_i = l_j THEN
               CONTINUE FOR
            END IF

            #找到了上層節點  
            IF g_tbtree[l_i].pid = g_tbtree[l_j].id THEN
               LET l_up_table = g_tbtree[l_j].tableid
               EXIT FOR
            END IF
         END FOR
      END IF


      INSERT INTO gzam_t(gzam001,gzam002,gzam003,gzam004,
                                 gzam005,gzam006,gzam007)
           VALUES(g_gzal.gzal001,g_gzal.gzal002,g_tbtree[l_i].tableid,l_up_table,
                  '','','')
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 取得Table的型態 
# Memo...........:
# Usage..........: CALL azzp660_02_get_table_type(p_dzea001)
#                  RETURNING r_dzea004
# Input parameter: p_dzea001:Table代號
# Return code....: r_dzea004:表格型態 
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_get_table_type(p_dzea001)
   DEFINE p_dzea001     LIKE dzea_t.dzea001
   DEFINE r_dzea004     LIKE dzea_t.dzea004

   LET r_dzea004 = ''

   IF cl_null(p_dzea001) THEN
      RETURN r_dzea004
   END IF

   SELECT dzea004 INTO r_dzea004
     FROM dzea_t
    WHERE dzea001 = p_dzea001

   RETURN r_dzea004
END FUNCTION

################################################################################
# Descriptions...: 取得Table Tree的資料 
# Memo...........:
# Usage..........: CALL azzp660_02_table_tree_b_fill()
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_table_tree_b_fill()
   DEFINE l_sql     STRING
   DEFINE l_gzam    RECORD
                       gzam001     LIKE gzam_t.gzam001,
                       gzam002     LIKE gzam_t.gzam002,
                       gzam003     LIKE gzam_t.gzam003,
                       gzam004     LIKE gzam_t.gzam004,
                       gzam005     LIKE gzam_t.gzam005,
                       gzam006     LIKE gzam_t.gzam006,
                       gzam007     LIKE gzam_t.gzam007,
                       gzam008     LIKE gzam_t.gzam008  #161024-00005#2
                    END RECORD
   DEFINE l_num     LIKE type_t.num10
   DEFINE l_cnt     LIKE type_t.num10
   #ming 20160615 add -----(S) 
   DEFINE l_root_id LIKE type_t.num5
   DEFINE l_str     STRING
   #ming 20160615 add -----(E) 

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM gzam_t
    WHERE gzam001 = g_gzal.gzal001
      AND gzam002 = g_gzal.gzal002
   IF cl_null(l_cnt) OR l_cnt <= 0 THEN
      RETURN
   END IF

   CALL g_tbtree.clear()

   LET l_sql = "SELECT gzam001,gzam002,gzam003,gzam004, ",
               "       gzam005,gzam006,gzam007,gzam008 ",  #161024-00005#2
               "  FROM gzam_t ",
               " WHERE gzam001 = '",g_gzal.gzal001,"' ",
               "   AND gzam002 = '",g_gzal.gzal002,"' ", 
               "   AND gzam004 IS NULL "
   PREPARE azzp660_02_table_tree_root_prep FROM l_sql
   DECLARE azzp660_02_table_tree_root_curs CURSOR FOR azzp660_02_table_tree_root_prep

   LET l_num = 1
   #ming 20160615 add -----(S) 
   LET l_root_id = 1
   #ming 20160615 add -----(E) 
   FOREACH azzp660_02_table_tree_root_curs INTO l_gzam.gzam001,l_gzam.gzam002,l_gzam.gzam003,l_gzam.gzam004,
                                                l_gzam.gzam005,l_gzam.gzam006,l_gzam.gzam007,l_gzam.gzam008  #161024-00005#2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_tbtree[l_num].table_flag = l_gzam.gzam008  #161024-00005#2
      LET g_tbtree[l_num].tableid = l_gzam.gzam003
      #取得table的多語言資料 
      CALL azzp660_02_get_table_name(g_tbtree[l_num].tableid)
           RETURNING g_tbtree[l_num].tablename
      #取得table的檔案類型  
      CALL azzp660_02_get_table_type(g_tbtree[l_num].tableid)
           RETURNING g_tbtree[l_num].table_type

      LET g_tbtree[l_num].pid   = '0'
      #ming 20160615 modify -----(S) 
      #修正id,pid會影響刪除的問題
      #LET g_tbtree[l_num].id    = '0.1'
      LET l_str = l_root_id
      LET g_tbtree[l_num].id    = '0.',l_str.trim()
      #ming 20160615 modify -----(E) 
      LET g_tbtree[l_num].hasc  = FALSE
      LET g_tbtree[l_num].exp   = FALSE 
      LET g_tbtree[l_num].level = 1

      CALL azzp660_02_table_tree_hasc(l_gzam.gzam003,l_num)

      LET l_num = g_tbtree.getLength() + 1 
      
      #ming 20160615 add -----(S) 
      LET l_root_id = l_root_id + 1
      #ming 20160615 add -----(E) 

   END FOREACH 
   
END FUNCTION

################################################################################
# Descriptions...: 處理Table Tree的子節點 
# Memo...........:
# Usage..........: CALL azzp660_02_table_tree_hasc(p_tablename,p_num)
#                  RETURNING 回传参数
# Input parameter: p_tablename:Table代號
#                : p_num:處理編號 
# Date & Author..: 2016/05/06 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_table_tree_hasc(p_tablename,p_num)
   DEFINE p_tablename     LIKE gzam_t.gzam003
   DEFINE p_num           LIKE type_t.num10
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_num           LIKE type_t.num10
   DEFINE l_gzam          RECORD
                             gzam001     LIKE gzam_t.gzam001,
                             gzam002     LIKE gzam_t.gzam002,
                             gzam003     LIKE gzam_t.gzam003,
                             gzam004     LIKE gzam_t.gzam004,
                             gzam005     LIKE gzam_t.gzam005,
                             gzam006     LIKE gzam_t.gzam006,
                             gzam007     LIKE gzam_t.gzam007,
                             gzam008     LIKE gzam_t.gzam008  #161024-00005#2
                          END RECORD
   DEFINE l_pid           STRING
   DEFINE l_seq           LIKE type_t.num5
   DEFINE l_temp_tree     DYNAMIC ARRAY OF RECORD
                             tableid       LIKE dzea_t.dzea001,     #節點名稱：資料表代號 
                             pid           LIKE type_t.chr100,      #父節點id 
                             id            LIKE type_t.chr100,      #節點id 
                             hasc          BOOLEAN,                 #是否有子節點 0:否 1:是 
                             exp           BOOLEAN,                 #是否展開 0:不展開 1:展開 
                             level         LIKE type_t.num5,        #階層 
                             tablename     LIKE dzeal_t.dzeal003,   #資料表名稱  
                             table_flag    LIKE type_t.chr1         #161024-00005#2
                          END RECORD
   DEFINE l_i             LIKE type_t.num10

   IF cl_null(p_tablename) OR cl_null(p_num) THEN
      RETURN
   END IF 
   
   SELECT COUNT(*) INTO l_cnt
     FROM gzam_t
    WHERE gzam001 = g_gzal.gzal001
      AND gzam002 = g_gzal.gzal002
      AND gzam004 = p_tablename
   IF cl_null(l_cnt) OR l_cnt <= 0 THEN
      RETURN
   END IF

   LET l_sql = "SELECT gzam001,gzam002,gzam003,gzam004, ",
               "       gzam005,gzam006,gzam007,gzam008 ",  #161024-00005#2
              "  FROM gzam_t ",
               " WHERE gzam001 = '",g_gzal.gzal001,"' ",
               "   AND gzam002 = '",g_gzal.gzal002,"' ",
               "   AND gzam004 = '",p_tablename,"' "
   PREPARE azzp660_02_find_hasc_prep FROM l_sql
   DECLARE azzp660_02_find_hasc_curs CURSOR FOR azzp660_02_find_hasc_prep

   LET l_num = p_num + 1
   LET l_pid = g_tbtree[p_num].id
   LET l_seq = 1

   LET g_tbtree[p_num].hasc = TRUE
   LET g_tbtree[p_num].exp  = TRUE

   FOREACH azzp660_02_find_hasc_curs INTO l_gzam.gzam001,l_gzam.gzam002,l_gzam.gzam003,l_gzam.gzam004,
                                          l_gzam.gzam005,l_gzam.gzam006,l_gzam.gzam007,l_gzam.gzam008  #161024-00005#2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_temp_tree[l_seq].table_flag = l_gzam.gzam008  #161024-00005#2
      LET l_temp_tree[l_seq].tableid = l_gzam.gzam003
      LET l_temp_tree[l_seq].pid     = l_pid
      LET l_temp_tree[l_seq].id      = l_pid CLIPPED || "." || l_seq CLIPPED
      LET l_temp_tree[l_seq].hasc    = FALSE
      LET l_temp_tree[l_seq].exp     = FALSE
      LET l_temp_tree[l_seq].level   = g_tbtree[p_num].level + 1

      LET l_seq = l_seq + 1

   END FOREACH

   FOR l_i = 1 TO l_temp_tree.getLength()
      LET g_tbtree[l_num].tableid = l_temp_tree[l_i].tableid
      #取得table的多語言資料 
      CALL azzp660_02_get_table_name(g_tbtree[l_num].tableid)
           RETURNING g_tbtree[l_num].tablename
      #取得table的檔案類型  
      CALL azzp660_02_get_table_type(g_tbtree[l_num].tableid)
           RETURNING g_tbtree[l_num].table_type
      LET g_tbtree[l_num].pid     = l_temp_tree[l_i].pid
      LET g_tbtree[l_num].id      = l_temp_tree[l_i].id
      LET g_tbtree[l_num].hasc    = l_temp_tree[l_i].hasc
      LET g_tbtree[l_num].exp     = l_temp_tree[l_i].exp 
      LET g_tbtree[l_num].level   = l_temp_tree[l_i].level
      LET g_tbtree[l_num].table_flag = l_temp_tree[l_i].table_flag  #161024-00005#2
      CALL azzp660_02_table_tree_hasc(g_tbtree[l_num].tableid,l_num)

      LET l_num = g_tbtree.getLength() + 1
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 開窗設定table鍵值 
# Memo...........:
# Usage..........: CALL azzp660_02_set_table_key(p_gzam001,p_gzam002,p_gzam003)
#                  RETURNING r_success,r_gzam005,r_gzam006,r_gzam007
# Input parameter: p_gzam001：作業編號
#                : p_gzam002：格式代號
#                : p_gzam003：表格編號
# Return code....: r_success：TRUE/FALSE 
#                : r_gzam005：主鍵 
#                : r_gzam006：鍵值 
#                : r_gzam007：外來鍵
# Date & Author..: 2016/03/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_set_table_key(p_gzam001,p_gzam002,p_gzam003)
   DEFINE p_gzam001       LIKE gzam_t.gzam001
   DEFINE p_gzam002       LIKE gzam_t.gzam002
   DEFINE p_gzam003       LIKE gzam_t.gzam003
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_gzam005       LIKE gzam_t.gzam005
   DEFINE r_gzam006       LIKE gzam_t.gzam006
   DEFINE r_gzam007       LIKE gzam_t.gzam007
   #在加入table時，開出畫面讓user設定鍵值 
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path         STRING
   DEFINE l_gzam          RECORD
                             gzam005     LIKE gzam_t.gzam005,
                             gzam006     LIKE gzam_t.gzam006,
                             gzam007     LIKE gzam_t.gzam007
                          END RECORD
   DEFINE l_action_choice STRING
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_dzag006       LIKE dzag_t.dzag006
   DEFINE l_dzag008       LIKE dzag_t.dzag008
   DEFINE l_dzag009       LIKE dzag_t.dzag009
   DEFINE l_dzag010       LIKE dzag_t.dzag010

   LET r_success = TRUE
   LET r_gzam005 = ''
   LET r_gzam006 = '' 
   LET r_gzam007 = ''

   #如果有傳入值為空的話就不執行後面的動作 
   IF cl_null(p_gzam001) OR cl_null(p_gzam002) OR cl_null(p_gzam003) THEN
      LET r_success = FALSE
      RETURN r_success,r_gzam005,r_gzam006,r_gzam007
   END IF

   #取得程式的規格資料中的鍵值 
   #先看有沒有客製的資料 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dzag_t
    WHERE dzag001 = p_gzam001     #規格編號  
      AND dzag002 = p_gzam003     #table編號  
      AND dzag006 = 'c'           #使用標示(s:標準,c:客製)  
   IF cl_null(l_cnt) OR l_cnt = 0 THEN
      LET l_dzag006 = 's'
   ELSE
      LET l_dzag006 = 'c'
   END IF

   #取得版本最新的規格資料中的鍵值  
   SELECT dzag008,dzag009,dzag010
     INTO l_dzag008,l_dzag009,l_dzag010 
     FROM dzag_t
    WHERE dzag001 = p_gzam001
      AND dzag002 = p_gzam003
      AND dzag003 = (SELECT MAX(dzag003) FROM dzag_t
                      WHERE dzag001 = p_gzam001
                        AND dzag002 = p_gzam003
                        AND dzag006 = l_dzag006)
      AND dzag006 = l_dzag006
   #如果三個都取不到資料的話 
   IF cl_null(l_dzag008) AND cl_null(l_dzag009) AND
      cl_null(l_dzag010) THEN
      #去取r.t中的table鍵值 
      LET l_sql = "SELECT dzed004,dzed006 ",
                  "  FROM dzed_t ",
                  " WHERE dzed001 = '",p_gzam003,"' ",     #table  
                  "   AND dzed003 = ? "      #P=>Primary   F=>Footing Data   R=>Referenced   U=>Unique  
      PREPARE azzp660_02_get_dzed_prep FROM l_sql
      DECLARE azzp660_02_get_dzed_curs CURSOR FOR azzp660_02_get_dzed_prep

      FOREACH azzp660_02_get_dzed_curs USING 'P'
                                        INTO l_dzag008,l_dzag010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err() 
            EXIT FOREACH
         END IF
      END FOREACH

      FOREACH azzp660_02_get_dzed_curs USING 'F'
                                        INTO l_dzag009,l_dzag010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         #有取到就離開 
         IF NOT cl_null(l_dzag009) AND NOT cl_null(l_dzag010) THEN
            EXIT FOREACH
         END IF
      END FOREACH

   END IF

   LET l_gzam.gzam005 = l_dzag008
   LET l_gzam.gzam006 = l_dzag009
   LET l_gzam.gzam007 = l_dzag010

   OPEN WINDOW w_azzp660_02_s01 WITH FORM cl_ap_formpath("azz","azzp660_02_s01") 
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

   WHILE TRUE
      DIALOG ATTRIBUTE(UNBUFFERED,FIELD ORDER FORM)
         INPUT BY NAME l_gzam.gzam005,l_gzam.gzam006,l_gzam.gzam007
                  ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD gzam005
            AFTER FIELD gzam006
            AFTER FIELD gzam007
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT

         ON ACTION accept
            LET l_action_choice = 'accept'
            EXIT DIALOG

         ON ACTION cancel
            LET l_action_choice = '' 
            LET INT_FLAG = TRUE
            LET r_success = FALSE
            EXIT DIALOG

         ON ACTION exit
           LET l_action_choice = "exit"
           LET INT_FLAG = FALSE
           LET r_success = FALSE
           EXIT DIALOG

         ON ACTION close
            LET l_action_choice = "exit"
            LET r_success = FALSE
            EXIT DIALOG
      END DIALOG

      IF l_action_choice = "exit" OR l_action_choice = 'accept' THEN
         EXIT WHILE
      END IF

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
   END WHILE

   CLOSE WINDOW w_azzp660_02_s01 
   
   IF r_success THEN
      LET r_gzam005 = l_gzam.gzam005
      LET r_gzam006 = l_gzam.gzam006
      LET r_gzam007 = l_gzam.gzam007
   END IF

   RETURN r_success,r_gzam005,r_gzam006,r_gzam007
   
END FUNCTION

################################################################################
# Descriptions...: 開窗讓user修改table的鍵值
# Memo...........:
# Usage..........: CALL azzp660_02_change_table_key()
# Date & Author..: 2016/06/28 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_change_table_key()
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path         STRING
   DEFINE l_gzam          RECORD
                             gzam005     LIKE gzam_t.gzam005,
                             gzam006     LIKE gzam_t.gzam006,
                             gzam007     LIKE gzam_t.gzam007
                          END RECORD
   DEFINE l_action_choice STRING

   OPEN WINDOW w_azzp660_02_s01 WITH FORM cl_ap_formpath("azz","azzp660_02_s01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

   #取得目前選取的table鍵值 
   SELECT gzam005,gzam006,gzam007 INTO l_gzam.gzam005,l_gzam.gzam006,
                                       l_gzam.gzam007
     FROM gzam_t
    WHERE gzam001 = g_gzal.gzal001
      AND gzam002 = g_gzal.gzal002
      AND gzam003 = g_tbtree[g_tbtree_idx].tableid
   #g_tbtree_idx 這是目前畫面上所選擇的列數 

   LET l_action_choice = '' 
   WHILE TRUE
      DIALOG ATTRIBUTE(UNBUFFERED,FIELD ORDER FORM)
         INPUT BY NAME l_gzam.gzam005,l_gzam.gzam006,l_gzam.gzam007
                  ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD gzam005
            AFTER FIELD gzam006
            AFTER FIELD gzam007
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT

         ON ACTION accept
            LET l_action_choice = 'accept'
            EXIT DIALOG

         ON ACTION cancel
            LET l_action_choice = ''
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
           LET l_action_choice = "exit"
           LET INT_FLAG = FALSE 
           EXIT DIALOG

         ON ACTION close
            LET l_action_choice = "exit"
            EXIT DIALOG
      END DIALOG

      IF l_action_choice = "exit" OR l_action_choice = 'accept' THEN
         EXIT WHILE
      END IF

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
   END WHILE

   IF l_action_choice = 'accept' THEN
      UPDATE gzam_t SET gzam005 = l_gzam.gzam005,
                        gzam006 = l_gzam.gzam006,
                        gzam007 = l_gzam.gzam007
       WHERE gzam001 = g_gzal.gzal001
         AND gzam002 = g_gzal.gzal002
         AND gzam003 = g_tbtree[g_tbtree_idx].tableid
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd gzam_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF

   CLOSE WINDOW w_azzp660_02_s01
   
END FUNCTION

################################################################################
# Descriptions...: 鍵值與外來鍵的基本檢查
# Memo...........:
# Usage..........: CALL azzp660_02_chk_gzam_key(p_gzam001,p_gzam002)
#                  RETURNING r_success 
# Input parameter: p_gzam001:作業編號 
#                : p_gzam002:格式代號
# Return code....: r_success:TRUE/FALSE
# Date & Author..: 2016/06/28 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp660_02_chk_gzam_key(p_gzam001,p_gzam002)
   DEFINE p_gzam001     LIKE gzam_t.gzam001
   DEFINE p_gzam002     LIKE gzam_t.gzam002
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_gzam        RECORD
                           gzam003     LIKE gzam_t.gzam003,
                           gzam006     LIKE gzam_t.gzam006,
                           gzam007     LIKE gzam_t.gzam007
                        END RECORD
   DEFINE l_tk_gzam006  base.StringTokenizer
   DEFINE l_tk_gzam007  base.StringTokenizer
   DEFINE l_cnt_gzam006 LIKE type_t.num5
   DEFINE l_cnt_gzam007 LIKE type_t.num5
   DEFINE l_field       LIKE gzan_t.gzan004

   LET r_success = TRUE

   LET l_sql = "SELECT gzam003,gzam006,gzam007 ",
               "  FROM gzam_t ",
               " WHERE gzam001 = '",p_gzam001,"' ",
               "   AND gzam002 = '",p_gzam002,"' ",
               "   AND gzam004 IS NOT NULL "
   PREPARE azzp660_02_sel_gzam_prep FROM l_sql
   DECLARE azzp660_02_sel_gzam_curs CURSOR FOR azzp660_02_sel_gzam_prep

   CALL cl_err_collect_init() 
   
   FOREACH azzp660_02_sel_gzam_curs INTO l_gzam.gzam003,l_gzam.gzam006,l_gzam.gzam007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      IF cl_null(l_gzam.gzam006) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'azz-01122'    #%1為下階table，鍵值不可為空！  
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_gzam.gzam003
         CALL cl_err()

         LET r_success = FALSE
      END IF

      IF cl_null(l_gzam.gzam007) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'azz-01123'   #%1為下階table，外來鍵不可為空！ 
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_gzam.gzam003 
         CALL cl_err()

         LET r_success = FALSE
      END IF

      #如果有其中一個欄位是空的，就沒必要再檢查鍵值數量是否相符  
      IF cl_null(l_gzam.gzam006) OR cl_null(l_gzam.gzam007) THEN
         CONTINUE FOREACH
      END IF

      LET l_cnt_gzam006 = 0
      LET l_cnt_gzam007 = 0

      LET l_tk_gzam006 = base.StringTokenizer.create(l_gzam.gzam006,",")
      WHILE l_tk_gzam006.hasMoreTokens()
         LET l_field = l_tk_gzam006.nextToken()
         LET l_cnt_gzam006 = l_cnt_gzam006 + 1
      END WHILE

      LET l_tk_gzam007 = base.StringTokenizer.create(l_gzam.gzam007,",")
      WHILE l_tk_gzam007.hasMoreTokens()
         LET l_field = l_tk_gzam007.nextToken()
         LET l_cnt_gzam007 = l_cnt_gzam007 + 1
      END WHILE

      IF l_cnt_gzam006 <> l_cnt_gzam007 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'azz-01124'    #鍵值數量與外來鍵數量不符！  
         LET g_errparam.popup  = TRUE 
         LET g_errparam.replace[1] = l_gzam.gzam003
         CALL cl_err()
         LET r_success = FALSE
      END IF

   END FOREACH

   CALL cl_err_collect_show()

   RETURN r_success
   
END FUNCTION

 
{</section>}
 
