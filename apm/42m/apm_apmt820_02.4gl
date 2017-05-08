#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt820_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2013-09-04 00:00:00), PR版次:0001(2013-09-05 10:51:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000144
#+ Filename...: apmt820_02
#+ Description: 批量選取供應商證照檔
#+ Creator....: 01996(2013-09-04 14:43:24)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="apmt820_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE TYPE type_g_pmag_d        RECORD
       sel LIKE type_t.chr500, 
   pmag001 LIKE pmag_t.pmag001, 
   pmag002 LIKE pmag_t.pmag002, 
   pmag003 LIKE pmag_t.pmag003, 
   pmag004 LIKE pmag_t.pmag004, 
   pmag005 LIKE pmag_t.pmag005, 
   pmag006 LIKE pmag_t.pmag006, 
   pmag007 LIKE pmag_t.pmag007, 
   pmag008 LIKE pmag_t.pmag008, 
   pmag009 LIKE pmag_t.pmag009
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_pmag_d          DYNAMIC ARRAY OF type_g_pmag_d
DEFINE g_pmag_d_t        type_g_pmag_d
 
 
DEFINE g_pmag001_t   LIKE pmag_t.pmag001    #Key值備份
DEFINE g_pmag002_t      LIKE pmag_t.pmag002    #Key值備份
DEFINE g_pmag003_t      LIKE pmag_t.pmag003    #Key值備份
 
 
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
 
