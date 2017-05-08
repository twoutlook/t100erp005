#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp350_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-07 10:43:28), PR版次:0002(2016-08-22 11:40:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: asfp350_01
#+ Description: 回收料號
#+ Creator....: 02040(2016-07-07 10:37:52)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="asfp350_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160819-00023#1 160822 By 02040  QBE條件，工單單號開窗改為q_sfaadocno_3要顯示部門
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
GLOBALS "../../asf/4gl/asfp350.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_sfeb_d        RECORD
       sfebseq LIKE sfeb_t.sfebseq, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb004_desc LIKE type_t.chr500, 
   sfeb004_desc_1 LIKE type_t.chr500, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb005_desc LIKE type_t.chr500, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb013_desc LIKE type_t.chr500, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb014_desc LIKE type_t.chr500, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb016_desc LIKE type_t.chr500, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb007_desc LIKE type_t.chr500, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb010_desc LIKE type_t.chr500, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfebdocno LIKE sfeb_t.sfebdocno
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_sfeb_d          DYNAMIC ARRAY OF type_g_sfeb_d
DEFINE g_sfeb_d_t        type_g_sfeb_d
 
 
DEFINE g_sfebdocno_t   LIKE sfeb_t.sfebdocno    #Key值備份
DEFINE g_sfebseq_t      LIKE sfeb_t.sfebseq    #Key值備份
 
 
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
 
