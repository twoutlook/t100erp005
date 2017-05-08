#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp168_4
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 產生畫面欄位資訊(含tsd資料與產生器資料)--取得欄位tab資訊

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
   DEFINE g_prog_id     LIKE dzfi_t.dzfi001
   DEFINE g_sd_ver      LIKE dzaa_t.dzaa002  #規格版次/程式版次
   DEFINE g_erp_ver     LIKE dzaa_t.dzaa008  #產品版本
   DEFINE g_dgenv       LIKE dzaa_t.dzaa009  #區域 (識別標示)
   DEFINE g_cust        LIKE dzaa_t.dzaa010  #客戶編號
   DEFINE g_prog_type   STRING
END GLOBALS

CONSTANT g_master_style = "1"     #單頭樣式
CONSTANT g_detail_style = "2"     #單身樣式

#field資訊
TYPE type_g_field       RECORD
                dzfj005         LIKE dzfj_t.dzfj005,   #畫面控件代號
                variable        LIKE dzfb_t.dzfb006,   #4gl定義的變數名稱
                label_text      STRING,                #欄位標籤代碼
                dzfj006         LIKE dzfj_t.dzfj006,   #控件類型
                gztd009         LIKE gztd_t.gztd009,   #Genero 資料型態
                dzfj005_ref     LIKE dzeb_t.dzeb004,   #參考欄位畫面控件代號
                variable_ref    LIKE dzeb_t.dzeb005    #參考欄位4gl定義的變數名稱
             END RECORD 

#structure資訊
TYPE type_g_structure   RECORD
                type            STRING,                #structure類型
                id              STRING,                #structure代碼
                label_text      STRING,                #structure標籤代碼
                style           LIKE dzfb_t.dzfb003,   #structure樣式:g_master_style(單頭); g_detail_style(單身)
                container_id    LIKE dzfi_t.dzfi004,   #container ID
                sfield          DYNAMIC ARRAY OF type_g_field
             END RECORD

#欄位tab定義資訊
TYPE type_g_dzfb        RECORD
                dzfb001         LIKE dzfb_t.dzfb001,   #畫面代碼    
                dzfb002         LIKE dzfb_t.dzfb002,   #設計點版本  
                dzfb003         LIKE dzfb_t.dzfb003,   #所屬結構樣式
                dzfb004         LIKE dzfb_t.dzfb004,   #所屬容器代碼
                dzfb005         LIKE dzfb_t.dzfb005,   #控件代號    
                dzfb006         LIKE dzfb_t.dzfb006,   #4gl變數名稱 
                dzfb007         LIKE dzfb_t.dzfb007,   #識別標示
                dzfb008         LIKE dzfb_t.dzfb008    #客戶代號
                END RECORD

DEFINE g_dzfb007            LIKE dzfb_t.dzfb007        #識別標示
DEFINE g_dzfb008            LIKE dzfb_t.dzfb008        #客戶代號
DEFINE g_error_message      STRING                     #錯誤訊息
DEFINE g_structure          DYNAMIC ARRAY OF type_g_structure

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_4_init(p_dzfi001, p_dzfi002, p_dzfi009)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #畫面代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002     #規格版本
   DEFINE p_dzfi009         LIKE dzfi_t.dzfi009     #識別標示
   
   DEFINE l_sql             STRING

   #取得識別標示
   IF NOT cl_null(p_dzfi009) THEN
      LET g_dzfb007 = p_dzfi009
   ELSE
      LET g_dzfb007 = FGL_GETENV("DGENV")     #"s":標準; "c"客製
   END IF

   #取得客戶代號
   LET g_dzfb008 = FGL_GETENV("CUST")
   
   #刪除此畫面代碼所有相關設計資訊
   IF NOT sadzp168_4_reload_delete(p_dzfi001, p_dzfi002, p_dzfi009) THEN
      DISPLAY "Delete failures."    #刪除失敗
      RETURN FALSE
   END IF

   #####宣告insert 畫面結構檔資枓表#####
   LET l_sql = "INSERT INTO dzfb_t (dzfb001, dzfb002, dzfb003, dzfb004, dzfb005, ",
               "                    dzfb006, dzfb007, dzfb008)",
               "  VALUES (?,?,?,?,?, ?,?,?)"
                     
   PREPARE sadzp168_4_dzfb_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "Warning-PREPARE sadzp168_4_dzfb_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

