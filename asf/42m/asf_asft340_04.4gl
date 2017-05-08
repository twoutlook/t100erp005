#該程式未解開Section, 採用最新樣板產出!
{<section id="asft340_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-09-10 16:30:33), PR版次:0006(2016-12-01 15:46:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: asft340_04
#+ Description: 拆件工單入庫明細快速產生
#+ Creator....: 01258(2015-08-04 21:56:38)
#+ Modifier...: 01588 -SD/PR- 08171
 
{</section>}
 
{<section id="asft340_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160512-00016#16 2016/05/28 By ming      s_asft300_02_bom增加傳入參數 
#161109-00085#34 2016/11/15 By lienjunqi 整批調整系統星號寫法
#161109-00085#65 2016/11/30 By 08171     整批調整系統星號寫法
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
PRIVATE type type_g_sfea_m        RECORD
       rd LIKE type_t.chr500, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb013_desc LIKE type_t.chr80, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb014_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sfeadocno           LIKE sfea_t.sfeadocno
DEFINE g_sfaadocno           LIKE sfaa_t.sfaadocno
#end add-point
 
DEFINE g_sfea_m        type_g_sfea_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asft340_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft340_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_sfeadocno,p_sfaadocno
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
   DEFINE p_sfeadocno     LIKE sfea_t.sfeadocno
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft340_04 WITH FORM cl_ap_formpath("asf","asft340_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_sfeadocno = p_sfeadocno
   LET g_sfaadocno = p_sfaadocno
   LET g_errshow = 1   #2015/09/10 by stellar add
   INITIALIZE g_sfea_m.* TO NULL   #2015/09/10 Sarah add
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_sfea_m.rd,g_sfea_m.sfeb013,g_sfea_m.sfeb014 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_sfea_m.rd = '1'
            DISPLAY BY NAME g_sfea_m.rd
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rd
            #add-point:BEFORE FIELD rd name="input.b.rd"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rd
            
            #add-point:AFTER FIELD rd name="input.a.rd"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rd
            #add-point:ON CHANGE rd name="input.g.rd"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="input.a.sfeb013"
            #2015/09/10 by stellar add ----- (S)
            LET g_sfea_m.sfeb013_desc = ''
            DISPLAY BY NAME g_sfea_m.sfeb013_desc
            
            IF NOT cl_null(g_sfea_m.sfeb013) THEN
               IF NOT asft340_04_chk_warehouses() THEN
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_desc_get_stock_desc(g_site,g_sfea_m.sfeb013)
                    RETURNING g_sfea_m.sfeb013_desc
               DISPLAY BY NAME g_sfea_m.sfeb013_desc
            END IF
            #2015/09/10 by stellar add ----- (E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="input.b.sfeb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb013
            #add-point:ON CHANGE sfeb013 name="input.g.sfeb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="input.a.sfeb014"
            #2015/09/10 by stellar add ----- (S)
            LET g_sfea_m.sfeb014_desc = ''
            DISPLAY BY NAME g_sfea_m.sfeb014_desc
            
            IF NOT cl_null(g_sfea_m.sfeb014) THEN
               IF NOT asft340_04_chk_warehouses() THEN
                  NEXT FIELD CURRENT
               END IF
            
               CALL s_desc_get_locator_desc(g_site,g_sfea_m.sfeb013,g_sfea_m.sfeb014)
                    RETURNING g_sfea_m.sfeb014_desc
               DISPLAY BY NAME g_sfea_m.sfeb014_desc
            ELSE
               LET g_sfea_m.sfeb014 = ' '
            END IF
            #2015/09/10 by stellar add ----- (E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="input.b.sfeb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb014
            #add-point:ON CHANGE sfeb014 name="input.g.sfeb014"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rd
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rd
            #add-point:ON ACTION controlp INFIELD rd name="input.c.rd"
            
            #END add-point
 
 
         #Ctrlp:input.c.sfeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="input.c.sfeb013"
            #2015/09/10 by stellar add ----- (S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfea_m.sfeb013

            CALL q_inaa001_2()
            LET g_sfea_m.sfeb013 = g_qryparam.return1    
            
            CALL s_desc_get_stock_desc(g_site,g_sfea_m.sfeb013)
                 RETURNING g_sfea_m.sfeb013_desc
            DISPLAY BY NAME g_sfea_m.sfeb013_desc
            
            NEXT FIELD sfeb013
            #2015/09/10 by stellar add ----- (E)
            #END add-point
 
 
         #Ctrlp:input.c.sfeb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="input.c.sfeb014"
            #2015/09/10 by stellar add ----- (S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_sfea_m.sfeb014
            LET g_qryparam.arg1 =  g_sfea_m.sfeb013
            CALL q_inab002_3()
            LET g_sfea_m.sfeb014 = g_qryparam.return1     #將開窗取得的值回傳到變數
            
            CALL s_desc_get_locator_desc(g_site,g_sfea_m.sfeb013,g_sfea_m.sfeb014)
                 RETURNING g_sfea_m.sfeb014_desc
            DISPLAY BY NAME g_sfea_m.sfeb014_desc
               
            NEXT FIELD sfeb014
            #2015/09/10 by stellar add ----- (E)
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
   CALL asft340_04_gen() RETURNING l_success
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asft340_04 
   
   #add-point:input段after input name="input.post_input"
   RETURN l_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft340_04.other_function" readonly="Y" >}

#根据画面条件产生相应入库明细资料
PRIVATE FUNCTION asft340_04_gen()
DEFINE r_success              LIKE type_t.num5
DEFINE l_n                    LIKE type_t.num5
                              
   LET r_success = FALSE
   SELECT COUNT(1) INTO l_n FROM sfeb_t 
    WHERE sfebent = g_enterprise AND sfebsite = g_site 
      AND sfebdocno = g_sfeadocno AND sfeb001 = g_sfaadocno
   IF l_n > 0 THEN
      IF cl_ask_confirm('asf-00479') THEN
         DELETE FROM sfeb_t 
          WHERE sfebent = g_enterprise AND sfebsite = g_site 
            AND sfebdocno = g_sfeadocno AND sfeb001 = g_sfaadocno   
         DELETE FROM sfec_t 
          WHERE sfecent = g_enterprise AND sfecsite = g_site 
            AND sfecdocno = g_sfeadocno AND sfec001 = g_sfaadocno            
         IF NOT asft340_04_gen_sfeb_sfec() THEN
            RETURN r_success
         END IF
      END IF
   ELSE
      IF NOT asft340_04_gen_sfeb_sfec() THEN
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

##根据sfac资料或者BOM资料产生入库明细资料
PRIVATE FUNCTION asft340_04_gen_sfeb_sfec()
DEFINE r_success              LIKE type_t.num5
DEFINE l_i                    LIKE type_t.num5
DEFINE l_j                    LIKE type_t.num5
DEFINE l_k                    LIKE type_t.num5
DEFINE l_bmba                 DYNAMIC ARRAY OF RECORD #回传数组
       bmba001                LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
       bmba002                LIKE bmba_t.bmba002,
       bmba003                LIKE bmba_t.bmba003,
       bmba004                LIKE bmba_t.bmba004,
       bmba005                DATETIME YEAR TO SECOND,
       bmba007                LIKE bmba_t.bmba007,
       bmba008                LIKE bmba_t.bmba008,
       #160512-00016#16 20160528 add by ming -----(S) 
       bmba035                LIKE bmba_t.bmba035,     #保稅否  
       #160512-00016#16 20160528 add by ming -----(E) 
       l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002              LIKE inam_t.inam002      #元件对应特征
                              END RECORD
DEFINE l_bmba_qty             DYNAMIC ARRAY OF RECORD #回传数组
       bmba001                LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
       bmba002                LIKE bmba_t.bmba002,
       bmba003                LIKE bmba_t.bmba003,
       bmba004                LIKE bmba_t.bmba004,
       bmba005                DATETIME YEAR TO SECOND,
       bmba007                LIKE bmba_t.bmba007,
       bmba008                LIKE bmba_t.bmba008,
       #160512-00016#16 20160528 add by ming -----(S) 
       bmba035                LIKE bmba_t.bmba035,     #保稅否 
       #160512-00016#16 20160528 add by ming -----(E) 
       l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002              LIKE inam_t.inam002,     #元件对应特征
       l_qty                  LIKE sfaa_t.sfaa012      #对应数量
                              END RECORD
DEFINE l_inam                 DYNAMIC ARRAY OF RECORD   #記錄產品特徵
        inam001               LIKE inam_t.inam001,
        inam002               LIKE inam_t.inam002,
        inam004               LIKE inam_t.inam004
                              END RECORD
DEFINE l_sql                  STRING
#161109-00085#34-s
#DEFINE l_sfaa                 RECORD LIKE sfaa_t.*
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaadocno  LIKE sfaa_t.sfaadocno,  #單號
       sfaa010    LIKE sfaa_t.sfaa010,    #生產料號
       sfaa011    LIKE sfaa_t.sfaa011,    #特性
       sfaa012    LIKE sfaa_t.sfaa012,    #生產數量
       sfaa013    LIKE sfaa_t.sfaa013,    #生產單位
       sfaa015    LIKE sfaa_t.sfaa015,    #BOM有效日期
       sfaa072    LIKE sfaa_t.sfaa072     #保稅否
END RECORD
#161109-00085#34-e
#161109-00085#34-s
#DEFINE l_sfac                 RECORD LIKE sfac_t.*
DEFINE l_sfac RECORD  #工單聯產品檔
       sfac001 LIKE sfac_t.sfac001, #料件編號
       sfac002 LIKE sfac_t.sfac002, #類型
       sfac003 LIKE sfac_t.sfac003, #預計產出量
       sfac004 LIKE sfac_t.sfac004, #單位
       sfac006 LIKE sfac_t.sfac006  #產品特徵
END RECORD
#161109-00085#34-e
#161109-00085#34-s
#DEFINE l_sfeb                 RECORD LIKE sfeb_t.*
DEFINE l_sfeb RECORD  #完工入庫申請檔
       sfebent LIKE sfeb_t.sfebent, #企業編號
       sfebsite LIKE sfeb_t.sfebsite, #營運據點
       sfebdocno LIKE sfeb_t.sfebdocno, #完工入庫單號
       sfebseq LIKE sfeb_t.sfebseq, #項次
       sfeb001 LIKE sfeb_t.sfeb001, #工單單號
       sfeb002 LIKE sfeb_t.sfeb002, #FQC
       sfeb003 LIKE sfeb_t.sfeb003, #入庫類型
       sfeb004 LIKE sfeb_t.sfeb004, #料件編號
       sfeb005 LIKE sfeb_t.sfeb005, #特徵
       sfeb006 LIKE sfeb_t.sfeb006, #包裝容器
       sfeb007 LIKE sfeb_t.sfeb007, #單位
       sfeb008 LIKE sfeb_t.sfeb008, #申請數量
       sfeb009 LIKE sfeb_t.sfeb009, #實際數量
       sfeb010 LIKE sfeb_t.sfeb010, #參考單位
       sfeb011 LIKE sfeb_t.sfeb011, #申請參考數量
       sfeb012 LIKE sfeb_t.sfeb012, #實際參考數量
       sfeb013 LIKE sfeb_t.sfeb013, #指定庫位
       sfeb014 LIKE sfeb_t.sfeb014, #指定儲位
       sfeb015 LIKE sfeb_t.sfeb015, #指定批號
       sfeb016 LIKE sfeb_t.sfeb016, #庫存管理特徵
       sfeb017 LIKE sfeb_t.sfeb017, #專案編號
       sfeb018 LIKE sfeb_t.sfeb018, #WBS
       sfeb019 LIKE sfeb_t.sfeb019, #活動編號
       sfeb020 LIKE sfeb_t.sfeb020, #理由碼
       sfeb021 LIKE sfeb_t.sfeb021, #庫存有效日期
       sfeb022 LIKE sfeb_t.sfeb022, #庫存備註
       sfeb023 LIKE sfeb_t.sfeb023, #生產料號
       sfeb024 LIKE sfeb_t.sfeb024, #生產料號BOM特性
       sfeb025 LIKE sfeb_t.sfeb025, #生產料號特徵
       sfeb026 LIKE sfeb_t.sfeb026, #RUN CARD
       sfeb027 LIKE sfeb_t.sfeb027, #檢驗合格量
       #161109-00085#65 --s add
       sfebud001 LIKE sfeb_t.sfebud001, #自定義欄位(文字)001
       sfebud002 LIKE sfeb_t.sfebud002, #自定義欄位(文字)002
       sfebud003 LIKE sfeb_t.sfebud003, #自定義欄位(文字)003
       sfebud004 LIKE sfeb_t.sfebud004, #自定義欄位(文字)004
       sfebud005 LIKE sfeb_t.sfebud005, #自定義欄位(文字)005
       sfebud006 LIKE sfeb_t.sfebud006, #自定義欄位(文字)006
       sfebud007 LIKE sfeb_t.sfebud007, #自定義欄位(文字)007
       sfebud008 LIKE sfeb_t.sfebud008, #自定義欄位(文字)008
       sfebud009 LIKE sfeb_t.sfebud009, #自定義欄位(文字)009
       sfebud010 LIKE sfeb_t.sfebud010, #自定義欄位(文字)010
       sfebud011 LIKE sfeb_t.sfebud011, #自定義欄位(數字)011
       sfebud012 LIKE sfeb_t.sfebud012, #自定義欄位(數字)012
       sfebud013 LIKE sfeb_t.sfebud013, #自定義欄位(數字)013
       sfebud014 LIKE sfeb_t.sfebud014, #自定義欄位(數字)014
       sfebud015 LIKE sfeb_t.sfebud015, #自定義欄位(數字)015
       sfebud016 LIKE sfeb_t.sfebud016, #自定義欄位(數字)016
       sfebud017 LIKE sfeb_t.sfebud017, #自定義欄位(數字)017
       sfebud018 LIKE sfeb_t.sfebud018, #自定義欄位(數字)018
       sfebud019 LIKE sfeb_t.sfebud019, #自定義欄位(數字)019
       sfebud020 LIKE sfeb_t.sfebud020, #自定義欄位(數字)020
       sfebud021 LIKE sfeb_t.sfebud021, #自定義欄位(日期時間)021
       sfebud022 LIKE sfeb_t.sfebud022, #自定義欄位(日期時間)022
       sfebud023 LIKE sfeb_t.sfebud023, #自定義欄位(日期時間)023
       sfebud024 LIKE sfeb_t.sfebud024, #自定義欄位(日期時間)024
       sfebud025 LIKE sfeb_t.sfebud025, #自定義欄位(日期時間)025
       sfebud026 LIKE sfeb_t.sfebud026, #自定義欄位(日期時間)026
       sfebud027 LIKE sfeb_t.sfebud027, #自定義欄位(日期時間)027
       sfebud028 LIKE sfeb_t.sfebud028, #自定義欄位(日期時間)028
       sfebud029 LIKE sfeb_t.sfebud029, #自定義欄位(日期時間)029
       sfebud030 LIKE sfeb_t.sfebud030, #自定義欄位(日期時間)030
       #161109-00085#65 --e add
       sfeb028 LIKE sfeb_t.sfeb028  #製造日期
END RECORD
#161109-00085#34-e
#161109-00085#34-s
#DEFINE l_sfec                 RECORD LIKE sfec_t.*
DEFINE l_sfec RECORD  #完工入庫明細檔
       sfecent LIKE sfec_t.sfecent, #企業編號
       sfecsite LIKE sfec_t.sfecsite, #營運據點
       sfecdocno LIKE sfec_t.sfecdocno, #單號
       sfecseq LIKE sfec_t.sfecseq, #項次
       sfecseq1 LIKE sfec_t.sfecseq1, #項次1
       sfec001 LIKE sfec_t.sfec001, #工單單號
       sfec002 LIKE sfec_t.sfec002, #FQC單號
       sfec003 LIKE sfec_t.sfec003, #判定項次
       sfec004 LIKE sfec_t.sfec004, #入庫類型
       sfec005 LIKE sfec_t.sfec005, #料件編號
       sfec006 LIKE sfec_t.sfec006, #特徵
       sfec007 LIKE sfec_t.sfec007, #包裝容器
       sfec008 LIKE sfec_t.sfec008, #單位
       sfec009 LIKE sfec_t.sfec009, #數量
       sfec010 LIKE sfec_t.sfec010, #參考單位
       sfec011 LIKE sfec_t.sfec011, #參考數量
       sfec012 LIKE sfec_t.sfec012, #庫位
       sfec013 LIKE sfec_t.sfec013, #儲位
       sfec014 LIKE sfec_t.sfec014, #批號
       sfec015 LIKE sfec_t.sfec015, #庫存管理特徵
       sfec016 LIKE sfec_t.sfec016, #有效日期
       sfec017 LIKE sfec_t.sfec017, #庫存備註
       sfec018 LIKE sfec_t.sfec018, #生產料號
       sfec019 LIKE sfec_t.sfec019, #生產料號BOM特性
       sfec020 LIKE sfec_t.sfec020, #生產料號產品特徵
       sfec021 LIKE sfec_t.sfec021, #RUN CARD
       #161109-00085#65 --s add
       sfecud001 LIKE sfec_t.sfecud001, #自定義欄位(文字)001
       sfecud002 LIKE sfec_t.sfecud002, #自定義欄位(文字)002
       sfecud003 LIKE sfec_t.sfecud003, #自定義欄位(文字)003
       sfecud004 LIKE sfec_t.sfecud004, #自定義欄位(文字)004
       sfecud005 LIKE sfec_t.sfecud005, #自定義欄位(文字)005
       sfecud006 LIKE sfec_t.sfecud006, #自定義欄位(文字)006
       sfecud007 LIKE sfec_t.sfecud007, #自定義欄位(文字)007
       sfecud008 LIKE sfec_t.sfecud008, #自定義欄位(文字)008
       sfecud009 LIKE sfec_t.sfecud009, #自定義欄位(文字)009
       sfecud010 LIKE sfec_t.sfecud010, #自定義欄位(文字)010
       sfecud011 LIKE sfec_t.sfecud011, #自定義欄位(數字)011
       sfecud012 LIKE sfec_t.sfecud012, #自定義欄位(數字)012
       sfecud013 LIKE sfec_t.sfecud013, #自定義欄位(數字)013
       sfecud014 LIKE sfec_t.sfecud014, #自定義欄位(數字)014
       sfecud015 LIKE sfec_t.sfecud015, #自定義欄位(數字)015
       sfecud016 LIKE sfec_t.sfecud016, #自定義欄位(數字)016
       sfecud017 LIKE sfec_t.sfecud017, #自定義欄位(數字)017
       sfecud018 LIKE sfec_t.sfecud018, #自定義欄位(數字)018
       sfecud019 LIKE sfec_t.sfecud019, #自定義欄位(數字)019
       sfecud020 LIKE sfec_t.sfecud020, #自定義欄位(數字)020
       sfecud021 LIKE sfec_t.sfecud021, #自定義欄位(日期時間)021
       sfecud022 LIKE sfec_t.sfecud022, #自定義欄位(日期時間)022
       sfecud023 LIKE sfec_t.sfecud023, #自定義欄位(日期時間)023
       sfecud024 LIKE sfec_t.sfecud024, #自定義欄位(日期時間)024
       sfecud025 LIKE sfec_t.sfecud025, #自定義欄位(日期時間)025
       sfecud026 LIKE sfec_t.sfecud026, #自定義欄位(日期時間)026
       sfecud027 LIKE sfec_t.sfecud027, #自定義欄位(日期時間)027
       sfecud028 LIKE sfec_t.sfecud028, #自定義欄位(日期時間)028
       sfecud029 LIKE sfec_t.sfecud029, #自定義欄位(日期時間)029
       sfecud030 LIKE sfec_t.sfecud030, #自定義欄位(日期時間)030
       #161109-00085#65 --e add
       sfec022 LIKE sfec_t.sfec022, #專案編號
       sfec023 LIKE sfec_t.sfec023, #WBS
       sfec024 LIKE sfec_t.sfec024, #活動編號
       sfec028 LIKE sfec_t.sfec028  #製造日期
END RECORD
#161109-00085#34-e
DEFINE l_type                 LIKE type_t.chr1
DEFINE l_flag                 LIKE type_t.chr1
DEFINE l_sfeadocdt            LIKE sfea_t.sfeadocdt
DEFINE l_bmba005_1            LIKE ooff_t.ooff007
DEFINE l_success              LIKE type_t.num5
DEFINE l_imaa005              LIKE imaa_t.imaa005
   
   LET r_success = FALSE
   
   #日期
   SELECT sfeadocdt INTO l_sfeadocdt FROM sfea_t
    WHERE sfeaent = g_enterprise AND sfeasite = g_site
      AND sfeadocno = g_sfeadocno
            
   IF g_sfea_m.rd = '1' THEN
      DECLARE asft340_04_sfec_cs CURSOR FOR 
      #161109-00085#34-s
         #SELECT * FROM sfac_t
         SELECT sfac001,sfac002,sfac003,sfac004,sfac006
           FROM sfac_t
          WHERE sfacent = g_enterprise AND sfacsite = g_site
            AND sfacdocno = g_sfaadocno
      #FOREACH asft340_04_sfec_cs INTO l_sfac.*
      FOREACH asft340_04_sfec_cs
         INTO l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac006
      #161109-00085#34-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.popup = TRUE
            CALL cl_err()        
            EXIT FOREACH
         END IF
         
         INITIALIZE l_sfeb.* TO NULL
         LET l_sfeb.sfebent   = g_enterprise        #企业编号
         LET l_sfeb.sfebsite  = g_site              #营运据点
         LET l_sfeb.sfebdocno = g_sfeadocno         #完工入库单号
         #项次
         SELECT MAX(sfebseq) INTO l_sfeb.sfebseq FROM sfeb_t 
          WHERE sfebent = g_enterprise AND sfebsite = g_site 
            AND sfebdocno = g_sfeadocno
         IF cl_null(l_sfeb.sfebseq) THEN
            LET l_sfeb.sfebseq = 1
         ELSE 
            LET l_sfeb.sfebseq = l_sfeb.sfebseq + 1
         END IF
         LET l_sfeb.sfeb001 = g_sfaadocno           #工单单号
         #FQC/专案代号/WBS/活动代号
         SELECT sfaa044,sfaa028,sfaa029,sfaa030 INTO l_sfeb.sfeb002,l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019 FROM sfaa_t
          WHERE sfaaent = g_enterprise AND sfaasite = g_site
            AND sfaadocno = g_sfaadocno
         LET l_sfeb.sfeb003 = l_sfac.sfac002        #入库类型
         LET l_sfeb.sfeb004 = l_sfac.sfac001        #料件编号
         LET l_sfeb.sfeb005 = l_sfac.sfac006        #产品特征
         LET l_sfeb.sfeb006   = ''                  #包装容器
         LET l_sfeb.sfeb007 = l_sfac.sfac004        #单位
         LET l_sfeb.sfeb008 = l_sfac.sfac003        #申请数量
         #实际数量
         IF l_sfeb.sfeb002 = 'N' THEN
            LET l_sfeb.sfeb009 = l_sfeb.sfeb008
            LET l_sfeb.sfeb027 = l_sfeb.sfeb008
         ELSE
            LET l_sfeb.sfeb009 = 0
            LET l_sfeb.sfeb027 = 0
         END IF
         
         #参考单位
         SELECT imaf015 INTO l_sfeb.sfeb010 FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site
            AND imaf001 = l_sfeb.sfeb004
            
         #申请参考数量/#实际参考数量
         #若没有参考单位时,参考数量DEFAULT NULL
         IF cl_null(l_sfeb.sfeb010) THEN
            LET l_sfeb.sfeb011 = NULL
            LET l_sfeb.sfeb012 = NULL
         ELSE
            CALL s_aooi250_convert_qty(l_sfeb.sfeb004,l_sfeb.sfeb007,l_sfeb.sfeb010,l_sfeb.sfeb008)
                 RETURNING l_success,l_sfeb.sfeb011
            IF NOT l_success THEN
               LET l_sfeb.sfeb011 = l_sfeb.sfeb008
            END IF
    
            IF l_sfeb.sfeb002 = 'N' THEN
               LET l_sfeb.sfeb012 = l_sfeb.sfeb011
            ELSE
               LET l_sfeb.sfeb012 = 0
            END IF
         END IF
         
        #指定库位/指定储位/指定批号
        #2015/09/10 by stellar add ----- (S)
        IF NOT cl_null(g_sfea_m.sfeb013) THEN
           LET l_sfeb.sfeb013 = g_sfea_m.sfeb013
           LET l_sfeb.sfeb014 = g_sfea_m.sfeb014
        ELSE
        #2015/09/10 by stellar add ----- (E) 
         CALL s_asft340_set_warehouses(l_sfeb.sfeb001,l_sfeb.sfeb004,'','','')
              RETURNING l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015
        END IF   #2015/09/10 by stellar add
    
         LET l_sfeb.sfeb016   = ' '                #库存管理特征
    
         LET l_sfeb.sfeb020   = ' '               #理由码
    
         #库存有效日期
         CALL s_aini010_calculate_effdt(g_site,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb015,l_sfeadocdt)
              RETURNING l_sfeb.sfeb021
         LET l_sfeb.sfeb022   = ' '               #库存备注
         LET l_sfeb.sfeb023   = ''                #生产料号
         LET l_sfeb.sfeb024   = ''                #生产料号BOM特性
         LET l_sfeb.sfeb025   = ''                #生产料号特征
         
         #RUN CARD
         #取工单的第一笔RUN CARD号
         LET l_sql = " SELECT sfcb001 FROM sfcb_t ",
                     "  WHERE sfcbent   = ",g_enterprise,
                     "    AND sfcbdocno = ? ",
                     " ORDER BY sfcb001 "
         PREPARE asft340_04_get_run_card_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "PREPARE asft340_04_get_run_card_p1"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF     
         DECLARE asft340_04_get_run_card_cs1 SCROLL CURSOR FOR asft340_04_get_run_card_p1
         OPEN asft340_04_get_run_card_cs1 USING l_sfeb.sfeb001
         FETCH FIRST asft340_04_get_run_card_cs1 INTO l_sfeb.sfeb026
         IF cl_null(l_sfeb.sfeb026) THEN
            LET l_sfeb.sfeb026 = 0
         END IF   
         #161109-00085#34-s
         #INSERT INTO sfeb_t VALUES l_sfeb.*
         #161109-00085#65 --s mark
         #INSERT INTO sfeb_t (sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,
         #                    sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,
         #                    sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,
         #                    sfeb027,sfeb028)
         #VALUES (l_sfeb.sfebent,l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb001,
         #        l_sfeb.sfeb002,l_sfeb.sfeb003,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,
         #        l_sfeb.sfeb007,l_sfeb.sfeb008,l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,
         #        l_sfeb.sfeb012,l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,
         #        l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019,l_sfeb.sfeb020,l_sfeb.sfeb021,
         #        l_sfeb.sfeb022,l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb026,
         #        l_sfeb.sfeb027,l_sfeb.sfeb028)
         #161109-00085#65 --e mark
         #161109-00085#34-e
         #161109-00085#65 --s add
         INSERT INTO sfeb_t(sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,
                            sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,
                            sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,
                            sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,
                            sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,
                            sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,
                            sfeb027,sfebud001,sfebud002,sfebud003,sfebud004,
                            sfebud005,sfebud006,sfebud007,sfebud008,sfebud009,
                            sfebud010,sfebud011,sfebud012,sfebud013,sfebud014,
                            sfebud015,sfebud016,sfebud017,sfebud018,sfebud019,
                            sfebud020,sfebud021,sfebud022,sfebud023,sfebud024,
                            sfebud025,sfebud026,sfebud027,sfebud028,sfebud029,
                            sfebud030,sfeb028)
         VALUES (l_sfeb.sfebent,l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb001,
                 l_sfeb.sfeb002,l_sfeb.sfeb003,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,
                 l_sfeb.sfeb007,l_sfeb.sfeb008,l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,
                 l_sfeb.sfeb012,l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,
                 l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019,l_sfeb.sfeb020,l_sfeb.sfeb021,
                 l_sfeb.sfeb022,l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb026,
                 l_sfeb.sfeb027,l_sfeb.sfebud001,l_sfeb.sfebud002,l_sfeb.sfebud003,l_sfeb.sfebud004,
                 l_sfeb.sfebud005,l_sfeb.sfebud006,l_sfeb.sfebud007,l_sfeb.sfebud008,l_sfeb.sfebud009,
                 l_sfeb.sfebud010,l_sfeb.sfebud011,l_sfeb.sfebud012,l_sfeb.sfebud013,l_sfeb.sfebud014,
                 l_sfeb.sfebud015,l_sfeb.sfebud016,l_sfeb.sfebud017,l_sfeb.sfebud018,l_sfeb.sfebud019,
                 l_sfeb.sfebud020,l_sfeb.sfebud021,l_sfeb.sfebud022,l_sfeb.sfebud023,l_sfeb.sfebud024,
                 l_sfeb.sfebud025,l_sfeb.sfebud026,l_sfeb.sfebud027,l_sfeb.sfebud028,l_sfeb.sfebud029,
                 l_sfeb.sfebud030,l_sfeb.sfeb028)
         #161109-00085#65 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert sfeb'
            LET g_errparam.popup = FALSE
            CALL cl_err()
            RETURN r_success
         END IF
      
         IF l_sfeb.sfeb002 = 'Y' THEN
            CONTINUE FOREACH
         END IF
               
         LET l_sfec.sfecent = g_enterprise 
         LET l_sfec.sfecsite = g_site
         LET l_sfec.sfecdocno = g_sfeadocno
         LET l_sfec.sfecseq = l_sfeb.sfebseq
         LET l_sfec.sfecseq1 = 1
         LET l_sfec.sfec001   = l_sfeb.sfeb001           #工單單號
         LET l_sfec.sfec002   = ''                       #FQC單號
         LET l_sfec.sfec003   = ''                       #判定項次
         LET l_sfec.sfec004   = l_sfeb.sfeb003           #入庫類型
         LET l_sfec.sfec005   = l_sfeb.sfeb004           #料件編號
         LET l_sfec.sfec006   = l_sfeb.sfeb005           #特徵
         LET l_sfec.sfec007   = l_sfeb.sfeb006           #包裝容器
         LET l_sfec.sfec008   = l_sfeb.sfeb007           #單位
         LET l_sfec.sfec009   = l_sfeb.sfeb008           #數量
         LET l_sfec.sfec010   = l_sfeb.sfeb010           #參考單位
         LET l_sfec.sfec011   = l_sfeb.sfeb011           #參考數量
         LET l_sfec.sfec012   = l_sfeb.sfeb013           #庫位
         LET l_sfec.sfec013   = l_sfeb.sfeb014           #儲位
         LET l_sfec.sfec014   = l_sfeb.sfeb015           #批號
         LET l_sfec.sfec015   = l_sfeb.sfeb016           #庫存管理特徵
         LET l_sfec.sfec016   = l_sfeb.sfeb021           #有效日期
         LET l_sfec.sfec017   = l_sfeb.sfeb022           #庫存備註
         LET l_sfec.sfec021   = l_sfeb.sfeb026           #RUN CARD
         LET l_sfec.sfec022   = l_sfeb.sfeb017           #專案編號
         LET l_sfec.sfec023   = l_sfeb.sfeb018           #WBS
         LET l_sfec.sfec024   = l_sfeb.sfeb019           #活動編號

         #161109-00085#34-s
         #INSERT INTO sfec_t VALUES l_sfec.*
         #161109-00085#65 --s mark
         #INSERT INTO sfec_t (sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,sfec001,sfec002,sfec003,sfec004,sfec005,
         #                    sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,
         #                    sfec016,sfec017,sfec018,sfec019,sfec020,sfec021,sfec022,sfec023,sfec024,sfec028)
         #VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
         #        l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
         #        l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
         #        l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
         #        l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
         #        l_sfec.sfec021,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#65 --e mark
         #161109-00085#34-e
         #161109-00085#65 --s add
         INSERT INTO sfec_t(sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,
                            sfec001,sfec002,sfec003,sfec004,sfec005,
                            sfec006,sfec007,sfec008,sfec009,sfec010,
                            sfec011,sfec012,sfec013,sfec014,sfec015,
                            sfec016,sfec017,sfec018,sfec019,sfec020,
                            sfec021,sfecud001,sfecud002,sfecud003,sfecud004,
                            sfecud005,sfecud006,sfecud007,sfecud008,sfecud009,
                            sfecud010,sfecud011,sfecud012,sfecud013,sfecud014,
                            sfecud015,sfecud016,sfecud017,sfecud018,sfecud019,
                            sfecud020,sfecud021,sfecud022,sfecud023,sfecud024,
                            sfecud025,sfecud026,sfecud027,sfecud028,sfecud029,
                            sfecud030,sfec022,sfec023,sfec024,sfec028)
         VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
                 l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
                 l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
                 l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
                 l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
                 l_sfec.sfec021,l_sfec.sfecud001,l_sfec.sfecud002,l_sfec.sfecud003,l_sfec.sfecud004,
                 l_sfec.sfecud005,l_sfec.sfecud006,l_sfec.sfecud007,l_sfec.sfecud008,l_sfec.sfecud009,
                 l_sfec.sfecud010,l_sfec.sfecud011,l_sfec.sfecud012,l_sfec.sfecud013,l_sfec.sfecud014,
                 l_sfec.sfecud015,l_sfec.sfecud016,l_sfec.sfecud017,l_sfec.sfecud018,l_sfec.sfecud019,
                 l_sfec.sfecud020,l_sfec.sfecud021,l_sfec.sfecud022,l_sfec.sfecud023,l_sfec.sfecud024,
                 l_sfec.sfecud025,l_sfec.sfecud026,l_sfec.sfecud027,l_sfec.sfecud028,l_sfec.sfecud029,
                 l_sfec.sfecud030,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#65 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins sfec_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF   
      END FOREACH
   END IF 
   
   IF g_sfea_m.rd = '2' OR g_sfea_m.rd = '3' THEN
      #161109-00085#34-s
      #SELECT * INTO l_sfaa.* FROM sfaa_t
      SELECT sfaadocno,sfaa010,sfaa011,sfaa012,sfaa013,sfaa015,sfaa072
        INTO l_sfaa.sfaadocno,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,
             l_sfaa.sfaa015,l_sfaa.sfaa072
      FROM sfaa_t
      #161109-00085#34-s
       WHERE sfaaent = g_enterprise AND sfaasite = g_site
         AND sfaadocno = g_sfaadocno
     #料号是否做特征管理
      CALL l_inam.clear()
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = l_sfaa.sfaa010
      IF NOT cl_null(l_imaa005) THEN
         CALL s_feature_multi(l_sfaa.sfaa010,'','',g_site,l_sfaa.sfaadocno) RETURNING l_success,l_inam
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF 
      IF g_sfea_m.rd = '2' THEN
         LET l_type = 'S'
      END IF
      IF g_sfea_m.rd = '3' THEN
         LET l_type = 'Y' 
      END IF
      IF l_inam.getLength() > 0 AND l_inam[1].inam004 > 0 THEN
         FOR l_i = 1 TO l_inam.getLength()
            #160512-00016#16 20160528 modify by ming -----(S) 
            #CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',l_inam[l_i].inam002,'N') RETURNING l_bmba
            CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',l_inam[l_i].inam002,'N',l_sfaa.sfaa072) 
                 RETURNING l_bmba
            #160512-00016#16 20160528 modify by ming -----(E)  
            IF l_bmba_qty.getLength() = 0 THEN
               FOR l_j = 1 TO l_bmba.getLength()
                  LET l_bmba_qty[l_j].bmba001    =  l_bmba[l_j].bmba001
                  LET l_bmba_qty[l_j].bmba002    =  l_bmba[l_j].bmba002  
                  LET l_bmba_qty[l_j].bmba003    =  l_bmba[l_j].bmba003  
                  LET l_bmba_qty[l_j].bmba004    =  l_bmba[l_j].bmba004  
                  LET l_bmba_qty[l_j].bmba005    =  l_bmba[l_j].bmba005  
                  LET l_bmba_qty[l_j].bmba007    =  l_bmba[l_j].bmba007  
                  LET l_bmba_qty[l_j].bmba008    =  l_bmba[l_j].bmba008  
                  #160512-00016#16 20160528 add by ming -----(S) 
                  LET l_bmba_qty[l_j].bmba035    =  l_bmba[l_j].bmba035
                  #160512-00016#16 20160528 add by ming -----(E) 
                  LET l_bmba_qty[l_j].l_bmba011  =  l_bmba[l_j].l_bmba011
                  LET l_bmba_qty[l_j].l_bmba012  =  l_bmba[l_j].l_bmba012
                  LET l_bmba_qty[l_j].l_inam002  =  l_bmba[l_j].l_inam002
                  LET l_bmba_qty[l_j].l_qty      =  l_inam[l_i].inam004
               END FOR
            ELSE
               FOR l_j = 1 TO l_bmba.getLength()
                  LET l_flag = 'N'
                  FOR l_k = 1 TO l_bmba_qty.getLength()
                     IF l_bmba_qty[l_k].bmba001    =  l_bmba[l_j].bmba001 AND 
                        l_bmba_qty[l_k].bmba002    =  l_bmba[l_j].bmba002 AND
                        l_bmba_qty[l_k].bmba003    =  l_bmba[l_j].bmba003 AND
                        l_bmba_qty[l_k].bmba004    =  l_bmba[l_j].bmba004 AND
                        l_bmba_qty[l_k].bmba005    =  l_bmba[l_j].bmba005 AND
                        l_bmba_qty[l_k].bmba007    =  l_bmba[l_j].bmba007 AND
                        l_bmba_qty[l_k].bmba008    =  l_bmba[l_j].bmba008 AND
                        l_bmba_qty[l_k].l_inam002  =  l_bmba[l_j].l_inam002 THEN
                        LET l_bmba_qty[l_k].l_qty  =  l_bmba_qty[l_k].l_qty + l_inam[l_i].inam004
                        LET l_flag = 'Y'
                        EXIT FOR
                     END IF
                  END FOR
                  IF l_flag = 'N' THEN
                     LET l_k = l_bmba_qty.getLength() + 1
                     LET l_bmba_qty[l_k].bmba001    =  l_bmba[l_j].bmba001
                     LET l_bmba_qty[l_k].bmba002    =  l_bmba[l_j].bmba002  
                     LET l_bmba_qty[l_k].bmba003    =  l_bmba[l_j].bmba003  
                     LET l_bmba_qty[l_k].bmba004    =  l_bmba[l_j].bmba004  
                     LET l_bmba_qty[l_k].bmba005    =  l_bmba[l_j].bmba005  
                     LET l_bmba_qty[l_k].bmba007    =  l_bmba[l_j].bmba007  
                     LET l_bmba_qty[l_k].bmba008    =  l_bmba[l_j].bmba008  
                     #160512-00016#16 20160528 add by ming -----(S) 
                     LET l_bmba_qty[l_k].bmba035    =  l_bmba[l_j].bmba035 
                     #160512-00016#16 20160528 add by ming -----(E) 
                     LET l_bmba_qty[l_k].l_bmba011  =  l_bmba[l_j].l_bmba011
                     LET l_bmba_qty[l_k].l_bmba012  =  l_bmba[l_j].l_bmba012
                     LET l_bmba_qty[l_k].l_inam002  =  l_bmba[l_j].l_inam002
                     LET l_bmba_qty[l_k].l_qty      =  l_inam[l_i].inam004
                  END IF
               END FOR 
            END IF   
         END FOR
      ELSE
         #160512-00016#16 20160528 modify by ming -----(S) 
         #CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',' ','N') RETURNING l_bmba
         CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',' ','N',l_sfaa.sfaa072) 
              RETURNING l_bmba
         #160512-00016#16 20160528 modify by ming -----(E) 
         FOR l_i = 1 TO l_bmba.getLength()
            LET l_bmba_qty[l_i].bmba001    =  l_bmba[l_i].bmba001
            LET l_bmba_qty[l_i].bmba002    =  l_bmba[l_i].bmba002  
            LET l_bmba_qty[l_i].bmba003    =  l_bmba[l_i].bmba003  
            LET l_bmba_qty[l_i].bmba004    =  l_bmba[l_i].bmba004  
            LET l_bmba_qty[l_i].bmba005    =  l_bmba[l_i].bmba005  
            LET l_bmba_qty[l_i].bmba007    =  l_bmba[l_i].bmba007  
            LET l_bmba_qty[l_i].bmba008    =  l_bmba[l_i].bmba008  
            #160512-00016#16 20160528 add by ming -----(S) 
            LET l_bmba_qty[l_i].bmba035    =  l_bmba[l_i].bmba035 
            #160512-00016#16 20160528 add by ming -----(E) 
            LET l_bmba_qty[l_i].l_bmba011  =  l_bmba[l_i].l_bmba011
            LET l_bmba_qty[l_i].l_bmba012  =  l_bmba[l_i].l_bmba012
            LET l_bmba_qty[l_i].l_inam002  =  l_bmba[l_i].l_inam002
            LET l_bmba_qty[l_i].l_qty      =  l_sfaa.sfaa012
         END FOR
      END IF
    
      FOR l_i = 1 TO l_bmba_qty.getLength()
         INITIALIZE l_sfeb.* TO NULL
         LET l_sfeb.sfebent   = g_enterprise        #企业编号
         LET l_sfeb.sfebsite  = g_site              #营运据点
         LET l_sfeb.sfebdocno = g_sfeadocno         #完工入库单号
         #项次
         SELECT MAX(sfebseq) INTO l_sfeb.sfebseq FROM sfeb_t 
          WHERE sfebent = g_enterprise AND sfebsite = g_site 
            AND sfebdocno = g_sfeadocno
         IF cl_null(l_sfeb.sfebseq) THEN
            LET l_sfeb.sfebseq = 1
         ELSE 
            LET l_sfeb.sfebseq = l_sfeb.sfebseq + 1
         END IF
         LET l_sfeb.sfeb001 = g_sfaadocno           #工单单号
         #FQC/专案代号/WBS/活动代号
         SELECT sfaa044,sfaa028,sfaa029,sfaa030 INTO l_sfeb.sfeb002,l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019 FROM sfaa_t
          WHERE sfaaent = g_enterprise AND sfaasite = g_site
            AND sfaadocno = g_sfaadocno
         LET l_sfeb.sfeb003 = '4'                   #入库类型
         LET l_sfeb.sfeb004 = l_bmba_qty[l_i].bmba003
         LET l_sfeb.sfeb005 = l_bmba_qty[l_i].l_inam002
         LET l_sfeb.sfeb006   = ''                  
        #单位
         LET l_bmba005_1 = l_bmba_qty[l_i].bmba005
         LET l_sql="SELECT bmba010 FROM bmba_t WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"'",
            "  AND bmba001='",l_bmba_qty[l_i].bmba001,"' AND bmba002='",l_bmba_qty[l_i].bmba002,"' AND bmba003='",l_bmba_qty[l_i].bmba003,"'",
            "  AND bmba004='",l_bmba_qty[l_i].bmba004,"' AND bmba007='",l_bmba_qty[l_i].bmba007,"' AND bmba008='",l_bmba_qty[l_i].bmba008,"'", 
            "  AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')='",l_bmba005_1,"'"
         PREPARE asft340_04_gen_sfeb_pre FROM l_sql
         EXECUTE asft340_04_gen_sfeb_pre INTO l_sfeb.sfeb007
         IF cl_null(l_sfeb.sfeb007) THEN
            SELECT imae081 INTO l_sfeb.sfeb007 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=l_bmba_qty[l_i].bmba003
            IF cl_null(l_sfeb.sfeb007) THEN
               SELECT imaa006 INTO l_sfeb.sfeb007 FROM imaa_t WHERE imaaent=g_enterprise AND imaa001=l_bmba_qty[l_i].bmba003
            END IF
         END IF
         LET l_sfeb.sfeb008 = l_bmba_qty[l_i].l_qty * l_bmba_qty[l_i].l_bmba011 / l_bmba_qty[l_i].l_bmba012
         
         #实际数量
         IF l_sfeb.sfeb002 = 'N' THEN
            LET l_sfeb.sfeb009 = l_sfeb.sfeb008
            LET l_sfeb.sfeb027 = l_sfeb.sfeb008
         ELSE
            LET l_sfeb.sfeb009 = 0
            LET l_sfeb.sfeb027 = 0
         END IF
         
         #参考单位
         SELECT imaf015 INTO l_sfeb.sfeb010 FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site
            AND imaf001 = l_sfeb.sfeb004
            
         #申请参考数量/#实际参考数量
         #若没有参考单位时,参考数量DEFAULT NULL
         IF cl_null(l_sfeb.sfeb010) THEN
            LET l_sfeb.sfeb011 = NULL
            LET l_sfeb.sfeb012 = NULL
         ELSE
            CALL s_aooi250_convert_qty(l_sfeb.sfeb004,l_sfeb.sfeb007,l_sfeb.sfeb010,l_sfeb.sfeb008)
                 RETURNING l_success,l_sfeb.sfeb011
            IF NOT l_success THEN
               LET l_sfeb.sfeb011 = l_sfeb.sfeb008
            END IF
    
            IF l_sfeb.sfeb002 = 'N' THEN
               LET l_sfeb.sfeb012 = l_sfeb.sfeb011
            ELSE
               LET l_sfeb.sfeb012 = 0
            END IF
         END IF
         
         #指定库位/指定储位/指定批号
        #2015/09/10 by stellar add ----- (S)
        IF NOT cl_null(g_sfea_m.sfeb013) THEN
           LET l_sfeb.sfeb013 = g_sfea_m.sfeb013
           LET l_sfeb.sfeb014 = g_sfea_m.sfeb014
        ELSE
        #2015/09/10 by stellar add ----- (E) 
         CALL s_asft340_set_warehouses(l_sfeb.sfeb001,l_sfeb.sfeb004,'','','')
              RETURNING l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015
        END IF   #2015/09/10 by stellar add
    
         LET l_sfeb.sfeb016   = ' '                #库存管理特征
    
         LET l_sfeb.sfeb020   = ' '               #理由码
    
         #库存有效日期
         CALL s_aini010_calculate_effdt(g_site,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb015,l_sfeadocdt)
              RETURNING l_sfeb.sfeb021
         LET l_sfeb.sfeb022   = ' '               #库存备注
         LET l_sfeb.sfeb023   = ''                #生产料号
         LET l_sfeb.sfeb024   = ''                #生产料号BOM特性
         LET l_sfeb.sfeb025   = ''                #生产料号特征
         
         #RUN CARD
         #取工单的第一笔RUN CARD号
         LET l_sql = " SELECT sfcb001 FROM sfcb_t ",
                     "  WHERE sfcbent   = ",g_enterprise,
                     "    AND sfcbdocno = ? ",
                     " ORDER BY sfcb001 "
         PREPARE asft340_04_get_run_card_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "PREPARE asft340_04_get_run_card_p1"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF     
         DECLARE asft340_04_get_run_card_cs2 SCROLL CURSOR FOR asft340_04_get_run_card_p2
         OPEN asft340_04_get_run_card_cs2 USING l_sfeb.sfeb001
         FETCH FIRST asft340_04_get_run_card_cs2 INTO l_sfeb.sfeb026
         IF cl_null(l_sfeb.sfeb026) THEN
            LET l_sfeb.sfeb026 = 0
         END IF
   
         #161109-00085#34-s
         #INSERT INTO sfeb_t VALUES l_sfeb.*
         #161109-00085#65 --s mark
         #INSERT INTO sfeb_t (sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,
         #                    sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,
         #                    sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,
         #                    sfeb027,sfeb028)
         #VALUES (l_sfeb.sfebent,l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb001,
         #        l_sfeb.sfeb002,l_sfeb.sfeb003,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,
         #        l_sfeb.sfeb007,l_sfeb.sfeb008,l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,
         #        l_sfeb.sfeb012,l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,
         #        l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019,l_sfeb.sfeb020,l_sfeb.sfeb021,
         #        l_sfeb.sfeb022,l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb026,
         #        l_sfeb.sfeb027,l_sfeb.sfeb028)
         #161109-00085#65 --e mark
         #161109-00085#34-e
         #161109-00085#65 --s add
         INSERT INTO sfeb_t(sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,
                            sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,
                            sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,
                            sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,
                            sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,
                            sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,
                            sfeb027,sfebud001,sfebud002,sfebud003,sfebud004,
                            sfebud005,sfebud006,sfebud007,sfebud008,sfebud009,
                            sfebud010,sfebud011,sfebud012,sfebud013,sfebud014,
                            sfebud015,sfebud016,sfebud017,sfebud018,sfebud019,
                            sfebud020,sfebud021,sfebud022,sfebud023,sfebud024,
                            sfebud025,sfebud026,sfebud027,sfebud028,sfebud029,
                            sfebud030,sfeb028)
         VALUES (l_sfeb.sfebent,l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb001,
                 l_sfeb.sfeb002,l_sfeb.sfeb003,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,
                 l_sfeb.sfeb007,l_sfeb.sfeb008,l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,
                 l_sfeb.sfeb012,l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,
                 l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019,l_sfeb.sfeb020,l_sfeb.sfeb021,
                 l_sfeb.sfeb022,l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb026,
                 l_sfeb.sfeb027,l_sfeb.sfebud001,l_sfeb.sfebud002,l_sfeb.sfebud003,l_sfeb.sfebud004,
                 l_sfeb.sfebud005,l_sfeb.sfebud006,l_sfeb.sfebud007,l_sfeb.sfebud008,l_sfeb.sfebud009,
                 l_sfeb.sfebud010,l_sfeb.sfebud011,l_sfeb.sfebud012,l_sfeb.sfebud013,l_sfeb.sfebud014,
                 l_sfeb.sfebud015,l_sfeb.sfebud016,l_sfeb.sfebud017,l_sfeb.sfebud018,l_sfeb.sfebud019,
                 l_sfeb.sfebud020,l_sfeb.sfebud021,l_sfeb.sfebud022,l_sfeb.sfebud023,l_sfeb.sfebud024,
                 l_sfeb.sfebud025,l_sfeb.sfebud026,l_sfeb.sfebud027,l_sfeb.sfebud028,l_sfeb.sfebud029,
                 l_sfeb.sfebud030,l_sfeb.sfeb028)
         #161109-00085#65 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert sfeb'
            LET g_errparam.popup = FALSE
            CALL cl_err()
            RETURN r_success
         END IF
      
         IF l_sfeb.sfeb002 = 'Y' THEN
            CONTINUE FOR
         END IF
               
         LET l_sfec.sfecent = g_enterprise 
         LET l_sfec.sfecsite = g_site
         LET l_sfec.sfecdocno = g_sfeadocno
         LET l_sfec.sfecseq = l_sfeb.sfebseq
         LET l_sfec.sfecseq1 = 1
         LET l_sfec.sfec001   = l_sfeb.sfeb001           #工單單號
         LET l_sfec.sfec002   = ''                       #FQC單號
         LET l_sfec.sfec003   = ''                       #判定項次
         LET l_sfec.sfec004   = l_sfeb.sfeb003           #入庫類型
         LET l_sfec.sfec005   = l_sfeb.sfeb004           #料件編號
         LET l_sfec.sfec006   = l_sfeb.sfeb005           #特徵
         LET l_sfec.sfec007   = l_sfeb.sfeb006           #包裝容器
         LET l_sfec.sfec008   = l_sfeb.sfeb007           #單位
         LET l_sfec.sfec009   = l_sfeb.sfeb008           #數量
         LET l_sfec.sfec010   = l_sfeb.sfeb010           #參考單位
         LET l_sfec.sfec011   = l_sfeb.sfeb011           #參考數量
         LET l_sfec.sfec012   = l_sfeb.sfeb013           #庫位
         LET l_sfec.sfec013   = l_sfeb.sfeb014           #儲位
         LET l_sfec.sfec014   = l_sfeb.sfeb015           #批號
         LET l_sfec.sfec015   = l_sfeb.sfeb016           #庫存管理特徵
         LET l_sfec.sfec016   = l_sfeb.sfeb021           #有效日期
         LET l_sfec.sfec017   = l_sfeb.sfeb022           #庫存備註
         LET l_sfec.sfec021   = l_sfeb.sfeb026           #RUN CARD
         LET l_sfec.sfec022   = l_sfeb.sfeb017           #專案編號
         LET l_sfec.sfec023   = l_sfeb.sfeb018           #WBS
         LET l_sfec.sfec024   = l_sfeb.sfeb019           #活動編號

         #161109-00085#34-s
         #INSERT INTO sfec_t VALUES l_sfec.*
         #161109-00085#65 --s mark
         #INSERT INTO sfec_t (sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,sfec001,sfec002,sfec003,sfec004,sfec005,
         #                    sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,
         #                    sfec016,sfec017,sfec018,sfec019,sfec020,sfec021,sfec022,sfec023,sfec024,sfec028)
         #VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
         #        l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
         #        l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
         #        l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
         #        l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
         #        l_sfec.sfec021,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#65 --e mark
         #161109-00085#34-e
         #161109-00085#65 --s add
         INSERT INTO sfec_t(sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,
                            sfec001,sfec002,sfec003,sfec004,sfec005,
                            sfec006,sfec007,sfec008,sfec009,sfec010,
                            sfec011,sfec012,sfec013,sfec014,sfec015,
                            sfec016,sfec017,sfec018,sfec019,sfec020,
                            sfec021,sfecud001,sfecud002,sfecud003,sfecud004,
                            sfecud005,sfecud006,sfecud007,sfecud008,sfecud009,
                            sfecud010,sfecud011,sfecud012,sfecud013,sfecud014,
                            sfecud015,sfecud016,sfecud017,sfecud018,sfecud019,
                            sfecud020,sfecud021,sfecud022,sfecud023,sfecud024,
                            sfecud025,sfecud026,sfecud027,sfecud028,sfecud029,
                            sfecud030,sfec022,sfec023,sfec024,sfec028)
         VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
                 l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
                 l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
                 l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
                 l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
                 l_sfec.sfec021,l_sfec.sfecud001,l_sfec.sfecud002,l_sfec.sfecud003,l_sfec.sfecud004,
                 l_sfec.sfecud005,l_sfec.sfecud006,l_sfec.sfecud007,l_sfec.sfecud008,l_sfec.sfecud009,
                 l_sfec.sfecud010,l_sfec.sfecud011,l_sfec.sfecud012,l_sfec.sfecud013,l_sfec.sfecud014,
                 l_sfec.sfecud015,l_sfec.sfecud016,l_sfec.sfecud017,l_sfec.sfecud018,l_sfec.sfecud019,
                 l_sfec.sfecud020,l_sfec.sfecud021,l_sfec.sfecud022,l_sfec.sfecud023,l_sfec.sfecud024,
                 l_sfec.sfecud025,l_sfec.sfecud026,l_sfec.sfecud027,l_sfec.sfecud028,l_sfec.sfecud029,
                 l_sfec.sfecud030,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#65 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins sfec_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF   
      END FOR 
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查庫位sfeb013/儲位sfeb014 值的合理性
# Memo...........:
# Usage..........: CALL asft340_04_chk_warehouses()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/09/10 by stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_04_chk_warehouses()
DEFINE r_success      LIKE type_t.num5
DEFINE l_sfaa005      LIKE sfaa_t.sfaa005
DEFINE l_sfaa010      LIKE sfaa_t.sfaa010
DEFINE l_inaa010      LIKE inaa_t.inaa010
   
   LET r_success = TRUE

   #檢查庫位資料
   IF NOT cl_null(g_sfea_m.sfeb013) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_sfea_m.sfeb013
      IF NOT cl_chk_exist("v_inaa001_2") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #檢查儲位
   IF NOT cl_null(g_sfea_m.sfeb014) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_sfea_m.sfeb013
      LET g_chkparam.arg3 = g_sfea_m.sfeb014
      IF NOT cl_chk_exist("v_inab002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   SELECT sfaa005,sfaa010 INTO l_sfaa005,l_sfaa010
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = g_sfaadocno
   IF l_sfaa005 = '5' THEN
      SELECT inaa010 INTO l_inaa010 
        FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_sfea_m.sfeb013
      IF l_inaa010 <> 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'arm-00013'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_sfaadocno
         LET g_errparam.replace[2] = g_sfea_m.sfeb013
         
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
