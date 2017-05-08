#該程式未解開Section, 採用最新樣板產出!
{<section id="asft300_07.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-07-30 15:11:26), PR版次:0005(2016-12-05 08:32:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: asft300_07
#+ Description: 拆件工單料號明細產生
#+ Creator....: 01258(2015-07-30 12:01:07)
#+ Modifier...: 01258 -SD/PR- 08171
 
{</section>}
 
{<section id="asft300_07.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160512-00016#14  2016/05/27 By ming      s_asft300_02_bom增加參數 
#160601-00015#1   2016/06/15 By ming      1. asft300_07.4gl 中的函式asft300_07_gen_sfac() 定義的l_bmba要和s_asft300_02.4gl的r_bmba一樣
#                                         2. 拆件式工單產生call s_asft300_02_bom的地方，保稅否傳工單單頭的保稅否sfaa072 
#161109-00085#28  2016/11/11 By lienjunqi 整批調整系統星號寫法
#161109-00085#62  2016/11/25  By 08171    整批調整系統星號寫法
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
PRIVATE type type_g_sfaa_m        RECORD
       rd LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sfaadocno     LIKE sfaa_t.sfaadocno
DEFINE g_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
        inam001        LIKE inam_t.inam001,
        inam002        LIKE inam_t.inam002,
        inam004        LIKE inam_t.inam004
                       END RECORD
#end add-point
 
DEFINE g_sfaa_m        type_g_sfaa_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asft300_07.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft300_07(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_sfaadocno,p_inam
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
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE p_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001        LIKE inam_t.inam001,
           inam002        LIKE inam_t.inam002,
           inam004        LIKE inam_t.inam004
                          END RECORD
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft300_07 WITH FORM cl_ap_formpath("asf","asft300_07")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_sfaadocno = p_sfaadocno
   LET g_inam = p_inam
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_sfaa_m.rd ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_sfaa_m.rd = '1' 
            DISPLAY BY NAME g_sfaa_m.rd
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
 
 
 #欄位檢查
                  #Ctrlp:input.c.rd
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rd
            #add-point:ON ACTION controlp INFIELD rd name="input.c.rd"
            
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
   IF g_sfaa_m.rd != '1' THEN 
      CALL asft300_07_gen() RETURNING l_success
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asft300_07 
   
   #add-point:input段after input name="input.post_input"
   RETURN g_sfaa_m.rd
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft300_07.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft300_07.other_function" readonly="Y" >}

#根据画面条件产生sfac资料
PRIVATE FUNCTION asft300_07_gen()
DEFINE r_success              LIKE type_t.num5
DEFINE l_n                    LIKE type_t.num5
                              
   LET r_success = FALSE
   SELECT COUNT(1) INTO l_n FROM sfac_t 
    WHERE sfacent = g_enterprise AND sfacsite = g_site 
      AND sfacdocno = g_sfaadocno
   IF l_n > 0 THEN
      IF cl_ask_confirm('asf-00478') THEN
         DELETE FROM sfac_t 
          WHERE sfacent = g_enterprise AND sfacsite = g_site
            AND sfacdocno = g_sfaadocno          
         IF NOT asft300_07_gen_sfac() THEN
            RETURN r_success
         END IF
      END IF
   ELSE
      IF NOT asft300_07_gen_sfac() THEN
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#根据BOM资料产生生产料号明细资料
PRIVATE FUNCTION asft300_07_gen_sfac()
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
       #160601-00015#1 20160615 add by ming -----(S) 
       bmba035                LIKE bmba_t.bmba035, 
       #160601-00015#1 20160615 add by ming -----(S) 
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
       #160512-00016#14 20160528 add by ming -----(S) 
       bmba035                LIKE bmba_t.bmba035,     #保稅否 
       #160512-00016#14 20160528 add by ming -----(E) 
       l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002              LIKE inam_t.inam002,     #元件对应特征
       l_qty                  LIKE sfaa_t.sfaa012      #对应数量
                              END RECORD
DEFINE l_sql                  STRING
#161109-00085#28-s
#DEFINE l_sfaa                 RECORD LIKE sfaa_t.*
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       #161109-00085#62 --s add
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
       sfaaud030 LIKE sfaa_t.sfaaud030, #自定義欄位(日期時間)030
       #161109-00085#62 --e add
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
END RECORD
#END RECORD
#161109-00085#28-e
DEFINE l_type                 LIKE type_t.chr1
DEFINE l_flag                 LIKE type_t.chr1
DEFINE l_sfacseq              LIKE sfac_t.sfacseq
DEFINE l_sfac003              LIKE sfac_t.sfac003
DEFINE l_sfac004              LIKE sfac_t.sfac004
DEFINE l_bmba005_1            LIKE ooff_t.ooff007
DEFINE l_success              LIKE type_t.num5
   
   LET r_success = FALSE
   #161109-00085#28-s
   #SELECT * INTO l_sfaa.* FROM sfaa_t
   #161109-00085#62 --s mark
   #SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
   #       sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
   #       sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
   #       sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
   #       sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
   #       sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
   #       sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
   #       sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
   #       sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaa071,sfaa072
   #  INTO l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,
   #       l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,
   #       l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,l_sfaa.sfaadocno,
   #       l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,
   #       l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,
   #       l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
   #       l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,
   #       l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,l_sfaa.sfaa023,l_sfaa.sfaa024,
   #       l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,
   #       l_sfaa.sfaa030,l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,
   #       l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,l_sfaa.sfaa039,
   #       l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,
   #       l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,
   #       l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
   #       l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,
   #       l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,l_sfaa.sfaa063,l_sfaa.sfaa064,
   #       l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,
   #       l_sfaa.sfaa070,l_sfaa.sfaa071,l_sfaa.sfaa072
   #  FROM sfaa_t
   #161109-00085#62 --e mark
   #161109-00085#28-e
   #161109-00085#62 --s add
   SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,
          sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
          sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,
          sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
          sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,
          sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
          sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,
          sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
          sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,
          sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
          sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,
          sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
          sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,
          sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
          sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,
          sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
          sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,
          sfaa070,sfaaud001,sfaaud002,sfaaud003,sfaaud004,
          sfaaud005,sfaaud006,sfaaud007,sfaaud008,sfaaud009,
          sfaaud010,sfaaud011,sfaaud012,sfaaud013,sfaaud014,
          sfaaud015,sfaaud016,sfaaud017,sfaaud018,sfaaud019,
          sfaaud020,sfaaud021,sfaaud022,sfaaud023,sfaaud024,
          sfaaud025,sfaaud026,sfaaud027,sfaaud028,sfaaud029,
          sfaaud030,sfaa071,sfaa072
     INTO l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,
          l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,
          l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,l_sfaa.sfaadocno,
          l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,
          l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,
          l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
          l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,
          l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,l_sfaa.sfaa023,l_sfaa.sfaa024,
          l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,
          l_sfaa.sfaa030,l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,
          l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,l_sfaa.sfaa039,
          l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,
          l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,
          l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
          l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,
          l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,l_sfaa.sfaa063,l_sfaa.sfaa064,
          l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,
          l_sfaa.sfaa070,l_sfaa.sfaaud001,l_sfaa.sfaaud002,l_sfaa.sfaaud003,l_sfaa.sfaaud004,
          l_sfaa.sfaaud005,l_sfaa.sfaaud006,l_sfaa.sfaaud007,l_sfaa.sfaaud008,l_sfaa.sfaaud009,
          l_sfaa.sfaaud010,l_sfaa.sfaaud011,l_sfaa.sfaaud012,l_sfaa.sfaaud013,l_sfaa.sfaaud014,
          l_sfaa.sfaaud015,l_sfaa.sfaaud016,l_sfaa.sfaaud017,l_sfaa.sfaaud018,l_sfaa.sfaaud019,
          l_sfaa.sfaaud020,l_sfaa.sfaaud021,l_sfaa.sfaaud022,l_sfaa.sfaaud023,l_sfaa.sfaaud024,
          l_sfaa.sfaaud025,l_sfaa.sfaaud026,l_sfaa.sfaaud027,l_sfaa.sfaaud028,l_sfaa.sfaaud029,
          l_sfaa.sfaaud030,l_sfaa.sfaa071,l_sfaa.sfaa072
     FROM sfaa_t
   #161109-00085#62 --e add
    WHERE sfaaent = g_enterprise AND sfaasite = g_site
      AND sfaadocno = g_sfaadocno
   IF g_sfaa_m.rd = '2' THEN
      LET l_type = 'S'
   END IF
   IF g_sfaa_m.rd = '3' THEN
      LET l_type = 'Y' 
   END IF
   IF g_inam.getLength() > 0 AND g_inam[1].inam004 > 0 THEN
      FOR l_i = 1 TO g_inam.getLength() 
         #160601-00015#1 20160615 modify by ming -----(S) 
         ##160512-00016#14 20160527 modify by ming -----(S) 
         ##不確定是否走保稅，所以不指定Y/N
         ##CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',g_inam[l_i].inam002,'N') RETURNING l_bmba
         #CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',g_inam[l_i].inam002,'N','') 
         #     RETURNING l_bmba
         ##160512-00016#14 20160527 modify by ming -----(E) 
         #拆件式工單產生call s_asft300_02_bom的地方，保稅否傳工單單頭的保稅否sfaa072 
         CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',g_inam[l_i].inam002,'N',l_sfaa.sfaa072) 
              RETURNING l_bmba
         #160601-00015#1 20160615 modify by ming -----(E) 
         IF l_bmba_qty.getLength() = 0 THEN
            FOR l_j = 1 TO l_bmba.getLength()
               LET l_bmba_qty[l_j].bmba001    =  l_bmba[l_j].bmba001
               LET l_bmba_qty[l_j].bmba002    =  l_bmba[l_j].bmba002  
               LET l_bmba_qty[l_j].bmba003    =  l_bmba[l_j].bmba003  
               LET l_bmba_qty[l_j].bmba004    =  l_bmba[l_j].bmba004  
               LET l_bmba_qty[l_j].bmba005    =  l_bmba[l_j].bmba005  
               LET l_bmba_qty[l_j].bmba007    =  l_bmba[l_j].bmba007  
               LET l_bmba_qty[l_j].bmba008    =  l_bmba[l_j].bmba008  
               LET l_bmba_qty[l_j].l_bmba011  =  l_bmba[l_j].l_bmba011
               LET l_bmba_qty[l_j].l_bmba012  =  l_bmba[l_j].l_bmba012
               LET l_bmba_qty[l_j].l_inam002  =  l_bmba[l_j].l_inam002
               LET l_bmba_qty[l_j].l_qty      =  g_inam[l_i].inam004
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
                     LET l_bmba_qty[l_k].l_qty  =  l_bmba_qty[l_k].l_qty + g_inam[l_i].inam004
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
                  LET l_bmba_qty[l_k].l_bmba011  =  l_bmba[l_j].l_bmba011
                  LET l_bmba_qty[l_k].l_bmba012  =  l_bmba[l_j].l_bmba012
                  LET l_bmba_qty[l_k].l_inam002  =  l_bmba[l_j].l_inam002
                  LET l_bmba_qty[l_k].l_qty      =  g_inam[l_i].inam004
               END IF
            END FOR 
         END IF   
      END FOR
   ELSE
      #160601-00015#1 20160615 modify by ming -----(S) 
      ##160512-00016#14 20160527 modify by ming -----(S) 
      ##不確定是否保稅，所以不指定Y/N
      ##CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',' ','N') RETURNING l_bmba
      #CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',' ','N','') 
      #     RETURNING l_bmba
      ##160512-00016#14 20160527 modify by ming -----(E) 
      #拆件式工單產生call s_asft300_02_bom的地方，保稅否傳工單單頭的保稅否sfaa072 
      CALL s_asft300_02_bom(0,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa013,1,1,l_sfaa.sfaa015,l_type,'',' ','N',l_sfaa.sfaa072) 
           RETURNING l_bmba
      #160601-00015#1 20160615 modify by ming -----(E) 
      FOR l_i = 1 TO l_bmba.getLength()
         LET l_bmba_qty[l_i].bmba001    =  l_bmba[l_i].bmba001
         LET l_bmba_qty[l_i].bmba002    =  l_bmba[l_i].bmba002  
         LET l_bmba_qty[l_i].bmba003    =  l_bmba[l_i].bmba003  
         LET l_bmba_qty[l_i].bmba004    =  l_bmba[l_i].bmba004  
         LET l_bmba_qty[l_i].bmba005    =  l_bmba[l_i].bmba005  
         LET l_bmba_qty[l_i].bmba007    =  l_bmba[l_i].bmba007  
         LET l_bmba_qty[l_i].bmba008    =  l_bmba[l_i].bmba008  
         LET l_bmba_qty[l_i].l_bmba011  =  l_bmba[l_i].l_bmba011
         LET l_bmba_qty[l_i].l_bmba012  =  l_bmba[l_i].l_bmba012
         LET l_bmba_qty[l_i].l_inam002  =  l_bmba[l_i].l_inam002
         LET l_bmba_qty[l_i].l_qty      =  l_sfaa.sfaa012
      END FOR
   END IF

   FOR l_i = 1 TO l_bmba_qty.getLength()
      SELECT MAX(sfacseq) INTO l_sfacseq FROM sfac_t 
       WHERE sfacent = g_enterprise AND sfacsite = g_site 
         AND sfacdocno = g_sfaadocno
      IF cl_null(l_sfacseq) THEN
         LET l_sfacseq = 1
      ELSE 
         LET l_sfacseq = l_sfacseq + 1
      END IF
      
      LET l_sfac003 = l_bmba_qty[l_i].l_qty * l_bmba_qty[l_i].l_bmba011 / l_bmba_qty[l_i].l_bmba012
      
      LET l_bmba005_1 = l_bmba_qty[l_i].bmba005
      LET l_sql="SELECT bmba010 FROM bmba_t WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"'",
         "  AND bmba001='",l_bmba_qty[l_i].bmba001,"' AND bmba002='",l_bmba_qty[l_i].bmba002,"' AND bmba003='",l_bmba_qty[l_i].bmba003,"'",
         "  AND bmba004='",l_bmba_qty[l_i].bmba004,"' AND bmba007='",l_bmba_qty[l_i].bmba007,"' AND bmba008='",l_bmba_qty[l_i].bmba008,"'", 
         "  AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')='",l_bmba005_1,"'"
      PREPARE asft300_07_gen_sfac_pre FROM l_sql
      EXECUTE asft300_07_gen_sfac_pre INTO l_sfac004
      IF cl_null(l_sfac004) THEN
         SELECT imae081 INTO l_sfac004 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=l_bmba_qty[l_i].bmba003
         IF cl_null(l_sfac004) THEN
            SELECT imaa006 INTO l_sfac004 FROM imaa_t WHERE imaaent=g_enterprise AND imaa001=l_bmba_qty[l_i].bmba003
         END IF
      END IF
      
      CALL s_aooi250_take_decimals(l_sfac004,l_sfac003)
           RETURNING l_success,l_sfac003
           
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,sfac002,sfac003,sfac004,sfac005,sfac006)
                  VALUES(g_enterprise,g_site,g_sfaadocno,l_sfacseq,l_bmba_qty[l_i].bmba003,'4',l_sfac003,l_sfac004,0,l_bmba_qty[l_i].l_inam002)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfac_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END FOR 
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

 
{</section>}
 