{<section id="asfp350_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asfp350_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asfp350_01 WITH FORM cl_ap_formpath("asf","asfp350_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_sfeb_d FROM s_detail1.*
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
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb004
            
            #add-point:AFTER FIELD sfeb004 name="input.a.page1.sfeb004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb004
            #add-point:BEFORE FIELD sfeb004 name="input.b.page1.sfeb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb004
            #add-point:ON CHANGE sfeb004 name="input.g.page1.sfeb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb005
            
            #add-point:AFTER FIELD sfeb005 name="input.a.page1.sfeb005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb005
            #add-point:BEFORE FIELD sfeb005 name="input.b.page1.sfeb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb005
            #add-point:ON CHANGE sfeb005 name="input.g.page1.sfeb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="input.a.page1.sfeb013"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="input.b.page1.sfeb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb013
            #add-point:ON CHANGE sfeb013 name="input.g.page1.sfeb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="input.a.page1.sfeb014"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="input.b.page1.sfeb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb014
            #add-point:ON CHANGE sfeb014 name="input.g.page1.sfeb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb015
            #add-point:BEFORE FIELD sfeb015 name="input.b.page1.sfeb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb015
            
            #add-point:AFTER FIELD sfeb015 name="input.a.page1.sfeb015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb015
            #add-point:ON CHANGE sfeb015 name="input.g.page1.sfeb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb016
            
            #add-point:AFTER FIELD sfeb016 name="input.a.page1.sfeb016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb016
            #add-point:BEFORE FIELD sfeb016 name="input.b.page1.sfeb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb016
            #add-point:ON CHANGE sfeb016 name="input.g.page1.sfeb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb007
            
            #add-point:AFTER FIELD sfeb007 name="input.a.page1.sfeb007"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb007
            #add-point:BEFORE FIELD sfeb007 name="input.b.page1.sfeb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb007
            #add-point:ON CHANGE sfeb007 name="input.g.page1.sfeb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb008
            #add-point:BEFORE FIELD sfeb008 name="input.b.page1.sfeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb008
            
            #add-point:AFTER FIELD sfeb008 name="input.a.page1.sfeb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb008
            #add-point:ON CHANGE sfeb008 name="input.g.page1.sfeb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb010
            
            #add-point:AFTER FIELD sfeb010 name="input.a.page1.sfeb010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb010
            #add-point:BEFORE FIELD sfeb010 name="input.b.page1.sfeb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb010
            #add-point:ON CHANGE sfeb010 name="input.g.page1.sfeb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb011
            #add-point:BEFORE FIELD sfeb011 name="input.b.page1.sfeb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb011
            
            #add-point:AFTER FIELD sfeb011 name="input.a.page1.sfeb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb011
            #add-point:ON CHANGE sfeb011 name="input.g.page1.sfeb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebdocno
            #add-point:BEFORE FIELD sfebdocno name="input.b.page1.sfebdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebdocno
            
            #add-point:AFTER FIELD sfebdocno name="input.a.page1.sfebdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfebdocno
            #add-point:ON CHANGE sfebdocno name="input.g.page1.sfebdocno"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sfeb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb004
            #add-point:ON ACTION controlp INFIELD sfeb004 name="input.c.page1.sfeb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb005
            #add-point:ON ACTION controlp INFIELD sfeb005 name="input.c.page1.sfeb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="input.c.page1.sfeb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="input.c.page1.sfeb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb015
            #add-point:ON ACTION controlp INFIELD sfeb015 name="input.c.page1.sfeb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb016
            #add-point:ON ACTION controlp INFIELD sfeb016 name="input.c.page1.sfeb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb007
            #add-point:ON ACTION controlp INFIELD sfeb007 name="input.c.page1.sfeb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb008
            #add-point:ON ACTION controlp INFIELD sfeb008 name="input.c.page1.sfeb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb010
            #add-point:ON ACTION controlp INFIELD sfeb010 name="input.c.page1.sfeb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb011
            #add-point:ON ACTION controlp INFIELD sfeb011 name="input.c.page1.sfeb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfebdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebdocno
            #add-point:ON ACTION controlp INFIELD sfebdocno name="input.c.page1.sfebdocno"
            
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
   CLOSE WINDOW w_asfp350_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asfp350_01.other_dialog" readonly="Y" >}

DIALOG asfp350_01_construct()

         CONSTRUCT BY NAME g_wc ON sfaa010,sfaadocno,sfaa017,sfaa016
            BEFORE CONSTRUCT
                CALL cl_qbe_init()
                
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
               NEXT FIELD sfaa010                     #返回原欄位 


            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF g_input.l_wo_type = '1' THEN
                  LET g_qryparam.where = " sfaa057 ='1' AND sfaasite = '",g_site,"'"
               ELSE
                 LET g_qryparam.where = " sfaa057 ='2' AND sfaasite = '",g_site,"'"," AND sfaa017 = '",g_input.pmds007,"'"
               END IF
              #CALL q_sfaadocno_1()                     #呼叫開窗  #160819-00023#1 mark
               CALL q_sfaadocno_3()                     #呼叫開窗  #160819-00023#1 add
               DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
               NEXT FIELD sfaadocno                     #返回原欄位 


            ON ACTION controlp INFIELD sfaa017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
               NEXT FIELD sfaa017                     #返回原欄位


            ON ACTION controlp INFIELD sfaa016                
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ecba002()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa016  #顯示到畫面上
               NEXT FIELD sfaa016                     #返回原欄位

         END CONSTRUCT
END DIALOG

DIALOG asfp350_01_input_01()
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_pmds007_desc LIKE type_t.chr80
   
       INPUT g_input.l_wo_type,g_input.pmds007,l_pmds007_desc,g_input.sfma001,g_input.sfeadocdt,g_input.l_sdt,g_input.l_edt,g_input.sfba003,g_input.sfba004
         FROM l_wo_type,pmds007,pmds007_desc,sfma001,sfeadocdt,l_sdt,l_edt,sfba003,sfba004 ATTRIBUTE(WITHOUT DEFAULTS)
           
           BEFORE INPUT
             CALL asfp350_01_set_entry()
             CALL asfp350_01_set_no_entry()
             
           ON ACTION controlp INFIELD pmds007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pmaa001 IN (SELECT pmab001 FROM pmab_t ",                                             
                                   "             WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1)" 
            LET g_qryparam.default1 = g_input.pmds007   
            CALL q_pmaa001_3()                              
            LET g_input.pmds007 = g_qryparam.return1     
            DISPLAY g_input.pmds007 TO pmds007 
            CALL s_desc_get_trading_partner_abbr_desc(g_input.pmds007) RETURNING l_pmds007_desc              
            DISPLAY l_pmds007_desc TO pmds007_desc           
 
         AFTER FIELD pmds007 
            IF NOT cl_null(g_input.pmds007) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_input.pmds007
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  NEXT FIELD CURRENT         
              END IF 
              CALL s_desc_get_trading_partner_abbr_desc(g_input.pmds007) RETURNING l_pmds007_desc              
              DISPLAY l_pmds007_desc TO pmds007_desc
            END IF
            
         ON ACTION controlp INFIELD sfba003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_sfcb003_4()
            LET g_input.sfba003 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_input.sfba003                 #顯示到畫面上            
            NEXT FIELD sfba003   

         ON ACTION controlp INFIELD sfba004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_sfcb004_2()
            LET g_input.sfba004 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_input.sfba004                 #顯示到畫面上            
            NEXT FIELD sfba004  
            
            
          ON CHANGE sfma001
             CALL asfp350_01_set_entry()
             CALL asfp350_01_set_no_entry()
             
          ON CHANGE l_wo_type
             CALL asfp350_01_set_entry()
             CALL asfp350_01_set_no_entry()


       END INPUT  

END DIALOG

################################################################################
# Descriptions...: 回收料頁籤輸入段
# Memo...........:
# Usage..........: CALL asfp350_01_input_02()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160622-00017#1 By 02040
# Modify.........:
################################################################################
DIALOG asfp350_01_input_02()
 DEFINE l_cmd     LIKE type_t.chr5
 DEFINE l_count   LIKE type_t.num5
 DEFINE l_ac_t    LIKE type_t.num10
 DEFINE l_imaa005 LIKE imaa_t.imaa005
 DEFINE l_success    LIKE type_t.num5
    
    INPUT ARRAY g_sfeb_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS,
                      INSERT ROW = TRUE,
                      DELETE ROW = TRUE,
                      APPEND ROW = TRUE)                  
                   
         
         BEFORE INPUT           
      
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            IF g_rec_b >= l_ac
               AND g_sfeb_d[l_ac].sfebseq IS NOT NULL

            THEN            
               LET l_ac_t = l_ac
               LET l_ac = ARR_CURR()
               LET g_detail_idx = l_ac
               LET l_cmd='u'
               LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*
            ELSE
               LET l_cmd='a'
            END IF
            CALL asfp350_01_set_entry_b()
            CALL asfp350_01_set_no_entry_b()  

         AFTER FIELD sfeb004
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb004) THEN
               IF g_sfeb_d[l_ac].sfeb004 <> g_sfeb_d_t.sfeb004 OR cl_null(g_sfeb_d_t.sfeb004) THEN
               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb004
                  IF NOT cl_chk_exist("v_imaf001_1") THEN
                     LET g_sfeb_d[l_ac].sfeb004 = g_sfeb_d_t.sfeb004
                     NEXT FIELD CURRENT
                  END IF
                  #帶預設值
                  SELECT imaf015
                    INTO g_sfeb_d[l_ac].sfeb010
                    FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_sfeb_d[l_ac].sfeb004
                  SELECT imae016,imae041,imae042
                    INTO g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014
                    FROM imae_t
                   WHERE imaeent = g_enterprise
                     AND imaesite = g_site
                     AND imae001 = g_sfeb_d[l_ac].sfeb004                    
                     
                  CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb007) RETURNING g_sfeb_d[l_ac].sfeb007_desc
                    DISPLAY BY NAME g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb007_desc
                  CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb010) RETURNING g_sfeb_d[l_ac].sfeb010_desc
                    DISPLAY BY NAME g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb010_desc              
                  CALL s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013) RETURNING g_sfeb_d[l_ac].sfeb013_desc            
                    DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb013_desc              
                  CALL s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014) RETURNING g_sfeb_d[l_ac].sfeb014_desc
                    DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb014_desc                    
               END IF
               LET g_sfeb_d_t.sfeb004 = g_sfeb_d[l_ac].sfeb004
            END IF
            CALL asfp350_01_set_entry_b()
            CALL asfp350_01_set_no_entry_b()             
            CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
              RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_1            
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_1
        
         ON ACTION controlp INFIELD sfeb004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()             
            LET g_sfeb_d[l_ac].sfeb004 = g_qryparam.return1
            DISPLAY g_sfeb_d[l_ac].sfeb004 TO sfeb004        
            NEXT FIELD CURRENT 
            CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
              RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_1            
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_1
          

         AFTER FIELD sfeb007
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb007) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb004
               LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb007
               IF NOT cl_chk_exist("v_imao002") THEN
                  NEXT FIELD CURRENT
               END IF           
            END IF            
            CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb007) RETURNING g_sfeb_d[l_ac].sfeb007_desc
              DISPLAY BY NAME g_sfeb_d[l_ac].sfeb007_desc

         #單位
         ON ACTION controlp INFIELD sfeb007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb007           #給予default值
            LET g_qryparam.arg1 = g_sfeb_d[l_ac].sfeb004
            CALL q_imao002()                                           #呼叫開窗
            LET  g_sfeb_d[l_ac].sfeb007 = g_qryparam.return1            #將開窗取得的值回傳到變數
            DISPLAY g_sfeb_d[l_ac].sfeb007 TO sfeb007                  #顯示到畫面上
            CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb007) RETURNING g_sfeb_d[l_ac].sfeb007_desc
            NEXT FIELD CURRENT                                        #返回原欄位
         
         AFTER FIELD sfeb010
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb010) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb004
               LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb010
               IF NOT cl_chk_exist("v_imao002") THEN
                  NEXT FIELD CURRENT
               END IF             
            END IF            
            CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb010) RETURNING g_sfeb_d[l_ac].sfeb010_desc
              DISPLAY BY NAME g_sfeb_d[l_ac].sfeb010_desc

         #參考單位
         ON ACTION controlp INFIELD sfeb010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb010           #給予default值
            LET g_qryparam.arg1 = g_sfeb_d[l_ac].sfeb004
            CALL q_imao002()                                           #呼叫開窗
            LET  g_sfeb_d[l_ac].sfeb010 = g_qryparam.return1            #將開窗取得的值回傳到變數
            DISPLAY g_sfeb_d[l_ac].sfeb010 TO sfeb010                  #顯示到畫面上
            CALL s_desc_get_unit_desc(g_sfeb_d[l_ac].sfeb010) RETURNING g_sfeb_d[l_ac].sfeb010_desc
            NEXT FIELD CURRENT                                         #返回原欄位

         AFTER FIELD sfeb013
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb013) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb013
               IF NOT cl_chk_exist("v_inaa001") THEN
                  NEXT FIELD CURRENT               
               END IF
               CALL s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013) RETURNING g_sfeb_d[l_ac].sfeb013_desc
               DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013_desc              
            END IF            


         #庫位
         ON ACTION controlp INFIELD sfeb013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb013    
            LET g_qryparam.arg1 = g_site
            CALL q_inaa001_6()
            LET g_sfeb_d[l_ac].sfeb013 = g_qryparam.return1
            DISPLAY g_sfeb_d[l_ac].sfeb013 TO sfeb013
            CALL s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013) RETURNING g_sfeb_d[l_ac].sfeb013_desc            
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013_desc              
            NEXT FIELD CURRENT

         AFTER FIELD sfeb014
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb014) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb013
               LET g_chkparam.arg3 = g_sfeb_d[l_ac].sfeb014
               IF NOT cl_chk_exist("v_inab002") THEN
                  NEXT FIELD CURRENT
               END IF                     
            END IF            
            CALL s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014) RETURNING g_sfeb_d[l_ac].sfeb014_desc
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014_desc              
         
         #儲位
         ON ACTION controlp INFIELD sfeb014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb014  #給予default值
            LET g_qryparam.arg1 = g_sfeb_d[l_ac].sfeb013
            CALL q_inab002_3()
            LET g_sfeb_d[l_ac].sfeb014 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_sfeb_d[l_ac].sfeb014 TO sfeb014         #顯示到畫面上
            CALL s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014) RETURNING g_sfeb_d[l_ac].sfeb014_desc
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014_desc
            NEXT FIELD CURRENT


         AFTER FIELD sfeb015
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb015) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb004
               LET g_chkparam.arg3 = g_sfeb_d[l_ac].sfeb005
               LET g_chkparam.arg4 = g_sfeb_d[l_ac].sfeb013
               LET g_chkparam.arg5 = g_sfeb_d[l_ac].sfeb014
               LET g_chkparam.arg6 = g_sfeb_d[l_ac].sfeb015
               IF NOT cl_chk_exist("v_inag006_1") THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

        AFTER FIELD sfeb005
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb005) THEN        
               IF NOT s_feature_check(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005) THEN
                  NEXT FIELD CURRENT            
               END IF
            END IF

         ON ACTION sfeb005
            LET l_imaa005 = ''
            CALL s_axmt500_get_imaa005(g_enterprise,g_sfeb_d[l_ac].sfeb004) 
              RETURNING l_imaa005  
            IF NOT cl_null(l_imaa005) THEN
               CALL s_feature_single(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_site,'')
                 RETURNING l_success,g_sfeb_d[l_ac].sfeb005               
               NEXT FIELD CURRENT
            END IF   


         BEFORE INSERT
           LET l_cmd = 'a'
           INITIALIZE g_sfeb_d[l_ac].* TO NULL
           INITIALIZE g_sfeb_d_t.* TO NULL   
           
           
           SELECT MAX(sfebseq)+1 INTO g_sfeb_d[l_ac].sfebseq
             FROM p350_01_temp
           IF cl_null(g_sfeb_d[l_ac].sfebseq) OR g_sfeb_d[l_ac].sfebseq = 0 THEN 
              LET g_sfeb_d[l_ac].sfebseq = 1
           END IF
           LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*               
            
         AFTER FIELD sfeb008
              IF NOT cl_ap_chk_range(g_sfeb_d[l_ac].sfeb008,"0.000","0","","","azz-00079",1) THEN
                 NEXT FIELD sfeb008
              END IF         
          
         AFTER INSERT

            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
              #CANCEL INSERT
            END IF
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM p350_01_temp 
             WHERE sfebseq = g_sfeb_d[l_ac].sfebseq
            #資料未重複, 插入新增資料
            IF l_count = 0  THEN 
               IF NOT cl_null(g_sfeb_d[g_detail_idx].sfeb004) THEN 
                  IF cl_null(g_sfeb_d[g_detail_idx].sfeb005) THEN 
                     LET g_sfeb_d[g_detail_idx].sfeb005 = ' '
                  END IF
                  INSERT INTO p350_01_temp(sfebseq,sfeb004,sfeb005,sfeb013,sfeb014,
                                           sfeb015,sfeb016,sfeb007,sfeb008,sfeb010,
                                           sfeb011)
                    VALUES (g_sfeb_d[g_detail_idx].sfebseq,g_sfeb_d[g_detail_idx].sfeb004,g_sfeb_d[g_detail_idx].sfeb005,g_sfeb_d[g_detail_idx].sfeb013,g_sfeb_d[g_detail_idx].sfeb014,
                            g_sfeb_d[g_detail_idx].sfeb015,g_sfeb_d[g_detail_idx].sfeb016,g_sfeb_d[g_detail_idx].sfeb007,g_sfeb_d[g_detail_idx].sfeb008,g_sfeb_d[g_detail_idx].sfeb010,
                            g_sfeb_d[g_detail_idx].sfeb011)                      
               END IF             
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_sfeb_d[l_ac].* TO NULL
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins p350_01_temp:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()                               
            END IF   
            

         ON ROW CHANGE
            IF cl_null(g_sfeb_d[g_detail_idx].sfeb005) THEN 
               LET g_sfeb_d[g_detail_idx].sfeb005 = ' '
            END IF            
            UPDATE p350_01_temp 
               SET sfeb004 = g_sfeb_d[g_detail_idx].sfeb004,
                   sfeb005 = g_sfeb_d[g_detail_idx].sfeb005,
                   sfeb013 = g_sfeb_d[g_detail_idx].sfeb013,
                   sfeb014 = g_sfeb_d[g_detail_idx].sfeb014,
                   sfeb015 = g_sfeb_d[g_detail_idx].sfeb015,
                   sfeb016 = g_sfeb_d[g_detail_idx].sfeb016,
                   sfeb007 = g_sfeb_d[g_detail_idx].sfeb007,
                   sfeb008 = g_sfeb_d[g_detail_idx].sfeb008,
                   sfeb010 = g_sfeb_d[g_detail_idx].sfeb010,
                   sfeb011 = g_sfeb_d[g_detail_idx].sfeb011
             WHERE sfebseq = g_sfeb_d[g_detail_idx].sfebseq
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "up p350_01_temp:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()                             
            END IF   

         END INPUT

