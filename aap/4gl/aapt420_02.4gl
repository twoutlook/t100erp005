#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt420_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-01-19 14:06:25), PR版次:0002(2015-01-19 14:04:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000124
#+ Filename...: aapt420_02
#+ Description: 自動產生請款資料
#+ Creator....: 03538(2014-12-13 23:36:22)
#+ Modifier...: 03538 -SD/PR- 03538
 
{</section>}
 
{<section id="aapt420_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apcc_m        RECORD
       type LIKE type_t.chr1, 
   apcadocno LIKE type_t.chr20, 
   apcc003 LIKE type_t.dat, 
   apcb028 LIKE type_t.chr20, 
   apca015 LIKE type_t.chr10, 
   apca014 LIKE type_t.chr20
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
DEFINE g_apcc_m        type_g_apcc_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt420_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt420_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_apcacomp,
   p_apcald,
   p_apca005,
   p_apcadocdt
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE r_wc            STRING   
   DEFINE p_apcacomp      LIKE apca_t.apcacomp
   DEFINE p_apcald        LIKE apca_t.apcald
   DEFINE p_apca005       LIKE apca_t.apca005
   DEFINE p_apcadocdt     LIKE apca_t.apcadocdt
   
   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt420_02 WITH FORM cl_ap_formpath("aap","aapt420_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('type','9961')
   LET g_apcc_m.type = '1'
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apcc_m.type ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            CLEAR FORM
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT r_wc ON apcadocno,apcc003,apcb028,apca015,apca014
                   FROM apcadocno,apcc003,apcb028,apca015,apca014
                   
         BEFORE CONSTRUCT
            IF g_apcc_m.type <> '2' THEN
               LET r_wc = " 1=1 "
               NEXT FIELD type 
            END IF
                 
         ON ACTION controlp INFIELD apcadocno
            #應付單號 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "     apcacomp = '",p_apcacomp,"' ",
                                   " AND apcald   = '",p_apcald,"' ",
                                   " AND apca005  = '",p_apca005,"' ",
                                   " AND apcadocdt<='",p_apcadocdt,"' ",
                                   " AND apca001 NOT LIKE '0%' "
            CALL q_apcadocno_10()
            DISPLAY g_qryparam.return1 TO apcadocno
            NEXT FIELD apcadocno

         ON ACTION controlp INFIELD apcb028
            #發票號碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = p_apcacomp
            LET g_qryparam.arg2 = p_apca005
            CALL q_isam010_7()
            DISPLAY g_qryparam.return1 TO apcb028  
            NEXT FIELD apcb028   

         ON ACTION controlp INFIELD apca015
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apca015  
            NEXT FIELD apca015        

         ON ACTION controlp INFIELD apca014
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apca014  
            NEXT FIELD apca014
            
      END CONSTRUCT             
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
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
      LET r_wc = " 1=2 "
      LET INT_FLAG = 0
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt420_02 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_wc
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt420_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt420_02.other_function" readonly="Y" >}

 
{</section>}
 
