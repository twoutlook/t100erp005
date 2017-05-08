
DATABASE ds

DEFINE g_arr DYNAMIC ARRAY OF RECORD
         tmp LIKE type_t.chr3,
         ida STRING,
         idb STRING,
         nea STRING,
         neb STRING
             END RECORD
DEFINE g_pg DYNAMIC ARRAY OF RECORD
         prog LIKE gzza_t.gzza001,
         page STRING,
         record STRING,
         chk  LIKE type_t.num5
             END RECORD
MAIN

   DEFINE ls_sql  STRING
   DEFINE lc_dzba001 LIKE dzba_t.dzba001
   DEFINE lc_dzba003 LIKE dzba_t.dzba003
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE lc_gzzx004 LIKE gzzx_t.gzzx004

   WHENEVER ERROR CONTINUE

   #填入資料
   LET li_cnt = 0
   CALL modadp_fill_data()
   CALL modadp_fill_data2()

   LET ls_sql = "SELECT dzba001,dzba003 FROM dzba_t ",
                " ORDER BY dzba001,dzba003"
   DECLARE mod_adpid_cs CURSOR FROM ls_sql

   #找出符合的項目
   FOREACH mod_adpid_cs INTO lc_dzba001,lc_dzba003

      #反推該code標定使用的樣板
      SELECT gzzx004 INTO lc_gzzx004 FROM gzzx_t
       WHERE gzzx001 = lc_dzba001
      IF SQLCA.SQLCODE THEN
         CONTINUE FOREACH
      END IF
      IF lc_gzzx004 IS NULL OR lc_gzzx004 = " " THEN
         CONTINUE FOREACH
      END IF
 
      #共用樣板轉換
      CASE 
         WHEN lc_gzzx004 = "c01a" LET lc_gzzx004 = "i01"
         WHEN lc_gzzx004 = "c02a" LET lc_gzzx004 = "i02"
         WHEN lc_gzzx004 = "c04a" LET lc_gzzx004 = "t02"
         WHEN lc_gzzx004 = "i09"  LET lc_gzzx004 = "t01"
         WHEN lc_gzzx004 = "i10"  LET lc_gzzx004 = "i01"
         WHEN lc_gzzx004 = "i12"  LET lc_gzzx004 = "i07"
         WHEN lc_gzzx004 = "i13"  LET lc_gzzx004 = "i01"
      END CASE

      IF NOT modadp_check_id(lc_dzba001,lc_gzzx004,lc_dzba003) THEN
         CONTINUE FOREACH
      END IF

      LET li_cnt = li_cnt + 1
   END FOREACH

   DISPLAY "總計修正:",li_cnt,"筆"
   CLOSE mod_adpid_cs
   FREE mod_adpid_cs                

   FOR li_cnt = 1 TO g_pg.getLength()
      IF NOT g_pg[li_cnt].chk THEN
         display "有TAB無設計資料的:",g_pg[li_cnt].prog
      END IF
   END FOR

END MAIN

