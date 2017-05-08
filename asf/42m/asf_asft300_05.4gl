#該程式未解開Section, 採用最新樣板產出!
{<section id="asft300_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-12-18 17:24:36), PR版次:0010(2016-12-28 17:18:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: asft300_05
#+ Description: 工單備置子作業
#+ Creator....: 05384(2014-12-16 17:15:16)
#+ Modifier...: 05384 -SD/PR- 00768
 
{</section>}
 
{<section id="asft300_05.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160408-00035#2  2016/04/15  By Shiunyo  備置已沖銷完畢，備置量還是可以改掉，應該加判斷修改後數量不可小於備置量-已沖銷備置量
#160816-00001#9  2016/08/17  By 08734    抓取理由碼改CALL sub
#160927-00025#1  2016/10/12  By Whitney  檢核庫存量
#160927-00024#1  2016/10/21  By Whitney  aimm212存货备置策略设置为0系统应不允许备置
#161109-00085#62 2016/11/25  By 08171    整批調整系統星號寫法
#161228-00035#1  2016/12/28  By 00768    解决闪退的问题
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
PRIVATE TYPE type_g_sfba_d        RECORD
       sfbadocno LIKE sfba_t.sfbadocno, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba002_desc LIKE type_t.chr500, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba003_desc LIKE type_t.chr500, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba006_desc LIKE type_t.chr500, 
   sfba006_desc_2 LIKE type_t.chr500, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba021_desc LIKE type_t.chr500, 
   sfba014 LIKE sfba_t.sfba014, 
   sfba014_desc LIKE type_t.chr500, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba031 LIKE sfba_t.sfba031, 
   sfba032 LIKE sfba_t.sfba032, 
   sfba032_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_sfba2_d RECORD
       sfbbdocno LIKE sfbb_t.sfbbdocno, 
   sfbbseq LIKE sfbb_t.sfbbseq, 
   sfbbseq1 LIKE sfbb_t.sfbbseq1, 
   sfbb001 LIKE sfbb_t.sfbb001, 
   sfbb002 LIKE sfbb_t.sfbb002, 
   sfbb002_desc LIKE type_t.chr500, 
   sfbb004 LIKE sfbb_t.sfbb004, 
   sfbb004_desc LIKE type_t.chr500, 
   sfbb005 LIKE sfbb_t.sfbb005, 
   sfbb005_desc LIKE type_t.chr500, 
   sfbb003 LIKE sfbb_t.sfbb003, 
   sfbb006 LIKE sfbb_t.sfbb006, 
   sfbb007 LIKE sfbb_t.sfbb007, 
   sfbb007_desc LIKE type_t.chr500, 
   sfbb008 LIKE sfbb_t.sfbb008, 
   sfbb009 LIKE sfbb_t.sfbb009
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sfaadocno     LIKE sfaa_t.sfaadocno
DEFINE g_sfbadocno     LIKE sfba_t.sfbadocno
DEFINE g_sfbaseq       LIKE sfba_t.sfbaseq
DEFINE g_sfbaseq1      LIKE sfba_t.sfbaseq1
DEFINE g_sfba006       LIKE sfba_t.sfba006
DEFINE g_sfba021       LIKE sfba_t.sfba021
DEFINE g_imaf058       LIKE imaf_t.imaf058      #存貨備置作業
DEFINE g_imaf053       LIKE imaf_t.imaf053      #庫存單位 
DEFINE g_acc           LIKE gzcb_t.gzcb007     
DEFINE g_success       LIKE type_t.num5
DEFINE g_type          LIKE type_t.num5      #1軟備置2硬備置

DEFINE g_sfbb        DYNAMIC ARRAY OF RECORD     #已勾選的備置
       sfbb008          LIKE sfbb_t.sfbb008,
       sfbb009          LIKE sfbb_t.sfbb009,
       sfbb010          LIKE sfbb_t.sfbb010,
       sfbb004          LIKE sfbb_t.sfbb004, 
       sfbb005          LIKE sfbb_t.sfbb005,
       sfbb003          LIKE sfbb_t.sfbb003,
       sfbb006          LIKE sfbb_t.sfbb006,
       sfbb007          LIKE sfbb_t.sfbb007
                     END RECORD

DEFINE g_sfba_d_o        type_g_sfba_d  #160927-00025#1

#end add-point
 
DEFINE g_sfba_d          DYNAMIC ARRAY OF type_g_sfba_d
DEFINE g_sfba_d_t        type_g_sfba_d
DEFINE g_sfba2_d   DYNAMIC ARRAY OF type_g_sfba2_d
DEFINE g_sfba2_d_t type_g_sfba2_d
 
 
DEFINE g_sfbadocno_t   LIKE sfba_t.sfbadocno    #Key值備份
DEFINE g_sfbaseq_t      LIKE sfba_t.sfbaseq    #Key值備份
DEFINE g_sfbaseq1_t      LIKE sfba_t.sfbaseq1    #Key值備份
 
 
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
 
{<section id="asft300_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft300_05(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_sfaadocno
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
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE r_success       LIKE type_t.num5   
   DEFINE l_forupd_sql    STRING   
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft300_05 WITH FORM cl_ap_formpath("asf","asft300_05")
 
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
   
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("sfba021,sfba021_desc",FALSE)
   END IF 

   
   IF cl_null(p_sfaadocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_sfaadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL s_transaction_begin()
   LET g_sfaadocno = p_sfaadocno


   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog  #160816-00001#9  2016/08/17  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#9  2016/08/17  By 08734 add
   
   CALL asft300_05_b_fill() 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_sfba_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            LET g_sfbadocno = g_sfba_d[l_ac].sfbadocno
            LET g_sfbaseq = g_sfba_d[l_ac].sfbaseq
            LET g_sfbaseq1 = g_sfba_d[l_ac].sfbaseq1
            LET g_sfba006 = g_sfba_d[l_ac].sfba006
            LET g_sfba021 = g_sfba_d[l_ac].sfba021
            LET g_sfba_d_t.* = g_sfba_d[l_ac].*          #BACKUP
            LET g_type = 1
            #抓取存貨備罝
            CALL asft300_05_get_imaf058()
            CALL asft300_05_set_entry()
            CALL asft300_05_set_no_entry()
            
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_sfba_d.getLength() TO FORMONLY.cnt
            CALL asft300_05_fetch()
            LET g_sfba_d_o.* = g_sfba_d[l_ac].*  #160927-00025#1
            
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

            IF ( g_sfba_d[l_ac].sfba031 >= 0 AND 
                (g_sfba_d[l_ac].sfba031 <> g_sfba_d_t.sfba031 OR g_sfba_d[l_ac].sfba032 <> g_sfba_d_t.sfba032) ) OR 
                g_type = 2 THEN  

       
               UPDATE sfba_t 
                  SET sfba031 = g_sfba_d[l_ac].sfba031,
                      sfba032 = g_sfba_d[l_ac].sfba032
                WHERE sfbaent = g_enterprise
                  AND sfbadocno = g_sfba_d[l_ac].sfbadocno
                  AND sfbaseq = g_sfba_d[l_ac].sfbaseq
                  AND sfbaseq1 = g_sfba_d[l_ac].sfbaseq1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "sfba_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sfba_d[l_ac].* = g_sfba_d_t.*
                  LET g_success = FALSE  
                  EXIT DIALOG

              ELSE
                 IF NOT asft300_05_gen_sfbb() THEN
                    LET g_success = FALSE
                    EXIT DIALOG
                 END IF     
         
               END IF                       
            END IF
            CALL asft300_05_fetch()           
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfba031
            #add-point:BEFORE FIELD sfba031 name="input.b.page1.sfba031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfba031
            
            #add-point:AFTER FIELD sfba031 name="input.a.page1.sfba031"
            #160927-00025#1-s
            IF NOT cl_null(g_sfba_d[l_ac].sfba031) THEN
               IF cl_null(g_sfba_d_o.sfba031) OR g_sfba_d[l_ac].sfba031 != g_sfba_d_o.sfba031 THEN
                  IF NOT asft300_05_sfba031_chk() THEN
                     LET g_sfba_d[l_ac].sfba031 = g_sfba_d_o.sfba031
                     NEXT FIELD sfba031
                  END IF
               END IF
            END IF
            LET g_sfba_d_o.sfba031 = g_sfba_d[l_ac].sfba031
            #160927-00025#1-e
            CALL asft300_05_set_entry()
            CALL asft300_05_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfba031
            #add-point:ON CHANGE sfba031 name="input.g.page1.sfba031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfba032
            
            #add-point:AFTER FIELD sfba032 name="input.a.page1.sfba032"
            LET g_sfba_d[l_ac].sfba032_desc = ''
            IF NOT cl_null(g_sfba_d[l_ac].sfba032) THEN
               IF cl_null(g_sfba_d_o.sfba032) OR g_sfba_d[l_ac].sfba032 != g_sfba_d_o.sfba032 THEN
                  IF NOT s_azzi650_chk_exist('307',g_sfba_d[l_ac].sfba032) THEN
                     LET g_sfba_d[l_ac].sfba032 = g_sfba_d_o.sfba032
                     CALL s_desc_get_acc_desc('307',g_sfba_d[l_ac].sfba032) RETURNING g_sfba_d[l_ac].sfba032_desc
                     NEXT FIELD sfba032
                  END IF
               END IF
               CALL s_desc_get_acc_desc('307',g_sfba_d[l_ac].sfba032) RETURNING g_sfba_d[l_ac].sfba032_desc
            END IF
            LET g_sfba_d_o.sfba032 = g_sfba_d[l_ac].sfba032
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfba032
            #add-point:BEFORE FIELD sfba032 name="input.b.page1.sfba032"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfba032
            #add-point:ON CHANGE sfba032 name="input.g.page1.sfba032"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sfba031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfba031
            #add-point:ON ACTION controlp INFIELD sfba031 name="input.c.page1.sfba031"

            IF g_imaf058 <> '1' AND g_sfba_d[l_ac].sfba031 > 0 THEN    
               CALL asft300_06(g_sfba_d[l_ac].sfbadocno,g_sfba_d[l_ac].sfbaseq,g_sfba_d[l_ac].sfbaseq1,g_sfba_d[l_ac].sfba031)
                    RETURNING r_success,g_sfbb
               IF r_success THEN
                  LET g_type = 2
               ELSE
                  LET g_sfba_d[l_ac].sfba031 = g_sfba_d_o.sfba031
                  NEXT FIELD sfba031
               END IF 
            END IF            
         

            #END add-point
 
 
         #Ctrlp:input.c.page1.sfba032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfba032
            #add-point:ON ACTION controlp INFIELD sfba032 name="input.c.page1.sfba032"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfba_d[l_ac].sfba032                #給予default值
            LET g_qryparam.arg1 = "307"                                     #給予arg
            CALL q_oocq002()                                                #呼叫開窗
            LET g_sfba_d[l_ac].sfba032 = g_qryparam.return1                 #將開窗取得的值回傳到變數
            DISPLAY g_sfba_d[l_ac].sfba032 TO sfba032                       #顯示到畫面上
            CALL s_desc_get_acc_desc('307',g_sfba_d[l_ac].sfba032) RETURNING g_sfba_d[l_ac].sfba032_desc
            NEXT FIELD sfba032
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
      DISPLAY ARRAY g_sfba2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_sfba2_d.getLength() TO FORMONLY.h_count

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_sfba2_d.getLength() TO FORMONLY.h_count
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
   CLOSE WINDOW w_asft300_05 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft300_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft300_05.other_function" readonly="Y" >}

PRIVATE FUNCTION asft300_05_b_fill()
DEFINE l_sql        STRING
DEFINE l_ac         LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5

   CALL g_sfba_d.clear()

   LET l_sql = " SELECT sfbadocno,sfbaseq,sfbaseq1,sfba002, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=sfbaent AND oocql001='215' AND oocql002=sfba002 AND oocql003='"||g_dlang||"') oocql004,",
               "        sfba003, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=sfbaent AND oocql001='221' AND oocql002=sfba003 AND oocql003='"||g_dlang||"') oocql004,",
               "        sfba006,imaal003,imaal004,sfba021,'',sfba014, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=sfbaent AND oocal001=sfba014 AND oocal002='"||g_dlang||"') oocal003,",
               "        sfba013,sfba016,sfba031,sfba032, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=sfbaent AND oocql001='307' AND oocql002=sfba032 AND oocql003='"||g_dlang||"') oocql004",
               "   FROM sfba_t ",
               "   LEFT JOIN imaal_t ON imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"' ",
               "  WHERE sfbaent = ",g_enterprise,
               "    AND sfbadocno = '",g_sfaadocno,"' ",
               #161228-00035#1 add--s
               "    AND EXISTS (SELECT 1 FROM imaf_t ",
               "                 WHERE imafent=sfbaent AND imafsite=sfbasite AND imaf001=sfba006 ",
               "                   AND imaf058 IN ('1','2')) "
               #161228-00035#1 add--e
   PREPARE asft300_sel FROM l_sql
   DECLARE b_fill_curs CURSOR FOR asft300_sel
   
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_sfba_d[l_ac].sfbadocno,g_sfba_d[l_ac].sfbaseq,g_sfba_d[l_ac].sfbaseq1,
                            g_sfba_d[l_ac].sfba002,g_sfba_d[l_ac].sfba002_desc,
                            g_sfba_d[l_ac].sfba003,g_sfba_d[l_ac].sfba003_desc,
                            g_sfba_d[l_ac].sfba006,g_sfba_d[l_ac].sfba006_desc,g_sfba_d[l_ac].sfba006_desc_2,
                            g_sfba_d[l_ac].sfba021,g_sfba_d[l_ac].sfba021_desc,
                            g_sfba_d[l_ac].sfba014,g_sfba_d[l_ac].sfba014_desc,
                            g_sfba_d[l_ac].sfba013,g_sfba_d[l_ac].sfba016,g_sfba_d[l_ac].sfba031,
                            g_sfba_d[l_ac].sfba032,g_sfba_d[l_ac].sfba032_desc
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "b_fill_curs",SQLERRMESSAGE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT FOREACH
        END IF
        IF cl_null(g_sfba_d[l_ac].sfba031) THEN 
           LET g_sfba_d[l_ac].sfba031 = 0 
        END IF

        #取得產品特徵說明 
        CALL s_feature_description(g_sfba_d[l_ac].sfba006,g_sfba_d[l_ac].sfba021)
             RETURNING l_success,g_sfba_d[l_ac].sfba021_desc
                   
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
   
   CALL g_sfba_d.deleteElement(g_sfba_d.getLength())
   LET g_rec_b = l_ac - 1  

   CLOSE b_fill_curs
   FREE asft300_sel
END FUNCTION

PRIVATE FUNCTION asft300_05_fetch()
DEFINE l_sql        STRING
DEFINE l_ac         LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5

   CALL g_sfba2_d.clear()
   
   LET l_sql = " SELECT sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,'',sfbb004,'', ",
               "        sfbb005,'',sfbb003,sfbb006,sfbb007,'',sfbb008,sfbb009 ",
               "   FROM sfbb_t ",
               "  WHERE sfbbent = '",g_enterprise,"' ",
               "    AND sfbbdocno = '",g_sfbadocno,"' ",
               "    AND sfbbseq = '",g_sfbaseq,"' ",
               "    AND sfbbseq1 = '",g_sfbaseq1,"' "
   PREPARE asft300_sfbb_sel FROM l_sql
   DECLARE asft300_sfbb_per CURSOR FOR asft300_sfbb_sel       

   LET l_ac = 1
   FOREACH asft300_sfbb_per INTO g_sfba2_d[l_ac].sfbbdocno,g_sfba2_d[l_ac].sfbbseq,g_sfba2_d[l_ac].sfbbseq1,
                                 g_sfba2_d[l_ac].sfbb001,g_sfba2_d[l_ac].sfbb002,g_sfba2_d[l_ac].sfbb002_desc,
                                 g_sfba2_d[l_ac].sfbb004,g_sfba2_d[l_ac].sfbb004_desc,
                                 g_sfba2_d[l_ac].sfbb005,g_sfba2_d[l_ac].sfbb005_desc,
                                 g_sfba2_d[l_ac].sfbb003,g_sfba2_d[l_ac].sfbb006,
                                 g_sfba2_d[l_ac].sfbb007,g_sfba2_d[l_ac].sfbb007_desc,
                                 g_sfba2_d[l_ac].sfbb008,g_sfba2_d[l_ac].sfbb009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL s_desc_get_stock_desc(g_site,g_sfba2_d[l_ac].sfbb004) RETURNING g_sfba2_d[l_ac].sfbb004_desc
      CALL s_desc_get_locator_desc(g_site,g_sfba2_d[l_ac].sfbb004,g_sfba2_d[l_ac].sfbb005) RETURNING g_sfba2_d[l_ac].sfbb005_desc   
      CALL s_desc_get_unit_desc(g_sfba2_d[l_ac].sfbb007) RETURNING g_sfba2_d[l_ac].sfbb007_desc     
      CALL s_feature_description(g_sfba2_d[l_ac].sfbb001,g_sfba2_d[l_ac].sfbb002)
           RETURNING l_success,g_sfba2_d[l_ac].sfbb002_desc
 
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
   
   CALL g_sfba2_d.deleteElement(g_sfba2_d.getLength())
   LET g_rec_b = l_ac - 1
   
   CLOSE asft300_sfbb_per
   FREE asft300_sfbb_sel
END FUNCTION

PRIVATE FUNCTION asft300_05_set_entry()

      CALL cl_set_comp_entry("sfba031,sfba032",TRUE)
END FUNCTION

PRIVATE FUNCTION asft300_05_set_no_entry()

     #160927-00024#1-s
     #IF g_imaf058 = '4' THEN    #等候需求模式
      IF g_imaf058 MATCHES '[03]' THEN
     #160927-00024#1-e
         CALL cl_set_comp_entry("sfba031",FALSE)
      END IF
      IF g_sfba_d[l_ac].sfba031 <= 0 THEN
         CALL cl_set_comp_entry("sfba032",FALSE)
      END IF
END FUNCTION
#取得存貨備置
PRIVATE FUNCTION asft300_05_get_imaf058()
DEFINE l_sfba001 LIKE sfba_t.sfba011   #料件編號

   LET g_imaf058 = ''
   SELECT imaf058,imaf053 INTO g_imaf058,g_imaf053
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = g_sfba006  

END FUNCTION
#產生訂單備置明細檔
PRIVATE FUNCTION asft300_05_gen_sfbb()
DEFINE p_sfbbdocno    LIKE sfbb_t.sfbbdocno
DEFINE p_sfbbseq      LIKE sfbb_t.sfbbseq
DEFINE p_sfbbseq1     LIKE sfbb_t.sfbbseq1
DEFINE r_success      LIKE type_t.num5
DEFINE l_sfbb008      LIKE type_t.num5
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_cnt1         LIKE type_t.num5
DEFINE i              LIKE type_t.num5
#DEFINE l_sfbb RECORD  LIKE sfbb_t.* #161109-00085#62 mark
#161109-00085#62 --s add
DEFINE l_sfbb RECORD  #工單備置明細檔
       sfbbent LIKE sfbb_t.sfbbent, #企業編號
       sfbbsite LIKE sfbb_t.sfbbsite, #營運據點
       sfbbdocno LIKE sfbb_t.sfbbdocno, #工單單號
       sfbbseq LIKE sfbb_t.sfbbseq, #工單項次
       sfbbseq1 LIKE sfbb_t.sfbbseq1, #工單項序
       sfbb001 LIKE sfbb_t.sfbb001, #料件編號
       sfbb002 LIKE sfbb_t.sfbb002, #產品特徵
       sfbb003 LIKE sfbb_t.sfbb003, #庫存管理特徵
       sfbb004 LIKE sfbb_t.sfbb004, #庫位
       sfbb005 LIKE sfbb_t.sfbb005, #儲位
       sfbb006 LIKE sfbb_t.sfbb006, #批號
       sfbb007 LIKE sfbb_t.sfbb007, #庫存單位
       sfbb008 LIKE sfbb_t.sfbb008, #備置量
       sfbb009 LIKE sfbb_t.sfbb009, #備置已沖銷量
       sfbb010 LIKE sfbb_t.sfbb010, #備置單位
       sfbbud001 LIKE sfbb_t.sfbbud001, #自定義欄位(文字)001
       sfbbud002 LIKE sfbb_t.sfbbud002, #自定義欄位(文字)002
       sfbbud003 LIKE sfbb_t.sfbbud003, #自定義欄位(文字)003
       sfbbud004 LIKE sfbb_t.sfbbud004, #自定義欄位(文字)004
       sfbbud005 LIKE sfbb_t.sfbbud005, #自定義欄位(文字)005
       sfbbud006 LIKE sfbb_t.sfbbud006, #自定義欄位(文字)006
       sfbbud007 LIKE sfbb_t.sfbbud007, #自定義欄位(文字)007
       sfbbud008 LIKE sfbb_t.sfbbud008, #自定義欄位(文字)008
       sfbbud009 LIKE sfbb_t.sfbbud009, #自定義欄位(文字)009
       sfbbud010 LIKE sfbb_t.sfbbud010, #自定義欄位(文字)010
       sfbbud011 LIKE sfbb_t.sfbbud011, #自定義欄位(數字)011
       sfbbud012 LIKE sfbb_t.sfbbud012, #自定義欄位(數字)012
       sfbbud013 LIKE sfbb_t.sfbbud013, #自定義欄位(數字)013
       sfbbud014 LIKE sfbb_t.sfbbud014, #自定義欄位(數字)014
       sfbbud015 LIKE sfbb_t.sfbbud015, #自定義欄位(數字)015
       sfbbud016 LIKE sfbb_t.sfbbud016, #自定義欄位(數字)016
       sfbbud017 LIKE sfbb_t.sfbbud017, #自定義欄位(數字)017
       sfbbud018 LIKE sfbb_t.sfbbud018, #自定義欄位(數字)018
       sfbbud019 LIKE sfbb_t.sfbbud019, #自定義欄位(數字)019
       sfbbud020 LIKE sfbb_t.sfbbud020, #自定義欄位(數字)020
       sfbbud021 LIKE sfbb_t.sfbbud021, #自定義欄位(日期時間)021
       sfbbud022 LIKE sfbb_t.sfbbud022, #自定義欄位(日期時間)022
       sfbbud023 LIKE sfbb_t.sfbbud023, #自定義欄位(日期時間)023
       sfbbud024 LIKE sfbb_t.sfbbud024, #自定義欄位(日期時間)024
       sfbbud025 LIKE sfbb_t.sfbbud025, #自定義欄位(日期時間)025
       sfbbud026 LIKE sfbb_t.sfbbud026, #自定義欄位(日期時間)026
       sfbbud027 LIKE sfbb_t.sfbbud027, #自定義欄位(日期時間)027
       sfbbud028 LIKE sfbb_t.sfbbud028, #自定義欄位(日期時間)028
       sfbbud029 LIKE sfbb_t.sfbbud029, #自定義欄位(日期時間)029
       sfbbud030 LIKE sfbb_t.sfbbud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#62 --e add

DEFINE l_sql          STRING

   LET r_success = TRUE 

   #add--160408-00035#3 By shiun--(S)
   IF g_sfba_d[l_ac].sfba031 = 0 THEN
      RETURN r_success
   END IF
   #add--160408-00035#3 By shiun--(E)

   LET l_cnt = 0   
   SELECT COUNT(*) INTO l_cnt 
     FROM sfbb_t
    WHERE sfbbent = g_enterprise
      AND sfbbsite = g_site
      AND sfbbdocno = g_sfbadocno
      AND sfbbseq = g_sfbaseq
      AND sfbbseq1 = g_sfbaseq1

     
    IF g_type = 1 THEN 
       IF l_cnt = 0 THEN
          #庫存管理特徵、庫位、儲位、批號、庫存單位均為空白，已沖銷庫存量為0
          INSERT INTO sfbb_t (sfbbent,sfbbsite,sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb007,sfbb008,sfbb009,sfbb010)
            VALUES (g_enterprise,g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_sfba006,g_sfba021,' ',' ',' ',' ',g_imaf053,g_sfba_d[l_ac].sfba031,0,g_sfba_d[l_ac].sfba014)
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "INSERT sfbb"
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
             LET r_success = FALSE  
             RETURN r_success 
          ELSE
          #呼叫'更新庫存備置量'應用元件更新存統計量  
 #            IF NOT s_prepare_upd('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
 #                              0,g_sfba006,g_sfba021,' ',' ',
 #                              ' ',' ',g_imaf053,g_sfba_d[l_ac].sfba031,'-1') THEN         
 #               LET r_success = FALSE  
 #               RETURN r_success                                   
 #            END IF
             #更新備置量
             IF NOT s_inventory_upd_inan('2',g_site,g_sfba006,g_sfba021,' ',' ',' ',' ',
                                         g_imaf053,g_sfba_d[l_ac].sfba031,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_site) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF        
       ELSE
          #撈出調整前的備置量
          LET l_sfbb008 = 0
          SELECT sfbb008 INTO l_sfbb008
            FROM sfbb_t
           WHERE sfbbent = g_enterprise
             AND sfbbsite = g_site
             AND sfbbdocno = g_sfbadocno
             AND sfbbseq = g_sfbaseq
             AND sfbbseq1 = g_sfbaseq1
             
          UPDATE sfbb_t 
             SET sfbb008 = g_sfba_d[l_ac].sfba031
           WHERE sfbbent = g_enterprise
             AND sfbbsite = g_site
             AND sfbbdocno = g_sfbadocno
             AND sfbbseq = g_sfbaseq
             AND sfbbseq1 = g_sfbaseq1
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "UPDATE sfbb008"
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
             LET r_success = FALSE  
             RETURN r_success 
          ELSE
          #需將舊的備置量先沖消後，再寫入新的備置量
             IF l_sfbb008 >= 0 AND l_sfbb008 <> g_sfba_d[l_ac].sfba031 THEN
                IF NOT s_prepare_upd_inan('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
                                  0,g_sfba006,g_sfba021,' ',' ',
                                  ' ',' ',g_imaf053,l_sfbb008,'1') THEN         
                   LET r_success = FALSE  
                   RETURN r_success                                   
                END IF 
                #備置量增加
                IF NOT s_prepare_upd_inan('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
                                  0,g_sfba006,g_sfba021,' ',' ',
                                  ' ',' ',g_imaf053,g_sfba_d[l_ac].sfba031,'-1') THEN         
                   LET r_success = FALSE  
                   RETURN r_success                                   
                END IF                
             END IF         
             
          END IF        
       END IF
    ELSE
    #AAAAAAAAAAAAAAAAAAAAAA
       IF l_cnt = 0 THEN
          FOR i = 1 TO g_sfbb.getLength()
              INSERT INTO sfbb_t (sfbbent,sfbbsite,sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb007,sfbb008,sfbb009,sfbb010)
                VALUES (g_enterprise,g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb007,g_sfbb[i].sfbb008,g_sfbb[i].sfbb009,g_sfbb[i].sfbb010)
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "INSERT sfbb"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
 
                 LET r_success = FALSE  
                 RETURN r_success 
              ELSE
 #                #備置量增加
 #                IF NOT s_prepare_upd('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
 #                                     0,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,
 #                                     g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb010,g_sfbb[i].sfbb008,'-1') THEN
 #                   LET r_success = FALSE  
 #                   RETURN r_success  
 #                END IF
                 #更新備置量
                 IF NOT s_inventory_upd_inan('2',g_site,g_sfba006,g_sfba021,
                                             g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,
                                             g_sfbb[i].sfbb007,g_sfbb[i].sfbb008,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_site) THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
              END IF          
          END FOR
       ELSE
         #LET l_sql = " SELECT * ", #161109-00085#62 mark
         #161109-00085#62 --s add
         LET l_sql = " SELECT sfbbent,sfbbsite,sfbbdocno,sfbbseq,sfbbseq1, ",
                     "        sfbb001,sfbb002,sfbb003,sfbb004,sfbb005, ",
                     "        sfbb006,sfbb007,sfbb008,sfbb009,sfbb010, ",
                     "        sfbbud001,sfbbud002,sfbbud003,sfbbud004,sfbbud005, ",
                     "        sfbbud006,sfbbud007,sfbbud008,sfbbud009,sfbbud010, ",
                     "        sfbbud011,sfbbud012,sfbbud013,sfbbud014,sfbbud015, ",
                     "        sfbbud016,sfbbud017,sfbbud018,sfbbud019,sfbbud020, ",
                     "        sfbbud021,sfbbud022,sfbbud023,sfbbud024,sfbbud025, ",
                     "        sfbbud026,sfbbud027,sfbbud028,sfbbud029,sfbbud030  ",
         #161109-00085#62 --e add
                     "   FROM sfbb_t ",
                     "  WHERE sfbbent = '",g_enterprise,"' ",
                     "    AND sfbbdocno = '",g_sfbadocno,"' ",
                     "    AND sfbbseq = '",g_sfbaseq,"' ",
                     "    AND sfbbseq1 = '",g_sfbaseq1,"' ",
                     "    AND sfbb009 = 0"
         
         PREPARE asft300_del_sel FROM l_sql
         DECLARE asft300_del_per CURSOR FOR asft300_del_sel       
        #FOREACH asft300_del_per INTO l_sfbb.* #161109-00085#62 mark
         #161109-00085#62 --s add
         FOREACH asft300_del_per INTO l_sfbb.sfbbent,l_sfbb.sfbbsite,l_sfbb.sfbbdocno,l_sfbb.sfbbseq,l_sfbb.sfbbseq1,
                                      l_sfbb.sfbb001,l_sfbb.sfbb002,l_sfbb.sfbb003,l_sfbb.sfbb004,l_sfbb.sfbb005,
                                      l_sfbb.sfbb006,l_sfbb.sfbb007,l_sfbb.sfbb008,l_sfbb.sfbb009,l_sfbb.sfbb010,
                                      l_sfbb.sfbbud001,l_sfbb.sfbbud002,l_sfbb.sfbbud003,l_sfbb.sfbbud004,l_sfbb.sfbbud005,
                                      l_sfbb.sfbbud006,l_sfbb.sfbbud007,l_sfbb.sfbbud008,l_sfbb.sfbbud009,l_sfbb.sfbbud010,
                                      l_sfbb.sfbbud011,l_sfbb.sfbbud012,l_sfbb.sfbbud013,l_sfbb.sfbbud014,l_sfbb.sfbbud015,
                                      l_sfbb.sfbbud016,l_sfbb.sfbbud017,l_sfbb.sfbbud018,l_sfbb.sfbbud019,l_sfbb.sfbbud020,
                                      l_sfbb.sfbbud021,l_sfbb.sfbbud022,l_sfbb.sfbbud023,l_sfbb.sfbbud024,l_sfbb.sfbbud025,
                                      l_sfbb.sfbbud026,l_sfbb.sfbbud027,l_sfbb.sfbbud028,l_sfbb.sfbbud029,l_sfbb.sfbbud030 
         #161109-00085#62 --e add
            IF NOT s_prepare_upd_inan('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
                              0,g_sfba006,g_sfba021,l_sfbb.sfbb003,l_sfbb.sfbb004,
                               l_sfbb.sfbb005,l_sfbb.sfbb006,l_sfbb.sfbb010,l_sfbb.sfbb008,'1') THEN
               LET r_success = FALSE  
               RETURN r_success                                   
            END IF
         END FOREACH
         #已沖銷備置量(sfbb009)=0的資料直接刪除
         DELETE FROM sfbb_t
          WHERE sfbbent = g_enterprise
            AND sfbbsite = g_site
            AND sfbbdocno = g_sfbadocno
            AND sfbbseq = g_sfbaseq
            AND sfbbseq1 = g_sfbaseq1
            AND sfbb009 = 0          
         FOR i = 1 TO g_sfbb.getLength()
             LET l_cnt1 = 0
             SELECT COUNT(*) INTO l_cnt1
               FROM sfbb_t
              WHERE sfbbent = g_enterprise       AND sfbbsite = g_site
                AND sfbbdocno = g_sfbadocno      AND sfbbseq = g_sfbaseq
                AND sfbbseq1 = g_sfbaseq1        AND sfbb001 = g_sfba006          
                AND sfbb002 = g_sfba021         AND sfbb003 = g_sfbb[i].sfbb003  
                AND sfbb004 = g_sfbb[i].sfbb004  AND sfbb005 = g_sfbb[i].sfbb005  
                AND sfbb006 = g_sfbb[i].sfbb006  AND sfbb007 = g_sfbb[i].sfbb007
             IF l_cnt1 = 0 THEN
                INSERT INTO sfbb_t (sfbbent,sfbbsite,sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb007,sfbb008,sfbb009,sfbb010)
                  VALUES (g_enterprise,g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb007,g_sfbb[i].sfbb008,g_sfbb[i].sfbb009,g_sfbb[i].sfbb010)
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "INSERT sfbb"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
 
                   LET r_success = FALSE  
                   RETURN r_success 
                ELSE
                   #呼叫'更新庫存備置量'應用元件更新存統計量      
 #                  #備置量增加
 #                  IF NOT s_prepare_upd('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
 #                                       0,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,
 #                                       g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb010,g_sfbb[i].sfbb008,'-1') THEN
 #                     LET r_success = FALSE  
 #                     RETURN r_success  
 #                  END IF  
                   #更新備置量
                   IF NOT s_inventory_upd_inan('2',g_site,g_sfba006,g_sfba021,
                                               g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,
                                               g_sfbb[i].sfbb007,g_sfbb[i].sfbb008,g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_site) THEN
                      LET r_success = FALSE
                      RETURN r_success
                   END IF
                 
                END IF           
             ELSE
               SELECT sfbb008 
                 INTO l_sfbb008
                 FROM sfbb_t
                WHERE sfbbent = g_enterprise       AND sfbbsite = g_site
                  AND sfbbdocno = g_sfbadocno      AND sfbbseq = g_sfbaseq
                  AND sfbbseq1 = g_sfbaseq1       
                  AND sfbb001 = g_sfba006          AND sfbb002 = g_sfba021
                  AND sfbb003 = g_sfbb[i].sfbb003  AND sfbb004 = g_sfbb[i].sfbb004
                  AND sfbb005 = g_sfbb[i].sfbb005  AND sfbb006 = g_sfbb[i].sfbb006
                  AND sfbb007 = g_sfbb[i].sfbb007  
               UPDATE sfbb_t 
                  SET sfbb008 = g_sfbb[i].sfbb008
                WHERE sfbbent = g_enterprise       AND sfbbsite = g_site
                  AND sfbbdocno = g_sfbadocno      AND sfbbseq = g_sfbaseq
                  AND sfbbseq1 = g_sfbaseq1        AND sfbb001 = g_sfba006         
                  AND sfbb002 = g_sfba021          AND sfbb003 = g_sfbb[i].sfbb003  
                  AND sfbb004 = g_sfbb[i].sfbb004  AND sfbb005 = g_sfbb[i].sfbb005  
                  AND sfbb006 = g_sfbb[i].sfbb006  AND sfbb007 = g_sfbb[i].sfbb007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "UPDATE sfbb008"
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
                  LET r_success = FALSE  
                  RETURN r_success 
               ELSE
                  #需將舊的備置量先沖消後，再寫入新的備置量
                  IF l_sfbb008 >= 0 AND l_sfbb008 <> g_sfba_d[l_ac].sfba031 THEN
                     IF NOT s_prepare_upd_inan('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
                                       0,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,
                                        g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb010,l_sfbb008,'1') THEN
                        LET r_success = FALSE  
                        RETURN r_success                                   
                     END IF 
                     #備置量增加
                        IF NOT s_prepare_upd_inan('2',g_site,g_sfbadocno,g_sfbaseq,g_sfbaseq1,
                                       0,g_sfba006,g_sfba021,g_sfbb[i].sfbb003,g_sfbb[i].sfbb004,
                                        g_sfbb[i].sfbb005,g_sfbb[i].sfbb006,g_sfbb[i].sfbb010,g_sfbb[i].sfbb008,'-1') THEN
                        LET r_success = FALSE  
                        RETURN r_success                                   
                     END IF                
                  END IF 
               END IF                  
             END IF             
         END FOR
       END IF         
    END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL asft300_05_sfba031_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: 
# Date & Author..: #160927-00025#1 By Whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asft300_05_sfba031_chk()
DEFINE l_sfbb008    LIKE sfbb_t.sfbb008
DEFINE l_sfbb009    LIKE sfbb_t.sfbb009
DEFINE l_sfbb  RECORD
    sfbb001    LIKE sfbb_t.sfbb001,
    sfbb002    LIKE sfbb_t.sfbb002,
    sfbb003    LIKE sfbb_t.sfbb003,
    sfbb004    LIKE sfbb_t.sfbb004,
    sfbb005    LIKE sfbb_t.sfbb005,
    sfbb006    LIKE sfbb_t.sfbb006,
    sfbb008    LIKE sfbb_t.sfbb008,
    sfbb010    LIKE sfbb_t.sfbb010
           END RECORD
DEFINE l_inag008_inag033   LIKE inag_t.inag008      #帳面庫存數量 或 基礎單位數量
DEFINE l_sfba031_convert   LIKE sfba_t.sfba031      #存放轉換後基礎單位數量 或 原始備置量
DEFINE l_inag032           LIKE inag_t.inag032      #料件基礎單位
DEFINE l_success           LIKE type_t.num5
DEFINE l_inan010           LIKE inan_t.inan010      #已在揀量&已備置量
DEFINE l_ysfba031          LIKE sfba_t.sfba031      #可備置量

   IF NOT cl_ap_chk_range(g_sfba_d[l_ac].sfba031,"0.000","1","","","azz-00079",1) THEN
      RETURN FALSE
   END IF
   
   #備置量不可大於分批數量
   IF g_sfba_d[l_ac].sfba031 > g_sfba_d[l_ac].sfba006 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00295'
      LET g_errparam.extend = g_sfba_d[l_ac].sfba031
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #備置數量應卡不可大於總應發數量-已發數量
   IF g_sfba_d[l_ac].sfba031 > g_sfba_d[l_ac].sfba013 - g_sfba_d[l_ac].sfba016 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'asf-00660'
      LET g_errparam.extend = g_sfba_d[l_ac].sfba031
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #160408-00035#2-s
   #備置量不可小於備置已沖銷量
   LET l_sfbb008 = 0
   LET l_sfbb009 = 0
   SELECT SUM(sfbb008),SUM(sfbb009) INTO l_sfbb008,l_sfbb009
     FROM sfbb_t
    WHERE sfbbent = g_enterprise
      AND sfbbsite = g_site
      AND sfbbdocno = g_sfbadocno
      AND sfbbseq = g_sfbaseq
      AND sfbbseq1 = g_sfbaseq1
   IF cl_null(l_sfbb008) THEN LET l_sfbb008 = 0 END IF  #161014-00034#1
   IF cl_null(l_sfbb009) THEN LET l_sfbb009 = 0 END IF
   IF l_sfbb009 > 0 THEN
      IF g_sfba_d[l_ac].sfba031 < l_sfbb009 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00296'
         LET g_errparam.extend = g_sfba_d[l_ac].sfba031
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #160408-00035#2-e
   
   #160927-00027#1-s
   #備置數量改為0表示要取消備置,將sfbb_t刪除
   IF g_sfba_d[l_ac].sfba031 = 0 THEN
      DECLARE upd_inan_cs CURSOR FOR
         SELECT sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb008,sfbb010
           FROM sfbb_t
          WHERE sfbbent = g_enterprise
            AND sfbbdocno = g_sfbadocno
            AND sfbbseq = g_sfbaseq
            AND sfbbseq1 = g_sfbaseq1
      FOREACH upd_inan_cs INTO l_sfbb.sfbb001,l_sfbb.sfbb002,l_sfbb.sfbb003,l_sfbb.sfbb004,l_sfbb.sfbb005,
                               l_sfbb.sfbb006,l_sfbb.sfbb008,l_sfbb.sfbb010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         IF NOT s_inventory_upd_inan('-2',g_site,l_sfbb.sfbb001,l_sfbb.sfbb002,l_sfbb.sfbb003,
                                     l_sfbb.sfbb004,l_sfbb.sfbb005,l_sfbb.sfbb006,l_sfbb.sfbb010,l_sfbb.sfbb008,
                                     g_sfbadocno,g_sfbaseq,g_sfbaseq1,g_site) THEN
            RETURN FALSE
         END IF
      END FOREACH
      DELETE FROM sfbb_t 
       WHERE sfbbent = g_enterprise
         AND sfbbsite = g_site
         AND sfbbdocno = g_sfbadocno
         AND sfbbseq = g_sfbaseq
         AND sfbbseq1 = g_sfbaseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DELETE FROM sfbb_t",SQLERRMESSAGE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   
       
   END IF
   #160927-00027#1-e
  
   
   CASE g_imaf058
      #160927-00025#1-s
      #copy axmt500_02
      WHEN '1'  #軟備置
         LET l_inag008_inag033 = 0
         LET l_sfba031_convert = g_sfba_d[l_ac].sfba031
         #啟用產品特徵
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0036')  = 'Y' THEN
            #取得料件基礎單位
            LET l_inag032 = ''
            SELECT imaa006 INTO l_inag032
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_sfba_d[l_ac].sfba006
            IF NOT cl_null(l_inag032) AND g_sfba_d[l_ac].sfba014 <> l_inag032 THEN
               CALL s_aooi250_convert_qty(g_sfba_d[l_ac].sfba006,g_sfba_d[l_ac].sfba014,l_inag032,g_sfba_d[l_ac].sfba031)
                    RETURNING l_success,l_sfba031_convert
               #基礎單位數量
               SELECT SUM(inag033) INTO l_inag008_inag033
                 FROM inag_t
                WHERE inagent  = g_enterprise
                  AND inagsite = g_site
                  AND inag001  = g_sfba_d[l_ac].sfba006
                  AND inag002  = g_sfba_d[l_ac].sfba021
                GROUP BY inag001, inag002
            ELSE
               #帳面庫存數量
               SELECT SUM(inag008) INTO l_inag008_inag033
                 FROM inag_t
                WHERE inagent  = g_enterprise
                  AND inagsite = g_site
                  AND inag001  = g_sfba_d[l_ac].sfba006
                  AND inag002  = g_sfba_d[l_ac].sfba021
                GROUP BY inag001, inag002
            END IF
            IF cl_null(l_inag008_inag033) THEN  LET l_inag008_inag033 = 0 END IF
            #已在揀量&已備置量inan010
            LET l_inan010 = 0
            SELECT SUM(inan010)  INTO l_inan010
              FROM inan_t
             WHERE inanent = g_enterprise
               AND inansite = g_site
               AND inan001 = g_sfba_d[l_ac].sfba006
               AND inan002 = g_sfba_d[l_ac].sfba021
            IF cl_null(l_inan010) THEN LET l_inan010 = 0 END IF
            #可備置量(l_ysfba031) = 庫存量(inag008)-已在揀量&已備置量(inan010)+這張單子本身的備置量
            LET l_ysfba031 = l_inag008_inag033 - l_inan010 + g_sfba_d_o.sfba031
            #不可大於可備置量
            IF l_sfba031_convert > l_ysfba031 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00306'
               LET g_errparam.extend = g_sfba_d[l_ac].sfba031
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF            
         END IF
         #160927-00025#1-e
        
      WHEN '2'
         IF g_sfba_d[l_ac].sfba031 <> 0 AND l_sfbb008 <> g_sfba_d[l_ac].sfba031 THEN  #160408-00035#2
            CALL g_sfbb.clear()
            CALL asft300_06(g_sfba_d[l_ac].sfbadocno,g_sfba_d[l_ac].sfbaseq,g_sfba_d[l_ac].sfbaseq1,g_sfba_d[l_ac].sfba031)
                 RETURNING l_success,g_sfbb
            IF l_success THEN
               LET g_type = 2
            ELSE
               RETURN FALSE
            END IF
         END IF
   END CASE

   RETURN TRUE
END FUNCTION

 
{</section>}
 