END DIALOG

 
{</section>}
 
{<section id="asfp350_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 回收料頁籤init
# Memo...........:
# Usage..........: CALL asfp350_01_init()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160622-00017#1 By 02040
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp350_01_init()

   WHENEVER ERROR CONTINUE 
   
   LET g_input.sfeadocdt = g_today
   CALL s_date_get_first_date(g_today) RETURNING g_input.l_sdt 
   LET g_input.l_edt = g_today
   LET g_input.l_wo_type = '1'
   LET g_input.sfma001 = '1'
   CALL cl_set_combo_scc_part('sfma001','5401','1,3')
   
    
    LET g_detail_cnt = 256
    
END FUNCTION
#欄位開放設定
PUBLIC FUNCTION asfp350_01_set_entry()
  CALL cl_set_comp_entry("pmds007,sfba003,sfba004,l_wo_type",TRUE) 
END FUNCTION
#欄位開放設定
PUBLIC FUNCTION asfp350_01_set_no_entry()
   #委外工單只能用入庫分攤
   IF g_input.sfma001 = '3' THEN
      CALL cl_set_comp_entry("l_wo_type",FALSE)
      LET g_input.l_wo_type = '1'   
   END IF
   IF g_input.sfma001 = '1' THEN
      CALL cl_set_comp_entry("sfba003",FALSE)
      LET g_input.sfba003 = ''
      CALL cl_set_comp_entry("sfba004",FALSE)
      LET g_input.sfba004 = ''      
   END IF

   IF g_input.l_wo_type = '1'  THEN
      CALL cl_set_comp_entry("pmds007",FALSE)
      LET g_input.pmds007 = ''
   END IF

END FUNCTION
################################################################################
# Descriptions...: 產生分攤明細前檢查
# Memo...........:
# Usage..........: CALL asfp350_01_execute_chk()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160709 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp350_01_execute_chk()
DEFINE l_count    LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5 

    WHENEVER ERROR CONTINUE 
    
    LET r_success = TRUE
    
    IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = ''
       LET g_errparam.code   = 'axm-00229'  #請先輸入料號！
       LET g_errparam.popup  = TRUE
       CALL cl_err()      
       LET r_success = FALSE
       RETURN r_success
    END IF

    IF g_detail_idx > 0 AND NOT cl_null(g_sfeb_d[g_detail_idx].sfeb004) THEN
       IF cl_null(g_sfeb_d[g_detail_idx].sfeb005) THEN 
          LET g_sfeb_d[g_detail_idx].sfeb005 = ' '
       END IF 
       LET l_count = 0
       SELECT COUNT(1) INTO l_count FROM p350_01_temp 
        WHERE sfebseq = g_sfeb_d[g_detail_idx].sfebseq    
       IF l_count = 0 THEN
       
          INSERT INTO p350_01_temp(sfebseq,sfeb004,sfeb005,sfeb013,sfeb014,
                                   sfeb015,sfeb016,sfeb007,sfeb008,sfeb010,
                                   sfeb011)
            VALUES (g_sfeb_d[g_detail_idx].sfebseq,g_sfeb_d[g_detail_idx].sfeb004,g_sfeb_d[g_detail_idx].sfeb005,g_sfeb_d[g_detail_idx].sfeb013,g_sfeb_d[g_detail_idx].sfeb014,
                    g_sfeb_d[g_detail_idx].sfeb015,g_sfeb_d[g_detail_idx].sfeb016,g_sfeb_d[g_detail_idx].sfeb007,g_sfeb_d[g_detail_idx].sfeb008,g_sfeb_d[g_detail_idx].sfeb010,
                    g_sfeb_d[g_detail_idx].sfeb011)       
       ELSE
           UPDATE p350_01_temp 
              SET sfeb004 = g_sfeb_d[g_detail_idx].sfeb004,
                  sfeb005 = g_sfeb_d[g_detail_idx].sfeb005,
                  sfeb013 = g_sfeb_d[g_detail_idx].sfeb013,
                  sfeb014 = g_sfeb_d[g_detail_idx].sfeb014,
                  sfeb015 = g_sfeb_d[g_detail_idx].sfeb015,
                  sfeb016 = g_sfeb_d[g_detail_idx].sfeb016,
                  sfeb007 = g_sfeb_d[g_detail_idx].sfeb007,
                  sfeb008 = g_sfeb_d[g_detail_idx].sfeb008,
                  sfeb010 = g_sfeb_d[g_detail_idx].sfeb010,
                  sfeb011 = g_sfeb_d[g_detail_idx].sfeb011
             WHERE sfebseq = g_sfeb_d[g_detail_idx].sfebseq       
       END IF    
    END IF
    LET l_count = 0
    SELECT COUNT(*) INTO l_count FROM p350_01_temp     
    IF l_count = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = ''
       LET g_errparam.code   = 'axm-00229'  #請先輸入料號！
       LET g_errparam.popup  = TRUE
       CALL cl_err()      
       LET r_success = FALSE
       RETURN r_success
    END IF
    RETURN r_success
    

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
PUBLIC FUNCTION asfp350_01_b_fill()
  DEFINE l_sql  STRING
  DEFINE l_ac_t      LIKE type_t.num5
  DEFINE l_cnt       LIKE type_t.num5

  INITIALIZE g_sfeb_d TO NULL
  
{  
  LET l_sql = "SELECT sfebseq,sfeb004,'',     '',sfeb005, ",
              "            '',sfeb013,'',sfeb014,     '', ",
              "       sfeb015,sfeb016,'',sfeb007,     '', ",
              "       sfeb008,sfeb010,'',     '' ",
              "   FROM p350_01_temp "
}

  LET l_sql = "SELECT sfebseq,sfeb004, ",
              " (SELECT imaal003 FROM imaal_t WHERE imaal001 = sfeb004 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') imaal003, ",
              " (SELECT imaal004 FROM imaal_t WHERE imaal001 = sfeb004 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') imaal004, ",          
              " sfeb005, ",
              " (SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = sfeb004 AND inaml002 = sfeb005 AND inaml003 = '",g_dlang,"') inaml004,",
              " sfeb013, ",
              " (SELECT inaa002 FROM inaa_t WHERE inaaent= ",g_enterprise," AND inaasite= '",g_site,"' AND inaa001=sfeb013) inaa001, ",              
              " sfeb014, ",
              " (SELECT inab003 FROM inab_t WHERE inabent=",g_enterprise," AND inab001=sfeb013 AND inab002=sfeb014 AND inabsite='",g_site," ') inab003, ",              
              "       sfeb015,sfeb016,'', ",
              " sfeb007, ",
              " (SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=sfeb007 AND oocal002='",g_dlang,"') oocal003,",
              " sfeb008, ",
              " sfeb010, ",
              " (SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=sfeb010 AND oocal002='",g_dlang,"') oocal003_1,",
              "      '' ",
              "   FROM p350_01_temp "

  PREPARE asfp350_01_sel_pr FROM l_sql
  DECLARE asfp350_01_sel_cs CURSOR FOR asfp350_01_sel_pr
   
  LET l_ac_t = l_ac    
  LET l_ac = 1

  FOREACH asfp350_01_sel_cs INTO g_sfeb_d[l_ac].* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp350_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF  
  END FOREACH
  CALL g_sfeb_d.deleteElement(l_ac)
  LET g_detail_cnt = l_ac - 1  
  LET l_ac = l_ac_t
END FUNCTION
#單身欄位開放
PRIVATE FUNCTION asfp350_01_set_entry_b()
  CALL cl_set_comp_entry("sfeb005,sfeb015,sfeb010,sfeb011,sfeb016",TRUE) 
END FUNCTION
#單身欄位開放
PRIVATE FUNCTION asfp350_01_set_no_entry_b()
DEFINE l_imaa005 LIKE imaa_t.imaa005
DEFINE l_imaf061 LIKE imaf_t.imaf061
DEFINE l_imaf015 LIKE imaf_t.imaf015
DEFINE l_imaf055 LIKE imaf_t.imaf055
DEFINE l_inaa007 LIKE inaa_t.inaa007  
   
   IF cl_null(g_sfeb_d[l_ac].sfeb004) THEN
      CALL cl_set_comp_entry("sfeb005",FALSE)
      CALL cl_set_comp_required("sfeb005",FALSE)   
   ELSE
      LET l_imaa005 = ''
      LET l_imaf015 = ''
      LET l_imaf055 = ''
      LET l_imaf061 = ''
      SELECT imaa005 INTO l_imaa005
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_sfeb_d[l_ac].sfeb004
      SELECT imaf015,imaf055,imaf061 
        INTO l_imaf015,l_imaf055,l_imaf061
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_sfeb_d[l_ac].sfeb004         
      #料件主檔無特徵類別，不能維護產品特徵
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
         LET l_imaa005 = ''
         CALL s_axmt500_get_imaa005(g_enterprise,g_sfeb_d[l_ac].sfeb004) RETURNING l_imaa005
         IF cl_null(l_imaa005) THEN
            CALL cl_set_comp_entry("sfeb005",FALSE)
            LET g_sfeb_d[l_ac].sfeb005 = ' '   
            LET g_sfeb_d[l_ac].sfeb005_desc = ' '            
         END IF
      END IF
      #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
      IF l_imaf061 NOT MATCHES '[13]' THEN
         LET g_sfeb_d[l_ac].sfeb015 = ' '
         CALL cl_set_comp_entry("sfeb015",FALSE)
      END IF
      #儲位控管若為5.不使用儲位控管，則不能維護儲位
      IF NOT cl_null(g_sfeb_d[l_ac].sfeb014) THEN
         LET l_inaa007 = ''
         SELECT inaa007 INTO l_inaa007
           FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = g_sfeb_d[l_ac].sfeb014
         IF l_inaa007 = '5' THEN
            CALL cl_set_comp_entry("sfeb014",FALSE)
            LET g_sfeb_d[l_ac].sfeb014 = ''  
            LET g_sfeb_d[l_ac].sfeb014_desc = ''
         END IF
      END IF
      #參考單位、參考數量
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
         LET g_sfeb_d[l_ac].sfeb010 = ''
         LET g_sfeb_d[l_ac].sfeb011 = ''
         LET g_sfeb_d[l_ac].sfeb010_desc = ''
      ELSE
         IF cl_null(l_imaf015) THEN
            CALL cl_set_comp_entry("sfeb010,sfeb011",FALSE)
            LET g_sfeb_d[l_ac].sfeb010 = ''
            LET g_sfeb_d[l_ac].sfeb011 = ''
            LET g_sfeb_d[l_ac].sfeb010_desc = ''
         END IF
      END IF
      #若無使用庫存管理特徵時，則不允許輸入
      IF l_imaf055 = '2' THEN
         CALL cl_set_comp_entry("sfeb016",FALSE)
         LET g_sfeb_d[l_ac].sfeb016 = ''
         LET g_sfeb_d[l_ac].sfeb016_desc = ''
      END IF      
   END IF            
END FUNCTION

 
{</section>}
 