PUBLIC FUNCTION sadzp168_4(p_dzfi001, p_dzfi002, p_dgenv)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #畫面代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002     #規格版本
   DEFINE p_dgenv           LIKE dzfi_t.dzfi009     #識別標示

   DEFINE l_time_s          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_dzfb            type_g_dzfb
   DEFINE l_prog_type       STRING
   DEFINE l_gzzacrtid       LIKE gzza_t.gzzacrtid   #創建人
   DEFINE l_gzzacrtdt       LIKE gzza_t.gzzacrtdt   #創建日期
   #DEFINE l_dzfq001         LIKE dzfi_t.dzfq001     #結構代號
   DEFINE l_table_main      STRING
   DEFINE l_table_main_pk   STRING
   DEFINE l_structure_cnt   LIKE type_t.num5
   DEFINE li_de_cnt         LIKE type_t.num5
   DEFINE l_success         LIKE type_t.num5        #操作上是否成功(全過程)
   DEFINE li_cnt            LIKE type_t.num5
   
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_j               LIKE type_t.num5
   DEFINE l_k               LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5

   #程式所用到的資料表
   DEFINE l_table     DYNAMIC ARRAY OF RECORD
                table_type  LIKE type_t.num5,       #1:單頭表 2:單身表
                table_id    STRING,
                table_pk    STRING,
                table_fk    STRING
             END RECORD
             
   #每個單身SR的id
   DEFINE l_dzfi      DYNAMIC ARRAY OF RECORD
                detail_sn   LIKE type_t.num5,
                detail_id   LIKE dzfi_t.dzfi004,
                detail_tab  LIKE dzfs_t.dzfs004,
                layer3_up   LIKE dzag_t.dzag004,    #上階table編號
                cluster     STRING,                 #串查記錄字串
                detail_ins  LIKE dzfs_t.dzfs006,
                detail_del  LIKE dzfs_t.dzfs007,
                detail_app  LIKE dzfs_t.dzfs008,
                connect     LIKE dzfs_t.dzfs009     #是否連動
             END RECORD

   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #RETURN TRUE, ""

   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   CALL g_structure.clear()
   CALL l_table.clear()
           
   IF cl_null(p_dzfi001) THEN
      LET g_error_message = "Warning:", cl_getmsg("adz-00009", g_lang)
      DISPLAY g_error_message
      RETURN FALSE, g_error_message
   END IF

   LET g_prog_id = p_dzfi001             #程式代碼
   LET g_sd_ver = p_dzfi002              #規格版本/產生版本
   LET g_erp_ver = FGL_GETENV("ERPVER")  #產品版本
   LET g_cust = FGL_GETENV("CUST")       #客戶編號
   LET g_dgenv = p_dgenv                 #區域(識別標示)

   #160104:經測試目前已無下述情況,因此mark下面段落=====
   ##150707:在標準轉客制情境時,在free style會產生錯誤的dzba_t add point資料
   ##(可參考150706 mail:abmm200客制,畫面加4個欄位元下載程式後,所有的變數定義都不見了情境)
   ##所以在這裡先排除版次為c1的解析動作,但全新客制的c1還是必須可以解析
   #IF p_dgenv = 'c' AND p_dzfi002 = 1 THEN
   #   SELECT COUNT(*) INTO l_cnt FROM dzaf_t
   #     WHERE dzaf001 = p_dzfi001 AND dzaf010 = 's'

   #   IF l_cnt > 0 THEN
   #      DISPLAY p_dzfi001, "is c1."
   #      RETURN TRUE, ""
   #   END IF
   #END IF
   #160104:=====

   
   #程式初始化
   IF NOT sadzp168_4_init(p_dzfi001, p_dzfi002, p_dgenv) THEN
      RETURN FALSE, g_error_message
   END IF

   #讀取基本資料 主表(dzag)及個別欄位關係 
   CALL sadzp030_tab_relation() RETURNING l_table_main, l_table_main_pk, l_table

   ###取得畫面單頭欄位
   CALL sadzp030_tab_ma_init()

   #開始判斷關係
   CALL sadzp030_tab_relation_prog_type("") 
      RETURNING l_prog_type, l_gzzacrtid, l_gzzacrtdt, l_k

   LET g_prog_type = l_prog_type
   
   #單頭資訊
   LET l_structure_cnt = 1
   LET g_structure[l_structure_cnt].style = g_master_style
   LET g_structure[l_structure_cnt].container_id = "Undefined"

   #取得單頭上的欄位資料
   IF NOT sadzp168_4_tab_ma(l_prog_type, l_table_main, l_structure_cnt) THEN
      #代表沒有單頭結構,所以structure數量不用加1
      LET l_structure_cnt = 0
   END IF

   ###取得畫面單身欄位             
   #取得單身型態的Table
   CALL sadzp030_tab_de_cnt() RETURNING l_success, li_de_cnt, l_dzfi

   IF NOT l_success THEN
      LET g_error_message = "Warning-CALL sadzp030_tab_de_cnt() Failure."
      DISPLAY g_error_message
      RETURN FALSE, g_error_message
   END IF
   
   #程式會有多個單身
   FOR li_cnt = 1 TO l_dzfi.getLength()
       #單身資訊
       LET l_structure_cnt = l_structure_cnt + 1
       LET g_structure[l_structure_cnt].style = g_detail_style
       LET g_structure[l_structure_cnt].container_id = l_dzfi[li_cnt].detail_id

       #取得單身上的欄位資料
       IF NOT sadzp168_4_tab_de(l_structure_cnt, l_dzfi[li_cnt].detail_id, l_dzfi[li_cnt].detail_tab) THEN
          LET g_error_message = "Warning-CALL sadzp168_4_tab_de() Failure."
          DISPLAY g_error_message
          RETURN FALSE, g_error_message
       END IF
   END FOR

   BEGIN WORK
   
   FOR l_i = 1 TO g_structure.getLength()
      #DISPLAY g_structure[l_i].STYLE
      #DISPLAY g_structure[l_i].container_id
      FOR l_j = 1 TO g_structure[l_i].sfield.getLength()
          #DISPLAY "  ", g_structure[l_i].sfield[l_j].variable, ":", g_structure[l_i].sfield[l_j].dzfj005, ";"

          LET l_dzfb.dzfb001 = p_dzfi001
          LET l_dzfb.dzfb002 = p_dzfi002
          LET l_dzfb.dzfb003 = g_structure[l_i].style
          LET l_dzfb.dzfb004 = g_structure[l_i].container_id
          LET l_dzfb.dzfb005 = g_structure[l_i].sfield[l_j].dzfj005
          LET l_dzfb.dzfb006 = g_structure[l_i].sfield[l_j].variable
          LET l_dzfb.dzfb007 = g_dzfb007
          LET l_dzfb.dzfb008 = g_dzfb008
          
          EXECUTE sadzp168_4_dzfb_ins_pre USING l_dzfb.dzfb001, l_dzfb.dzfb002, l_dzfb.dzfb003, l_dzfb.dzfb004, l_dzfb.dzfb005, 
                                                l_dzfb.dzfb006, l_dzfb.dzfb007, l_dzfb.dzfb008
          
          IF SQLCA.sqlcode THEN
             LET g_error_message = "Warning-PREPARE sadzp168_4_dzfb_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
             DISPLAY g_error_message
             
             ROLLBACK WORK
             RETURN FALSE, g_error_message
          END IF     
      END FOR
   END FOR

   COMMIT WORK
   
   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ delete 畫面相關設計資訊
