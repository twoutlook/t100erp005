#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt430_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-12-30 10:33:04), PR版次:0001(2014-12-31 00:56:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000092
#+ Filename...: aapt430_01
#+ Description: 費用分攤來源單號項次開窗選擇
#+ Creator....: 03080(2014-08-14 15:47:33)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aapt430_01.global" >}
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
PRIVATE TYPE type_g_apcb_d        RECORD
       sel LIKE type_t.chr1, 
   apca004 LIKE type_t.chr10, 
   apca004_desc LIKE type_t.chr100, 
   apca001 LIKE type_t.chr10, 
   apcadocdt LIKE type_t.dat, 
   apcbld LIKE apcb_t.apcbld, 
   apcbdocno LIKE apcb_t.apcbdocno, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc009 LIKE apcc_t.apcc009, 
   apca036 LIKE apca_t.apca036, 
   apca036_desc LIKE type_t.chr500, 
   apca015 LIKE apca_t.apca015, 
   apca015_desc LIKE type_t.chr500, 
   apca113 LIKE apca_t.apca113, 
   sumapce119 LIKE type_t.num20_6, 
   apcb005 LIKE apcb_t.apcb005, 
   apcc119 LIKE apcc_t.apcc119, 
   apcc129 LIKE apcc_t.apcc129, 
   apcc139 LIKE apcc_t.apcc139
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE r_array DYNAMIC ARRAY OF RECORD
               apcadocno  LIKE apca_t.apcadocno,
               apcbseq    LIKE apcb_t.apcbseq,
               apcc001    LIKE apcc_t.apcc001
               END RECORD
               
DEFINE g_type        LIKE type_t.chr1
DEFINE g_wc          STRING
DEFINE g_wc2         STRING
DEFINE g_apdald      LIKE apda_t.apdald
DEFINE g_apdadocdt   LIKE apda_t.apdadocdt
DEFINE g_apca001     LIKE apca_t.apca001     #帳款單性質
DEFINE g_apceorga    LIKE apce_t.apceorga    #組織類型
DEFINE g_reqry       LIKE type_t.num5
#end add-point
 
DEFINE g_apcb_d          DYNAMIC ARRAY OF type_g_apcb_d
DEFINE g_apcb_d_t        type_g_apcb_d
 
 
DEFINE g_apcbld_t   LIKE apcb_t.apcbld    #Key值備份
DEFINE g_apcbdocno_t      LIKE apcb_t.apcbdocno    #Key值備份
DEFINE g_apcbseq_t      LIKE apcb_t.apcbseq    #Key值備份
 
 
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
 
