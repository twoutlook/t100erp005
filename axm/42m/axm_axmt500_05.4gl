#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt500_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-02-05 17:46:35), PR版次:0005(2016-10-20 16:46:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000227
#+ Filename...: axmt500_05
#+ Description: 維護訂單附屬零件明細子作業
#+ Creator....: 02040(2014-05-12 18:32:44)
#+ Modifier...: 02040 -SD/PR- 07804
 
{</section>}
 
{<section id="axmt500_05.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161013-00031#1  2016/10/19 By Ann_Huang    1.調整axmt500_get_bmab()增加傳入xmdc062
#                                           2.調整axmt500_05 新增傳入參數 p_xmdc001,p_xmdc062,p_xmdc011,p_xmdcunit
#                                           3.修改axmt500_05_b_fill() a.SQL語法應綁入site資料,否則會取到其他據點資料
#                                                                     b.料件特性應由單身輸入欄位取得
#                                           4.axmt500()調整單位/數量有調整時，新增判斷是否要刪除xmdq_t舊值
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
PRIVATE TYPE type_g_xmdq_d        RECORD
       sel LIKE type_t.chr500, 
   xmdqdocno LIKE xmdq_t.xmdqdocno, 
   xmdqseq LIKE xmdq_t.xmdqseq, 
   xmdqseq1 LIKE xmdq_t.xmdqseq1, 
   xmdq012 LIKE xmdq_t.xmdq012, 
   xmdq001 LIKE xmdq_t.xmdq001, 
   xmdq001_desc LIKE type_t.chr500, 
   imaal0041 LIKE type_t.chr500, 
   xmdq010 LIKE xmdq_t.xmdq010, 
   xmdq011 LIKE xmdq_t.xmdq011, 
   xmdq006 LIKE xmdq_t.xmdq006, 
   xmdq007 LIKE xmdq_t.xmdq007, 
   xmdq008 LIKE xmdq_t.xmdq008, 
   xmdq008_desc LIKE type_t.chr500, 
   xmdq009 LIKE xmdq_t.xmdq009, 
   xmdq002 LIKE xmdq_t.xmdq002, 
   xmdq002_desc LIKE type_t.chr500, 
   imaal0042 LIKE type_t.chr500, 
   xmdq004 LIKE xmdq_t.xmdq004, 
   xmdq005 LIKE xmdq_t.xmdq005
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdcdocno  LIKE xmdc_t.xmdcdocno
DEFINE g_xmdcseq    LIKE xmdc_t.xmdcseq
DEFINE g_xmdc001    LIKE xmdc_t.xmdc001      #料件編號
DEFINE g_xmdc011    LIKE xmdc_t.xmdc001      #數量
DEFINE g_xmdcunit   LIKE xmdc_t.xmdcunit     #出貨據點
DEFINE g_imae037    LIKE imae_t.imae037      #預設BOM特性


DEFINE g_tmp_d   DYNAMIC ARRAY OF RECORD
   sel       LIKE type_t.num5,
   xmdqdocno LIKE xmdq_t.xmdqdocno, 
   xmdqseq   LIKE xmdq_t.xmdqseq, 
   xmdqseq1  LIKE xmdq_t.xmdqseq1, 
   xmdq001   LIKE xmdq_t.xmdq001, 
   xmdq010   LIKE xmdq_t.xmdq010, 
   xmdq011   LIKE xmdq_t.xmdq011, 
   xmdq006   LIKE xmdq_t.xmdq006, 
   xmdq007   LIKE xmdq_t.xmdq007, 
   xmdq008   LIKE xmdq_t.xmdq008, 
   xmdq009   LIKE xmdq_t.xmdq009, 
   xmdq002   LIKE xmdq_t.xmdq002, 
   xmdq004   LIKE xmdq_t.xmdq004, 
   xmdq005   LIKE xmdq_t.xmdq005
       END RECORD
#end add-point
 
DEFINE g_xmdq_d          DYNAMIC ARRAY OF type_g_xmdq_d
DEFINE g_xmdq_d_t        type_g_xmdq_d
 
 
DEFINE g_xmdqdocno_t   LIKE xmdq_t.xmdqdocno    #Key值備份
DEFINE g_xmdqseq_t      LIKE xmdq_t.xmdqseq    #Key值備份
DEFINE g_xmdqseq1_t      LIKE xmdq_t.xmdqseq1    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="axmt500_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt500_05(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdcdocno,p_xmdcseq
   ,p_xmdc001,p_xmdc062,p_xmdc011,p_xmdcunit     #161013-00031#1 add
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
   DEFINE p_xmdcdocno     LIKE xmdc_t.xmdcdocno
   DEFINE p_xmdcseq       LIKE xmdc_t.xmdcseq  
   DEFINE l_forupd_sql    STRING   
   DEFINE l_seq1          LIKE xmdc_t.xmdcseq
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   #161013-00031#1-(S)-add   
   DEFINE p_xmdc001       LIKE xmdc_t.xmdc001
   DEFINE p_xmdc062       LIKE xmdc_t.xmdc062   
   DEFINE p_xmdc011       LIKE xmdc_t.xmdc011   #計價數量   
   DEFINE p_xmdcunit      LIKE xmdc_t.xmdcunit  #出貨據點
   #161013-00031#1-(E)-add   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt500_05 WITH FORM cl_ap_formpath("axm","axmt500_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE 
   
   IF cl_null(p_xmdcdocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_xmdcdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF cl_null(p_xmdcseq) THEN
      #傳入的項次為空！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00279'
      LET g_errparam.extend = p_xmdcseq
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   CALL cl_set_combo_scc_part('xmdq012','2055','4,5')      #子件特性：4可選件 5附屬零件
   LET g_xmdcdocno = p_xmdcdocno
   LET g_xmdcseq = p_xmdcseq 
   #161013-00031#1-(S) add
   LET g_xmdc001 = p_xmdc001  
   LET g_imae037 = p_xmdc062  
   LET g_xmdc011 = p_xmdc011
   LET g_xmdcunit = p_xmdcunit
   IF cl_null(g_xmdc011) THEN LET g_xmdc011 = 0 END IF 
   IF cl_null(g_xmdcunit) THEN LET g_xmdcunit = g_site END IF 
   #161013-00031#1-(E) add
   
   CALL axmt500_05_b_fill() 
    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            DISPLAY l_ac TO FORMONLY.idx 
            LET g_xmdq_d_t.* = g_xmdq_d[l_ac].*             

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            LET g_rec_b = g_xmdq_d.getLength()
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdq006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdq_d[l_ac].xmdq006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdq006
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdq006 name="input.a.page1.xmdq006"
            IF NOT cl_null(g_xmdq_d[l_ac].xmdq006) AND (g_xmdq_d[l_ac].xmdq006 <> g_xmdq_d_t.xmdq006) THEN 
               #重新推算數量：數量 * 組成用量 / 主件底數
               LET g_xmdq_d[l_ac].xmdq009 = g_xmdc011 * g_xmdq_d[l_ac].xmdq006 / g_xmdq_d[l_ac].xmdq007
               LET g_xmdq_d_t.xmdq006 = g_xmdq_d[l_ac].xmdq006
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdq006
            #add-point:BEFORE FIELD xmdq006 name="input.b.page1.xmdq006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdq006
            #add-point:ON CHANGE xmdq006 name="input.g.page1.xmdq006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdq007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdq_d[l_ac].xmdq007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdq007
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdq007 name="input.a.page1.xmdq007"
            IF NOT cl_null(g_xmdq_d[l_ac].xmdq007) AND (g_xmdq_d[l_ac].xmdq007 <> g_xmdq_d_t.xmdq007) THEN 
               #重新推算數量：數量 * 組成用量 / 主件底數
               LET g_xmdq_d[l_ac].xmdq009 = g_xmdc011 * g_xmdq_d[l_ac].xmdq006 / g_xmdq_d[l_ac].xmdq007
               LET g_xmdq_d_t.xmdq007 = g_xmdq_d[l_ac].xmdq007               
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdq007
            #add-point:BEFORE FIELD xmdq007 name="input.b.page1.xmdq007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdq007
            #add-point:ON CHANGE xmdq007 name="input.g.page1.xmdq007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdq006
            #add-point:ON ACTION controlp INFIELD xmdq006 name="input.c.page1.xmdq006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdq007
            #add-point:ON ACTION controlp INFIELD xmdq007 name="input.c.page1.xmdq007"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               EXIT DIALOG
            ELSE          
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt
                FROM xmdq_t 
               WHERE xmdqent = g_enterprise
                 AND xmdqdocno = g_xmdcdocno
                 AND xmdqseq = g_xmdcseq
              IF l_cnt > 0 THEN
                 DELETE FROM xmdq_t
                  WHERE xmdqent = g_enterprise
                    AND xmdqdocno = g_xmdcdocno
                    AND xmdqseq = g_xmdcseq
              END IF

              FOR i = 1 TO g_xmdq_d.getLength() 
                  IF g_xmdq_d[i].sel = 'N' THEN
                     CONTINUE FOR
                  END IF
 
                  IF g_xmdq_d[i].sel = 'Y' THEN
                     SELECT MAX(xmdqseq1) + 1 
                       INTO l_seq1 FROM xmdq_t
                      WHERE xmdqent = g_enterprise
                        AND xmdqdocno = g_xmdcdocno
                        AND xmdqseq = g_xmdcseq
                     IF cl_null(l_seq1) OR l_seq1 = 0 THEN
                        LET l_seq1 = 1
                     END IF                            
                     INSERT INTO xmdq_t (xmdqent,xmdqsite,xmdqdocno,xmdqseq,xmdqseq1,
                                         xmdq001,xmdq002,xmdq004,xmdq005,xmdq006,
                                         xmdq007,xmdq008,xmdq009,xmdq010,xmdq011,
                                         xmdq012)
                            VALUES (g_enterprise,g_site,g_xmdcdocno,g_xmdcseq,l_seq1,
                                    g_xmdq_d[i].xmdq001,g_xmdq_d[i].xmdq002,g_xmdq_d[i].xmdq004,g_xmdq_d[i].xmdq005,g_xmdq_d[i].xmdq006,
                                    g_xmdq_d[i].xmdq007,g_xmdq_d[i].xmdq008,g_xmdq_d[i].xmdq009,g_xmdq_d[i].xmdq010,g_xmdq_d[i].xmdq011,
                                    g_xmdq_d[i].xmdq012) 
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "xmdq_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET r_success = FALSE
                        CONTINUE DIALOG                       
                      ELSE                        
                        ERROR 'INSERT O.K'                     
                      END IF     
                  END IF
              END FOR             
            END IF              
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axmt500_05 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = 0
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt500_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt500_05.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt500_05_b_fill()
DEFINE l_sql      STRING
DEFINE i          LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_bmba020  LIKE bmba_t.bmba020    #可選件
DEFINE l_bmba025  LIKE bmba_t.bmba025    #附屬零件
DEFINE l_xmdq006  LIKE xmdq_t.xmdq006
DEFINE l_xmdq007  LIKE xmdq_t.xmdq007

   #161013-00031#1-(S)-mark
   #改由axmt500單身畫面取得資料
   #抓取此訂單項次料號、數量、出貨據點
   #SELECT xmdc001,xmdc011,xmdcunit 
   #  INTO g_xmdc001,g_xmdc011,g_xmdcunit 
   #  FROM xmdc_t 
   # WHERE xmdcent = g_enterprise
   #   AND xmdcdocno = g_xmdcdocno
   #   AND xmdcseq = g_xmdcseq
   #IF cl_null(g_xmdcunit) THEN LET g_xmdcunit = g_site END IF 
   #
   #抓取料件特性   
   #SELECT imae037 INTO g_imae037 FROM imae_t
   # WHERE imaeent = g_enterprise
   #   AND imaesite = g_site
   #   AND imae001 = g_xmdc001
   #161013-00031#1-(E)-mark
      
          
   LET l_sql = "SELECT bmba003,bmba011,bmba012,bmba010,bmba001,bmba007,bmba008,bmba020,bmba025 FROM ( ",  
              #"   SELECT bmba003,bmba011,bmba012,bmba010,bmba001,bmba007,bmba008,bmba020,bmba025 FROM bmaa_t,bmba_t ",           #161013-00031#1 mark
               "   SELECT DISTINCT bmba003,bmba011,bmba012,bmba010,bmba001,bmba007,bmba008,bmba020,bmba025 FROM bmaa_t,bmba_t ",  #161013-00031#1 add
               "    WHERE bmaa001 = bmba001 AND bmaa002 = bmba002 ",
               "      AND bmaaent = bmbaent AND bmaasite = bmbasite ",
               "      AND bmba005 <= SYSDATE ",    
               "      AND (bmba006 >= SYSDATE OR bmba006 IS NULL) ",
               "   Connect by bmba001 = prior bmba003  AND bmba002 = prior bmba002 ",
               "              AND bmbasite = prior bmbasite ",     #161013-00031#1 add
               "   Start with bmaa001 = '",g_xmdc001,"' ",
               "          AND bmaa002 = '",g_imae037,"' ",
               "          AND bmbasite = '",g_xmdcunit,"' ",
               "   ) ", 
               " WHERE (bmba025 = 'Y' OR bmba020 = 'Y') "   
   PREPARE axmt500_sel FROM l_sql
   DECLARE b_fill_curs CURSOR FOR axmt500_sel
   CALL g_xmdq_d.clear()
   
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_xmdq_d[l_ac].xmdq001,g_xmdq_d[l_ac].xmdq010,g_xmdq_d[l_ac].xmdq011,g_xmdq_d[l_ac].xmdq008,
                            g_xmdq_d[l_ac].xmdq002,g_xmdq_d[l_ac].xmdq004,g_xmdq_d[l_ac].xmdq005,l_bmba020,l_bmba025
                            
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           EXIT FOREACH
        END IF
      
        LET g_xmdq_d[l_ac].sel = 'N'
        IF l_bmba020 = 'Y' AND l_bmba025 = 'Y' THEN
           LET g_xmdq_d[l_ac].xmdq012 = '4'
        ELSE
           IF l_bmba020 = 'Y'  THEN
              LET g_xmdq_d[l_ac].xmdq012 = '4'
           ELSE
              IF l_bmba025 = 'Y' THEN
                 LET g_xmdq_d[l_ac].xmdq012 = '5'
              END IF
           END IF
        END IF
        LET g_xmdq_d[l_ac].xmdqdocno = g_xmdcdocno
        LET g_xmdq_d[l_ac].xmdqseq = g_xmdcseq
        LET g_xmdq_d[l_ac].xmdqseq1 = l_ac
        LET g_xmdq_d[l_ac].xmdq006 = g_xmdq_d[l_ac].xmdq010 
        LET g_xmdq_d[l_ac].xmdq007 = g_xmdq_d[l_ac].xmdq011 
        
        # [C:數量] = 訂單數量*標準組成用量/標準主件底數
        LET g_xmdq_d[l_ac].xmdq009 = g_xmdc011 * g_xmdq_d[l_ac].xmdq010 / g_xmdq_d[l_ac].xmdq011
        
        CALL axmt500_05_xmdq001_ref(g_xmdq_d[l_ac].xmdq001) RETURNING g_xmdq_d[l_ac].xmdq001_desc,g_xmdq_d[l_ac].imaal0041
        CALL axmt500_05_xmdq001_ref(g_xmdq_d[l_ac].xmdq002) RETURNING g_xmdq_d[l_ac].xmdq002_desc,g_xmdq_d[l_ac].imaal0042
        CALL axmt500_05_unit_ref(g_xmdq_d[l_ac].xmdq008) RETURNING g_xmdq_d[l_ac].xmdq008_desc       
        LET l_ac = l_ac + 1       
   END FOREACH
   CALL g_xmdq_d.deleteElement(g_xmdq_d.getLength())
   LET g_rec_b = l_ac - 1   
 

   DISPLAY g_max_rec TO FORMONLY.h_count

   CLOSE b_fill_curs
   FREE axmt500_sel
   
   #判斷是否有維護過屬零件/可選件
   FOR i = 1 TO g_xmdq_d.getLength()  
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM xmdq_t
        WHERE xmdqent = g_enterprise
          AND xmdqdocno = g_xmdcdocno
          AND xmdqseq = g_xmdcseq
          AND xmdq001 = g_xmdq_d[i].xmdq001
          AND xmdq002 = g_xmdq_d[i].xmdq002
       IF l_cnt > 0 THEN
          LET g_xmdq_d[i].sel = 'Y'
          SELECT xmdq006,xmdq007
            INTO g_xmdq_d[i].xmdq006,g_xmdq_d[i].xmdq007       
            FROM xmdq_t
           WHERE xmdqent = g_enterprise
             AND xmdqdocno = g_xmdq_d[i].xmdqdocno
             AND xmdqseq = g_xmdq_d[i].xmdqseq
             AND xmdq001 = g_xmdq_d[i].xmdq001
             AND xmdq002 = g_xmdq_d[i].xmdq002          
       END IF
       
   END FOR
      
END FUNCTION
#單位名稱顯示
PRIVATE FUNCTION axmt500_05_unit_ref(p_xmdq008)
DEFINE p_xmdq008      LIKE xmdq_t.xmdq008
DEFINE r_xmdq008_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdq008
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_xmdq008_desc = '', g_rtn_fields[1] , ''
       RETURN r_xmdq008_desc
END FUNCTION
#品名、規格說明
PRIVATE FUNCTION axmt500_05_xmdq001_ref(p_xmdq001)
DEFINE p_xmdq001     LIKE xmdq_t.xmdq001
DEFINE r_imaal003    LIKE imaal_t.imaal003
DEFINE r_imaal004    LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdq001
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields 
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
END FUNCTION

 
{</section>}
 
