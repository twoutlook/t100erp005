#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt430_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-11-30 18:30:22), PR版次:0001(2014-12-31 01:11:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000092
#+ Filename...: aapt430_02
#+ Description: 費用分攤目的來源查詢
#+ Creator....: 03080(2014-08-14 19:56:41)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aapt430_02.global" >}
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
PRIVATE TYPE type_g_pmds_d        RECORD
       sel LIKE type_t.chr1, 
   pmds011 LIKE pmds_t.pmds011, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr500, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdtseq LIKE type_t.num10, 
   pmds001 LIKE pmds_t.pmds001, 
   pmdt006 LIKE type_t.chr500, 
   pmdt006_desc LIKE type_t.chr500, 
   pmdt001 LIKE type_t.chr20, 
   pmds048 LIKE pmds_t.pmds048, 
   pmdtsite LIKE type_t.chr10, 
   pmdtsite_desc LIKE type_t.chr500, 
   apcbdocno LIKE type_t.chr20, 
   apcbseq LIKE type_t.num10
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE r_array       DYNAMIC ARRAY OF RECORD
                     apcadocno  LIKE apca_t.apcadocno,
                     apcbseq    LIKE apcb_t.apcbseq,
                     apcc001    LIKE apcc_t.apcc001
                     END RECORD
                     
DEFINE g_type        LIKE type_t.chr1
DEFINE g_wc          STRING
DEFINE g_wc2         STRING
DEFINE g_reqry       LIKE type_t.num5
DEFINE g_apdcorga    LIKE apdc_t.apdcorga    #組織類型
#end add-point
 
DEFINE g_pmds_d          DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t        type_g_pmds_d
 
 
DEFINE g_pmdsdocno_t   LIKE pmds_t.pmdsdocno    #Key值備份
 
 
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
 