PUBLIC FUNCTION sadzp168_4_reload_delete(p_dzfi001, p_dzfi002, p_dzfi009)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #畫面代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002     #規格版本
   DEFINE p_dzfi009         LIKE dzfi_t.dzfi009     #識別標示
   
   DELETE FROM dzfb_t 
     WHERE dzfb001 = p_dzfi001 AND dzfb002 = p_dzfi002 
       AND dzfb007 = p_dzfi009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "Warning-del dzfb_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#取得單頭上的欄位資訊
PRIVATE FUNCTION sadzp168_4_tab_ma(p_prog_type, p_dzea001, p_structure_idx)
   #DEFINE p_dzfq001         LIKE dzfi_t.dzfq001     #結構代號
   DEFINE p_prog_type       STRING
   DEFINE p_dzea001         LIKE dzea_t.dzea001     #資料表代號
   DEFINE p_structure_idx   LIKE type_t.num5        #container index

   DEFINE l_container       STRING
   DEFINE ls_master_col     STRING                  #單頭欄位控件
   DEFINE l_type            LIKE type_t.chr1

   #取得單頭上的欄位資料(對q類來說是qbe處稱為head)
   LET l_type = "1"

   IF p_prog_type.subString(1, 1) = "q" THEN
      LET l_container = "qbe"
      LET ls_master_col = sadzp030_tab_ma(l_container, l_type, p_dzea001, TRUE)
   ELSE
      #取得單頭上的欄位4gl定義的變數名稱
      LET l_container = "mainlayout"
      LET ls_master_col = sadzp030_tab_ma(l_container, l_type, p_dzea001, FALSE)
   END IF
   
   #IF cl_null(ls_master_col) THEN
   #   IF g_bg_exec = "Y" THEN
   #      DISPLAY "ERROR:", cl_getmsg_parm("adz-00251", g_lang, g_prog_id)
   #   ELSE
   #      CALL cl_err_msg(NULL, "adz-00251", g_prog_id, 0)
   #   END IF 
   #   RETURN FALSE
   #END IF

   IF NOT cl_null(ls_master_col) THEN
      CALL sadzp168_4_set_field_value(l_type, ls_master_col, p_structure_idx)
   ELSE
      #代表沒有單頭結構
      RETURN FALSE
   END IF

      
   #取得單頭上的畫面欄位控件代碼資料
   LET l_type = "5"
   IF p_prog_type.subString(1, 1) = "q" THEN
      LET ls_master_col = sadzp030_tab_ma(l_container, l_type, p_dzea001, TRUE)
   ELSE
      LET ls_master_col = sadzp030_tab_ma(l_container, l_type, p_dzea001, FALSE)
   END IF
      
   #IF cl_null(ls_master_col) THEN
   #   IF g_bg_exec = "Y" THEN
   #      DISPLAY "ERROR:", cl_getmsg_parm("adz-00251", g_lang, g_prog_id || ".mainlayout")
   #   ELSE
   #      CALL cl_err_msg(NULL, "adz-00251", g_prog_id || ".mainlayout", 0)
   #    END IF 
   #   RETURN FALSE
   #END IF

   IF NOT cl_null(ls_master_col) THEN   
      CALL sadzp168_4_set_field_value(l_type, ls_master_col, p_structure_idx)
   ELSE
      #代表沒有單頭結構
      RETURN FALSE
   END IF

   RETURN TRUE   