{<section id="apmt820_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt820_02(--)
   #add-point:input段變數傳入 name="input.get_var"
p_pmcbdocno,p_pmag001
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
   DEFINE p_pmag001       LIKE pmag_t.pmag001
   DEFINE p_pmcbdocno     LIKE pmcb_t.pmcbdocno
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_pmcb   RECORD
               pmcb001  LIKE pmcb_t.pmcb001,
               pmcb002  LIKE pmcb_t.pmcb002,
               pmcb003  LIKE pmcb_t.pmcb003,
               pmcb004  LIKE pmcb_t.pmcb004,
               pmcb005  LIKE pmcb_t.pmcb005,
               pmcb006  LIKE pmcb_t.pmcb006,
               pmcb007  LIKE pmcb_t.pmcb007,
               pmcb008  LIKE pmcb_t.pmcb008,
               pmcb009  LIKE pmcb_t.pmcb009
               END RECORD
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_pmcbseq     LIKE type_t.num5
   DEFINE r_times       LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt820_02 WITH FORM cl_ap_formpath("apm","apmt820_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CREATE TEMP TABLE apmt820_02_tmp(
                          tmp_sel      varchar(1),
                          tmp_pmag001  varchar(10),
                          tmp_pmag002  varchar(10),
                          tmp_pmag003  varchar(40),
                          tmp_pmag004  varchar(255),
                          tmp_pmag005  varchar(10),
                          tmp_pmag006  varchar(40),
                          tmp_pmag007  date,
                          tmp_pmag008  date,
                          tmp_pmag009  varchar(10))
   INSERT INTO apmt820_02_tmp 
     SELECT 'N',pmag001,pmag002,pmag003,pmag004,pmag005,pmag006,pmag007,pmag008,pmag009
       FROM pmag_t 
      WHERE pmagent = g_enterprise AND pmag001 = p_pmag001
   DECLARE apmt820_02_curs CURSOR FOR
      SELECT * FROM apmt820_02_tmp
   LET l_cnt = 1
   FOREACH apmt820_02_curs INTO  g_pmag_d[l_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_pmag_d.deleteElement(g_pmag_d.getLength())
   LET l_allow_insert = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmag_d FROM s_detail1.*
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
           
            DISPLAY ARRAY g_pmag_d TO s_detail1.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            
         BEFORE ROW
            LET l_ac = ARR_CURR()         
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET l_success = 'Y'
               EXIT DIALOG 
            END IF
            
            UPDATE apmt820_02_tmp SET tmp_sel = g_pmag_d[l_ac].sel
                                WHERE tmp_pmag001 = p_pmag001
                                  AND tmp_pmag002 = g_pmag_d[l_ac].pmag002
                                  AND tmp_pmag003 = g_pmag_d[l_ac].pmag003
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
         BEFORE FIELD pmag001
            #add-point:BEFORE FIELD pmag001 name="input.b.page1.pmag001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag001
            
            #add-point:AFTER FIELD pmag001 name="input.a.page1.pmag001"
            #此段落由子樣板a05產生



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag001
            #add-point:ON CHANGE pmag001 name="input.g.page1.pmag001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag002
            #add-point:BEFORE FIELD pmag002 name="input.b.page1.pmag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag002
            
            #add-point:AFTER FIELD pmag002 name="input.a.page1.pmag002"
            #此段落由子樣板a05產生



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag002
            #add-point:ON CHANGE pmag002 name="input.g.page1.pmag002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag003
            #add-point:BEFORE FIELD pmag003 name="input.b.page1.pmag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag003
            
            #add-point:AFTER FIELD pmag003 name="input.a.page1.pmag003"
            #此段落由子樣板a05產生


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag003
            #add-point:ON CHANGE pmag003 name="input.g.page1.pmag003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag004
            #add-point:BEFORE FIELD pmag004 name="input.b.page1.pmag004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag004
            
            #add-point:AFTER FIELD pmag004 name="input.a.page1.pmag004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag004
            #add-point:ON CHANGE pmag004 name="input.g.page1.pmag004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag005
            #add-point:BEFORE FIELD pmag005 name="input.b.page1.pmag005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag005
            
            #add-point:AFTER FIELD pmag005 name="input.a.page1.pmag005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag005
            #add-point:ON CHANGE pmag005 name="input.g.page1.pmag005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag006
            #add-point:BEFORE FIELD pmag006 name="input.b.page1.pmag006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag006
            
            #add-point:AFTER FIELD pmag006 name="input.a.page1.pmag006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag006
            #add-point:ON CHANGE pmag006 name="input.g.page1.pmag006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag007
            #add-point:BEFORE FIELD pmag007 name="input.b.page1.pmag007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag007
            
            #add-point:AFTER FIELD pmag007 name="input.a.page1.pmag007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag007
            #add-point:ON CHANGE pmag007 name="input.g.page1.pmag007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag008
            #add-point:BEFORE FIELD pmag008 name="input.b.page1.pmag008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag008
            
            #add-point:AFTER FIELD pmag008 name="input.a.page1.pmag008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag008
            #add-point:ON CHANGE pmag008 name="input.g.page1.pmag008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmag009
            #add-point:BEFORE FIELD pmag009 name="input.b.page1.pmag009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmag009
            
            #add-point:AFTER FIELD pmag009 name="input.a.page1.pmag009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmag009
            #add-point:ON CHANGE pmag009 name="input.g.page1.pmag009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag001
            #add-point:ON ACTION controlp INFIELD pmag001 name="input.c.page1.pmag001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag002
            #add-point:ON ACTION controlp INFIELD pmag002 name="input.c.page1.pmag002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag003
            #add-point:ON ACTION controlp INFIELD pmag003 name="input.c.page1.pmag003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag004
            #add-point:ON ACTION controlp INFIELD pmag004 name="input.c.page1.pmag004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag005
            #add-point:ON ACTION controlp INFIELD pmag005 name="input.c.page1.pmag005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag006
            #add-point:ON ACTION controlp INFIELD pmag006 name="input.c.page1.pmag006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag007
            #add-point:ON ACTION controlp INFIELD pmag007 name="input.c.page1.pmag007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag008
            #add-point:ON ACTION controlp INFIELD pmag008 name="input.c.page1.pmag008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmag009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmag009
            #add-point:ON ACTION controlp INFIELD pmag009 name="input.c.page1.pmag009"
            
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt820_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      DECLARE apmt820_02_curs1 CURSOR FOR
        SELECT tmp_pmag001,tmp_pmag002,tmp_pmag003,tmp_pmag004,tmp_pmag005,
               tmp_pmag006,tmp_pmag007,tmp_pmag008,tmp_pmag009 
          FROM apmt820_02_tmp WHERE tmp_sel = 'Y'
      LET l_pmcbseq = 0
      SELECT MAX(pmcbseq) INTO l_pmcbseq FROM pmcb_t
       WHERE pmcbent = g_enterprise AND pmcbdocno = p_pmcbdocno
      IF cl_null(l_pmcbseq) THEN LET l_pmcbseq = 0 END IF
      LET l_pmcbseq = l_pmcbseq + 1
      CALL s_transaction_begin()
      LET r_times = 0
      LET l_success = 'Y'
      FOREACH apmt820_02_curs1 INTO l_pmcb.*
         IF SQLCA.SQLCODE THEN
            LET l_success = 'N'
            EXIT FOREACH
         END IF
         IF NOT apmt820_02_pmag_chk(l_pmcb.pmcb001,l_pmcb.pmcb002,l_pmcb.pmcb003,l_pmcb.pmcb004,l_pmcb.pmcb005,
                                    l_pmcb.pmcb006,l_pmcb.pmcb007,l_pmcb.pmcb008,l_pmcb.pmcb009) THEN
            CONTINUE FOREACH 
         ELSE
            INSERT INTO pmcb_t(pmcbent,pmcbdocno,pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008,pmcb009,pmcbacti)  
                  VALUES(g_enterprise,p_pmcbdocno,l_pmcbseq,l_pmcb.pmcb001,l_pmcb.pmcb002,l_pmcb.pmcb003,l_pmcb.pmcb004,l_pmcb.pmcb005,
                         l_pmcb.pmcb006,l_pmcb.pmcb007,l_pmcb.pmcb008,l_pmcb.pmcb009,'Y')    
            IF SQLCA.SQLCODE THEN
               LET l_success = 'N'
               EXIT FOREACH
            END IF
            LET l_pmcbseq = l_pmcbseq + 1
            LET r_times = r_times + 1
         END IF
         
      END FOREACH
      CALL s_transaction_end(l_success,'0')
      DROP TABLE apmt820_02_tmp
      RETURN r_times
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt820_02.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION apmt820_02_pmag_chk(p_pmcb001,p_pmcb002,p_pmcb003,p_pmcb004,p_pmcb005,p_pmcb006,p_pmcb007,p_pmcb008,p_pmcb009)
DEFINE p_pmcb001 LIKE pmcb_t.pmcb001
DEFINE p_pmcb002 LIKE pmcb_t.pmcb002
DEFINE p_pmcb003 LIKE pmcb_t.pmcb003
DEFINE p_pmcb004 LIKE pmcb_t.pmcb004
DEFINE p_pmcb005 LIKE pmcb_t.pmcb005
DEFINE p_pmcb006 LIKE pmcb_t.pmcb006
DEFINE p_pmcb007 LIKE pmcb_t.pmcb007
DEFINE p_pmcb008 LIKE pmcb_t.pmcb008
DEFINE p_pmcb009 LIKE pmcb_t.pmcb009
DEFINE l_n       LIKE type_t.num5
   IF NOT cl_null(p_pmcb001) AND NOT cl_null(p_pmcb002) AND NOT cl_null(p_pmcb003) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM pmcb_t WHERE pmcbent = g_enterprise
         AND pmcb001 = p_pmcb001
         AND pmcb002 = p_pmcb002
         AND pmcb003 = p_pmcb003
      IF l_n > 0 THEN   
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(p_pmcb002) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM oocq_t 
       WHERE oocq001 = '2036'
         AND oocq002 = p_pmcb002
         AND oocqent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM oocq_t 
       WHERE oocq001 = '2036'
         AND oocq002 = p_pmcb002
         AND oocqent = g_enterprise
         AND oocqstus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(p_pmcb005) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM rtax_t
       WHERE rtax001 = p_pmcb005
         AND rtaxent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM rtax_t
       WHERE rtax001 = p_pmcb005
         AND rtaxent = g_enterprise
         AND rtaxstus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      IF NOT cl_null(p_pmcb006) THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM imaa_t
          WHERE imaa001 =  p_pmcb006 
            AND imaa009 =  p_pmcb005
            AND imaaent = g_enterprise                     
         IF l_n = 0 THEN
            RETURN FALSE  
         END IF 
      END IF
   END IF     

   IF NOT cl_null(p_pmcb006) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imaa_t
       WHERE imaa001 = p_pmcb006
         AND imaaent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE 
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imaa_t
       WHERE imaa001 = p_pmcb006
         AND imaaent = g_enterprise
         AND imaastus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      IF NOT cl_null(p_pmcb005) THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM imaa_t
          WHERE imaa001 =  p_pmcb006 
            AND imaa009 =  p_pmcb005
            AND imaaent = g_enterprise                     
         IF l_n = 0 THEN
            RETURN FALSE
         END IF   
      END IF
    END IF

   IF NOT cl_null(p_pmcb007) AND NOT cl_null(p_pmcb008) THEN
      IF p_pmcb007 > p_pmcb008 THEN
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(p_pmcb009) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM ooea_t 
       WHERE ooea001 = p_pmcb009
         AND ooeaent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM ooea_t 
       WHERE ooea001 = p_pmcb009
         AND ooeaent = g_enterprise
         AND ooeastus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
   END IF
RETURN TRUE 
END FUNCTION

 
{</section>}
 
