#該程式未解開Section, 採用最新樣板產出!
{<section id="asft300_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-02-25 10:39:38), PR版次:0009(2017-01-24 10:48:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000159
#+ Filename...: asft300_01
#+ Description: 多訂單來源產生
#+ Creator....: 01258(2013-12-25 15:13:32)
#+ Modifier...: 07024 -SD/PR- 05384
 
{</section>}
 
{<section id="asft300_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#3   2016/04/12  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161109-00085#28  2016/11/11  By lienjunqi   整批調整系統星號寫法
#161109-00085#65  2016/11/30  By 08171       整批調整系統星號寫法
#170104-00066#2   2017/01/06  By Rainy       筆數相關變數由num5放大至num10
#161128-00045#1   2017/01/24  By shiun       更改q_xmdddocno開窗條件及程式內xmdastus改為IN ('Y','H')
#170103-00023#1   2017/01/12  By shiun       取得料號後帶出保稅否
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="asft300_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_xmdd_m        RECORD
       xmdd001         LIKE xmdd_t.xmdd001, 
       xmdd040         LIKE xmdd_t.xmdd040, #160214-00005#3-add
       xmdd001_desc    LIKE imaal_t.imaal003,
       xmdd001_desc1   LIKE imaal_t.imaal004,
       imae016         LIKE imae_t.imae016,
       imae016_desc    LIKE oocal_t.oocal003,
       date_begin      LIKE xmdd_t.xmdd011,
       date_end        LIKE xmdd_t.xmdd011,
       sum             LIKE xmdd_t.xmdd006
                       END RECORD
DEFINE g_xmdd_d        DYNAMIC ARRAY OF RECORD
       select          LIKE type_t.chr1,
       xmdddocno       LIKE xmdd_t.xmdddocno,
       xmddseq         LIKE xmdd_t.xmddseq,
       xmddseq1        LIKE xmdd_t.xmddseq1,
       xmddseq2	       LIKE xmdd_t.xmddseq2,
       xmdd006         LIKE xmdd_t.xmdd006,
       xmdd004         LIKE xmdd_t.xmdd004,
       xmdd004_desc    LIKE oocal_t.oocal003,
       qty1            LIKE xmdd_t.xmdd006,
       unit            LIKE xmdd_t.xmdd004,
       unit_desc       LIKE oocal_t.oocal003,
       qty2            LIKE xmdd_t.xmdd006,
       qty3            LIKE xmdd_t.xmdd006,
       xmda004         LIKE xmda_t.xmda004,
       xmda004_desc    LIKE type_t.chr80,
       xmda003         LIKE xmda_t.xmda003,
       xmda003_desc    LIKE type_t.chr80,
       xmda002         LIKE xmda_t.xmda003,
       xmda002_desc    LIKE type_t.chr80,
       xmdd011         LIKE xmdd_t.xmdd011
                       END RECORD
#161109-00085#28-s
#DEFINE g_sfaa          RECORD LIKE sfaa_t.*
DEFINE g_sfaa RECORD  #工單單頭檔
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
       #161109-00085#65 --s add
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
       #161109-00085#65 --e add
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
END RECORD
#161109-00085#28-e
DEFINE l_ac            LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_x             LIKE type_t.num5
DEFINE g_ref_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
       
#end add-point
 
{</section>}
 
{<section id="asft300_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asft300_01.other_dialog" >}

 
{</section>}
 
{<section id="asft300_01.other_function" readonly="Y" >}
#说明栏位显示
PRIVATE FUNCTION asft300_01_desc(p_type)
DEFINE p_type    LIKE type_t.chr1
   IF p_type = 'N' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_m.xmdd001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_m.xmdd001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_m.xmdd001_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_m.xmdd001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_m.xmdd001_desc1 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_m.xmdd001_desc1
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_m.imae016
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_m.imae016_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_m.imae016_desc
   END IF
   
   IF p_type = 'Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_d[l_ac].xmdd004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_d[l_ac].xmdd004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_d[l_ac].unit
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_d[l_ac].unit_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_d[l_ac].unit_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_d[l_ac].xmda002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_xmdd_d[l_ac].xmda002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_d[l_ac].xmda002_desc
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_d[l_ac].xmda003
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_d[l_ac].xmda003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_d[l_ac].xmda003_desc
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdd_d[l_ac].xmda004
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_xmdd_d[l_ac].xmda004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmdd_d[l_ac].xmda004_desc
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 多订单来源产生
# Memo...........:
# Usage..........: CALL asft300_01(p_sfaadocno)
#                  RETURNING 回传参数
# Input parameter: 1.p_sfaadocno       LIKE sfaa_t.sfaadocno
# Return code....: 
# Date & Author..: 2014/3/31 By wuxja
# Modify.........:
################################################################################
PUBLIC FUNCTION asft300_01(p_sfaadocno)
DEFINE p_sfaadocno        LIKE sfaa_t.sfaadocno
DEFINE l_allow_insert     LIKE type_t.num5         #可新增否 
DEFINE l_allow_delete     LIKE type_t.num5        #可刪除否
#161109-00085#28-s
#DEFINE l_sfab             RECORD LIKE sfab_t.*
DEFINE l_sfab RECORD  #工單來源檔
       sfabent LIKE sfab_t.sfabent, #企業編號
       sfabsite LIKE sfab_t.sfabsite, #營運據點
       sfabdocno LIKE sfab_t.sfabdocno, #單號
       sfab001 LIKE sfab_t.sfab001, #來源
       sfab002 LIKE sfab_t.sfab002, #來源單號
       sfab003 LIKE sfab_t.sfab003, #來源項次
       sfab004 LIKE sfab_t.sfab004, #來源項序
       sfab005 LIKE sfab_t.sfab005, #分批序
       sfab006 LIKE sfab_t.sfab006, #分配優先序
       sfab007 LIKE sfab_t.sfab007, #本次轉開工單量
      #sfabseq LIKE sfab_t.sfabseq  #項次 #161109-00085#65 mark
       #161109-00085#65 --s add
       sfabseq LIKE sfab_t.sfabseq, #項次
       sfabud001 LIKE sfab_t.sfabud001, #自定義欄位(文字)001
       sfabud002 LIKE sfab_t.sfabud002, #自定義欄位(文字)002
       sfabud003 LIKE sfab_t.sfabud003, #自定義欄位(文字)003
       sfabud004 LIKE sfab_t.sfabud004, #自定義欄位(文字)004
       sfabud005 LIKE sfab_t.sfabud005, #自定義欄位(文字)005
       sfabud006 LIKE sfab_t.sfabud006, #自定義欄位(文字)006
       sfabud007 LIKE sfab_t.sfabud007, #自定義欄位(文字)007
       sfabud008 LIKE sfab_t.sfabud008, #自定義欄位(文字)008
       sfabud009 LIKE sfab_t.sfabud009, #自定義欄位(文字)009
       sfabud010 LIKE sfab_t.sfabud010, #自定義欄位(文字)010
       sfabud011 LIKE sfab_t.sfabud011, #自定義欄位(數字)011
       sfabud012 LIKE sfab_t.sfabud012, #自定義欄位(數字)012
       sfabud013 LIKE sfab_t.sfabud013, #自定義欄位(數字)013
       sfabud014 LIKE sfab_t.sfabud014, #自定義欄位(數字)014
       sfabud015 LIKE sfab_t.sfabud015, #自定義欄位(數字)015
       sfabud016 LIKE sfab_t.sfabud016, #自定義欄位(數字)016
       sfabud017 LIKE sfab_t.sfabud017, #自定義欄位(數字)017
       sfabud018 LIKE sfab_t.sfabud018, #自定義欄位(數字)018
       sfabud019 LIKE sfab_t.sfabud019, #自定義欄位(數字)019
       sfabud020 LIKE sfab_t.sfabud020, #自定義欄位(數字)020
       sfabud021 LIKE sfab_t.sfabud021, #自定義欄位(日期時間)021
       sfabud022 LIKE sfab_t.sfabud022, #自定義欄位(日期時間)022
       sfabud023 LIKE sfab_t.sfabud023, #自定義欄位(日期時間)023
       sfabud024 LIKE sfab_t.sfabud024, #自定義欄位(日期時間)024
       sfabud025 LIKE sfab_t.sfabud025, #自定義欄位(日期時間)025
       sfabud026 LIKE sfab_t.sfabud026, #自定義欄位(日期時間)026
       sfabud027 LIKE sfab_t.sfabud027, #自定義欄位(日期時間)027
       sfabud028 LIKE sfab_t.sfabud028, #自定義欄位(日期時間)028
       sfabud029 LIKE sfab_t.sfabud029, #自定義欄位(日期時間)029
       sfabud030 LIKE sfab_t.sfabud030  #自定義欄位(日期時間)030
       #161109-00085#65 --e add
                 END RECORD
#161109-00085#28-e
DEFINE l_flag             LIKE type_t.chr1
DEFINE l_i                LIKE type_t.num10     #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_success          LIKE type_t.num5
DEFINE l_rate             LIKE type_t.num5
DEFINE l_ooef008          LIKE ooef_t.ooef008
DEFINE l_n                LIKE type_t.num5
DEFINE l_days             LIKE type_t.num5
DEFINE l_flag1            LIKE type_t.chr1

   #畫面開啟 (identifier)
   OPEN WINDOW w_asft300_01 WITH FORM cl_ap_formpath("asf","asft300_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   CLEAR FORM
   CALL g_xmdd_d.clear()
   
   #輸入前處理
   #add-point:單身前置處理
   LET g_sfaa.sfaadocno = p_sfaadocno
   #161109-00085#28-s
   #SELECT * INTO g_sfaa.* FROM sfaa_t
   #161109-00085#65 --s mark
   #SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
   #       sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
   #       sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
   #       sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
   #       sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
   #       sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
   #       sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
   #       sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
   #       sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaa071,sfaa072
   #  INTO g_sfaa.sfaaent,g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,
   #       g_sfaa.sfaacrtdt,g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,
   #       g_sfaa.sfaapstid,g_sfaa.sfaapstdt,g_sfaa.sfaastus,g_sfaa.sfaasite,g_sfaa.sfaadocno,
   #       g_sfaa.sfaadocdt,g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,
   #       g_sfaa.sfaa005,g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,
   #       g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,
   #       g_sfaa.sfaa015,g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,
   #       g_sfaa.sfaa020,g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,
   #       g_sfaa.sfaa025,g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,
   #       g_sfaa.sfaa030,g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,
   #       g_sfaa.sfaa035,g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,
   #       g_sfaa.sfaa040,g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,
   #       g_sfaa.sfaa045,g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,
   #       g_sfaa.sfaa050,g_sfaa.sfaa051,g_sfaa.sfaa052,g_sfaa.sfaa053,g_sfaa.sfaa054,
   #       g_sfaa.sfaa055,g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,g_sfaa.sfaa059,
   #       g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa062,g_sfaa.sfaa063,g_sfaa.sfaa064,
   #       g_sfaa.sfaa065,g_sfaa.sfaa066,g_sfaa.sfaa067,g_sfaa.sfaa068,g_sfaa.sfaa069,
   #       g_sfaa.sfaa070,g_sfaa.sfaa071,g_sfaa.sfaa072 
   #FROM sfaa_t
   #161109-00085#65 --e amrk
   #161109-00085#28-e   
   #161109-00085#65 --s add
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
     INTO g_sfaa.sfaaent,g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,
          g_sfaa.sfaacrtdt,g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,
          g_sfaa.sfaapstid,g_sfaa.sfaapstdt,g_sfaa.sfaastus,g_sfaa.sfaasite,g_sfaa.sfaadocno,
          g_sfaa.sfaadocdt,g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,
          g_sfaa.sfaa005,g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,
          g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,
          g_sfaa.sfaa015,g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,
          g_sfaa.sfaa020,g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,
          g_sfaa.sfaa025,g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,
          g_sfaa.sfaa030,g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,
          g_sfaa.sfaa035,g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,
          g_sfaa.sfaa040,g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,
          g_sfaa.sfaa045,g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,
          g_sfaa.sfaa050,g_sfaa.sfaa051,g_sfaa.sfaa052,g_sfaa.sfaa053,g_sfaa.sfaa054,
          g_sfaa.sfaa055,g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,g_sfaa.sfaa059,
          g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa062,g_sfaa.sfaa063,g_sfaa.sfaa064,
          g_sfaa.sfaa065,g_sfaa.sfaa066,g_sfaa.sfaa067,g_sfaa.sfaa068,g_sfaa.sfaa069,
          g_sfaa.sfaa070,g_sfaa.sfaaud001,g_sfaa.sfaaud002,g_sfaa.sfaaud003,g_sfaa.sfaaud004,
          g_sfaa.sfaaud005,g_sfaa.sfaaud006,g_sfaa.sfaaud007,g_sfaa.sfaaud008,g_sfaa.sfaaud009,
          g_sfaa.sfaaud010,g_sfaa.sfaaud011,g_sfaa.sfaaud012,g_sfaa.sfaaud013,g_sfaa.sfaaud014,
          g_sfaa.sfaaud015,g_sfaa.sfaaud016,g_sfaa.sfaaud017,g_sfaa.sfaaud018,g_sfaa.sfaaud019,
          g_sfaa.sfaaud020,g_sfaa.sfaaud021,g_sfaa.sfaaud022,g_sfaa.sfaaud023,g_sfaa.sfaaud024,
          g_sfaa.sfaaud025,g_sfaa.sfaaud026,g_sfaa.sfaaud027,g_sfaa.sfaaud028,g_sfaa.sfaaud029,
          g_sfaa.sfaaud030,g_sfaa.sfaa071,g_sfaa.sfaa072
     FROM sfaa_t
   #161109-00085#65 --e add
    WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = g_sfaa.sfaadocno
   IF NOT cl_null(g_sfaa.sfaa010) AND NOT cl_null(g_sfaa.sfaa013) THEN
      LET g_xmdd_m.xmdd001 = g_sfaa.sfaa010
      LET g_xmdd_m.imae016 = g_sfaa.sfaa013
      DISPLAY BY NAME g_xmdd_m.xmdd001,g_xmdd_m.imae016  
      CALL asft300_01_desc('N')      
      CALL cl_set_comp_entry("xmdd001",FALSE)     
   ELSE
      CALL cl_set_comp_entry("xmdd001",TRUE)
   END IF 
   
   LET g_xmdd_m.date_begin = ''
   LET g_xmdd_m.date_end = ''
   LET g_xmdd_m.sum = 0
   DISPLAY BY NAME g_xmdd_m.date_begin,g_xmdd_m.date_end,g_xmdd_m.sum
   
   WHILE TRUE
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_xmdd_m.xmdd001,g_xmdd_m.xmdd040,g_xmdd_m.date_begin,g_xmdd_m.date_end ATTRIBUTE(WITHOUT DEFAULTS) #160214-00005#3-add-'xmdd040'
         AFTER FIELD xmdd001
            IF NOT cl_null(g_xmdd_m.xmdd001) THEN
               IF NOT asft300_01_xmdd001() THEN
                  NEXT FIELD xmdd001
               END IF
               SELECT imae016 INTO g_xmdd_m.imae016 FROM imae_t
                WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_xmdd_m.xmdd001
               IF cl_null(g_xmdd_m.imae016) THEN
                  SELECT imaa006 INTO g_xmdd_m.imae016 FROM imaa_t
                   WHERE imaaent = g_enterprise AND imaa001 = g_xmdd_m.xmdd001
               END IF
               DISPLAY BY NAME g_xmdd_m.imae016
               CALL asft300_01_desc('N')
            END IF

         #160214-00005#3-add----(S)
         AFTER FIELD xmdd040
            IF NOT cl_null(g_xmdd_m.xmdd040) THEN
               IF NOT cl_null(g_xmdd_m.xmdd001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                   LET g_chkparam.arg1 = g_xmdd_m.xmdd001
                   LET g_chkparam.arg2 = g_xmdd_m.xmdd040
                   #160318-00025#3--add--str
                   LET g_errshow = TRUE 
                   LET g_chkparam.err_str[1] = "aim-00127:sub-01302|abmm200|",cl_get_progname("abmm200",g_lang,"2"),"|:EXEPROGabmm200"
                   #160318-00025#3--add--end
                   IF NOT cl_chk_exist("v_bmaa002") THEN
                      LET g_xmdd_m.xmdd040 = ''
                      DISPLAY BY NAME g_xmdd_m.xmdd040
                      NEXT FIELD CURRENT
                   END IF
                END IF
             END IF
         #160214-00005#3-add----(E)
         
         AFTER FIELD date_begin
            IF NOT cl_null(g_xmdd_m.date_begin) AND NOT cl_null(g_xmdd_m.date_end) THEN
               IF g_xmdd_m.date_begin > g_xmdd_m.date_end THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00202'
                  LET g_errparam.extend = g_xmdd_m.date_begin
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD date_end
            IF NOT cl_null(g_xmdd_m.date_begin) AND NOT cl_null(g_xmdd_m.date_end) THEN
               IF g_xmdd_m.date_begin > g_xmdd_m.date_end THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00202'
                  LET g_errparam.extend = g_xmdd_m.date_end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  NEXT FIELD CURRENT
               END IF
            END IF
                        
         ON ACTION controlp INFIELD xmdd001
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdd_m.xmdd001             #給予default值
            #給予arg
            CALL q_imaf001_6()                               #呼叫開窗
            LET g_xmdd_m.xmdd001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdd_m.xmdd001 TO xmdd001             #顯示到畫面上
            NEXT FIELD xmdd001                          #返回原欄位 

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            IF cl_null(g_xmdd_m.xmdd001) THEN
               NEXT FIELD xmdd001
            END IF
                         
            CALL asft300_01_b_fill()
            IF g_x = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00203'
               LET g_errparam.extend = g_xmdd_m.xmdd001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD xmdd001
            ELSE
               LET l_flag = 'N'
            END IF 
      END INPUT
   
      #輸入開始
      INPUT ARRAY g_xmdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_xmdd_d.getLength(),MAXCOUNT = g_xmdd_d.getLength(),WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
                  
          BEFORE ROW 
             LET l_flag = 'Y'
             LET l_ac = ARR_CURR()
             
          ON CHANGE select
             IF g_xmdd_d[l_ac].select = 'Y' THEN
                LET g_xmdd_m.sum = g_xmdd_m.sum + g_xmdd_d[l_ac].qty3
             END IF
             IF g_xmdd_d[l_ac].select = 'N' THEN
                LET g_xmdd_m.sum = g_xmdd_m.sum - g_xmdd_d[l_ac].qty3
             END IF
             DISPLAY BY NAME g_xmdd_m.sum
             
      END INPUT
      
      AFTER DIALOG
         #输入完单头后点确定后强制进入单身
         IF l_flag = 'N' AND INT_FLAG = FALSE THEN
            NEXT FIELD select
         END IF 
         
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
           LET INT_FLAG = TRUE
           EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG
   END DIALOG

   IF INT_FLAG THEN
      LET INT_FLAG = TRUE
      IF cl_null(g_sfaa.sfaa010) THEN
         IF NOT s_aooi200_del_docno(g_sfaa.sfaadocno,g_sfaa.sfaadocdt) THEN
         END IF
      END IF
      
      EXIT WHILE
   END IF
   
   LET l_flag1 = 'N'
   FOR l_i = 1 TO g_x
      IF g_xmdd_d[l_i].select = 'N' THEN
         CONTINUE FOR
      END IF
      LET l_flag1 = 'Y'
      LET l_sfab.sfabent=g_enterprise
      LET l_sfab.sfabsite=g_site
      LET l_sfab.sfabdocno=g_sfaa.sfaadocno
      LET l_sfab.sfab001='2'
      LET l_sfab.sfab002=g_xmdd_d[l_i].xmdddocno
      LET l_sfab.sfab003=g_xmdd_d[l_i].xmddseq
      LET l_sfab.sfab004=g_xmdd_d[l_i].xmddseq1
      LET l_sfab.sfab005=g_xmdd_d[l_i].xmddseq2
      LET l_sfab.sfab007=g_xmdd_d[l_i].qty3
      SELECT MAX(sfabseq)+1 INTO l_sfab.sfabseq FROM sfab_t
       WHERE sfabent = g_enterprise AND sfabsite = g_site
         AND sfabdocno = l_sfab.sfabdocno
      IF cl_null(l_sfab.sfabseq) THEN
         LET l_sfab.sfabseq = 1
      END IF     
      SELECT MAX(sfab006) INTO l_sfab.sfab006 FROM sfab_t WHERE sfabent=g_enterprise AND sfabsite = g_site
         AND sfabdocno = g_sfaa.sfaadocno
      IF cl_null(l_sfab.sfab006) THEN
         LET l_sfab.sfab006 = 10
      ELSE
         LET l_sfab.sfab006 = l_sfab.sfab006 + 10
      END IF
      
      #161109-00085#28-s
      #INSERT INTO sfab_t VALUES(l_sfab.*)
      #161109-00085#65 --s mark
      #INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfab001,sfab002,sfab003,sfab004,sfab005,sfab006,sfab007,sfabseq) 
      #VALUES(l_sfab.sfabent,l_sfab.sfabsite,l_sfab.sfabdocno,l_sfab.sfab001,l_sfab.sfab002,
      #       l_sfab.sfab003,l_sfab.sfab004,l_sfab.sfab005,l_sfab.sfab006,l_sfab.sfab007,
      #       l_sfab.sfabseq)
      #161109-00085#65 --e mark
      #161109-00085#28-e
      #161109-00085#65 --s add
      INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfab001,sfab002,
                         sfab003,sfab004,sfab005,sfab006,sfab007,
                         sfabseq,sfabud001,sfabud002,sfabud003,sfabud004,
                         sfabud005,sfabud006,sfabud007,sfabud008,sfabud009,
                         sfabud010,sfabud011,sfabud012,sfabud013,sfabud014,
                         sfabud015,sfabud016,sfabud017,sfabud018,sfabud019,
                         sfabud020,sfabud021,sfabud022,sfabud023,sfabud024,
                         sfabud025,sfabud026,sfabud027,sfabud028,sfabud029,
                         sfabud030)
      VALUES(l_sfab.sfabent,l_sfab.sfabsite,l_sfab.sfabdocno,l_sfab.sfab001,l_sfab.sfab002,
             l_sfab.sfab003,l_sfab.sfab004,l_sfab.sfab005,l_sfab.sfab006,l_sfab.sfab007,
             l_sfab.sfabseq,l_sfab.sfabud001,l_sfab.sfabud002,l_sfab.sfabud003,l_sfab.sfabud004,
             l_sfab.sfabud005,l_sfab.sfabud006,l_sfab.sfabud007,l_sfab.sfabud008,l_sfab.sfabud009,
             l_sfab.sfabud010,l_sfab.sfabud011,l_sfab.sfabud012,l_sfab.sfabud013,l_sfab.sfabud014,
             l_sfab.sfabud015,l_sfab.sfabud016,l_sfab.sfabud017,l_sfab.sfabud018,l_sfab.sfabud019,
             l_sfab.sfabud020,l_sfab.sfabud021,l_sfab.sfabud022,l_sfab.sfabud023,l_sfab.sfabud024,
             l_sfab.sfabud025,l_sfab.sfabud026,l_sfab.sfabud027,l_sfab.sfabud028,l_sfab.sfabud029,
             l_sfab.sfabud030)
      #161109-00085#65 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfab_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CONTINUE FOR
      END IF
   END FOR 
   
   IF l_flag1 = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00338'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CONTINUE WHILE
   END IF
   
   #回写工单单头资料
   SELECT sum(sfab007) INTO g_sfaa.sfaa012 FROM sfab_t WHERE sfabent=g_enterprise AND sfabsite=g_site AND sfabdocno=g_sfaa.sfaadocno
   LET g_sfaa.sfaa010 = g_xmdd_m.xmdd001
   #160214-00005#3-mod-(S)
#   SELECT imae037 INTO g_sfaa.sfaa011 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_sfaa.sfaa010
   LET g_sfaa.sfaa011 = g_xmdd_m.xmdd040
   #160214-00005#3-mod-(E)
   IF cl_null(g_sfaa.sfaa011) THEN
      LET g_sfaa.sfaa011 = ' '
   END IF
   
   LET g_sfaa.sfaa013 = g_xmdd_m.imae016
   #170103-00023#1-s-mod
#   SELECT imaf015 INTO g_sfaa.sfaa060 FROM imaf_t
#    WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_sfaa.sfaa010
    
   SELECT imaf015,imaf034 INTO g_sfaa.sfaa060,g_sfaa.sfaa072
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = g_sfaa.sfaa010
   
   IF cl_null(g_sfaa.sfaa072) THEN
      LET g_sfaa.sfaa072 = 'N'
   END IF
   #170103-00023#1-e-mod
   IF NOT cl_null(g_sfaa.sfaa060) THEN
     #CALL s_aimi190_get_convert(g_sfaa.sfaa010,g_sfaa.sfaa013,g_sfaa.sfaa060) RETURNING l_success,l_rate
     #IF l_success THEN
     #   LET g_sfaa.sfaa058 = g_sfaa.sfaa012 * l_rate
     #ELSE
     #   LET g_sfaa.sfaa058 = g_sfaa.sfaa012
     #END IF
      CALL s_aooi250_convert_qty(g_sfaa.sfaa010,g_sfaa.sfaa013,g_sfaa.sfaa060,g_sfaa.sfaa012)
           RETURNING l_success,g_sfaa.sfaa058
      IF NOT l_success THEN
         LET g_sfaa.sfaa058 = g_sfaa.sfaa012
      END IF
   END IF
   IF NOT cl_null(g_sfaa.sfaa020) THEN
      CALL s_asft300_06('2',g_sfaa.sfaa010,g_sfaa.sfaa012,g_sfaa.sfaa020) RETURNING l_success,g_sfaa.sfaa019
      IF g_sfaa.sfaa019 < g_sfaa.sfaadocdt THEN   
         LET l_days = g_sfaa.sfaadocdt - g_sfaa.sfaa019
         LET g_sfaa.sfaa019 = g_sfaa.sfaadocdt
         #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
         SELECT ooef008 INTO l_ooef008 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=g_site
         CALL s_date_get_work_date(g_site,l_ooef008,'2',g_sfaa.sfaa020,0,l_days) RETURNING g_sfaa.sfaa020 
      END IF         
   ELSE
      IF NOT cl_null(g_sfaa.sfaa019) THEN
         CALL s_asft300_06('1',g_sfaa.sfaa010,g_sfaa.sfaa012,g_sfaa.sfaa019) RETURNING l_success,g_sfaa.sfaa020
      END IF
   END IF
   #161109-00085#28-s
   #UPDATE sfaa_t SET sfaa_t.* = g_sfaa.*
   #161109-00085#65 --s mark
   #UPDATE sfaa_t SET (sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,
   #                   sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,sfaa005,
   #                   sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,sfaa015,
   #                   sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,sfaa025, 
   #                   sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,
   #                   sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045, 
   #                   sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,sfaa055,
   #                   sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,sfaa065, 
   #                   sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaa071,sfaa072)
   #                = (g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,g_sfaa.sfaacrtdt,
   #                   g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,g_sfaa.sfaapstid,
   #                   g_sfaa.sfaapstdt,g_sfaa.sfaastus,g_sfaa.sfaasite,g_sfaa.sfaadocno,g_sfaa.sfaadocdt,
   #                   g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,g_sfaa.sfaa005,
   #                   g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,g_sfaa.sfaa010, 
   #                   g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,g_sfaa.sfaa015,
   #                   g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,g_sfaa.sfaa020, 
   #                   g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,g_sfaa.sfaa025, 
   #                   g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,g_sfaa.sfaa030,
   #                   g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,g_sfaa.sfaa035,
   #                   g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,g_sfaa.sfaa040, 
   #                   g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,g_sfaa.sfaa045, 
   #                   g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,g_sfaa.sfaa050, 
   #                   g_sfaa.sfaa051,g_sfaa.sfaa052,g_sfaa.sfaa053,g_sfaa.sfaa054,g_sfaa.sfaa055,
   #                   g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,g_sfaa.sfaa059,g_sfaa.sfaa060,
   #                   g_sfaa.sfaa061,g_sfaa.sfaa062,g_sfaa.sfaa063,g_sfaa.sfaa064,g_sfaa.sfaa065, 
   #                   g_sfaa.sfaa066,g_sfaa.sfaa067,g_sfaa.sfaa068,g_sfaa.sfaa069,g_sfaa.sfaa070, 
   #                   g_sfaa.sfaa071,g_sfaa.sfaa072) 
   #161109-00085#65 --e mark
   #161109-00085#28-e      
   #161109-00085#65 --s add
   UPDATE sfaa_t SET (sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,
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
                      sfaaud030,sfaa071,sfaa072)
                    =(g_sfaa.sfaaent,g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,
                      g_sfaa.sfaacrtdt,g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,
                      g_sfaa.sfaapstid,g_sfaa.sfaapstdt,g_sfaa.sfaastus,g_sfaa.sfaasite,g_sfaa.sfaadocno,
                      g_sfaa.sfaadocdt,g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,
                      g_sfaa.sfaa005,g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,
                      g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,
                      g_sfaa.sfaa015,g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,
                      g_sfaa.sfaa020,g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,
                      g_sfaa.sfaa025,g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,
                      g_sfaa.sfaa030,g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,
                      g_sfaa.sfaa035,g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,
                      g_sfaa.sfaa040,g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,
                      g_sfaa.sfaa045,g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,
                      g_sfaa.sfaa050,g_sfaa.sfaa051,g_sfaa.sfaa052,g_sfaa.sfaa053,g_sfaa.sfaa054,
                      g_sfaa.sfaa055,g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,g_sfaa.sfaa059,
                      g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa062,g_sfaa.sfaa063,g_sfaa.sfaa064,
                      g_sfaa.sfaa065,g_sfaa.sfaa066,g_sfaa.sfaa067,g_sfaa.sfaa068,g_sfaa.sfaa069,
                      g_sfaa.sfaa070,g_sfaa.sfaaud001,g_sfaa.sfaaud002,g_sfaa.sfaaud003,g_sfaa.sfaaud004,
                      g_sfaa.sfaaud005,g_sfaa.sfaaud006,g_sfaa.sfaaud007,g_sfaa.sfaaud008,g_sfaa.sfaaud009,
                      g_sfaa.sfaaud010,g_sfaa.sfaaud011,g_sfaa.sfaaud012,g_sfaa.sfaaud013,g_sfaa.sfaaud014,
                      g_sfaa.sfaaud015,g_sfaa.sfaaud016,g_sfaa.sfaaud017,g_sfaa.sfaaud018,g_sfaa.sfaaud019,
                      g_sfaa.sfaaud020,g_sfaa.sfaaud021,g_sfaa.sfaaud022,g_sfaa.sfaaud023,g_sfaa.sfaaud024,
                      g_sfaa.sfaaud025,g_sfaa.sfaaud026,g_sfaa.sfaaud027,g_sfaa.sfaaud028,g_sfaa.sfaaud029,
                      g_sfaa.sfaaud030,g_sfaa.sfaa071,g_sfaa.sfaa072)
   #161109-00085#65 --e add
   WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = g_sfaa.sfaadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd sfaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      EXIT WHILE
   END IF
      
   EXIT WHILE
   END WHILE
   CLOSE WINDOW w_asft300_01
END FUNCTION
#chk料号
PRIVATE FUNCTION asft300_01_xmdd001()
DEFINE l_sql                STRING
DEFINE l_n                  LIKE type_t.num5
DEFINE l_imaa010            LIKE imaa_t.imaa010
DEFINE l_imae036            LIKE imae_t.imae036
DEFINE l_oocq005            LIKE oocq_t.oocq005
DEFINE l_oocq006            LIKE oocq_t.oocq006
DEFINE r_success            LIKE type_t.num5
DEFINE l_success            LIKE type_t.num5
DEFINE l_flag               LIKE type_t.num5

   LET r_success = TRUE
   
   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_xmdd_m.xmdd001
   #呼叫檢查存在並帶值的library
   IF cl_chk_exist("v_imaa001") THEN
      IF NOT cl_chk_exist("v_imaf001_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160214-00005#3-add-(S)
   IF NOT cl_null(g_xmdd_m.xmdd040) THEN
     INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdd_m.xmdd001
      LET g_chkparam.arg2 = g_xmdd_m.xmdd040
      #160318-00025#3--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "aim-00127:sub-01302|abmm200|",cl_get_progname("abmm200",g_lang,"2"),"|:EXEPROGabmm200"
      #160318-00025#3--add--end
      IF NOT cl_chk_exist("v_bmaa002") THEN
         LET g_xmdd_m.xmdd040 = ''
         DISPLAY BY NAME g_xmdd_m.xmdd040
      END IF
   END IF
   #160214-00005#3-add-(E)          
   #判斷輸入的料件編號是否在控制組限制的產品範圍內，若不在限制內則不允許請購此料
   CALL s_control_chk_group('3','6',g_user,g_dept,g_xmdd_m.xmdd001,'','','','') RETURNING l_success,l_flag
   IF NOT l_success THEN      #处理状态
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF NOT l_flag THEN      #是否存在
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00324'
         LET g_errparam.extend = g_xmdd_m.xmdd001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
   CALL s_control_chk_doc('4',g_sfaa.sfaadocno,g_xmdd_m.xmdd001,'','','','') RETURNING l_success,l_flag
   IF NOT l_success THEN      #处理状态
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF NOT l_flag THEN      #是否存在
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
   CALL s_control_chk_doc('5',g_sfaa.sfaadocno,g_xmdd_m.xmdd001,'','','','') RETURNING l_success,l_flag
   IF NOT l_success THEN      #处理状态
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF NOT l_flag THEN      #是否存在
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
      
   
   IF g_sfaa.sfaa003 MATCHES '[145]' THEN
      LET l_sql = "SELECT COUNT(bmaa001) FROM bmaa_t WHERE bmaaent=",g_enterprise," AND bmaasite='",g_site,"'",
                  "   AND bmaa001='", g_xmdd_m.xmdd001,"' AND bmaastus='Y'"
      IF NOT cl_null(g_sfaa.sfaa011) THEN
         LET l_sql = l_sql," AND bmaa002='",g_sfaa.sfaa011,"'"
      END IF
      PREPARE sel_bmaa_pre FROM l_sql
      EXECUTE sel_bmaa_pre INTO l_n
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00045'
         LET g_errparam.extend = g_xmdd_m.xmdd001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   SELECT imaa010 INTO l_imaa010 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_xmdd_m.xmdd001
   IF NOT cl_null(l_imaa010) THEN
      SELECT oocq005,oocq006 INTO l_oocq005,l_oocq006 FROM oocq_t WHERE oocqent = g_enterprise 
         AND oocq001 = '210' AND oocq002 = l_imaa010 AND oocqstus = 'Y'
      IF g_sfaa.sfaa003 = '4' THEN
         IF l_oocq005 != 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00052'
            LET g_errparam.extend = g_xmdd_m.xmdd001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      ELSE
         IF l_oocq006 != 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00053'
            LET g_errparam.extend = g_xmdd_m.xmdd001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF 
   END IF 
   
   SELECT imae036 INTO l_imae036 FROM imae_t WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_xmdd_m.xmdd001
   IF cl_null(l_imae036) OR l_imae036 = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00330'
      LET g_errparam.extend = g_xmdd_m.xmdd001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
#根据单头下的条件抓出资料并于单身显示
PRIVATE FUNCTION asft300_01_b_fill()
DEFINE l_sql                        STRING
DEFINE l_sql_1                      STRING
DEFINE l_xmdd014                    LIKE xmdd_t.xmdd014
DEFINE l_xmdd031                    LIKE xmdd_t.xmdd031
DEFINE l_success                    LIKE type_t.num5
DEFINE l_rate                       LIKE type_t.num26_10 
DEFINE l_imae015                    LIKE imae_t.imae015
DEFINE l_xmdddocno                  LIKE xmdd_t.xmdddocno
DEFINE l_xmddseq                    LIKE xmdd_t.xmddseq
DEFINE l_xmddseq1                   LIKE xmdd_t.xmddseq1
DEFINE l_xmddseq2                   LIKE xmdd_t.xmddseq2
DEFINE l_xmda008                    LIKE xmda_t.xmda008
DEFINE l_num                        LIKE sfaa_t.sfaa012
DEFINE l_num1                       LIKE sfaa_t.sfaa012
DEFINE l_where                      STRING #150909 earl add
#161219-00070#2-add-s
DEFINE l_sql_2      STRING
DEFINE l_count      LIKE type_t.num5
DEFINE l_xmdadocno  LIKE xmda_t.xmdadocno
DEFINE l_xmda005    LIKE xmda_t.xmda005
DEFINE l_xmda007    LIKE xmda_t.xmda007
#161219-00070#2-add-e

  LET l_sql = "SELECT 'N',xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd006,xmdd004,'','','','','','',xmda004,'',xmda003,'',xmda002,'',xmdd011 FROM xmda_t,xmdd_t",
              " WHERE xmdaent=xmddent AND xmdasite=xmddsite AND xmdadocno=xmdddocno AND xmddent=",g_enterprise," AND xmddsite='",g_site,"'",
              #161128-00045#1-s-mod
#              "   AND xmdd001='",g_xmdd_m.xmdd001,"' AND xmdastus='Y'"
              "   AND xmdd001='",g_xmdd_m.xmdd001,"' AND xmdastus IN ('Y','H') "
              #161128-00045#1-e-mod
  IF NOT cl_null(g_xmdd_m.date_begin) THEN
     LET l_sql = l_sql," AND xmdd011>='",g_xmdd_m.date_begin,"'"
  END IF
  IF NOT cl_null(g_xmdd_m.date_end) THEN
     LET l_sql = l_sql," AND xmdd011<='",g_xmdd_m.date_end,"'"
  END IF
  #160214-00005#3-add-(S)
  IF cl_null(g_xmdd_m.xmdd040) THEN
     LET l_sql = l_sql CLIPPED," AND xmdd040 = ' ' "
  ELSE
     LET l_sql = l_sql CLIPPED," AND xmdd040 = '",g_xmdd_m.xmdd040,"'"
  END IF
  #160214-00005#3-add-(E)
  
  
  #150909 earl mod s
  #組合過濾前後置單據資料SQL
  CALL s_aooi210_get_check_sql(g_site,'',g_sfaa.sfaadocno,'4','','xmdddocno') RETURNING l_success,l_where
  IF l_success THEN
     LET l_sql = l_sql," AND ",l_where
  ELSE
     LET l_sql = l_sql," AND 1=2 "
  END IF
  #150909 earl mod e
  
  PREPARE asft300_01_pre FROM l_sql
  DECLARE asft300_01_cs CURSOR FOR asft300_01_pre
  LET l_ac = 1
  FOREACH asft300_01_cs INTO g_xmdd_d[l_ac].*
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        EXIT FOREACH
     END IF
     
     #161219-00070#2-add-s
      SELECT xmda005,xmda007,xmda008 INTO l_xmda005,l_xmda007,l_xmda008
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_xmdd_d[l_ac].xmdddocno
      
      LET l_sql_2 = " SELECT xmdadocno ",
                   "   FROM xmda_t ",
                   "  WHERE xmdaent = ",g_enterprise,
                   #161128-00045#1-s-mod
#                   "    AND xmdastus = 'Y' ",
                   "    AND xmdastus IN ('Y','H') ",
                   #161128-00045#1-e-mod
                   "    AND xmda007 = '2' ",
                   "    AND xmda008 = ? "
      PREPARE t300_01_chk_xmda_p FROM l_sql_2
      DECLARE t300_01_chk_xmda_c CURSOR FOR t300_01_chk_xmda_p
      
      LET l_sql_2 = " SELECT COUNT(1) ",
                   "   FROM sfaa_t ",
                   "  WHERE sfaaent = ",g_enterprise,
                   "    AND sfaa005 = '2' ",
                   "    AND sfaa006 = ? "
      PREPARE t300_01_chk_sfaa_p FROM l_sql_2
      LET l_sql_2 = " SELECT COUNT(1) ",
                   "   FROM sfaa_t,sfab_t ",
                   "  WHERE sfaaent = sfabent ",
                   "    AND sfaadocno = sfabdocno ",
                   "    AND sfabent = ",g_enterprise,                     
                   "    AND sfab001 = '2' ",
                   "    AND sfab002 = ? "
      PREPARE t300_01_chk_sfab_p FROM l_sql_2
      IF l_xmda005 = '5' THEN   #若訂單性質為預先訂單，需檢查該預先訂單對應的訂單是否有轉工單
         LET l_xmdadocno = ''           
         FOREACH t300_01_chk_xmda_c USING g_xmdd_d[l_ac].xmdddocno INTO l_xmdadocno
            LET l_count = 0
            EXECUTE t300_01_chk_sfaa_p USING l_xmdadocno INTO l_count
            IF l_count = 0 THEN
               EXECUTE t300_01_chk_sfab_p USING l_xmdadocno INTO l_count                 
            END IF
            IF l_count > 0 THEN
               CONTINUE FOREACH
            END IF
         END FOREACH
      ELSE
         IF l_xmda007 = '2' THEN
            LET l_count = 0
            EXECUTE t300_01_chk_sfaa_p USING l_xmda008 INTO l_count
            IF l_count = 0 THEN
               EXECUTE t300_01_chk_sfab_p USING l_xmda008 INTO l_count                 
            END IF
            IF l_count > 0 THEN
               CONTINUE FOREACH
            END IF
         END IF
      END IF
      #161219-00070#2-add-e
     
     SELECT xmdd031,xmdd014 INTO l_xmdd031,l_xmdd014 FROM xmdd_t WHERE xmddent=g_enterprise AND xmddsite=g_site 
        AND xmdddocno=g_xmdd_d[l_ac].xmdddocno AND xmddseq=g_xmdd_d[l_ac].xmddseq
        AND xmddseq1=g_xmdd_d[l_ac].xmddseq1 AND xmddseq2=g_xmdd_d[l_ac].xmddseq2
     IF l_xmdd031 > l_xmdd014 THEN
        LET l_xmdd014 = l_xmdd031
     END IF
     IF g_xmdd_d[l_ac].xmdd006 <=l_xmdd014 THEN
        CONTINUE FOREACH
     END IF
     
     LET g_xmdd_d[l_ac].unit = g_xmdd_m.imae016
    #CALL s_aimi190_get_convert(g_xmdd_m.xmdd001,g_xmdd_d[l_ac].xmdd004,g_xmdd_m.imae016) RETURNING l_success,l_rate
    #IF l_success THEN
    #   LET g_xmdd_d[l_ac].qty1 = g_xmdd_d[l_ac].xmdd006 * l_rate
    #ELSE
    #   LET g_xmdd_d[l_ac].qty1 = g_xmdd_d[l_ac].xmdd006
    #END IF        
     CALL s_aooi250_convert_qty(g_xmdd_m.xmdd001,g_xmdd_d[l_ac].xmdd004,g_xmdd_m.imae016,g_xmdd_d[l_ac].xmdd006)
          RETURNING l_success,g_xmdd_d[l_ac].qty1
     IF NOT l_success THEN
        LET g_xmdd_d[l_ac].qty1 = g_xmdd_d[l_ac].xmdd006
     END IF
     CALL asft300_01_qty2(g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].unit) RETURNING g_xmdd_d[l_ac].qty2
     
     #找预先订单对应已开工单量
     SELECT xmda008 INTO l_xmda008 FROM xmda_t WHERE xmdaent=g_enterprise AND xmdasite=g_site 
        AND xmdadocno=g_xmdd_d[l_ac].xmdddocno AND xmda007='2'
     IF NOT cl_null(l_xmda008) THEN
        LET l_sql_1 = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 FROM xmdd_t,xmda_t WHERE xmdaent=xmddent AND xmdasite=xmddsite AND xmdadocno=xmdddocno",
                      "   AND xmddent=",g_enterprise," AND xmddsite='",g_site,"' AND xmdadocno='",l_xmda008,"'",
                      #161128-00045#1-s-mod
#                      "   AND xmdd001='",g_xmdd_m.xmdd001,"' AND xmdastus='Y'"
                      "   AND xmdd001='",g_xmdd_m.xmdd001,"' AND xmdastus IN ('Y','H') "
                      #161128-00045#1-e-mod
        PREPARE asft300_01_pre_1 FROM l_sql_1
        DECLARE asft300_01_cs_1 CURSOR FOR asft300_01_pre_1
        LET l_num = 0
        FOREACH asft300_01_cs_1 INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

              EXIT FOREACH
           END IF
           CALL asft300_01_qty2(l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2,g_xmdd_d[l_ac].unit) RETURNING l_num1
           LET l_num = l_num + l_num1
        END FOREACH
        LET g_xmdd_d[l_ac].qty2 = g_xmdd_d[l_ac].qty2 + l_num 
     END IF
     
     #生产超交率
     SELECT imae015 INTO l_imae015 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_xmdd_m.xmdd001
     IF cl_null(l_imae015) THEN
        LET l_imae015 = 0 
     END IF
     LET g_xmdd_d[l_ac].qty3 = (g_xmdd_d[l_ac].qty1 - g_xmdd_d[l_ac].qty2)  * (1 + l_imae015 / 100)
     IF g_xmdd_d[l_ac].qty3 <= 0 THEN 
        CONTINUE FOREACH
     END IF
     
     CALL asft300_01_desc('Y')    
     LET l_ac = l_ac + 1
  END FOREACH
  
  CALL g_xmdd_d.deleteElement(l_ac)
  LET g_x = l_ac - 1

END FUNCTION
#已开工单量汇总
PRIVATE FUNCTION asft300_01_qty2(p_sfab002,p_sfab003,p_sfab004,p_sfab005,p_unit)
DEFINE p_sfab002         LIKE sfab_t.sfab002
DEFINE p_sfab003         LIKE sfab_t.sfab003
DEFINE p_sfab004         LIKE sfab_t.sfab004
DEFINE p_sfab005         LIKE sfab_t.sfab005
DEFINE p_unit            LIKE sfaa_t.sfaa013
DEFINE l_sql             STRING
DEFINE l_sum             LIKE sfaa_t.sfaa012
DEFINE l_sfab007         LIKE sfab_t.sfab007
DEFINE l_sfaa013         LIKE sfaa_t.sfaa013
DEFINE l_success         LIKE type_t.num5
DEFINE l_rate            LIKE type_t.num26_10

  LET l_sql = "SELECT sfaa013,sfab007 FROM sfaa_t,sfab_t WHERE sfaaent=sfabent AND sfaadocno=sfabdocno",
              "   AND sfaaent=",g_enterprise," AND sfaasite='",g_site,"'",
              "   AND sfaa010='",g_xmdd_m.xmdd001,"' AND sfaastus != 'X'",
              "   AND sfab002=? AND sfab003=? AND sfab004=? AND sfab005=?"
  PREPARE asft300_01_qty2_pre FROM l_sql
  DECLARE asft300_01_qty2_cs CURSOR FOR asft300_01_qty2_pre
  LET l_sum = 0
  FOREACH asft300_01_qty2_cs USING p_sfab002,p_sfab003,p_sfab004,p_sfab005 INTO l_sfaa013,l_sfab007
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        EXIT FOREACH
     END IF    
    #CALL s_aimi190_get_convert(g_xmdd_m.xmdd001,l_sfaa013,g_xmdd_m.imae016) RETURNING l_success,l_rate
    #IF l_success THEN
    #   LET l_sfab007 = l_sfab007 * l_rate
    #END IF
     CALL s_aooi250_convert_qty(g_xmdd_m.xmdd001,l_sfaa013,g_xmdd_m.imae016,l_sfab007)
          RETURNING l_success,l_sfab007
     LET l_sum = l_sum + l_sfab007
  END FOREACH     
     
  RETURN l_sum   

END FUNCTION

 
{</section>}
 