PRIVATE FUNCTION modadp_check_id(lc_dzba001,lc_gzzx004,lc_dzba003)
   DEFINE lc_dzba001 LIKE dzba_t.dzba001
   DEFINE lc_dzba003 LIKE dzba_t.dzba003
   DEFINE lc_dzba003_new LIKE dzba_t.dzba003
   DEFINE li_status  LIKE type_t.num5
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lc_gzzx004 LIKE gzzx_t.gzzx004
   DEFINE ls_tmp     STRING
   DEFINE li_posa    LIKE type_t.num5  #前置字串起始位置
   DEFINE li_lengtha LIKE type_t.num5  #前置字串長度
   DEFINE ls_new     STRING            #新字串
   DEFINE li_dzba,li_dzbb LIKE type_t.num5

   LET li_status = FALSE
   LET ls_tmp = lc_dzba003

   #查array
   FOR li_cnt = 1 TO g_arr.getLength()
      #檢查樣板
      IF lc_gzzx004 <> g_arr[li_cnt].tmp THEN
         CONTINUE FOR
      END IF

      #檢查前置字串
      LET li_posa = ls_tmp.getIndexOf(g_arr[li_cnt].ida,1) 
      LET li_lengtha = g_arr[li_cnt].ida.getLength()
      IF NOT li_posa = 1 THEN
         CONTINUE FOR
      END IF
 
      #如果後置字串存在則檢查
      IF g_arr[li_cnt].idb IS NOT NULL THEN
         IF ls_tmp.getIndexOf(g_arr[li_cnt].idb, li_lengtha + 1) THEN
            LET li_status = TRUE
            EXIT FOR
         END IF
      ELSE
         LET li_status = TRUE
         EXIT FOR
      END IF
   END FOR

   #如果有查到,截出原有page_id字串,兜上新的頭尾
   IF li_status THEN
      LET ls_new = ls_tmp.subString(li_lengtha+1,ls_tmp.getLength())

      IF g_arr[li_cnt].idb IS NOT NULL THEN
         LET ls_new = ls_new.subString(1, (ls_new.getLength() - g_arr[li_cnt].idb.getLength()) )
      END IF

      #取出的中間段放去檢查
      LET ls_new = modadp_chk_middle(lc_dzba001,ls_new)

      LET ls_new = g_arr[li_cnt].nea.trim(),ls_new.trim(),g_arr[li_cnt].neb.trim()

      #扣除不需要更名的項目
      IF ls_new.trim() = lc_dzba003 CLIPPED THEN
         LET li_status = FALSE
      END IF
   END IF

   IF li_status THEN
      LET lc_dzba003_new = ls_new

      SELECT COUNT(*) INTO li_dzba FROM dzba_t
       WHERE dzba001 = lc_dzba001 AND dzba003 = lc_dzba003
      UPDATE dzba_t SET dzba003 = lc_dzba003_new
       WHERE dzba001 = lc_dzba001 AND dzba003 = lc_dzba003
      IF SQLCA.SQLCODE THEN
         display 'Fail 程式:',lc_dzba001,' 樣板:',lc_gzzx004,' 更改前:',lc_dzba003,' 後:',ls_new,' ba:error'
      END IF

      SELECT COUNT(*) INTO li_dzbb FROM dzbb_t
       WHERE dzbb001 = lc_dzba001 AND dzbb002 = lc_dzba003
      UPDATE dzbb_t SET dzbb002 = lc_dzba003_new
       WHERE dzbb001 = lc_dzba001 AND dzbb002 = lc_dzba003
      IF SQLCA.SQLCODE THEN
         display 'Fail 程式:',lc_dzba001,' 樣板:',lc_gzzx004,' 更改前:',lc_dzba003,' 後:',ls_new,' bb:error'
      ELSE
         display 'ok 程式:',lc_dzba001,' 樣板:',lc_gzzx004,' 更改前:',lc_dzba003,' 後:',ls_new
      END IF

   END IF

   RETURN li_status 

END FUNCTION

PRIVATE FUNCTION modadp_chk_middle(lc_dzba001,ls_orig)

   DEFINE lc_dzba001 LIKE dzba_t.dzba001
   DEFINE ls_orig    STRING
   DEFINE li_cnt     LIKE type_t.num5

   FOR li_cnt = 1 TO g_pg.getLength()
      IF g_pg[li_cnt].prog = lc_dzba001 AND g_pg[li_cnt].page = ls_orig THEN
         LET g_pg[li_cnt].chk = TRUE
         RETURN g_pg[li_cnt].record
      END IF
   END FOR

   RETURN ls_orig
END FUNCTION