{<section id="aapt430_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt430_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_wc2,
   p_apdcorga
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
   DEFINE p_wc2           STRING                  #額外的Sql條件
   DEFINE p_apdcorga      LIKE apdc_t.apdcorga    #組織類型
   WHENEVER ERROR CONTINUE
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt430_02 WITH FORM cl_ap_formpath("aap","aapt430_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_wc = ' 1=1'
   LET g_wc2 = p_wc2
   LET g_apdcorga = p_apdcorga
   IF cl_null(g_wc2)THEN LET g_wc2 = ' 1=1' END IF
   #採購單性質
   CALL cl_set_combo_scc('pmds011','2052')
   #內外購
   CALL cl_set_combo_scc('pmds048','2087')
   
   WHILE TRUE
      CALL aapt430_02_query()
      IF INT_FLAG THEN
         EXIT WHILE
      END IF
      CALL aapt430_02_b_fill(g_wc,g_apdcorga)
      LET g_reqry = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmds_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
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
         BEFORE FIELD pmds011
            #add-point:BEFORE FIELD pmds011 name="input.b.page1.pmds011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds011
            
            #add-point:AFTER FIELD pmds011 name="input.a.page1.pmds011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds011
            #add-point:ON CHANGE pmds011 name="input.g.page1.pmds011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds007
            
            #add-point:AFTER FIELD pmds007 name="input.a.page1.pmds007"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds007
            #add-point:BEFORE FIELD pmds007 name="input.b.page1.pmds007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds007
            #add-point:ON CHANGE pmds007 name="input.g.page1.pmds007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds007_desc
            #add-point:BEFORE FIELD pmds007_desc name="input.b.page1.pmds007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds007_desc
            
            #add-point:AFTER FIELD pmds007_desc name="input.a.page1.pmds007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds007_desc
            #add-point:ON CHANGE pmds007_desc name="input.g.page1.pmds007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdsdocno
            #add-point:BEFORE FIELD pmdsdocno name="input.b.page1.pmdsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdsdocno
            
            #add-point:AFTER FIELD pmdsdocno name="input.a.page1.pmdsdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdsdocno
            #add-point:ON CHANGE pmdsdocno name="input.g.page1.pmdsdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtseq
            #add-point:BEFORE FIELD pmdtseq name="input.b.page1.pmdtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtseq
            
            #add-point:AFTER FIELD pmdtseq name="input.a.page1.pmdtseq"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdtseq
            #add-point:ON CHANGE pmdtseq name="input.g.page1.pmdtseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds001
            #add-point:BEFORE FIELD pmds001 name="input.b.page1.pmds001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds001
            
            #add-point:AFTER FIELD pmds001 name="input.a.page1.pmds001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds001
            #add-point:ON CHANGE pmds001 name="input.g.page1.pmds001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt006
            
            #add-point:AFTER FIELD pmdt006 name="input.a.page1.pmdt006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt006
            #add-point:BEFORE FIELD pmdt006 name="input.b.page1.pmdt006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt006
            #add-point:ON CHANGE pmdt006 name="input.g.page1.pmdt006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt006_desc
            #add-point:BEFORE FIELD pmdt006_desc name="input.b.page1.pmdt006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt006_desc
            
            #add-point:AFTER FIELD pmdt006_desc name="input.a.page1.pmdt006_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt006_desc
            #add-point:ON CHANGE pmdt006_desc name="input.g.page1.pmdt006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt001
            #add-point:BEFORE FIELD pmdt001 name="input.b.page1.pmdt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt001
            
            #add-point:AFTER FIELD pmdt001 name="input.a.page1.pmdt001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt001
            #add-point:ON CHANGE pmdt001 name="input.g.page1.pmdt001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds048
            #add-point:BEFORE FIELD pmds048 name="input.b.page1.pmds048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds048
            
            #add-point:AFTER FIELD pmds048 name="input.a.page1.pmds048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds048
            #add-point:ON CHANGE pmds048 name="input.g.page1.pmds048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtsite
            
            #add-point:AFTER FIELD pmdtsite name="input.a.page1.pmdtsite"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtsite
            #add-point:BEFORE FIELD pmdtsite name="input.b.page1.pmdtsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdtsite
            #add-point:ON CHANGE pmdtsite name="input.g.page1.pmdtsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtsite_desc
            #add-point:BEFORE FIELD pmdtsite_desc name="input.b.page1.pmdtsite_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtsite_desc
            
            #add-point:AFTER FIELD pmdtsite_desc name="input.a.page1.pmdtsite_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdtsite_desc
            #add-point:ON CHANGE pmdtsite_desc name="input.g.page1.pmdtsite_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbdocno
            #add-point:BEFORE FIELD apcbdocno name="input.b.page1.apcbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbdocno
            
            #add-point:AFTER FIELD apcbdocno name="input.a.page1.apcbdocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbdocno
            #add-point:ON CHANGE apcbdocno name="input.g.page1.apcbdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmds_d[l_ac].apcbseq,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD apcbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apcbseq name="input.a.page1.apcbseq"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbseq
            #add-point:BEFORE FIELD apcbseq name="input.b.page1.apcbseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbseq
            #add-point:ON CHANGE apcbseq name="input.g.page1.apcbseq"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds011
            #add-point:ON ACTION controlp INFIELD pmds011 name="input.c.page1.pmds011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds007
            #add-point:ON ACTION controlp INFIELD pmds007 name="input.c.page1.pmds007"
            #此段落由子樣板a07產生            

            #END add-point
 
 
         #Ctrlp:input.c.page1.pmds007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds007_desc
            #add-point:ON ACTION controlp INFIELD pmds007_desc name="input.c.page1.pmds007_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdsdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdsdocno
            #add-point:ON ACTION controlp INFIELD pmdsdocno name="input.c.page1.pmdsdocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtseq
            #add-point:ON ACTION controlp INFIELD pmdtseq name="input.c.page1.pmdtseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmds001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds001
            #add-point:ON ACTION controlp INFIELD pmds001 name="input.c.page1.pmds001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt006
            #add-point:ON ACTION controlp INFIELD pmdt006 name="input.c.page1.pmdt006"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt006_desc
            #add-point:ON ACTION controlp INFIELD pmdt006_desc name="input.c.page1.pmdt006_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt001
            #add-point:ON ACTION controlp INFIELD pmdt001 name="input.c.page1.pmdt001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmds048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds048
            #add-point:ON ACTION controlp INFIELD pmds048 name="input.c.page1.pmds048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdtsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtsite
            #add-point:ON ACTION controlp INFIELD pmdtsite name="input.c.page1.pmdtsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdtsite_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtsite_desc
            #add-point:ON ACTION controlp INFIELD pmdtsite_desc name="input.c.page1.pmdtsite_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbdocno
            #add-point:ON ACTION controlp INFIELD apcbdocno name="input.c.page1.apcbdocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbseq
            #add-point:ON ACTION controlp INFIELD apcbseq name="input.c.page1.apcbseq"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      ON ACTION query
         CALL aapt430_02_query()
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
     IF g_reqry THEN
         CONTINUE WHILE
      END IF
      EXIT WHILE
   END WHILE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt430_02 
   
   #add-point:input段after input name="input.post_input"
   CALL aapt430_02_to_r_array()
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
  # CALL aapt430_01_visible()
   RETURN r_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt430_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢單身填充
# Memo...........:
# Usage..........: CALL aapt430_02_b_fill(p_wc2,p_apdcorga)
# Input parameter: 
# Date & Author..: 140815 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_02_b_fill(p_wc2,p_apdcorga)
DEFINE l_sql        STRING
DEFINE p_wc2        STRING
DEFINE p_apdcorga   LIKE apdc_t.apdcorga    #組織類型
DEFINE l_str        STRING

   WHENEVER ERROR CONTINUE
   IF cl_null(p_wc2)THEN LET p_wc2 = ' 1=1' END IF
  
   LET l_sql = "SELECT UNIQUE 'N',pmds011,pmds007,'',pmdsdocno,",
               "              pmdtseq,pmds001,pmdt006,'',",
               "              pmdt001,pmds048,pmdtsite,'',",
               "              apcbdocno,apcbseq ",
               "  FROM pmds_t,pmdt_t,apca_t,apcb_t",
               " WHERE pmdsent = ? ",
               "   AND pmdsent = pmdtent ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmdsent   = apcbent ",
               "   AND pmdsdocno = apcb002 ",
               "   AND pmdtseq   = apcb003 ",
               "   AND apcbent   = apcaent ",
               "   AND apcbld    = apcald  ",
               "   AND apcbdocno = apcadocno ",
               "   AND apcb023 <> 'Y' ",          #非沖暫估單
               "   AND pmds000 NOT IN ('1','2','5','7','8','9','10','11','14','15') ", #不顯示收貨單、倉退單、驗退單
               "   AND pmdsstus='S' ",            #已庫存過帳單據
               "   AND apca001 IN ('13','17')",   #有入庫立帳者
               "   AND apcborga ='",p_apdcorga,"'",
               #要補帳務中心條件   #albireo-s
               "   AND ",p_wc2 CLIPPED,
               "   AND ",g_wc2 CLIPPED 
               
   PREPARE b_fill_pre1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR b_fill_pre1

   CALL g_pmds_d.clear()
   LET l_ac = 1
   FOREACH b_fill_curs1 USING g_enterprise INTO g_pmds_d[l_ac].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF

      #供應商名稱
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d[l_ac].pmds007) RETURNING g_pmds_d[l_ac].pmds007_desc
      
      #品名
      CALL s_desc_get_item_desc(g_pmds_d[l_ac].pmdt006) RETURNING g_pmds_d[l_ac].pmdt006_desc,l_str
      IF cl_null(g_pmds_d[l_ac].pmdt006_desc) AND NOT cl_null(l_str) THEN
         LET g_pmds_d[l_ac].pmdt006_desc = l_str
      END IF
      IF NOT cl_null(g_pmds_d[l_ac].pmdt006_desc) AND NOT cl_null(l_str) THEN
         LET g_pmds_d[l_ac].pmdt006_desc = g_pmds_d[l_ac].pmdt006_desc,"/",l_str
      END IF
      
      #來源組織名稱
      CALL s_desc_get_department_desc(g_pmds_d[l_ac].pmdtsite) RETURNING g_pmds_d[l_ac].pmdtsite_desc
      
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_pmds_d.deleteElement(g_pmds_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 單身查詢
# Memo...........:
# Usage..........: aapt430_01_query()
# Input parameter: 
# Date & Author..: 140814 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_02_query()
   WHENEVER ERROR CONTINUE
   CALL g_pmds_d.clear()
   CALL r_array.clear()
   CONSTRUCT g_wc ON pmds011,pmds007,pmdsdocno,pmdtseq,
                     pmds001,pmdt006,pmdt001,pmds048,
                     pmdtsite,apcbdocno,apcbseq
                  FROM s_detail1[1].pmds011,s_detail1[1].pmds007,s_detail1[1].pmdsdocno,s_detail1[1].pmdtseq,s_detail1[1].pmds001,
                       s_detail1[1].pmdt006,s_detail1[1].pmdt001,s_detail1[1].pmds048,s_detail1[1].pmdtsite,s_detail1[1].apcbdocno,
                       s_detail1[1].apcbseq
      BEFORE CONSTRUCT
      ON ACTION accept
         EXIT CONSTRUCT
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT CONSTRUCT 

   END CONSTRUCT

   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
   END IF

   CALL aapt430_02_b_fill(g_wc,g_apdcorga)
END FUNCTION

################################################################################
# Descriptions...: 把選取的資料拋轉到要傳出的array
# Memo...........:
# Usage..........: CALL aapt430_02_to_r_array()
# Input parameter: 
# Date & Author..: 140815 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_02_to_r_array()
   DEFINE l_i     LIKE type_t.num10
   DEFINE l_index LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET l_index = 1
   CALL r_array.clear()
   FOR l_i = 1 TO g_pmds_d.getLength()
      IF g_pmds_d[l_i].sel = 'Y' THEN
         LET r_array[l_index].apcadocno = g_pmds_d[l_i].apcbdocno
         LET r_array[l_index].apcbseq   = g_pmds_d[l_i].apcbseq
         LET r_array[l_index].apcc001   = ''
         LET l_index = l_index + 1
      END IF
   END FOR
END FUNCTION

 
{</section>}
 
