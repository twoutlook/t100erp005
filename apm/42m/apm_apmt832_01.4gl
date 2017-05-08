{<section id="apmt832_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000029
#+ 
#+ Filename...: apmt832_01
#+ Description: ...
#+ Creator....: 01533(2014/03/25)
#+ Modifier...: 01533(2014/03/26) -SD/PR- 00000(2013/01/01)
#+ Buildtype..: 應用 c01b 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="apmt832_01.global" >}

 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmcp_m        RECORD
       pmcp009 LIKE pmcp_t.pmcp009, 
   pmcp007 LIKE pmcp_t.pmcp007, 
   pmcp011 LIKE pmcp_t.pmcp011, 
   pmcp008 LIKE pmcp_t.pmcp008, 
   pmcp008_desc LIKE type_t.chr80, 
   pmcp005 LIKE pmcp_t.pmcp005
       END RECORD
DEFINE g_pmcp_m        type_g_pmcp_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="apmt832_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt832_01(--)
   #add-point:input段變數傳入
   
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt832_01 WITH FORM cl_ap_formpath("apm","apmt832_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pmcp_m.pmcp009,g_pmcp_m.pmcp007,g_pmcp_m.pmcp011,g_pmcp_m.pmcp008,g_pmcp_m.pmcp005  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理
            
            #end add-point
          
                  #此段落由子樣板a01產生
         BEFORE FIELD pmcp009
            #add-point:BEFORE FIELD pmcp009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pmcp009
            
            #add-point:AFTER FIELD pmcp009
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pmcp009
            #add-point:ON CHANGE pmcp009
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pmcp007
            #add-point:BEFORE FIELD pmcp007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pmcp007
            
            #add-point:AFTER FIELD pmcp007
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pmcp007
            #add-point:ON CHANGE pmcp007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pmcp011
            #add-point:BEFORE FIELD pmcp011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pmcp011
            
            #add-point:AFTER FIELD pmcp011
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pmcp011
            #add-point:ON CHANGE pmcp011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pmcp008
            
            #add-point:AFTER FIELD pmcp008

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcp_m.pmcp008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcp_m.pmcp008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmcp_m.pmcp008_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD pmcp008
            #add-point:BEFORE FIELD pmcp008
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE pmcp008
            #add-point:ON CHANGE pmcp008
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pmcp005
            #add-point:BEFORE FIELD pmcp005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pmcp005
            
            #add-point:AFTER FIELD pmcp005

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcp_m.pmcp005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcp_m.pmcp005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmcp_m.pmcp005_desc

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pmcp005
            #add-point:ON CHANGE pmcp005
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.pmcp009
         ON ACTION controlp INFIELD pmcp009
            #add-point:ON ACTION controlp INFIELD pmcp009
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcp_m.pmcp009             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pmcp_m.pmcp009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcp_m.pmcp009 TO pmcp009              #顯示到畫面上

            NEXT FIELD pmcp009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.pmcp007
#         ON ACTION controlp INFIELD pmcp007
            #add-point:ON ACTION controlp INFIELD pmcp007
            
            #END add-point
 
         #Ctrlp:input.c.pmcp011
#         ON ACTION controlp INFIELD pmcp011
            #add-point:ON ACTION controlp INFIELD pmcp011
            
            #END add-point
 
         #Ctrlp:input.c.pmcp008
         ON ACTION controlp INFIELD pmcp008
            #add-point:ON ACTION controlp INFIELD pmcp008
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcp_m.pmcp008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmcp_m.pmcp008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcp_m.pmcp008 TO pmcp008              #顯示到畫面上

            NEXT FIELD pmcp008                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.pmcp005
         ON ACTION controlp INFIELD pmcp005
            #add-point:ON ACTION controlp INFIELD pmcp005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcp_m.pmcp005             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pmcp_m.pmcp005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcp_m.pmcp005 TO pmcp005              #顯示到畫面上

            NEXT FIELD pmcp005                          #返回原欄位


            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input
      
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
 
   #add-point:畫面關閉前
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt832_01 
   
   #add-point:input段after input 
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt832_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt832_01.other_function" readonly="Y" >}

 
{</section>}
 