{<section id="aapt430_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt430_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type,
   p_wc2,
   p_apdald,
   p_apdadocdt,
   p_apca001
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
   DEFINE p_type          LIKE type_t.chr1        #1:apcc_t 2:匯總
   DEFINE p_wc2           STRING                  #額外的Sql條件
   DEFINE p_apdald        LIKE apda_t.apdald
   DEFINE p_apdadocdt     LIKE apda_t.apdadocdt   #分攤日期
   DEFINE p_apca001       LIKE apca_t.apca001     #帳款單性質
   DEFINE l_scc8502       STRING

   WHENEVER ERROR CONTINUE
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt430_01 WITH FORM cl_ap_formpath("aap","aapt430_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('apca001','8502')
   #取得SCC_8502 費用分攤來源
   CALL s_aap_get_acc_str("8502"," gzcb006 = 'Y' ") RETURNING l_scc8502
   CALL cl_set_combo_scc_part('apca001','8502',l_scc8502)
 
   LET g_wc = ' 1=1'
   LET g_wc2 = p_wc2
   LET g_apdald = p_apdald
   LET g_apdadocdt = p_apdadocdt
   LET g_apca001 = p_apca001
   IF cl_null(g_wc2)THEN LET g_wc2 = ' 1=1' END IF
   LET g_type = p_type
   
   CALL aapt430_01_visible()
   CALL aapt430_01_no_visible()
   WHILE TRUE
      CALL aapt430_01_query(g_apca001)
      IF INT_FLAG THEN
         EXIT WHILE
      END IF
      CALL aapt430_01_b_fill(g_wc,g_apdald,g_apdadocdt,g_apca001)
      LET g_reqry = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_apcb_d FROM s_detail1.*
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca004
            
            #add-point:AFTER FIELD apca004 name="input.a.page1.apca004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca004
            #add-point:BEFORE FIELD apca004 name="input.b.page1.apca004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca004
            #add-point:ON CHANGE apca004 name="input.g.page1.apca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca004_desc
            #add-point:BEFORE FIELD apca004_desc name="input.b.page1.apca004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca004_desc
            
            #add-point:AFTER FIELD apca004_desc name="input.a.page1.apca004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca004_desc
            #add-point:ON CHANGE apca004_desc name="input.g.page1.apca004_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="input.b.page1.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="input.a.page1.apca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca001
            #add-point:ON CHANGE apca001 name="input.g.page1.apca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="input.b.page1.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="input.a.page1.apcadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocdt
            #add-point:ON CHANGE apcadocdt name="input.g.page1.apcadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbld
            #add-point:BEFORE FIELD apcbld name="input.b.page1.apcbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbld
            
            #add-point:AFTER FIELD apcbld name="input.a.page1.apcbld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbld
            #add-point:ON CHANGE apcbld name="input.g.page1.apcbld"
            
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
            IF NOT cl_ap_chk_range(g_apcb_d[l_ac].apcbseq,"1.000","1","","","azz-00079",1) THEN
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc001
            #add-point:BEFORE FIELD apcc001 name="input.b.page1.apcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc001
            
            #add-point:AFTER FIELD apcc001 name="input.a.page1.apcc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc001
            #add-point:ON CHANGE apcc001 name="input.g.page1.apcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc009
            #add-point:BEFORE FIELD apcc009 name="input.b.page1.apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc009
            
            #add-point:AFTER FIELD apcc009 name="input.a.page1.apcc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc009
            #add-point:ON CHANGE apcc009 name="input.g.page1.apcc009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca036
            
            #add-point:AFTER FIELD apca036 name="input.a.page1.apca036"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca036
            #add-point:BEFORE FIELD apca036 name="input.b.page1.apca036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca036
            #add-point:ON CHANGE apca036 name="input.g.page1.apca036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca036_desc
            #add-point:BEFORE FIELD apca036_desc name="input.b.page1.apca036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca036_desc
            
            #add-point:AFTER FIELD apca036_desc name="input.a.page1.apca036_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca036_desc
            #add-point:ON CHANGE apca036_desc name="input.g.page1.apca036_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca015
            
            #add-point:AFTER FIELD apca015 name="input.a.page1.apca015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca015
            #add-point:BEFORE FIELD apca015 name="input.b.page1.apca015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca015
            #add-point:ON CHANGE apca015 name="input.g.page1.apca015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca015_desc
            #add-point:BEFORE FIELD apca015_desc name="input.b.page1.apca015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca015_desc
            
            #add-point:AFTER FIELD apca015_desc name="input.a.page1.apca015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca015_desc
            #add-point:ON CHANGE apca015_desc name="input.g.page1.apca015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca113
            #add-point:BEFORE FIELD apca113 name="input.b.page1.apca113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca113
            
            #add-point:AFTER FIELD apca113 name="input.a.page1.apca113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca113
            #add-point:ON CHANGE apca113 name="input.g.page1.apca113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sumapce119
            #add-point:BEFORE FIELD sumapce119 name="input.b.page1.sumapce119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sumapce119
            
            #add-point:AFTER FIELD sumapce119 name="input.a.page1.sumapce119"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sumapce119
            #add-point:ON CHANGE sumapce119 name="input.g.page1.sumapce119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb005
            #add-point:BEFORE FIELD apcb005 name="input.b.page1.apcb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb005
            
            #add-point:AFTER FIELD apcb005 name="input.a.page1.apcb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb005
            #add-point:ON CHANGE apcb005 name="input.g.page1.apcb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc119
            #add-point:BEFORE FIELD apcc119 name="input.b.page1.apcc119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc119
            
            #add-point:AFTER FIELD apcc119 name="input.a.page1.apcc119"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc119
            #add-point:ON CHANGE apcc119 name="input.g.page1.apcc119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc129
            #add-point:BEFORE FIELD apcc129 name="input.b.page1.apcc129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc129
            
            #add-point:AFTER FIELD apcc129 name="input.a.page1.apcc129"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc129
            #add-point:ON CHANGE apcc129 name="input.g.page1.apcc129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc139
            #add-point:BEFORE FIELD apcc139 name="input.b.page1.apcc139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc139
            
            #add-point:AFTER FIELD apcc139 name="input.a.page1.apcc139"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc139
            #add-point:ON CHANGE apcc139 name="input.g.page1.apcc139"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca004
            #add-point:ON ACTION controlp INFIELD apca004 name="input.c.page1.apca004"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca004_desc
            #add-point:ON ACTION controlp INFIELD apca004_desc name="input.c.page1.apca004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="input.c.page1.apca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="input.c.page1.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbld
            #add-point:ON ACTION controlp INFIELD apcbld name="input.c.page1.apcbld"
            
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
 
 
         #Ctrlp:input.c.page1.apcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc001
            #add-point:ON ACTION controlp INFIELD apcc001 name="input.c.page1.apcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc009
            #add-point:ON ACTION controlp INFIELD apcc009 name="input.c.page1.apcc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca036
            #add-point:ON ACTION controlp INFIELD apca036 name="input.c.page1.apca036"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca036_desc
            #add-point:ON ACTION controlp INFIELD apca036_desc name="input.c.page1.apca036_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca015
            #add-point:ON ACTION controlp INFIELD apca015 name="input.c.page1.apca015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca015_desc
            #add-point:ON ACTION controlp INFIELD apca015_desc name="input.c.page1.apca015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca113
            #add-point:ON ACTION controlp INFIELD apca113 name="input.c.page1.apca113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sumapce119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sumapce119
            #add-point:ON ACTION controlp INFIELD sumapce119 name="input.c.page1.sumapce119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb005
            #add-point:ON ACTION controlp INFIELD apcb005 name="input.c.page1.apcb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc119
            #add-point:ON ACTION controlp INFIELD apcc119 name="input.c.page1.apcc119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc129
            #add-point:ON ACTION controlp INFIELD apcc129 name="input.c.page1.apcc129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc139
            #add-point:ON ACTION controlp INFIELD apcc139 name="input.c.page1.apcc139"
            
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
         CALL aapt430_01_query(g_apca001)

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
   CLOSE WINDOW w_aapt430_01 
   
   #add-point:input段after input name="input.post_input"
   CALL aapt430_01_to_r_array()
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
   CALL aapt430_01_visible()
   RETURN r_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt430_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢單身填充
# Memo...........:
# Usage..........: CALL aapt430_01_b_fill(p_wc2,p_apdald,p_apdadocdt,p_apca001)
# Input parameter: 
# Date & Author..: 140814 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_01_b_fill(p_wc2,p_apdald,p_apdadocdt,p_apca001)
DEFINE l_sql        STRING
DEFINE p_wc2        STRING
DEFINE p_apdald     LIKE apda_t.apdald
DEFINE p_apdadocdt  LIKE apda_t.apdadocdt   #分攤日期
DEFINE p_apca001    LIKE apca_t.apca001     #帳款單性質
DEFINE l_apcb       type_g_apcb_d
DEFINE l_scc8502    STRING
DEFINE l_where      STRING
DEFINE l_where2     STRING

   WHENEVER ERROR CONTINUE   
   IF cl_null(p_wc2)THEN LET p_wc2 = ' 1=1' END IF
   
   #取得SCC_8502 費用分攤來源
   CALL s_aap_get_acc_str("8502"," gzcb006 = 'Y' ") RETURNING l_scc8502
   IF NOT cl_null(l_scc8502) THEN
      LET l_where = " AND apca001 IN (",l_scc8502,")"
   ELSE
      LET l_where = " AND 1=1"
   END IF
   
   #預帶帳款單性質作where條件
   IF NOT cl_null(p_apca001) THEN
      LET l_where2 = " AND apca001 = '",p_apca001,"'"
   ELSE
      LET l_where2 = " AND 1=1"
   END IF

   CASE
      WHEN g_type = '1'
         LET l_sql = "SELECT UNIQUE 'N',apca004,'',apca001,apcadocdt,",
                     "              apcald,apcadocno,apcbseq,apcb002,",
                     "              apcb021,'',apcb010,'',apcb113,0,",
                     "              apcb005 ",
                     "  FROM apca_t,apcb_t ",
                     " WHERE apcbent   = apcaent ",
                     "   AND apcbld    = apcald  ",
                     "   AND apcbdocno = apcadocno ",
                     "   AND apcbent = ? ",
                     "   AND ",p_wc2 CLIPPED,
                     "   AND ",g_wc2 CLIPPED 
      WHEN g_type = '2'
        LET l_sql = "SELECT         'N',apca004,'',apca001,apcadocdt,",
                     "              apcald,apcadocno,0,apcb002,",
                     "              apcb021,'',apcb010,'',SUM(apcb113),0,",
                     "              apcb005 ",
                     "  FROM apca_t,apcb_t ",
                     " WHERE apcbent   = apcaent ",
                     "   AND apcbld    = apcald  ",
                     "   AND apcbdocno = apcadocno ",
                     "   AND apcbent = ? ",
                     "   AND ",p_wc2 CLIPPED,
                     "   AND ",g_wc2 CLIPPED,
                     " GROUP BY apca004,apca001,apcadocdt,apcald,apcadocno,",
                     "          apcb002,apcb021,apcb010,apcb005"
      WHEN g_type = '3' #取apca_t+apcc_t
        LET l_sql =  "SELECT 'N',apca004,'',apca001,apcadocdt,",
                     "       apcald,apcadocno,apccseq,apcc001,apcc009,",
                     "       apca036,'',apca015,'',apcc118,",
                     "       (SELECT CASE WHEN SUM(apce119) IS NULL THEN 0 ELSE SUM(apce119) END",
                     "          FROM apda_t,apce_t",
                     "         WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno",
                     "           AND apdaent = apcaent",
                     "           AND apda001 = '43'",
                     "           AND apdastus <> 'X'",
                     "           AND apce003 = apcadocno",
                     "           AND apce004 = apccseq) AS aaa",
                     "       ,'',apcc119,apcc129,apcc139",
                     "  FROM apca_t,apcc_t,apcb_t",
                     #"  FROM apca_t,apcc_t",
                     " WHERE apcaent = apccent",
                     "   AND apcald = apccld",
                     "   AND apcadocno = apccdocno",
                     "   AND apcaent = apcbent",
                     "   AND apcald = apcbld",
                     "   AND apcadocno = apcbdocno ",
                     "   AND apcaent =",g_enterprise,
                     "   AND apcald =",p_apdald,
                     "   AND apcastus = 'Y'",
                     "   AND apcadocdt <= ?",
                     "   AND apcaent = ? ",
                     #"   AND apca001 ='",p_apca001,"'",
                     #"   AND apcaorga ='",p_apceorga,"'",
                     "   AND apcc118 > (SELECT CASE WHEN SUM(apce119) IS NULL THEN 0 ELSE SUM(apce119) END",
                     "                    FROM apda_t,apce_t",
                     "                   WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno",
                     "                     AND apdaent = apcaent",
                     "                     AND apda001 = '43'",
                     "                     AND apdastus <> 'X'",
                     "                     AND apce003 = apcadocno",
                     "                     AND apce004 = apccseq)",
                     "   AND ",p_wc2 CLIPPED,
                     "   AND ",g_wc2 CLIPPED,l_where,l_where2,
                     " ORDER BY apca004,apca001,apcadocdt,apcald,apcadocno,apccseq"
   END CASE
   PREPARE b_fill_pre1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR b_fill_pre1

   CALL g_apcb_d.clear()
   LET l_ac = 1
   FOREACH b_fill_curs1 USING p_apdadocdt,g_enterprise INTO l_apcb.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF

      IF l_apcb.apca113 - l_apcb.apcc119 - l_apcb.sumapce119 > 0 THEN
         #本幣
         LET l_apcb.apca113 = l_apcb.apca113 - l_apcb.apcc119

         LET g_apcb_d[l_ac].* = l_apcb.*
         CALL s_desc_get_trading_partner_abbr_desc(g_apcb_d[l_ac].apca004) RETURNING g_apcb_d[l_ac].apca004_desc
         CALL s_desc_show1(g_apcb_d[l_ac].apca004,g_apcb_d[l_ac].apca004_desc) RETURNING g_apcb_d[l_ac].apca004_desc
         
         CALL s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apca036) RETURNING g_apcb_d[l_ac].apca036_desc
         CALL s_desc_show1(g_apcb_d[l_ac].apca036,g_apcb_d[l_ac].apca036_desc) RETURNING g_apcb_d[l_ac].apca036_desc
         
         CALL s_desc_get_department_desc(g_apcb_d[l_ac].apca015) RETURNING g_apcb_d[l_ac].apca015_desc
         CALL s_desc_show1(g_apcb_d[l_ac].apca015,g_apcb_d[l_ac].apca015_desc) RETURNING g_apcb_d[l_ac].apca015_desc
         
         LET l_ac = l_ac + 1
      END IF
   END FOREACH
   #CALL g_apcb_d.deleteElement(g_apcb_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 單身查詢
# Memo...........:
# Usage..........: aapt430_01_query(p_apca001)
# Input parameter: 
# Date & Author..: 140814 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_01_query(p_apca001)
DEFINE p_apca001       LIKE apca_t.apca001     #帳款單性質
   
   WHENEVER ERROR CONTINUE
   CALL g_apcb_d.clear()
   CALL r_array.clear()
   CONSTRUCT g_wc ON apca004_desc,apcadocdt,apcbld,apcbdocno,apcbseq
                    ,apcc001,apcc009,apca036_desc,apca015_desc,apcb005
                FROM s_detail1[1].apca004_desc,s_detail1[1].apcadocdt,s_detail1[1].apcbld,s_detail1[1].apcbdocno,s_detail1[1].apcbseq
                    ,s_detail1[1].apcc001,s_detail1[1].apcc009,s_detail1[1].apca036_desc,s_detail1[1].apca015_desc,s_detail1[1].apcb005
      
      BEFORE CONSTRUCT
         #預設顯示母程式選的帳款單性質
         LET g_apcb_d[1].apca001 = p_apca001
         DISPLAY BY NAME g_apcb_d[1].apca001
         CALL cl_set_comp_entry("apca001",FALSE)
         
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

   CALL aapt430_01_b_fill(g_wc,g_apdald,g_apdadocdt,g_apca001)
END FUNCTION

################################################################################
# Descriptions...: 把選取的資料拋轉到要傳出的array
# Memo...........:
# Usage..........: CALL aapt430_01_to_r_array()
# Input parameter: 
# Date & Author..: 140814 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_01_to_r_array()
   DEFINE l_i     LIKE type_t.num10
   DEFINE l_index LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET l_index = 1
   CALL r_array.clear()
   FOR l_i = 1 TO g_apcb_d.getLength()
      IF g_apcb_d[l_i].sel = 'Y' THEN
         LET r_array[l_index].apcadocno = g_apcb_d[l_i].apcbdocno
         LET r_array[l_index].apcbseq   = g_apcb_d[l_i].apcbseq
         LET r_array[l_index].apcc001   = g_apcb_d[l_i].apcc001
         LET l_index = l_index + 1
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: hardcode欄位隱藏 及ACTION隱藏 (開)
# Memo...........:
# Date & Author..: 14/08/14 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_01_visible()
   #CALL cl_set_comp_visible('apcbseq',TRUE)
   
   #CALL cl_set_act_visible("insert,delete", TRUE)
   CALL cl_set_act_visible("query", TRUE)
END FUNCTION

################################################################################
# Descriptions...: hardcode欄位隱藏及ACTION隱藏(關)
# Memo...........:
# Date & Author..: 14/08/14 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_01_no_visible()
   #IF g_type = '2' THEN    
   #   CALL cl_set_comp_visible('apcbseq',FALSE)
   #END IF
   
   CALL cl_set_act_visible("insert,delete", FALSE)
END FUNCTION

 
{</section>}
 