END FUNCTION


#取得單身上的欄位資訊
PRIVATE FUNCTION sadzp168_4_tab_de(p_structure_idx, p_detail_id, p_detail_tab)
   DEFINE p_structure_idx   LIKE type_t.num5        #container index
   DEFINE p_detail_id       LIKE dzfi_t.dzfi004     #table控件名稱
   DEFINE p_detail_tab      LIKE dzfs_t.dzfs004     #資料表編號
   
   DEFINE l_type            LIKE type_t.chr1
   DEFINE ls_temp           STRING

   #取得單頭上的欄位4gl定義的變數名稱
   LET l_type = "1"
   LET ls_temp = sadzp030_tab_de(p_detail_id, l_type, p_detail_tab)

   IF cl_null(ls_temp) THEN
      LET g_error_message = "Warning-1:", cl_getmsg_parm("adz-00251", g_lang, g_prog_id || "." || p_detail_id)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
      
   CALL sadzp168_4_set_field_value(l_type, ls_temp, p_structure_idx)

   #取得單頭上的畫面欄位控件代碼資料
   LET l_type = "5"
   LET ls_temp = sadzp030_tab_de(p_detail_id, l_type, p_detail_tab)

   IF cl_null(ls_temp) THEN
      LET g_error_message = "Warning-5:", cl_getmsg_parm("adz-00251", g_lang, g_prog_id || "." || p_detail_id)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   CALL sadzp168_4_set_field_value(l_type, ls_temp, p_structure_idx)

   RETURN TRUE
END FUNCTION


#設定畫面欄位資訊
PRIVATE FUNCTION sadzp168_4_set_field_value(p_type, p_fields, p_structure_idx)
   DEFINE p_type            LIKE type_t.chr1        #欄位名稱組合型態
   DEFINE p_fields          STRING                  #欄位名稱組合
   DEFINE p_structure_idx   LIKE type_t.num5        #container index
   
   DEFINE l_tok             base.StringTokenizer
   DEFINE l_tmp             STRING
   DEFINE l_cnt             LIKE type_t.num5

   LET l_cnt = 1
   
   LET l_tok = base.StringTokenizer.createExt(p_fields CLIPPED, ",", "", TRUE)   #指定分隔符號

   #依序取得子字串
   WHILE l_tok.hasMoreTokens()  
      LET l_tmp = l_tok.nextToken()

      CASE p_type
         WHEN "1"   #4gl定義的變數名稱
            IF l_tmp.getIndexOf("(", 1) > 1 THEN
               LET l_tmp = l_tmp.subString(1, l_tmp.getIndexOf("(", 1) - 1)
            END IF
            LET g_structure[p_structure_idx].sfield[l_cnt].variable = l_tmp.trim()
            
         WHEN "5"   #畫面控件代號
            LET g_structure[p_structure_idx].sfield[l_cnt].dzfj005 = l_tmp.trim()
            
      END CASE
      LET l_cnt = l_cnt + 1
   END WHILE
END FUNCTION

