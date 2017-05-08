#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt500_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-06-27 18:50:43), PR版次:0006(2016-08-16 16:54:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000157
#+ Filename...: adbt500_02
#+ Description: 維護訂單備置作業
#+ Creator....: 02748(2014-05-22 15:59:38)
#+ Modifier...: 02748 -SD/PR- 08742
 
{</section>}
 
{<section id="adbt500_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#6  160321 By Jessy 修正azzi920重複定義之錯誤訊息
#160816-00001#2  16/08/16 By 08742     抓取理由碼改CALL sub
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
PRIVATE TYPE type_g_xmdd_d        RECORD
       xmddsite LIKE xmdd_t.xmddsite, 
   xmdddocno LIKE xmdd_t.xmdddocno, 
   xmddseq LIKE xmdd_t.xmddseq, 
   xmddseq2 LIKE xmdd_t.xmddseq2, 
   xmddseq1 LIKE xmdd_t.xmddseq1, 
   xmdd001 LIKE xmdd_t.xmdd001, 
   xmdd001_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   xmdd002 LIKE xmdd_t.xmdd002, 
   xmdd004 LIKE xmdd_t.xmdd004, 
   xmdd004_desc LIKE type_t.chr500, 
   xmdd006 LIKE xmdd_t.xmdd006, 
   xmdd014 LIKE xmdd_t.xmdd014, 
   xmdd015 LIKE xmdd_t.xmdd015, 
   xmdd032 LIKE xmdd_t.xmdd032, 
   xmdd033 LIKE xmdd_t.xmdd033, 
   xmdd033_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmdd2_d RECORD
       xmdrdocno LIKE xmdr_t.xmdrdocno, 
   xmdrseq LIKE xmdr_t.xmdrseq, 
   xmdrseq1 LIKE xmdr_t.xmdrseq1, 
   xmdrseq2 LIKE xmdr_t.xmdrseq2, 
   xmdr001 LIKE xmdr_t.xmdr001, 
   xmdr002 LIKE xmdr_t.xmdr002, 
   xmdr004 LIKE xmdr_t.xmdr004, 
   xmdr004_desc LIKE type_t.chr500, 
   xmdr005 LIKE xmdr_t.xmdr005, 
   xmdr005_desc LIKE type_t.chr500, 
   xmdr003 LIKE xmdr_t.xmdr003, 
   xmdr006 LIKE xmdr_t.xmdr006, 
   xmdr007 LIKE xmdr_t.xmdr007, 
   xmdr007_desc LIKE type_t.chr500, 
   xmdr008 LIKE xmdr_t.xmdr008, 
   xmdr009 LIKE xmdr_t.xmdr009
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdadocno     LIKE xmda_t.xmdadocno
DEFINE g_xmdddocno     LIKE xmdd_t.xmdddocno
DEFINE g_xmddsite      LIKE xmdd_t.xmddsite
DEFINE g_xmddseq       LIKE xmdd_t.xmddseq
DEFINE g_xmddseq1      LIKE xmdd_t.xmddseq1
DEFINE g_xmddseq2      LIKE xmdd_t.xmddseq2
DEFINE g_xmdd001       LIKE xmdd_t.xmdd001
DEFINE g_xmdd002       LIKE xmdd_t.xmdd002
DEFINE g_imaf058       LIKE imaf_t.imaf058      #存貨備置作業
DEFINE g_acc           LIKE gzcb_t.gzcb007     
DEFINE g_success       LIKE type_t.num5
DEFINE g_type          LIKE type_t.num5      #1軟備置2硬備置

DEFINE g_xmdr        DYNAMIC ARRAY OF RECORD     #已勾選的備置
       xmdr008          LIKE xmdr_t.xmdr008,
       xmdr009          LIKE xmdr_t.xmdr009,
       xmdr010          LIKE xmdr_t.xmdr010,
       xmdr004          LIKE xmdr_t.xmdr004, 
       xmdr005          LIKE xmdr_t.xmdr005,
       xmdr003          LIKE xmdr_t.xmdr003,
       xmdr006          LIKE xmdr_t.xmdr006,
       xmdr007          LIKE xmdr_t.xmdr007
                     END RECORD
#end add-point
 
DEFINE g_xmdd_d          DYNAMIC ARRAY OF type_g_xmdd_d
DEFINE g_xmdd_d_t        type_g_xmdd_d
DEFINE g_xmdd2_d   DYNAMIC ARRAY OF type_g_xmdd2_d
DEFINE g_xmdd2_d_t type_g_xmdd2_d
 
 
DEFINE g_xmdddocno_t   LIKE xmdd_t.xmdddocno    #Key值備份
DEFINE g_xmddseq_t      LIKE xmdd_t.xmddseq    #Key值備份
DEFINE g_xmddseq1_t      LIKE xmdd_t.xmddseq1    #Key值備份
DEFINE g_xmddseq2_t      LIKE xmdd_t.xmddseq2    #Key值備份
 
 
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
 
{<section id="adbt500_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION adbt500_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdadocno
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
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE r_success       LIKE type_t.num5   
   DEFINE l_forupd_sql    STRING   
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_xmdr009       LIKE xmdr_t.xmdr009
   DEFINE l_inag008       LIKE inag_t.inag008
   DEFINE l_inan010       LIKE inan_t.inan010
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adbt500_02 WITH FORM cl_ap_formpath("adb","adbt500_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET g_success = TRUE
   
   IF cl_null(p_xmdadocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'sub-00228'  #160318-00005#6 mark
      LET g_errparam.code = 'sub-01320'   #160318-00005#6 add
      LET g_errparam.extend = p_xmdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL s_transaction_begin()
   LET g_xmdadocno = p_xmdadocno


   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog  #160816-00001#2  mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')   #160816-00001#2  Add
   
   CALL adbt500_02_b_fill() 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            LET g_xmddsite = g_xmdd_d[l_ac].xmddsite
            LET g_xmdddocno = g_xmdd_d[l_ac].xmdddocno
            LET g_xmddseq = g_xmdd_d[l_ac].xmddseq
            LET g_xmddseq1 = g_xmdd_d[l_ac].xmddseq1
            LET g_xmddseq2 = g_xmdd_d[l_ac].xmddseq2
            LET g_xmdd001 = g_xmdd_d[l_ac].xmdd001
            LET g_xmdd002 = g_xmdd_d[l_ac].xmdd002
            LET g_xmdd_d_t.* = g_xmdd_d[l_ac].*          #BACKUP
            LET g_type = 1
            #抓取存貨備罝
            CALL adbt500_02_get_imaf058()
            CALL adbt500_02_set_entry()
            CALL adbt500_02_set_no_entry()
            
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_xmdd_d.getLength() TO FORMONLY.h_count
            CALL adbt500_02_fetch()
            
         AFTER ROW   
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0               
               EXIT DIALOG
            END IF       
            IF (g_xmdd_d[l_ac].xmdd032 > 0 AND (g_xmdd_d[l_ac].xmdd032 <> g_xmdd_d_t.xmdd032)) OR g_type = 2 THEN
               UPDATE xmdd_t 
                  SET xmdd032 = g_xmdd_d[l_ac].xmdd032,
                      xmdd033 = g_xmdd_d[l_ac].xmdd033
                WHERE xmddent = g_enterprise
                  AND xmdddocno = g_xmdd_d[l_ac].xmdddocno
                  AND xmddseq = g_xmdd_d[l_ac].xmddseq
                  AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1
                  AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmdd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xmdd_d[l_ac].* = g_xmdd_d_t.*
                  LET g_success = FALSE  
                  EXIT DIALOG
               ELSE
                  IF NOT adbt500_02_gen_xmdr() THEN
                     LET g_success = FALSE
                     EXIT DIALOG
                  END IF
               END IF                       
            END IF
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdd032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdd_d[l_ac].xmdd032,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdd032
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdd032 name="input.a.page1.xmdd032"

            IF NOT cl_null(g_xmdd_d[l_ac].xmdd032) THEN 
               IF g_xmdd_d[l_ac].xmdd032 > 0 AND g_xmdd_d[l_ac].xmdd032 <> g_xmdd_d_t.xmdd032 THEN
                  #備置量不可以大於訂單量-已出貨量+已銷退量  
                  IF g_xmdd_d[l_ac].xmdd032 > g_xmdd_d[l_ac].xmdd006 - g_xmdd_d[l_ac].xmdd014 + g_xmdd_d[l_ac].xmdd015 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00310'
                      LET g_errparam.extend = ""
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_xmdd_d[l_ac].xmdd032 = g_xmdd_d_t.xmdd032
                      DISPLAY BY NAME g_xmdd_d[l_ac].xmdd032
                      NEXT FIELD xmdd032
                  END IF
                  #備置量不可小於備置已沖銷量  
                  LET l_xmdr009 = 0
                  SELECT SUM(xmdr009) INTO l_xmdr009
                    FROM xmdr_t
                   WHERE xmdrent = g_enterprise
                     AND xmdrsite = g_xmddsite
                     AND xmdrdocno = g_xmdddocno
                     AND xmdrseq = g_xmddseq
                     AND xmdrseq1 = g_xmddseq1
                     AND xmdrseq2 = g_xmddseq2
                  IF cl_null(l_xmdr009) THEN LET l_xmdr009 = 0 END IF
                  IF l_xmdr009 > 0 THEN
                     IF g_xmdd_d[l_ac].xmdd032 < l_xmdr009 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00296'
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xmdd_d[l_ac].xmdd032 = g_xmdd_d_t.xmdd032
                        DISPLAY BY NAME g_xmdd_d[l_ac].xmdd032                        
                        NEXT FIELD xmdd032                     
                     END IF
                  END IF
                  IF g_imaf058 = '1' THEN
                     #該料的總庫存量(inag010='Y')
                     LET l_inag008= 0
                     SELECT inag008 INTO l_inag008
                       FROM inag_t 
                      WHERE inagent = g_enterprise
                        AND inagsite = g_xmddsite
                        AND inag001 = g_xmdd001
                        AND inag002 = g_xmdd002       
                        AND inag010 = 'Y'
                        
                     IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
                     #已在揀量inan010+已備置量inan010
                     LET l_inan010 = 0
                     SELECT SUM(inan010) INTO l_inan010
                       FROM inan_t
                      WHERE inanent = g_enterprise
                        AND inansite = g_xmddsite
                        AND inan001 = g_xmdd001
                        AND inan002 = g_xmdd002       

                     IF cl_null(l_inan010) THEN LET l_inan010 = 0 END IF
                     #庫存量(inag008)-已在揀量inan010-已備置量inan010        
                     IF g_xmdd_d[l_ac].xmdd032 > l_inag008 - l_inan010 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00306'
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xmdd_d[l_ac].xmdd032 = g_xmdd_d_t.xmdd032
                        DISPLAY BY NAME g_xmdd_d[l_ac].xmdd032                        
                        NEXT FIELD xmdd032
                     END IF
                  END IF
                  IF g_imaf058 = '2' THEN
                     CALL g_xmdr.clear()
                     CALL adbt500_06(g_xmdd_d[l_ac].xmddsite,g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd032)
                          RETURNING r_success,g_xmdr 
                     IF NOT r_success THEN
                        LET g_xmdd_d[l_ac].xmdd032 = g_xmdd_d_t.xmdd032
                        DISPLAY BY NAME g_xmdd_d[l_ac].xmdd032                        
                        NEXT FIELD xmdd032
                     ELSE
                        LET g_type = 2                        
                     END IF                             
                  END IF

               END IF
            END IF 
            CALL adbt500_02_set_entry()
            CALL adbt500_02_set_no_entry()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdd032
            #add-point:BEFORE FIELD xmdd032 name="input.b.page1.xmdd032"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdd032
            #add-point:ON CHANGE xmdd032 name="input.g.page1.xmdd032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdd033
            
            #add-point:AFTER FIELD xmdd033 name="input.a.page1.xmdd033"
           #IF NOT cl_null(g_xmdd_d[l_ac].xmdd033) THEN 
           #   IF NOT s_azzi650_chk_exist(g_acc,g_xmdd_d[l_ac].xmdd033) THEN
           #      NEXT FIELD xmdd033
           #   END IF
           #END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdd033
            #add-point:BEFORE FIELD xmdd033 name="input.b.page1.xmdd033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdd033
            #add-point:ON CHANGE xmdd033 name="input.g.page1.xmdd033"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdd032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdd032
            #add-point:ON ACTION controlp INFIELD xmdd032 name="input.c.page1.xmdd032"
            IF g_imaf058 <> '1' AND g_xmdd_d[l_ac].xmdd032 > 0 THEN
               CALL adbt500_06(g_xmdd_d[l_ac].xmddsite,g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd032)
                    RETURNING r_success,g_xmdr
               IF NOT r_success THEN
                  LET g_xmdd_d[l_ac].xmdd032 = g_xmdd_d_t.xmdd032
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd032                        
                  NEXT FIELD xmdd032  
               ELSE
                  LET g_type = 2                        
               END IF 
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdd033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdd033
            #add-point:ON ACTION controlp INFIELD xmdd033 name="input.c.page1.xmdd033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdd_d[l_ac].xmdd033                #給予default值
            #給予arg
            LET g_qryparam.arg1 = "307" 
            CALL q_oocq002()                                                #呼叫開窗
            LET g_xmdd_d[l_ac].xmdd033 = g_qryparam.return1                 #將開窗取得的值回傳到變數
            DISPLAY g_xmdd_d[l_ac].xmdd033 TO xmdd033                       #顯示到畫面上

            CALL s_desc_get_acc_desc('307',g_xmdd_d[l_ac].xmdd033) RETURNING g_xmdd_d[l_ac].xmdd033_desc
            DISPLAY BY NAME g_xmdd_d[l_ac].xmdd033_desc
            NEXT FIELD xmdd033                                              #返回原欄位       
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               LET g_success = FALSE
               EXIT DIALOG
            END IF

            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_xmdd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_xmdd2_d.getLength() TO FORMONLY.h_count
            
         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_xmdd2_d.getLength() TO FORMONLY.h_count
      END DISPLAY 
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
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET INT_FLAG = 0
      LET g_success = FALSE
   END IF
   IF g_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_adbt500_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adbt500_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adbt500_02.other_function" readonly="Y" >}

PRIVATE FUNCTION adbt500_02_b_fill()
DEFINE l_sql      STRING
DEFINE l_ac       LIKE type_t.num5


   LET l_sql = "SELECT xmddsite,xmdddocno,xmddseq,xmddseq2,xmddseq1,xmdd001, ",
               "       '','',xmdd002,xmdd004,'', ",
               "       xmdd006,xmdd014,xmdd015,xmdd032,xmdd033 ",
               "  FROM xmdd_t ",
               " WHERE xmddent = '",g_enterprise,"' ",
               "   AND xmdddocno = '",g_xmdadocno,"' "

   PREPARE adbt500_sel FROM l_sql
   DECLARE b_fill_curs CURSOR FOR adbt500_sel
   CALL g_xmdd_d.clear()
   
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_xmdd_d[l_ac].*
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           EXIT FOREACH
        END IF
        IF cl_null(g_xmdd_d[l_ac].xmdd032) THEN LET g_xmdd_d[l_ac].xmdd032 = 0 END IF
        CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001)RETURNING g_xmdd_d[l_ac].xmdd001_desc,g_xmdd_d[l_ac].imaal004
        CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc        
        CALL s_desc_get_acc_desc('307',g_xmdd_d[l_ac].xmdd033) RETURNING g_xmdd_d[l_ac].xmdd033_desc        
        LET l_ac = l_ac + 1
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  9035
           LET g_errparam.extend =  ''
           LET g_errparam.popup = FALSE
           CALL cl_err()

           EXIT FOREACH
        END IF        
   END FOREACH
   CALL g_xmdd_d.deleteElement(g_xmdd_d.getLength())
   LET g_rec_b = l_ac - 1  

   CLOSE b_fill_curs
   FREE adbt500_sel
   
END FUNCTION

PRIVATE FUNCTION adbt500_02_fetch()
DEFINE l_sql      STRING
DEFINE l_ac       LIKE type_t.num5
   
   INITIALIZE g_xmdd2_d TO NULL
   
   LET l_sql = " SELECT xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001, ",
               "        xmdr002,xmdr004,'',xmdr005,'', ",
               "        xmdr003,xmdr006,xmdr007,'',xmdr008, ",
               "        xmdr009 ",
               "   FROM xmdr_t ",
               "  WHERE xmdrent = '",g_enterprise,"' ",
               "    AND xmdrdocno = '",g_xmdddocno,"' ",
               "    AND xmdrseq = '",g_xmddseq,"' ",
               "    AND xmdrseq1 = '",g_xmddseq1,"' ",
               "    AND xmdrseq2 = '",g_xmddseq2,"' "
   PREPARE adbt500_xmdr_sel FROM l_sql
   DECLARE adbt500_xmdr_per CURSOR FOR adbt500_xmdr_sel       

   LET l_ac = 1
   FOREACH adbt500_xmdr_per INTO g_xmdd2_d[l_ac].*
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           EXIT FOREACH
        END IF
        CALL s_desc_get_stock_desc(g_xmddsite,g_xmdd2_d[l_ac].xmdr004) RETURNING g_xmdd2_d[l_ac].xmdr004_desc
        CALL s_desc_get_locator_desc(g_xmddsite,g_xmdd2_d[l_ac].xmdr004,g_xmdd2_d[l_ac].xmdr005) RETURNING g_xmdd2_d[l_ac].xmdr005_desc
        CALL s_desc_get_unit_desc(g_xmdd2_d[l_ac].xmdr007) RETURNING g_xmdd2_d[l_ac].xmdr007_desc
        LET l_ac = l_ac + 1
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  9035
           LET g_errparam.extend =  ''
           LET g_errparam.popup = FALSE
           CALL cl_err()

           EXIT FOREACH
        END IF        
   END FOREACH
   CALL g_xmdd2_d.deleteElement(g_xmdd2_d.getLength())
   LET g_rec_b = l_ac - 1  
   CLOSE adbt500_xmdr_per
   FREE adbt500_xmdr_sel
   
END FUNCTION

PRIVATE FUNCTION adbt500_02_set_entry()

      CALL cl_set_comp_entry("xmdd032,xmdd033",TRUE)
END FUNCTION

PRIVATE FUNCTION adbt500_02_set_no_entry()
      
      IF g_imaf058 = '3' THEN    #等候需求模式
         CALL cl_set_comp_entry("xmdd032",FALSE)
      END IF
      IF g_xmdd_d[l_ac].xmdd032 <= 0 THEN
         CALL cl_set_comp_entry("xmdd033",FALSE)
      END IF
END FUNCTION
#取得存貨備置
PRIVATE FUNCTION adbt500_02_get_imaf058()
DEFINE l_xmdd001 LIKE xmdd_t.xmdd011   #料件編號

   LET g_imaf058 = ''
   SELECT imaf058 INTO g_imaf058
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL' #g_xmddsite
      AND imaf001 = g_xmdd001  

END FUNCTION
#產生訂單備置明細檔
PRIVATE FUNCTION adbt500_02_gen_xmdr()
DEFINE p_xmdrdocno       LIKE xmdr_t.xmdrdocno
DEFINE p_xmdrseq         LIKE xmdr_t.xmdrseq
DEFINE p_xmdrseq1        LIKE xmdr_t.xmdrseq1
DEFINE p_xmdrseq2        LIKE xmdr_t.xmdrseq2
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_cnt1            LIKE type_t.num5
DEFINE i                 LIKE type_t.num5


   LET r_success = TRUE 
      
   LET l_cnt = 0   
   SELECT COUNT(*) INTO l_cnt
     FROM xmdr_t
    WHERE xmdrent = g_enterprise
      AND xmdrsite = g_xmddsite
      AND xmdrdocno = g_xmdddocno
      AND xmdrseq = g_xmddseq
      AND xmdrseq1 = g_xmddseq1
      AND xmdrseq2 = g_xmddseq2  
      
   IF g_type = 1 THEN 
      IF l_cnt = 0 THEN
         #庫存管理特徵、庫位、儲位、批號、庫存單位均為空白，已沖銷庫存量為0
         INSERT INTO xmdr_t (xmdrent,xmdrsite,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdr007,xmdr008,xmdr009,xmdr010)
           VALUES (g_enterprise,g_xmddsite,g_xmdddocno,g_xmddseq,g_xmddseq1,g_xmddseq2,g_xmdd001,g_xmdd002,' ',' ',' ',' ',' ',g_xmdd_d[l_ac].xmdd032,0,g_xmdd_d[l_ac].xmdd004)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT xmdr"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE  
            RETURN r_success 
         ELSE
         #呼叫'更新庫存備置量'應用元件更新存統計量      
         END IF        
      ELSE
         UPDATE xmdr_t 
            SET xmdr008 = g_xmdd_d[l_ac].xmdd032
          WHERE xmdrent = g_enterprise
            AND xmdrsite = g_xmddsite
            AND xmdrdocno = g_xmdddocno
            AND xmdrseq = g_xmddseq
            AND xmdrseq1 = g_xmddseq1
            AND xmdrseq2 = g_xmddseq2 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE xmdr008"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE  
            RETURN r_success 
         ELSE
         #呼叫'更新庫存備置量'應用元件更新存統計量      
         END IF        
      END IF
   ELSE
      IF l_cnt = 0 THEN
         FOR i = 1 TO g_xmdr.getLength()
             INSERT INTO xmdr_t (xmdrent,xmdrsite,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdr007,xmdr008,xmdr009,xmdr010)
               VALUES (g_enterprise,g_xmddsite,g_xmdddocno,g_xmddseq,g_xmddseq1,g_xmddseq2,g_xmdd001,g_xmdd002,g_xmdr[i].xmdr003,g_xmdr[i].xmdr004,g_xmdr[i].xmdr005,g_xmdr[i].xmdr006,g_xmdr[i].xmdr007,g_xmdr[i].xmdr008,g_xmdr[i].xmdr009,g_xmdr[i].xmdr010)
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT xmdr"
            LET g_errparam.popup = TRUE
            CALL cl_err()

                LET r_success = FALSE  
                RETURN r_success 
             ELSE
             #呼叫'更新庫存備置量'應用元件更新存統計量      
             END IF          
         END FOR
      ELSE
        #已沖銷備置量(xmdr009)=0的資料直接刪除
        DELETE FROM xmdr_t
         WHERE xmdrent = g_enterprise
           AND xmdrsite = g_xmddsite
           AND xmdrdocno = g_xmdddocno
           AND xmdrseq = g_xmddseq
           AND xmdrseq1 = g_xmddseq1
           AND xmdrseq2 = g_xmddseq2
           AND xmdr009 = 0          
        FOR i = 1 TO g_xmdr.getLength()
            LET l_cnt1 = 0
            SELECT COUNT(*) INTO l_cnt1
              FROM xmdr_t
             WHERE xmdrent = g_enterprise       AND xmdrsite = g_xmddsite
               AND xmdrdocno = g_xmdddocno      AND xmdrseq = g_xmddseq
               AND xmdrseq1 = g_xmddseq1        AND xmdrseq2 = g_xmddseq2
               AND xmdr001 = g_xmdd001          AND xmdr002 = g_xmdd002
               AND xmdr003 = g_xmdr[i].xmdr003  AND xmdr004 = g_xmdr[i].xmdr004
               AND xmdr005 = g_xmdr[i].xmdr005  AND xmdr006 = g_xmdr[i].xmdr006
               AND xmdr007 = g_xmdr[i].xmdr007
            IF l_cnt1 = 0 THEN
               INSERT INTO xmdr_t (xmdrent,xmdrsite,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdr007,xmdr008,xmdr009,xmdr010)
                 VALUES (g_enterprise,g_xmddsite,g_xmdddocno,g_xmddseq,g_xmddseq1,g_xmddseq2,g_xmdd001,g_xmdd002,g_xmdr[i].xmdr003,g_xmdr[i].xmdr004,g_xmdr[i].xmdr005,g_xmdr[i].xmdr006,g_xmdr[i].xmdr007,g_xmdr[i].xmdr008,g_xmdr[i].xmdr009,g_xmdr[i].xmdr010)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT xmdr"
            LET g_errparam.popup = TRUE
            CALL cl_err()

                  LET r_success = FALSE  
                  RETURN r_success 
               ELSE
               #呼叫'更新庫存備置量'應用元件更新存統計量      
               END IF           
            ELSE
              UPDATE xmdr_t 
                 SET xmdr008 = g_xmdr[i].xmdr008
               WHERE xmdrent = g_enterprise       AND xmdrsite = g_xmddsite
                 AND xmdrdocno = g_xmdddocno      AND xmdrseq = g_xmddseq
                 AND xmdrseq1 = g_xmddseq1        AND xmdrseq2 = g_xmddseq2
                 AND xmdr001 = g_xmdd001          AND xmdr002 = g_xmdd002
                 AND xmdr003 = g_xmdr[i].xmdr003  AND xmdr004 = g_xmdr[i].xmdr004
                 AND xmdr005 = g_xmdr[i].xmdr005  AND xmdr006 = g_xmdr[i].xmdr006
                 AND xmdr007 = g_xmdr[i].xmdr007
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE xmdr008"
            LET g_errparam.popup = TRUE
            CALL cl_err()

                 LET r_success = FALSE  
                 RETURN r_success 
              ELSE
              #呼叫'更新庫存備置量'應用元件更新存統計量      
              END IF                  
            END IF             
        END FOR
      END IF         
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 
