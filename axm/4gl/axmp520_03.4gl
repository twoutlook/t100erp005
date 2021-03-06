#該程式已解開Section, 不再透過樣板產出!
{<section id="axmp520_03.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000015
#+ 
#+ Filename...: axmp520_03
#+ Description: 多庫儲批維護
#+ Creator....: 02040(2015-06-05 10:16:50)
#+ Modifier...: 02040(2015-07-21 10:31:31) -SD/PR- 02040
 
{</section>}
 
{<section id="axmp520_03.global" >}
#應用 c02b 樣板自動產生(Version:5)
#160727-00019#23   2016/08/15 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   p520_02_xmdi_temp--> p520_tmp03 
#160727-00019#24   2016/08/15 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                          Mod   axmp580_02_temp_d3--> axmp580_tmp03
#161006-00018#24  2017/01/16 By 02040      增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS "../../axm/4gl/axmp520_01.inc"    #161006-00018#24 add
GLOBALS "../../axm/4gl/axmp520_02.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdi_d        RECORD
       linkno LIKE type_t.chr500, 
   xmdiseq LIKE type_t.num10, 
   xmdiseq1 LIKE type_t.num10, 
   xmdi001 LIKE type_t.chr500, 
   xmdi002 LIKE type_t.chr500, 
   xmdi003 LIKE type_t.chr10, 
   xmdi004 LIKE type_t.chr10, 
   cost LIKE type_t.chr500, 
   xmdi005 LIKE type_t.chr10, 
   xmdi005_desc LIKE type_t.chr500, 
   xmdi006 LIKE type_t.chr10, 
   xmdi006_desc LIKE type_t.chr500, 
   xmdi007 LIKE type_t.chr30, 
   xmdi013 LIKE type_t.chr30, 
   xmdi008 LIKE type_t.chr500, 
   xmdi008_desc LIKE type_t.chr500, 
   inag008 LIKE type_t.chr500, 
   inan010 LIKE type_t.chr500, 
   ready LIKE type_t.chr500, 
   xmdi009 LIKE type_t.chr500, 
   xmdi010 LIKE type_t.chr500, 
   xmdi010_desc LIKE type_t.chr500, 
   xmdi011 LIKE type_t.num20_6
       END RECORD
 
 
DEFINE g_xmdi_d          DYNAMIC ARRAY OF type_g_xmdi_d
DEFINE g_xmdi_d_t        type_g_xmdi_d
 
 
DEFINE g_xmdidocno_t   LIKE xmdi_t.xmdidocno    #Key值備份
DEFINE g_xmdiseq_t      LIKE xmdi_t.xmdiseq    #Key值備份
DEFINE g_xmdiseq1_t      LIKE xmdi_t.xmdiseq1    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_xmdi_d_o        type_g_xmdi_d

TYPE type_g_xmdi_data      RECORD
   cost      LIKE type_t.chr1,           #成本庫否
   xmdiseq1  LIKE xmdi_t.xmdiseq1,
   xmdi001   LIKE xmdi_t.xmdi001,
   xmdi002   LIKE xmdi_t.xmdi002,
   xmdi003   LIKE xmdi_t.xmdi003,
   xmdi004   LIKE xmdi_t.xmdi004,
   xmdi005   LIKE xmdi_t.xmdi005,
   xmdi006   LIKE xmdi_t.xmdi006,
   xmdi007   LIKE xmdi_t.xmdi007,
   xmdi008   LIKE xmdi_t.xmdi008,
   xmdi009   LIKE xmdi_t.xmdi009,
   xmdi010   LIKE xmdi_t.xmdi010,
   xmdi011   LIKE xmdi_t.xmdi011,
   xmdi012   LIKE xmdi_t.xmdi012,
   xmdi013   LIKE xmdi_t.xmdi013
       END RECORD

DEFINE g_xmdl    RECORD   #單頭display欄位
   linkno    LIKE type_t.num5,
   xmdlseq   LIKE xmdl_t.xmdlseq,
   xmdl001   LIKE xmdl_t.xmdl001,
   xmdl002   LIKE xmdl_t.xmdl002,
   xmdl003   LIKE xmdl_t.xmdl003,
   xmdl004   LIKE xmdl_t.xmdl004,
   xmdl008   LIKE xmdl_t.xmdl008,
   xmdl009   LIKE xmdl_t.xmdl009,
   xmdl011   LIKE xmdl_t.xmdl011,
   xmdl012   LIKE xmdl_t.xmdl012,
   xmdl017   LIKE xmdl_t.xmdl017,
   xmdl018   LIKE xmdl_t.xmdl018,
   xmdl019   LIKE xmdl_t.xmdl019,
   xmdl020   LIKE xmdl_t.xmdl020,
   xmdl081   LIKE xmdl_t.xmdl081,
   xmdl082   LIKE xmdl_t.xmdl082
                 END RECORD
                 
DEFINE g_hidden_ref      LIKE type_t.chr1        #是否使用參考單位(Y/N)
DEFINE g_xmdksite        LIKE xmdk_t.xmdksite    #營運據點
DEFINE g_xmdl013         LIKE xmdl_t.xmdl013     #多庫儲批
DEFINE g_xmdl014         LIKE xmdl_t.xmdl014     #限制庫位
DEFINE g_xmdl015         LIKE xmdl_t.xmdl015     #限制儲位
DEFINE g_xmdl016         LIKE xmdl_t.xmdl016     #限制批號
DEFINE g_xmdl052         LIKE xmdl_t.xmdl052     #限制庫存管理特徵
#end add-point
    
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
    
#add-point:傳入參數說明(global.argv)
#p_xmdksite      #營運據點
#p_linkno        #暫存檔之key
#p_linkseq       #項次
#p_xmdl008       #料件編號
#p_xmdl009       #產品特徵
#p_xmdl011       #作業編號
#p_xmdl012       #製程序
#p_xmdl017       #出貨單位
#p_xmdl018       #數量
#p_xmdl019       #參考單位
#p_xmdl020       #參考數量
#p_xmdcdocno     #訂單單號
#p_xmdcseq       #訂單項次

#r_success       #執行結果
#r_xmdl014       #庫位(只有一筆時回傳)
#r_xmdl015       #儲位(只有一筆時回傳)
#r_xmdl016       #批號(只有一筆時回傳)
#r_xmdl052       #庫存管理特徵(只有一筆時回傳)
#end add-point    
 
{</section>}
 
{<section id="axmp520_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmp520_03(--)
   #add-point:input段變數傳入
   p_xmdksite,
   p_linkno,
   p_linkseq,
   p_xmdl008,
   p_xmdl009,
   p_xmdl011,
   p_xmdl012,
   p_xmdl017,
   p_xmdl018,
   p_xmdl019,
   p_xmdl020,
   p_xmdcdocno,
   p_xmdcseq   
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define
   DEFINE p_xmdksite      LIKE xmdk_t.xmdksite  
   DEFINE p_linkno        LIKE type_t.num5
   DEFINE p_linkseq       LIKE xmdi_t.xmdidocno
   DEFINE p_xmdl008       LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009       LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011       LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012       LIKE xmdl_t.xmdl012
   DEFINE p_xmdl017       LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018       LIKE xmdl_t.xmdl018
   DEFINE p_xmdl019       LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020       LIKE xmdl_t.xmdl020
   DEFINE p_xmdcdocno     LIKE xmdc_t.xmdcdocno
   DEFINE p_xmdcseq       LIKE xmdc_t.xmdcseq
   DEFINE r_success       LIKE type_t.num5   
   DEFINE r_xmdl014       LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015       LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016       LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052       LIKE xmdl_t.xmdl052   
   
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ship          LIKE ooba_t.ooba001
   DEFINE l_num           LIKE type_t.num5
   #end add-point
   #add-point:input段define

   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmp520_03 WITH FORM cl_ap_formpath("axm","axmp520_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''

   #160808-00024 by whitney add start
   IF g_s_bas_0028 = 'N' THEN
      CALL cl_set_comp_visible("lbl_xmdl019,xmdl019,lbl_xmdl019_display,xmdl019_desc,lbl_xmdl020,xmdl020,xmdi010,xmdi010_desc,xmdi011",FALSE)
   END IF
   IF g_s_bas_0036 = 'N' THEN
      CALL cl_set_comp_visible("lbl_xmdl009,xmdl009,xmdi002",FALSE)
   END IF
   #160808-00024 by whitney add end

   LET g_errno = ''
   CASE
      WHEN cl_null(p_xmdksite) OR cl_null(p_xmdcdocno) OR cl_null(p_xmdcseq)
         LET g_errno = 'sub-00280'  #傳入參數為空或傳入值不正確!
      WHEN cl_null(p_linkseq)
         LET g_errno = 'sub-00406'  #傳入的項次為空!
      WHEN cl_null(p_xmdl008)
         LET g_errno = 'sub-00123'  #料件編號不可為空
      WHEN cl_null(p_xmdl017)
         LET g_errno = 'axm-00199'  #單位不可為空！
      WHEN cl_null(p_xmdl018)
         LET g_errno = 'axm-00200'  #數量不可為空！
      WHEN p_xmdl018 <= 1
         LET g_errno = 'axm-00377'  #數量必須大於2才可做多庫儲批！
   END CASE
   
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE WINDOW w_axmp520_03
      LET r_success = FALSE
      RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052      
   END IF   


   INITIALIZE g_xmdl.* TO NULL
   #將主程式的資訊帶入
   LET g_xmdksite = p_xmdksite          #營運據點
   
   LET g_xmdl.linkno   = p_linkno       #暫存檔之key
   LET g_xmdl.xmdlseq = p_linkseq       #暫存檔之key項次
   LET g_xmdl.xmdl008 = p_xmdl008       #料件編號
   LET g_xmdl.xmdl009 = p_xmdl009       #產品特徵
   LET g_xmdl.xmdl011 = p_xmdl011       #作業編號
   LET g_xmdl.xmdl012 = p_xmdl012       #製程序
   LET g_xmdl.xmdl017 = p_xmdl017       #出貨單位
   LET g_xmdl.xmdl018 = p_xmdl018       #數量
   LET g_xmdl.xmdl019 = p_xmdl019       #參考單位
   LET g_xmdl.xmdl020 = p_xmdl020       #參考數量


   #產品特徵為Null要補' '
   IF cl_null(g_xmdl.xmdl009) THEN LET g_xmdl.xmdl009 = ' ' END IF

   CALL axmp520_03_display_xmdl()        #單頭display      

   #隱藏、替換畫面說明
   CALL axmp520_03_window_show()

   #檢查是否存在來源限制條件
   LET g_xmdl013 = 'N'  #多庫儲批
   LET g_xmdl014 = ''  #庫位
   LET g_xmdl015 = ''  #儲位
   LET g_xmdl016 = ''  #批號
   LET g_xmdl052 = ''  #庫存管理特徵
   
   SELECT xmdc028,xmdc029,xmdc030,xmdc057
     INTO g_xmdl014,g_xmdl015,g_xmdl016,g_xmdl052
     FROM xmdc_t
    WHERE xmdcent = g_enterprise
      AND xmdcsite = g_xmdksite
      AND xmdcdocno = p_xmdcdocno
      AND xmdcseq = p_xmdcseq
   #清空temp_table
   DELETE FROM axmp520_03_temp  
   #塞temp_table
   IF NOT axmp520_03_insert_temp_table() THEN
      LET r_success = FALSE
   END IF
   
   #顯示單身
   CALL axmp520_03_b_fill()   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdi_d FROM s_detail1_axmp520_03.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_xmdi_d_t.* = g_xmdi_d[l_ac].*            
            DISPLAY l_ac TO FORMONLY.idx         
            
            
         
         AFTER FIELD xmdi009       
            IF NOT cl_ap_chk_range(g_xmdi_d[l_ac].xmdi009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdi009
            END IF  
            IF NOT cl_null(g_xmdi_d[l_ac].xmdi009) THEN  
               #總數量與項次檢查
               IF NOT axmp520_03_sum_chk('1') THEN
                  LET g_xmdi_d[l_ac].xmdi009 = g_xmdi_d_o.xmdi009
                  NEXT FIELD CURRENT
               END IF                
               #取位
               CALL s_aooi250_take_decimals(g_xmdi_d[l_ac].xmdi008,g_xmdi_d[l_ac].xmdi009) RETURNING l_success,g_xmdi_d[l_ac].xmdi009               
               #推算參考數量
               IF NOT cl_null(g_xmdi_d[l_ac].xmdi010) THEN
                  CALL s_aooi250_convert_qty(g_xmdi_d[l_ac].xmdi001,g_xmdi_d[l_ac].xmdi008,g_xmdi_d[l_ac].xmdi010,g_xmdi_d[l_ac].xmdi009)
                  RETURNING l_success,g_xmdi_d[l_ac].xmdi011
               END IF                  
            END IF
            LET g_xmdi_d_o.xmdi009 = g_xmdi_d[l_ac].xmdi009
            
         AFTER FIELD xmdi011
            IF NOT cl_ap_chk_range(g_xmdi_d[l_ac].xmdi011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdi011
            END IF  
            IF NOT cl_null(g_xmdi_d[l_ac].xmdi011) THEN
               IF NOT axmp520_03_sum_chk('1') THEN
                  LET g_xmdi_d[l_ac].xmdi011 = g_xmdi_d_o.xmdi011
                  NEXT FIELD xmdi011
               END IF               
               #參考數量取位
               IF NOT cl_null(g_xmdi_d[l_ac].xmdi010) THEN
                  CALL s_aooi250_take_decimals(g_xmdi_d[l_ac].xmdi010,g_xmdi_d[l_ac].xmdi011) RETURNING l_success,g_xmdi_d[l_ac].xmdi011
               END IF   
            END IF 	
            LET g_xmdi_d_o.xmdi011 = g_xmdi_d[l_ac].xmdi011
            
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xmdi_d[l_ac].* = g_xmdi_d_t.*
               EXIT DIALOG
            END IF
            ##庫儲批補空格及資料重複輸入檢查
            #IF NOT axmp520_03_repeat_chk() THEN
            #   NEXT FIELD xmdi009
            #END IF

            #批號檢查
            IF NOT axmp520_03_xmdi007_chk() THEN               
               NEXT FIELD xmdi007
            END IF
            UPDATE axmp520_03_temp 
               SET xmdi009 = g_xmdi_d[l_ac].xmdi009,
                   xmdi011 = g_xmdi_d[l_ac].xmdi011                                       
             WHERE linkno = g_xmdi_d_t.linkno
               AND xmdiseq = g_xmdi_d_t.xmdiseq
               AND xmdiseq1 = g_xmdi_d_t.xmdiseq1
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE axmp520_03_temp"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_xmdi_d[l_ac].* = g_xmdi_d_t.*
            END IF            
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdi005
            
            #add-point:AFTER FIELD xmdi005



            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdi005
            #add-point:BEFORE FIELD xmdi005

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xmdi005
            #add-point:ON CHANGE xmdi005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdi006
            
            #add-point:AFTER FIELD xmdi006



            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdi006
            #add-point:BEFORE FIELD xmdi006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xmdi006
            #add-point:ON CHANGE xmdi006

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdi007
            #add-point:BEFORE FIELD xmdi007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdi007
            
            #add-point:AFTER FIELD xmdi007

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xmdi007
            #add-point:ON CHANGE xmdi007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdi013
            #add-point:BEFORE FIELD xmdi013

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdi013
            
            #add-point:AFTER FIELD xmdi013

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xmdi013
            #add-point:ON CHANGE xmdi013

            #END add-point 
 
 
                  #Ctrlp:input.c.page1_axmp520_03.xmdi005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdi005
            #add-point:ON ACTION controlp INFIELD xmdi005


            #END add-point
 
         #Ctrlp:input.c.page1_axmp520_03.xmdi006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdi006
            #add-point:ON ACTION controlp INFIELD xmdi006



            #END add-point
 
         #Ctrlp:input.c.page1_axmp520_03.xmdi007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdi007
            #add-point:ON ACTION controlp INFIELD xmdi007

            #END add-point
 
         #Ctrlp:input.c.page1_axmp520_03.xmdi013
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdi013
            #add-point:ON ACTION controlp INFIELD xmdi013

            #END add-point
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)

         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理
            IF NOT axmp520_03_sum_chk('2') THEN
               NEXT FIELD xmdi009
            END IF                       
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel

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
 
   #add-point:畫面關閉前
 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axmp520_03 
   
   #add-point:input段after input 
   IF NOT INT_FLAG THEN
      CALL axmp520_03_xmdi_insert() 
      RETURNING r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   ELSE
      LET INT_FLAG = FALSE
      LET r_success = FALSE
   END IF    
   
   RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmp520_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmp520_03.other_function" readonly="Y" >}

#建立axmp520_03要用到的Temp_table
PUBLIC FUNCTION axmp520_03_create_temp_table()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   CREATE TEMP TABLE axmp520_03_temp(
           cost        LIKE type_t.chr1,      #成本庫否
           linkno      LIKE type_t.num5,
           xmdiseq     LIKE xmdi_t.xmdiseq,
           xmdiseq1    LIKE xmdi_t.xmdiseq1,
           xmdi001     LIKE xmdi_t.xmdi001,
           xmdi002     LIKE xmdi_t.xmdi002,
           xmdi003     LIKE xmdi_t.xmdi003,
           xmdi004     LIKE xmdi_t.xmdi004,
           xmdi005     LIKE xmdi_t.xmdi005,
           xmdi006     LIKE xmdi_t.xmdi006,
           xmdi007     LIKE xmdi_t.xmdi007,
           xmdi008     LIKE xmdi_t.xmdi008,
           xmdi009     LIKE xmdi_t.xmdi009,
           xmdi010     LIKE xmdi_t.xmdi010,
           xmdi011     LIKE xmdi_t.xmdi011,
           xmdi013     LIKE xmdi_t.xmdi013);
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmp520_03_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION axmp520_03_drop_temp_table()
DEFINE r_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   DROP TABLE axmp520_03_temp
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmp520_03_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp520_03_set_entry()
   CALL cl_set_comp_entry("xmdi005,xmdi006,xmdi007,xmdi013",TRUE)
   CALL cl_set_comp_entry("xmdi009,xmdi011",TRUE)
END FUNCTION

PRIVATE FUNCTION axmp520_03_set_no_entry()
 
  
   #來源已做多庫儲批
   IF g_xmdl013 = 'Y' THEN
      CALL cl_set_comp_entry("xmdi005,xmdi006,xmdi007,xmdi013",FALSE)
   END IF

   #來源有限制庫位
   IF NOT cl_null(g_xmdl014) THEN
      CALL cl_set_comp_entry("xmdi005",FALSE) 
   END IF
   
   #來源有限制儲位
   IF NOT cl_null(g_xmdl015) THEN
      CALL cl_set_comp_entry("xmdi006",FALSE) 
   END IF
   
   #來源有限制批號
   IF NOT cl_null(g_xmdl016) THEN
      CALL cl_set_comp_entry("xmdi007",FALSE) 
   END IF
   
   #來源有限制庫存管理特徵
   IF NOT cl_null(g_xmdl052) THEN
      CALL cl_set_comp_entry("xmdi013",FALSE)
   END IF

   #檢查料件是否使用批號
   IF NOT s_axmt540_imaf061_chk(g_xmdi_d[l_ac].xmdi001) THEN
      CALL cl_set_comp_entry("xmdi007",FALSE)
   END IF
   
   #參考數量
   IF cl_null(g_xmdl.xmdl020) THEN
      CALL cl_set_comp_entry("xmdi011",FALSE)
      LET g_xmdi_d[l_ac].xmdi011 = ''
   END IF

   #儲位控管若為5.不使用儲位控管
   IF NOT s_axmt540_inaa007_chk(g_xmdi_d[l_ac].xmdi005) THEN
      CALL cl_set_comp_entry("xmdi006",FALSE)
   END IF

END FUNCTION
#單頭顯示
PRIVATE FUNCTION axmp520_03_display_xmdl()
   DEFINE l_imaal003   LIKE imaal_t.imaal003
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   DEFINE l_oocal003   LIKE oocal_t.oocal003
   
   DISPLAY BY NAME g_xmdl.xmdlseq
   DISPLAY BY NAME g_xmdl.xmdl008
   DISPLAY BY NAME g_xmdl.xmdl009
   DISPLAY BY NAME g_xmdl.xmdl011
   DISPLAY BY NAME g_xmdl.xmdl012
   DISPLAY BY NAME g_xmdl.xmdl017
   DISPLAY BY NAME g_xmdl.xmdl018
   DISPLAY BY NAME g_xmdl.xmdl019
   DISPLAY BY NAME g_xmdl.xmdl020  
   
   DISPLAY BY NAME g_xmdl.xmdl081
   DISPLAY BY NAME g_xmdl.xmdl082
   
   #品名、規格desc
   LET l_imaal003 = ''
   LET l_imaal004 = ''
   CALL s_desc_get_item_desc(g_xmdl.xmdl008) RETURNING l_imaal003,l_imaal004
   DISPLAY l_imaal003 TO FORMONLY.xmdl008_desc
   DISPLAY l_imaal004 TO FORMONLY.xmdl008_desc1
   
   #單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl017) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl017_desc
   
   #參考單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl019) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl019_desc
END FUNCTION
#欄位顯示/隱藏
PRIVATE FUNCTION axmp520_03_window_show()

   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_xmdksite,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdl009,xmdi002",FALSE)
   END IF

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   CALL cl_get_para(g_enterprise,g_xmdksite,'S-BAS-0028') RETURNING g_hidden_ref
   IF g_hidden_ref = 'N' THEN
      CALL cl_set_comp_visible("xmdl019,xmdl019_desc,xmdl020,xmdi10,xmdi010_desc,xmdi011",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 將來源、庫存資料列出
# Memo...........:
# Usage..........: CALL axmp520_03_insert_temp_table()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150721 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_insert_temp_table()

   DEFINE l_sql        STRING
   DEFINE l_xmdi       type_g_xmdi_data
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_xmdi009    LIKE xmdi_t.xmdi009
   DEFINE l_xmdi011    LIKE xmdi_t.xmdi011
   DEFINE l_seq        LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   DEFINE l_xmdk039    LIKE xmdk_t.xmdk039
   DEFINE l_xmdk040    LIKE xmdk_t.xmdk040
  #161006-00018#24-s-add
   DEFINE l_flag2     LIKE type_t.num5
   DEFINE l_ooac002   LIKE ooac_t.ooac002
   DEFINE l_ooac004   LIKE ooac_t.ooac004
  #161006-00018#24-e-add  
    

   LET r_success = TRUE

  #161006-00018#24-s-add
   CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_flag2,l_ooac002
   CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
  #161006-00018#24-e-add  

   #先列出所有庫存庫儲批，之後再替換上已輸入的資料
   LET l_sql = "SELECT DISTINCT '','',",
                "                inag004,inag005,inag006,inag003",
                "  FROM inag_t",
                " WHERE inagent = '",g_enterprise,"'",
                "   AND inagsite = '",g_xmdksite,"'",
                "   AND inag001 = '",g_xmdl.xmdl008,"'",
                "   AND inag002 = '",g_xmdl.xmdl009,"'",
                "   AND inag007 = '",g_xmdl.xmdl017,"'"

   #有限定庫位
   IF NOT cl_null(g_xmdl014) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#24
         LET l_sql = l_sql," AND inag004 = '",g_xmdl014,"'"
      END IF                    #161006-00018#24    
   END IF
   
   #有限定儲位
   IF NOT cl_null(g_xmdl015) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#24   
         LET l_sql = l_sql," AND inag005 = '",g_xmdl015,"'"
      END IF                    #161006-00018#24       
   END IF
   
   #有限定批號
   IF NOT cl_null(g_xmdl016) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#24      
         LET l_sql = l_sql," AND inag006 = '",g_xmdl016,"'"
      END IF                    #161006-00018#24       
   END IF
   
   #有限定庫存管理特徵
   IF NOT cl_null(g_xmdl052) THEN   
      LET l_sql = l_sql," AND inag003 = '",g_xmdl052,"'"
   END IF 
                 
   LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"
    
   PREPARE axmp520_03_temp_pre1 FROM l_sql
   DECLARE axmp520_03_temp_cs1 CURSOR FOR axmp520_03_temp_pre1

   LET l_seq = 0
   INITIALIZE l_xmdi.* TO NULL
   
   FOREACH axmp520_03_temp_cs1 INTO l_xmdk039,l_xmdk040,
                                    l_xmdi.xmdi005,l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi013  #來源庫儲批

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      LET l_seq = l_seq + 1

      LET l_xmdi.xmdiseq1 = l_seq #項序
      LET l_xmdi.xmdi001 = g_xmdl.xmdl008  #料件編號
      LET l_xmdi.xmdi002 = g_xmdl.xmdl009  #產品特徵
      LET l_xmdi.xmdi003 = g_xmdl.xmdl011  #作業編號
      LET l_xmdi.xmdi004 = g_xmdl.xmdl012  #製程序
      
      LET l_xmdi.xmdi008 = g_xmdl.xmdl017  #單位
      LET l_xmdi.xmdi010 = g_xmdl.xmdl019  #參考單位
      
      #成本庫否
      CALL s_axmt540_inag012_chk(g_xmdksite,l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi013,l_xmdi.xmdi005,l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008)
      RETURNING l_xmdi.cost

      LET l_xmdi.xmdi009 = 0  #數量
      LET l_xmdi.xmdi011 = 0  #參考數量


      INSERT INTO axmp520_03_temp(cost,
                                  linkno,xmdiseq,xmdiseq1,
                                  xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,
                                  xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,
                                  xmdi011,xmdi013)
           VALUES(l_xmdi.cost,
                  g_xmdl.linkno,g_xmdl.xmdlseq,l_xmdi.xmdiseq1,
                  l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi003,l_xmdi.xmdi004,l_xmdi.xmdi005,
                  l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008,l_xmdi.xmdi009,l_xmdi.xmdi010,
                  l_xmdi.xmdi011,l_xmdi.xmdi013)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   CLOSE axmp520_03_temp_cs1
   FREE axmp520_03_temp_pre1 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身顯示
# Memo...........:
# Usage..........: CALL axmp520_03_b_fill()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150721 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_b_fill()
   DEFINE l_sql        STRING
   
   LET l_sql = "SELECT cost,",
               "       linkno,xmdiseq,xmdiseq1,",
               "       xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,",
               "       xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,",
               "       xmdi011,xmdi013",
               "  FROM axmp520_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdiseq = '",g_xmdl.xmdlseq,"'",
               " ORDER BY xmdi009,xmdi011"

   PREPARE axmp520_03_b_pre FROM l_sql
   DECLARE axmp520_03_b_cs CURSOR FOR axmp520_03_b_pre

   CALL g_xmdi_d.clear()
   LET l_ac = 1
   FOREACH axmp520_03_b_cs INTO g_xmdi_d[l_ac].cost,
                                g_xmdi_d[l_ac].linkno,g_xmdi_d[l_ac].xmdiseq,g_xmdi_d[l_ac].xmdiseq1,
                                g_xmdi_d[l_ac].xmdi001,g_xmdi_d[l_ac].xmdi002,g_xmdi_d[l_ac].xmdi003,g_xmdi_d[l_ac].xmdi004,g_xmdi_d[l_ac].xmdi005,
                                g_xmdi_d[l_ac].xmdi006,g_xmdi_d[l_ac].xmdi007,g_xmdi_d[l_ac].xmdi008,g_xmdi_d[l_ac].xmdi009,g_xmdi_d[l_ac].xmdi010,
                                g_xmdi_d[l_ac].xmdi011,g_xmdi_d[l_ac].xmdi013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_desc_get_stock_desc(g_xmdksite,g_xmdi_d[l_ac].xmdi005) RETURNING g_xmdi_d[l_ac].xmdi005_desc
      CALL s_desc_get_locator_desc(g_xmdksite,g_xmdi_d[l_ac].xmdi005,g_xmdi_d[l_ac].xmdi006) RETURNING g_xmdi_d[l_ac].xmdi006_desc
      CALL s_desc_get_unit_desc(g_xmdi_d[l_ac].xmdi008) RETURNING g_xmdi_d[l_ac].xmdi008_desc
      CALL s_desc_get_unit_desc(g_xmdi_d[l_ac].xmdi010) RETURNING g_xmdi_d[l_ac].xmdi010_desc


      CALL axmp520_03_inan010_display()
      CALL axmp520_03_inag_display()
      CALL axmp520_03_ready_display()


      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_ac = l_ac - 1
   CALL g_xmdi_d.deleteElement(g_xmdi_d.getLength())
   LET g_rec_b = l_ac
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE axmp520_03_b_cs
   FREE axmp520_03_b_pre
END FUNCTION
#顯示在揀量
PRIVATE FUNCTION axmp520_03_inan010_display()
   DEFINE l_inan010     LIKE inan_t.inan010
      
   LET l_inan010 = 0
       
   SELECT SUM(inan010) INTO l_inan010
     FROM inan_t
    WHERE inanent = g_enterprise
      AND inansite = g_xmdksite
      AND inan001 = g_xmdi_d[l_ac].xmdi001
      AND inan002 = g_xmdi_d[l_ac].xmdi002
      AND COALESCE(inan003,' ') = COALESCE(g_xmdi_d[l_ac].xmdi013,' ')
      AND inan004 = g_xmdi_d[l_ac].xmdi005
      AND COALESCE(inan005,' ') = COALESCE(g_xmdi_d[l_ac].xmdi006,' ')
      AND COALESCE(inan006,' ') = COALESCE(g_xmdi_d[l_ac].xmdi007,' ')
      AND COALESCE(inan007,' ') = COALESCE(g_xmdi_d[l_ac].xmdi008,' ')
   
   IF cl_null(l_inan010) THEN
      LET l_inan010 = 0
   END IF
   
   LET g_xmdi_d[l_ac].inan010 = l_inan010
END FUNCTION
#庫存量顯示
PRIVATE FUNCTION axmp520_03_inag_display()
   DEFINE l_inag008    LIKE inag_t.inag008
      
   LET l_inag008 = 0
         
   SELECT inag008
     INTO l_inag008
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inagsite = g_xmdksite
      AND inag001 = g_xmdi_d[l_ac].xmdi001
      AND inag002 = g_xmdi_d[l_ac].xmdi002
      AND COALESCE(inag003,' ') = COALESCE(g_xmdi_d[l_ac].xmdi013,' ')
      AND inag004 = g_xmdi_d[l_ac].xmdi005
      AND COALESCE(inag005,' ') = COALESCE(g_xmdi_d[l_ac].xmdi006,' ')
      AND COALESCE(inag006,' ') = COALESCE(g_xmdi_d[l_ac].xmdi007,' ')
      AND COALESCE(inag007,' ') = COALESCE(g_xmdi_d[l_ac].xmdi008,' ')
   
   IF cl_null(l_inag008) THEN
      LET l_inag008 = 0
   END IF

   LET g_xmdi_d[l_ac].inag008 = l_inag008
END FUNCTION
#可出貨量顯示
PRIVATE FUNCTION axmp520_03_ready_display()
   DEFINE l_ready    LIKE type_t.num5
   
   LET l_ready = 0
   
   IF NOT cl_null(g_xmdi_d[l_ac].inag008) THEN
      LET l_ready = l_ready + g_xmdi_d[l_ac].inag008
   END IF
   
   IF NOT cl_null(g_xmdi_d[l_ac].inan010) THEN
      LET l_ready = l_ready - g_xmdi_d[l_ac].inan010
   END IF
   
   LET g_xmdi_d[l_ac].ready = l_ready
END FUNCTION

################################################################################
# Descriptions...: 將多庫儲批資料寫入TEMP中
# Memo...........:
# Usage..........: CALL axmp520_03_xmdi_insert()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success 
# Date & Author..: 20150722 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_xmdi_insert()
 
   DEFINE l_sql        STRING
   DEFINE l_xmdi       type_g_xmdi_data
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   DEFINE l_seq        LIKE xmdi_t.xmdiseq
   DEFINE r_xmdl014    LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015    LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016    LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052    LIKE xmdl_t.xmdl052     
   DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM p520_tmp03                 #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
    WHERE linkno = g_xmdl.linkno
      AND xmdiseq = g_xmdl.xmdlseq 
      
   IF l_cnt > 0 THEN
      DELETE FROM p520_tmp03         #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
       WHERE linkno = g_xmdl.linkno
         AND xmdiseq = g_xmdl.xmdlseq          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'DELETE p520_tmp03'   #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
      END IF
   END IF
   
   LET l_sql = "SELECT xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,",
               "       xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,",
               "       xmdi011,xmdi013",
               "  FROM axmp520_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdiseq = '",g_xmdl.xmdlseq,"'"
   PREPARE axmp520_03_pre1 FROM l_sql
   DECLARE axmp520_03_cs1 CURSOR FOR axmp520_03_pre1   
   
   INITIALIZE l_xmdi.* TO NULL
   LET l_seq = 0
   FOREACH axmp520_03_cs1 INTO l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi003,l_xmdi.xmdi004,l_xmdi.xmdi005,
                               l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008,l_xmdi.xmdi009,l_xmdi.xmdi010,
                               l_xmdi.xmdi011,l_xmdi.xmdi013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #要被回寫的欄位預設為0
      LET l_xmdi.xmdi012 = 0  #已轉出貨量

      IF cl_null(l_xmdi.xmdi009) THEN LET l_xmdi.xmdi009 = 0 END IF  #數量
      IF cl_null(l_xmdi.xmdi011) THEN LET l_xmdi.xmdi011 = 0 END IF  #參考數量
         
      LET l_num = l_xmdi.xmdi009 + l_xmdi.xmdi011
           
      #無輸入任何資料不儲存
      IF l_num = 0 THEN
         CONTINUE FOREACH
      END IF     
      LET l_seq = l_seq + 1   
      INSERT INTO p520_tmp03(linkno,xmdiseq,xmdiseq1,            #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03   
                                    xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,
                                    xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,
                                    xmdi011,xmdi012,xmdi013)
           VALUES(g_xmdl.linkno,g_xmdl.xmdlseq,l_seq,
                  l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi003,l_xmdi.xmdi004,l_xmdi.xmdi005,
                  l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008,l_xmdi.xmdi009,l_xmdi.xmdi010,
                  l_xmdi.xmdi011,l_xmdi.xmdi012,l_xmdi.xmdi013)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT axmp580_tmp03:"          #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
      END IF                  
   END FOREACH

   CLOSE axmp520_03_cs1
   FREE axmp520_03_pre1

   IF l_seq = 1 THEN  #只有一筆
      SELECT xmdi005,xmdi006,xmdi007,xmdi013
        INTO r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
        FROM p520_tmp03              #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03   
       WHERE linkno = g_xmdl.linkno
         AND xmdiseq = g_xmdl.xmdlseq  
   END IF

   RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052 
   
END FUNCTION

################################################################################
# Descriptions...: 資料重覆性檢查
# Memo...........:
# Usage..........: CALL axmp520_03_repeat_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 140722 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_repeat_chk()
   DEFINE l_n        LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE

   #可能為Null的欄位
   #產品特徵
   IF cl_null(g_xmdi_d[l_ac].xmdi002) THEN LET g_xmdi_d[l_ac].xmdi002 = ' ' END IF
   #庫位
   IF cl_null(g_xmdi_d[l_ac].xmdi005) THEN LET g_xmdi_d[l_ac].xmdi005 = ' ' END IF
   #儲位
   IF cl_null(g_xmdi_d[l_ac].xmdi006) THEN LET g_xmdi_d[l_ac].xmdi006 = ' ' END IF
   #批號
   IF cl_null(g_xmdi_d[l_ac].xmdi007) THEN LET g_xmdi_d[l_ac].xmdi007 = ' ' END IF
   #庫存管理特徵
   IF cl_null(g_xmdi_d[l_ac].xmdi013) THEN LET g_xmdi_d[l_ac].xmdi013 = ' ' END IF

   #重複輸入檢查
   LET l_n = 0
   SELECT COUNT(xmdiseq1) INTO l_n
     FROM axmp520_03_temp
    WHERE xmdi005 = g_xmdi_d[l_ac].xmdi005
      AND xmdi006 = g_xmdi_d[l_ac].xmdi006
      AND xmdi007 = g_xmdi_d[l_ac].xmdi007
      AND xmdi013 = g_xmdi_d[l_ac].xmdi013
      AND xmdiseq1 <> g_xmdi_d_t.xmdiseq1   #排除當下這筆

   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00095'  #庫儲批不可以重複輸入！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 批號檢查
# Memo...........:
# Usage..........: CALL axmp520_03_xmdi007_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 140722 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_xmdi007_chk()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(g_xmdi_d[l_ac].xmdi007) THEN
      
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdksite
      LET g_chkparam.arg2 = g_xmdi_d[l_ac].xmdi001
      LET g_chkparam.arg3 = g_xmdi_d[l_ac].xmdi002
      LET g_chkparam.arg4 = g_xmdi_d[l_ac].xmdi007      
      IF NOT cl_chk_exist("v_inad001_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 數量檢查/資料檢查
# Memo...........:
# Usage..........: CALL axmp520_03_sum_chk(p_type)
#                  RETURNING r_success
# Input parameter: p_type         1.AFTER FIELD 檢查  2.AFTER INPUT檢查
# Return code....: r_success      執行結果
#                : 
# Date & Author..: 150816 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_03_sum_chk(p_type)
   DEFINE p_type          LIKE type_t.chr1  #1.AFTER FIELD檢查  2.AFTER INPUT檢查
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_xmdi009       LIKE xmdi_t.xmdi009
   DEFINE l_xmdi011       LIKE xmdi_t.xmdi011
   DEFINE l_xmdiseq1      LIKE xmdi_t.xmdiseq1
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sql           STRING
   
   LET r_success = TRUE 
     
   #輸入總數量與項次檢查   
   LET l_xmdi009 = 0
   LET l_xmdi011 = 0
   LET l_xmdiseq1 = ''
   
   LET l_sql = "SELECT SUM(COALESCE(xmdi009,0)),SUM(COALESCE(xmdi011,0)),COUNT(xmdiseq1)",  
               "  FROM axmp520_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdiseq = '",g_xmdl.xmdlseq,"'",
               "   AND (xmdi009 > 0 OR xmdi011 > 0 )"
               
   IF p_type = '1' THEN
      LET l_sql = l_sql," AND xmdiseq1 <> '",g_xmdi_d[l_ac].xmdiseq1,"'"
   END IF

   PREPARE axmp520_03_temp_pre3 FROM l_sql
   
   EXECUTE axmp520_03_temp_pre3 INTO l_xmdi009,l_xmdi011,l_xmdiseq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'EXECUTE'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_xmdi009) THEN LET l_xmdi009 = 0 END IF
   IF cl_null(l_xmdi011) THEN LET l_xmdi011 = 0 END IF
   IF cl_null(l_xmdiseq1) THEN LET l_xmdiseq1 = 0 END IF

   CASE p_type
      WHEN '1'  #AFTER FIELD
         IF NOT cl_null(g_xmdi_d[l_ac].xmdi009) THEN LET l_xmdi009 = l_xmdi009 + g_xmdi_d[l_ac].xmdi009 END IF
         IF NOT cl_null(g_xmdi_d[l_ac].xmdi011) THEN LET l_xmdi011 = l_xmdi011 + g_xmdi_d[l_ac].xmdi011 END IF
            
         IF l_xmdi009 > g_xmdl.xmdl018 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00384'   #多庫儲批總"出貨數量%1"不可大於項次%2"出貨數量%3"！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdi009
            LET g_errparam.replace[2] = g_xmdl.xmdlseq
            LET g_errparam.replace[3] = g_xmdl.xmdl018
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         #141105取消參考數量需相等的控卡      
         #IF l_xmdi011 > g_xmdl.xmdl020 THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = 'axm-00383'   #多庫儲批總"參考數量%1"不可大於項次%2"參考數量%3"！
         #   LET g_errparam.extend = ''
         #   LET g_errparam.popup = TRUE
         #   LET g_errparam.replace[1] = l_xmdi011 
         #   LET g_errparam.replace[2] = g_xmdl.xmdlseq 
         #   LET g_errparam.replace[3] = g_xmdl.xmdl020
         #   CALL cl_err()
         #   LET r_success = FALSE
         #   RETURN r_success
         #END IF


      WHEN '2'  #AFTER INPUT
         IF l_xmdi009 <> g_xmdl.xmdl018 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00196'   #多庫儲批總"出貨數量%1"不可與項次%2"出貨數量%3"不相等！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdi009 
            LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
            LET g_errparam.replace[3] =  g_xmdl.xmdl018
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
        #141105取消參考數量需相等的控卡       
        #IF l_xmdi011 <> g_xmdl.xmdl020 THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = 'axm-00232'   #多庫儲批總"參考數量%1"不可與項次%2"參考數量%3"不相等！
        #   LET g_errparam.extend = ''
        #   LET g_errparam.popup = TRUE
        #   LET g_errparam.replace[1] = l_xmdi011 
        #   LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
        #   LET g_errparam.replace[3] =  g_xmdl.xmdl020
        #   CALL cl_err()
        #   LET r_success = FALSE
        #   RETURN r_success
        #END IF   
        #檢查是否成本庫與非成本庫混和輸入
        LET l_cnt = 0
        SELECT COUNT(DISTINCT(cost))
          INTO l_cnt
          FROM axmp520_03_temp
         WHERE linkno = g_xmdl.linkno
           AND xmdiseq = g_xmdl.xmdlseq
           AND (xmdi009 > 0 OR xmdi011 > 0 )
        IF l_cnt > 1 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'axm-00375'   #成本庫與非成本庫不可混合輸入！
           LET g_errparam.extend = ''
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success        
        END IF
   END CASE        
   RETURN r_success
END FUNCTION

 
{</section>}
 