PRIVATE FUNCTION modadp_fill_data()

   LET g_arr[01].tmp = "i02" LET g_arr[01].ida = "input.page"              LET g_arr[01].idb = ".action"
   LET g_arr[02].tmp = "i02" LET g_arr[02].ida = "detail_show.reference"   LET g_arr[02].idb = ""
   LET g_arr[03].tmp = "i07" LET g_arr[03].ida = "ui_dialog.page"          LET g_arr[03].idb = ".action"
   LET g_arr[04].tmp = "i07" LET g_arr[04].ida = "input.page"              LET g_arr[04].idb = ".action"
   LET g_arr[05].tmp = "i07" LET g_arr[05].ida = "input2.d.before_input"   LET g_arr[05].idb = ""
   LET g_arr[06].tmp = "i07" LET g_arr[06].ida = "ref_show.body.reference" LET g_arr[06].idb = ""
   LET g_arr[07].tmp = "i04" LET g_arr[07].ida = "input.d.before_input"    LET g_arr[07].idb = ""
   LET g_arr[08].tmp = "i04" LET g_arr[08].ida = "input.page"              LET g_arr[08].idb = ".action"
   LET g_arr[09].tmp = "i04" LET g_arr[09].ida = "show.body.reference"     LET g_arr[09].idb = ""
   LET g_arr[10].tmp = "i08" LET g_arr[10].ida = "input.d.before_input"    LET g_arr[10].idb = ""
   LET g_arr[11].tmp = "i08" LET g_arr[11].ida = "input.page"              LET g_arr[11].idb = ".action"
   LET g_arr[12].tmp = "i08" LET g_arr[12].ida = "input.display.page"      LET g_arr[12].idb = ".action"
   LET g_arr[13].tmp = "i08" LET g_arr[13].ida = "show.body.reference"     LET g_arr[13].idb = ""
   LET g_arr[14].tmp = "t01" LET g_arr[14].ida = "ui_dialog.page"          LET g_arr[14].idb = ".before_row"
   LET g_arr[15].tmp = "t01" LET g_arr[15].ida = "ui_dialog.page"          LET g_arr[15].idb = ".action"
   LET g_arr[16].tmp = "t01" LET g_arr[16].ida = "input.d.before_input"    LET g_arr[16].idb = ""
   LET g_arr[17].tmp = "t01" LET g_arr[17].ida = "input.d.before_input"    LET g_arr[17].idb = ""
   LET g_arr[18].tmp = "t01" LET g_arr[18].ida = "input.page"              LET g_arr[18].idb = ".before_row"
   LET g_arr[19].tmp = "t01" LET g_arr[19].ida = "input.page"              LET g_arr[19].idb = ".action"
   LET g_arr[20].tmp = "t01" LET g_arr[20].ida = "input.page"              LET g_arr[20].idb = ".before_row"
   LET g_arr[21].tmp = "t01" LET g_arr[21].ida = "input.page"              LET g_arr[21].idb = ".action"
   LET g_arr[22].tmp = "t01" LET g_arr[22].ida = "show.body.reference"     LET g_arr[22].idb = ""
   LET g_arr[23].tmp = "t02" LET g_arr[23].ida = "input.body.m_update"     LET g_arr[23].idb = ""
   LET g_arr[24].tmp = "t02" LET g_arr[24].ida = "input.body.m_update"     LET g_arr[24].idb = ""
   LET g_arr[25].tmp = "t02" LET g_arr[25].ida = "input.page"              LET g_arr[25].idb = ".action"
   LET g_arr[26].tmp = "t02" LET g_arr[26].ida = "input.page"              LET g_arr[26].idb = ".action"

   LET g_arr[01].nea = "input.body"         LET g_arr[01].neb = ".action"
   LET g_arr[02].nea = "detail_show.body"   LET g_arr[02].neb = ".reference"
   LET g_arr[03].nea = "ui_dialog.body"     LET g_arr[03].neb = ".action"
   LET g_arr[04].nea = "input.body"         LET g_arr[04].neb = ".action"
   LET g_arr[05].nea = "input2.body"        LET g_arr[05].neb = ".before_input"
   LET g_arr[06].nea = "ref_show.body"      LET g_arr[06].neb = ".reference"
   LET g_arr[07].nea = "input.body"         LET g_arr[07].neb = ".before_input"
   LET g_arr[08].nea = "input.body"         LET g_arr[08].neb = ".action"
   LET g_arr[09].nea = "show.body"          LET g_arr[09].neb = ".reference"
   LET g_arr[10].nea = "input.body"         LET g_arr[10].neb = ".before_input"
   LET g_arr[11].nea = "input.body"         LET g_arr[11].neb = ".action"
   LET g_arr[12].nea = "input.display.body" LET g_arr[12].neb = ".action"
   LET g_arr[13].nea = "show.body"          LET g_arr[13].neb = ".reference"
   LET g_arr[14].nea = "ui_dialog.body"     LET g_arr[14].neb = ".before_row"
   LET g_arr[15].nea = "ui_dialog.body"     LET g_arr[15].neb = ".action"
   LET g_arr[16].nea = "input.body"         LET g_arr[16].neb = ".before_input"
   LET g_arr[17].nea = "input.body"         LET g_arr[17].neb = ".before_input"
   LET g_arr[18].nea = "input.body"         LET g_arr[18].neb = ".before_row"
   LET g_arr[19].nea = "input.body"         LET g_arr[19].neb = ".action"
   LET g_arr[20].nea = "input.body"         LET g_arr[20].neb = ".before_row"
   LET g_arr[21].nea = "input.body"         LET g_arr[21].neb = ".action"
   LET g_arr[22].nea = "show.body"          LET g_arr[22].neb = ".reference"
   LET g_arr[23].nea = "input.body"         LET g_arr[23].neb = ".m_update"
   LET g_arr[24].nea = "input.body"         LET g_arr[24].neb = ".m_update"
   LET g_arr[25].nea = "input.body"         LET g_arr[25].neb = ".action"
   LET g_arr[26].nea = "input.body"         LET g_arr[26].neb = ".action"

