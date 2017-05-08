#該程式未解開Section, 採用最新樣板產出!
{<section id="artm230_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-11-20 10:22:10), PR版次:0005(2016-09-20 15:34:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: artm230_01
#+ Description: 門店資源協議批量終止子程式
#+ Creator....: 06254(2015-11-20 10:20:10)
#+ Modifier...: 06254 -SD/PR- 07142
 
{</section>}
 
{<section id="artm230_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160907-00024#1 2016/09/07 by 08172    artm230终止的时候，把单身的资源单身的失效日期更新成终止日期
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_rtap_d        RECORD
       sel LIKE type_t.chr1, 
   rtap001 LIKE rtap_t.rtap001, 
   rtapseq LIKE rtap_t.rtapseq, 
   rtap002 LIKE rtap_t.rtap002, 
   rtap002_desc LIKE type_t.chr500, 
   rtap024 LIKE rtap_t.rtap024, 
   rtap007 LIKE rtap_t.rtap007, 
   rtap007_desc LIKE type_t.chr500, 
   rtap008 LIKE rtap_t.rtap008, 
   rtap008_desc LIKE type_t.chr500, 
   rtap017 LIKE rtap_t.rtap017, 
   rtap020 LIKE rtap_t.rtap020
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_cnt     LIKE type_t.num5
#end add-point
 
DEFINE g_rtap_d          DYNAMIC ARRAY OF type_g_rtap_d
DEFINE g_rtap_d_t        type_g_rtap_d
 
 
DEFINE g_rtapseq_t   LIKE rtap_t.rtapseq    #Key值備份
DEFINE g_rtap001_t      LIKE rtap_t.rtap001    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
DEFINE g_rtaosite      LIKE rtao_t.rtaosite
DEFINE g_rtao001       LIKE rtao_t.rtao001
#end add-point    
 
{</section>}
 
{<section id="artm230_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION artm230_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_rtaosite,
   p_rtao001
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_rtaosite      LIKE rtao_t.rtaosite
   DEFINE p_rtao001       LIKE rtao_t.rtao001
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_artm230_01 WITH FORM cl_ap_formpath("art","artm230_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('rtap020','6841')
   LET g_rtaosite=p_rtaosite
   LET g_rtao001=p_rtao001
   CALL artm230_01_b_fill(" 1=1")
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_rtap_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtap001
            #add-point:BEFORE FIELD rtap001 name="input.b.page1.rtap001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtap001
            
            #add-point:AFTER FIELD rtap001 name="input.a.page1.rtap001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtap_d[g_detail_idx].rtapseq IS NOT NULL AND g_rtap_d[g_detail_idx].rtap001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtap_d[g_detail_idx].rtapseq != g_rtap_d_t.rtapseq OR g_rtap_d[g_detail_idx].rtap001 != g_rtap_d_t.rtap001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtap_t WHERE "||"rtapent = '" ||g_enterprise|| "' AND "||"rtapseq = '"||g_rtap_d[g_detail_idx].rtapseq ||"' AND "|| "rtap001 = '"||g_rtap_d[g_detail_idx].rtap001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtap001
            #add-point:ON CHANGE rtap001 name="input.g.page1.rtap001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtap001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtap001
            #add-point:ON ACTION controlp INFIELD rtap001 name="input.c.page1.rtap001"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
 
   #add-point:畫面關閉前 name="input.before_close"
   IF INT_FLAG = FALSE THEN
      CALL artm230_01_upd()
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_artm230_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artm230_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="artm230_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION artm230_01_b_fill(p_wc)
DEFINE l_sql    STRING
DEFINE p_wc     STRING
DEFINE l_where  STRING

   IF cl_null(p_wc) THEN
      LET p_wc = " 1=1"
   END IF
   LET l_sql = " SELECT 'N',rtap001,rtapseq,rtap002,rtall003,rtap024,rtap007,mhael024,rtap008,pmaal003,rtap017,rtap020,rtap005 ",##add by zhangnan rtap005
               "   FROM rtap_t ",
               "        LEFT JOIN rtall_t ON rtallent='"||g_enterprise||"' AND rtall001 = rtap002 AND rtall002= '"||g_dlang||"'",
               "        LEFT JOIN mhael_t ON mhaelent='"||g_enterprise||"' AND mhael001 = rtap007 AND mhael022= '"||g_dlang||"'",
               "        LEFT JOIN pmaal_t ON pmaalent='"||g_enterprise||"' AND pmaal001 = rtap008 AND pmaal002= '"||g_dlang||"'",
               "   WHERE rtap001='",g_rtao001,"'",
               "     AND rtap020 = '2'",
               "     AND ",p_wc CLIPPED,
               "   ORDER BY rtap001,rtapseq "
               
   
   PREPARE artm230_01_b_fill_pre FROM l_sql
   DECLARE artm230_01_b_fill_cs CURSOR FOR artm230_01_b_fill_pre
   LET l_ac = 1
   FOREACH artm230_01_b_fill_cs
      INTO g_rtap_d[l_ac].sel,
           g_rtap_d[l_ac].rtap001,g_rtap_d[l_ac].rtapseq,
           g_rtap_d[l_ac].rtap002,g_rtap_d[l_ac].rtap002_desc, 
           g_rtap_d[l_ac].rtap024,g_rtap_d[l_ac].rtap007,
           g_rtap_d[l_ac].rtap007_desc,g_rtap_d[l_ac].rtap008,
           g_rtap_d[l_ac].rtap008_desc,g_rtap_d[l_ac].rtap017,g_rtap_d[l_ac].rtap020
           
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach artm230_01_b_fill_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_rtap_d.deleteElement(g_rtap_d.getLength())
   
   LET l_ac = 1
   LET g_detail_cnt = g_rtap_d.getLength()
   DISPLAY g_rec_b TO FORMONLY.cnt
   
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
PRIVATE FUNCTION artm230_01_upd()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5
DEFINE i              LIKE type_t.num5
DEFINE l_rtap005      LIKE  rtap_t.rtap005
DEFINE l_rtap004      LIKE rtap_t.rtap004     #160907-00024#1 by 08172
DEFINE l_rtap003      LIKE rtap_t.rtap003 
       
       CALL s_transaction_begin()
       CALL cl_err_collect_init()
       LET l_success=TRUE
       
       FOR i=1 to g_rtap_d.getlength()
           IF g_rtap_d[i].sel='Y' THEN
           ##add by zhangnan  --str
           SELECT rtap005 INTO l_rtap005  FROM rtap_t 
           WHERE rtapent=g_enterprise  AND rtap001=g_rtap_d[i].rtap001 AND rtapseq=g_rtap_d[i].rtapseq
              UPDATE rtal_t SET rtal008 = rtal008 + l_rtap005,
                                rtal013 = '',
                                rtal012 = CASE rtal006 WHEN 'Y' THEN '1' 
                                          WHEN 'N' THEN CASE (rtal007-rtal008-l_rtap005) WHEN 0 THEN '1' ELSE rtal012 END 
                                          ELSE rtal012 END
              WHERE rtalent=g_enterprise  AND rtal001=g_rtap_d[i].rtap002  AND rtalsite=g_rtaosite
           ##add by zhangnan --end 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = " upd rtal_t "
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_success = FALSE
                 EXIT FOR   
              END IF
              #160907-00024#1 -s by 08172
              SELECT rtap003,rtap004 INTO l_rtap003,l_rtap004 
                FROM rtap_t
               WHERE rtapent = g_enterprise
                 AND rtap001 = g_rtap_d[i].rtap001
                 AND rtapseq = g_rtap_d[i].rtapseq
              IF l_rtap004 >= g_today THEN
                 UPDATE rtap_t SET rtap004 = g_today
                  WHERE rtapent = g_enterprise
                    AND rtap001 = g_rtap_d[i].rtap001
                    AND rtapseq = g_rtap_d[i].rtapseq
                 ##add by zhangnan --str
                 IF l_rtap003 > g_today THEN 
                    UPDATE rtap_t SET rtap003 = g_today
                    WHERE rtapent = g_enterprise
                    AND rtap001 = g_rtap_d[i].rtap001
                    AND rtapseq = g_rtap_d[i].rtapseq
                 END IF
                 ##add by zhangnan --end                  
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = " upd rtap004 "
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_success = FALSE
                    EXIT FOR   
                 END IF
              END IF
              #160907-00024#1 -e by 08172 
              UPDATE rtap_t SET rtap020='3'
               WHERE rtap001=g_rtap_d[i].rtap001 AND rtapseq=g_rtap_d[i].rtapseq AND rtapent = g_enterprise #160905-00007#14 add  rtapent = g_enterprise
               IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = " upd rtap_t "
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_success = FALSE
                 EXIT FOR   
              END IF
           END IF           
       END FOR
       
       IF l_success THEN 
          CALL cl_err_collect_show()
          CALL s_transaction_end('Y','0')
       ELSE
          CALL cl_err_collect_show()
          CALL s_transaction_end('N','0')
      END IF        

END FUNCTION

 
{</section>}
 