END FUNCTION

FUNCTION modadp_fill_data2()
   DEFINE li_cnt LIKE type_t.num5

   LET g_pg[01].prog = "abgi010"  LET g_pg[01].page = "2" LET g_pg[01].record = "1_info" 
   LET g_pg[02].prog = "aiti200"  LET g_pg[02].page = "2" LET g_pg[02].record = "1_info" 
   LET g_pg[03].prog = "aiti203"  LET g_pg[03].page = "2" LET g_pg[03].record = "1_info" 
   LET g_pg[04].prog = "aiti899"  LET g_pg[04].page = "2" LET g_pg[04].record = "1_info" 
   LET g_pg[05].prog = "aiti902"  LET g_pg[05].page = "2" LET g_pg[05].record = "1_info" 
   LET g_pg[06].prog = "aiti903"  LET g_pg[06].page = "2" LET g_pg[06].record = "1_info" 
   LET g_pg[07].prog = "aiti907"  LET g_pg[07].page = "2" LET g_pg[07].record = "1_info" 
   LET g_pg[08].prog = "aiti908"  LET g_pg[08].page = "2" LET g_pg[08].record = "1_info" 
   LET g_pg[09].prog = "aiti909"  LET g_pg[09].page = "2" LET g_pg[09].record = "1_info" 
   LET g_pg[10].prog = "anmi100"  LET g_pg[10].page = "2" LET g_pg[10].record = "1_info" 
   LET g_pg[11].prog = "anmi110"  LET g_pg[11].page = "2" LET g_pg[11].record = "1_info" 
   LET g_pg[12].prog = "anmi140"  LET g_pg[12].page = "2" LET g_pg[12].record = "1_info" 
   LET g_pg[13].prog = "anmi160"  LET g_pg[13].page = "2" LET g_pg[13].record = "1_info" 
   LET g_pg[14].prog = "anmi180"  LET g_pg[14].page = "2" LET g_pg[14].record = "1_info" 
   LET g_pg[15].prog = "anmi190"  LET g_pg[15].page = "2" LET g_pg[15].record = "1_info" 
   LET g_pg[16].prog = "aooi020"  LET g_pg[16].page = "2" LET g_pg[16].record = "1_info" 
   LET g_pg[17].prog = "aooi030"  LET g_pg[17].page = "2" LET g_pg[17].record = "1_info" 
   LET g_pg[18].prog = "aooi040"  LET g_pg[18].page = "2" LET g_pg[18].record = "1_info" 
   LET g_pg[19].prog = "aooi060"  LET g_pg[19].page = "2" LET g_pg[19].record = "1_info" 
   LET g_pg[20].prog = "aooi130"  LET g_pg[20].page = "2" LET g_pg[20].record = "1_info" 
   LET g_pg[21].prog = "aooi250"  LET g_pg[21].page = "2" LET g_pg[21].record = "1_info" 
   LET g_pg[22].prog = "aooi260"  LET g_pg[22].page = "2" LET g_pg[22].record = "1_info" 
   LET g_pg[23].prog = "aooi310"  LET g_pg[23].page = "2" LET g_pg[23].record = "1_info" 
   LET g_pg[24].prog = "aooi320"  LET g_pg[24].page = "2" LET g_pg[24].record = "1_info" 
   LET g_pg[25].prog = "aooi400"  LET g_pg[25].page = "2" LET g_pg[25].record = "1_info" 
   LET g_pg[26].prog = "aooi410"  LET g_pg[26].page = "2" LET g_pg[26].record = "1_info" 
   LET g_pg[27].prog = "aooi420"  LET g_pg[27].page = "2" LET g_pg[27].record = "1_info" 
   LET g_pg[28].prog = "aooi426"  LET g_pg[28].page = "2" LET g_pg[28].record = "1_info" 
   LET g_pg[29].prog = "aooi428"  LET g_pg[29].page = "2" LET g_pg[29].record = "1_info" 
   LET g_pg[30].prog = "aooi429"  LET g_pg[30].page = "2" LET g_pg[30].record = "1_info" 
   LET g_pg[31].prog = "aqci001"  LET g_pg[31].page = "2" LET g_pg[31].record = "1_info" 
   LET g_pg[32].prog = "aqci002"  LET g_pg[32].page = "2" LET g_pg[32].record = "1_info" 
   LET g_pg[33].prog = "aqci004"  LET g_pg[33].page = "2" LET g_pg[33].record = "1_info" 
   LET g_pg[34].prog = "aqci005"  LET g_pg[34].page = "2" LET g_pg[34].record = "1_info" 
   LET g_pg[35].prog = "aqci006"  LET g_pg[35].page = "2" LET g_pg[35].record = "1_info" 
   LET g_pg[36].prog = "azzi040"  LET g_pg[36].page = "2" LET g_pg[36].record = "1_info" 
   LET g_pg[37].prog = "azzi050"  LET g_pg[37].page = "2" LET g_pg[37].record = "1_info" 
   LET g_pg[38].prog = "azzi060"  LET g_pg[38].page = "2" LET g_pg[38].record = "1_info" 
   LET g_pg[39].prog = "azzi500"  LET g_pg[39].page = "2" LET g_pg[39].record = "1_info" 
   LET g_pg[40].prog = "azzi660"  LET g_pg[40].page = "2" LET g_pg[40].record = "1_info" 
   LET g_pg[41].prog = "azzi920"  LET g_pg[41].page = "2" LET g_pg[41].record = "1_info" 

   FOR li_cnt = 1 TO g_pg.getLength()
      LET g_pg[li_cnt].chk = FALSE
   END FOR

END FUNCTION
