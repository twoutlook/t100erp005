#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp520_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2016-02-25 18:08:21), PR版次:0023(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: axmp520_02
#+ Description: 出貨調整
#+ Creator....: 02040(2015-06-05 10:15:54)
#+ Modifier...: 06815 -SD/PR- 00000
 
{</section>}
 
{<section id="axmp520_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00005#48  2016/3/31   pengxin      修正azzi902重复定义之错误讯息 
#160309-00005#1   2016/04/27  By ming      修正欄位entry的錯誤 
#160805-00054#1   2016/08/11  By 02097     不需要检验的出通单，抛转的资料检验合格量为0
#160727-00019#23  2016/08/15  By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                           Mod   p520_02_xmdg_temp--> p520_tmp01  ,  p520_02_xmdh_temp--> p520_tmp02
#                                           Mod   p520_02_xmdi_temp--> p520_tmp03
#160706-00037#12  2016/10/24  By shiun     檢查來源單據的狀態碼(例如可拋轉的單據狀態碼應該是Y.已確認)，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
#161101-00013#1   2016/11/01  By fionchen  產生出通單時,申請出通量應與調整後的出通量相同,不應帶訂單出通量
#161103-00046#1   2016/11/07  By 06948     產生出通單時，應依據參數D-BAS-0094判斷合格量
#161109-00085#10  2016/11/10  By lienjunqi 整批調整系統星號寫法
#161207-00057#1   2016/12/08  By ouhz      调整限定批号有值，仓库开窗只显示限定批号库存信息,拿掉AFTER FIELD xmdh014是否存在库存档中的检查
#170104-00066#2   2017/01/06  By Rainy     筆數相關變數由num5放大至num10
#170106-00046#1   2017/01/09  By shiun     在INSERT INTO xmdg_t多增加寫入xmdg056的欄位
#170111-00026#4   2017/01/11  By 08993     修改產生的單號和單據日期不一致
#161006-00018#24  2017/01/16  By 02040     增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
#161124-00047#1   2017/01/18  By lixh      根据xmdg001单据性质串查不同类型的出通单
#161230-00019#4   2017/02/06  By shiun     引導式作業一次性交易對象處理，需加上對象識別碼為匯總條件，一次性交易對象不同識別碼者需拆單
#161205-00025#14  2017/02/09  By shiun     效能調整
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../axm/4gl/axmp520_01.inc"
GLOBALS "../../axm/4gl/axmp520_02.inc"
#end add-point
 
{</section>}
 
{<section id="axmp520_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_xmdg_d        RECORD
   linkno       LIKE type_t.num10,         
   xmdgdocno    LIKE xmdg_t.xmdgdocno,
   xmdg005      LIKE xmdg_t.xmdg005,
   xmdg005_desc LIKE type_t.chr500,
   xmdg008      LIKE xmdg_t.xmdg008, 
   xmdg008_desc LIKE type_t.chr500, 
   xmdg009      LIKE xmdg_t.xmdg009, 
   xmdg009_desc LIKE type_t.chr500, 
   xmdg010      LIKE xmdg_t.xmdg010, 
   xmdg010_desc LIKE type_t.chr500, 
   xmdg011      LIKE xmdg_t.xmdg011, 
   xmdg012      LIKE xmdg_t.xmdg012, 
   xmdg013      LIKE xmdg_t.xmdg013, 
   xmdg013_desc LIKE type_t.chr500,
   xmdg014      LIKE xmdg_t.xmdg014,
   xmdg014_desc LIKE type_t.chr500,    
   xmdg015      LIKE xmdg_t.xmdg015, 
   xmdg006      LIKE xmdg_t.xmdg006, 
   xmdg006_desc LIKE type_t.chr500,
   xmdg007      LIKE xmdg_t.xmdg007,
   xmdg007_desc LIKE type_t.chr500,
   xmdg017      LIKE xmdg_t.xmdg017,
   result       LIKE type_t.chr500 
       END RECORD
 TYPE type_g_xmdh_d RECORD
   linkno       LIKE type_t.num10, 
   linkseq      LIKE xmdh_t.xmdhseq,
   xmdh001      LIKE xmdh_t.xmdh001,
   xmdh002      LIKE xmdh_t.xmdh002,
   xmdh003      LIKE xmdh_t.xmdh003,
   xmdh004      LIKE xmdh_t.xmdh004,
   xmdh005      LIKE xmdh_t.xmdh005,
   xmdh006      LIKE xmdh_t.xmdh006,
   imaal003     LIKE imaal_t.imaal003,
   imaal004     LIKE imaal_t.imaal004,
   xmdh007      LIKE xmdh_t.xmdh007,
   xmdh007_desc LIKE type_t.chr500,
   xmdh009      LIKE xmdh_t.xmdh009,
   xmdh009_desc LIKE type_t.chr500,
   xmdh010      LIKE xmdh_t.xmdh010,
   xmdh015      LIKE xmdh_t.xmdh015,
   xmdh015_desc LIKE type_t.chr500,
   xmdh016      LIKE xmdh_t.xmdh016,
   xmdh017      LIKE xmdh_t.xmdh017,
   xmdh018      LIKE xmdh_t.xmdh018,
   xmdh018_desc LIKE type_t.chr500,
   xmdh019      LIKE xmdh_t.xmdh019,
   xmdh011      LIKE xmdh_t.xmdh011,
   xmdh012      LIKE xmdh_t.xmdh012,
   xmdh012_desc LIKE type_t.chr500,
   xmdh013      LIKE xmdh_t.xmdh013,
   xmdh013_desc LIKE type_t.chr500,
   xmdh014      LIKE xmdh_t.xmdh014,
   xmdh029      LIKE xmdh_t.xmdh029,
   xmdh020      LIKE xmdh_t.xmdh020,
   xmdh020_desc LIKE type_t.chr500,
   xmdh021      LIKE xmdh_t.xmdh021,
   xmdh022      LIKE xmdh_t.xmdh022
       END RECORD   
 TYPE type_g_xmdi_d RECORD
   xmdiseq      LIKE xmdi_t.xmdiseq,
   xmdiseq1     LIKE xmdi_t.xmdiseq1,
   xmdi001      LIKE xmdi_t.xmdi001,
   imaal003_3   LIKE imaal_t.imaal003,
   imaal004_3   LIKE imaal_t.imaal004,
   xmdi002      LIKE xmdi_t.xmdi002,
   xmdi002_desc LIKE type_t.chr500,
   xmdi003      LIKE xmdi_t.xmdi003,
   xmdi003_desc LIKE type_t.chr500,
   xmdi004      LIKE xmdi_t.xmdi004,
   xmdi005      LIKE xmdi_t.xmdi005,
   xmdi005_desc LIKE type_t.chr500,
   xmdi006      LIKE xmdi_t.xmdi006,
   xmdi006_desc LIKE type_t.chr500,
   xmdi007      LIKE xmdi_t.xmdi007,
   xmdi013      LIKE xmdi_t.xmdi013,
   xmdi008      LIKE xmdi_t.xmdi008,
   xmdi008_desc LIKE type_t.chr500,   
   xmdi009      LIKE xmdi_t.xmdi009,
   xmdi010      LIKE xmdi_t.xmdi010,
   xmdi010_desc LIKE type_t.chr500,
   xmdi011      LIKE xmdi_t.xmdi011
       END RECORD         
 TYPE type_g_xmdc_d RECORD
   xmdcseq      LIKE xmdc_t.xmdcseq,
   xmdc019      LIKE xmdc_t.xmdc019,
   xmdc001      LIKE xmdc_t.xmdc001,
   imaal003_1   LIKE imaal_t.imaal003,
   imaal004_1   LIKE imaal_t.imaal004,   
   xmdc002      LIKE xmdc_t.xmdc002,
   xmdc002_desc LIKE type_t.chr500,
   xmdc004      LIKE xmdc_t.xmdc004,
   xmdc004_desc LIKE type_t.chr500,
   xmdc005      LIKE xmdc_t.xmdc005,
   xmdc006      LIKE xmdc_t.xmdc006,
   xmdc006_desc LIKE type_t.chr500,
   xmdc007      LIKE xmdc_t.xmdc007,
   xmdc010      LIKE xmdc_t.xmdc010,
   xmdc010_desc LIKE type_t.chr500,
   xmdc011      LIKE xmdc_t.xmdc011,   
   xmdc015      LIKE xmdc_t.xmdc015,
   xmdc016      LIKE xmdc_t.xmdc016,
   xmdc016_desc LIKE type_t.chr500,   
   xmdc017      LIKE xmdc_t.xmdc017,
   xmdc046      LIKE xmdc_t.xmdc046,
   xmdc047      LIKE xmdc_t.xmdc047,
   xmdc048      LIKE xmdc_t.xmdc048,
   xmdc040      LIKE xmdc_t.xmdc040,
   xmdc041      LIKE xmdc_t.xmdc041,
   xmdc042      LIKE xmdc_t.xmdc042,
   xmdc043      LIKE xmdc_t.xmdc043,
   xmdc044      LIKE xmdc_t.xmdc044
       END RECORD         

DEFINE g_xmdg_d    DYNAMIC ARRAY OF type_g_xmdg_d
DEFINE g_xmdh_d   DYNAMIC ARRAY OF type_g_xmdh_d
DEFINE g_xmdh_d_t type_g_xmdh_d
DEFINE g_xmdh_d_o type_g_xmdh_d
DEFINE g_xmdi_d   DYNAMIC ARRAY OF type_g_xmdi_d
DEFINE g_xmdi_d_t type_g_xmdi_d
DEFINE g_xmdc_d   DYNAMIC ARRAY OF type_g_xmdc_d
DEFINE g_result_str LIKE type_t.chr1000        #執行結果
DEFINE g_gather     LIKE type_t.chr1
#mod--161109-00085#10-s
#DEFINE g_xmdg     RECORD LIKE xmdg_t.*
DEFINE g_xmdg RECORD  #出通單單頭檔
       xmdgent LIKE xmdg_t.xmdgent, #企業編號
       xmdgsite LIKE xmdg_t.xmdgsite, #營運據點
       xmdgunit LIKE xmdg_t.xmdgunit, #應用組織
       xmdgdocno LIKE xmdg_t.xmdgdocno, #單據單號
       xmdgdocdt LIKE xmdg_t.xmdgdocdt, #單據日期
       xmdg001 LIKE xmdg_t.xmdg001, #出貨性質
       xmdg002 LIKE xmdg_t.xmdg002, #業務人員
       xmdg003 LIKE xmdg_t.xmdg003, #業務部門
       xmdg004 LIKE xmdg_t.xmdg004, #訂單單號
       xmdg005 LIKE xmdg_t.xmdg005, #訂單客戶
       xmdg006 LIKE xmdg_t.xmdg006, #收款客戶
       xmdg007 LIKE xmdg_t.xmdg007, #收貨客戶
       xmdg008 LIKE xmdg_t.xmdg008, #收款條件
       xmdg009 LIKE xmdg_t.xmdg009, #交易條件
       xmdg010 LIKE xmdg_t.xmdg010, #稅別
       xmdg011 LIKE xmdg_t.xmdg011, #稅率
       xmdg012 LIKE xmdg_t.xmdg012, #單價含稅否
       xmdg013 LIKE xmdg_t.xmdg013, #發票類型
       xmdg014 LIKE xmdg_t.xmdg014, #幣別
       xmdg015 LIKE xmdg_t.xmdg015, #匯率
       xmdg016 LIKE xmdg_t.xmdg016, #送貨供應商
       xmdg017 LIKE xmdg_t.xmdg017, #送貨地址
       xmdg018 LIKE xmdg_t.xmdg018, #運輸方式
       xmdg019 LIKE xmdg_t.xmdg019, #交運起點
       xmdg020 LIKE xmdg_t.xmdg020, #交運終點
       xmdg021 LIKE xmdg_t.xmdg021, #航次/航班/車號
       xmdg022 LIKE xmdg_t.xmdg022, #起運日期
       xmdg023 LIKE xmdg_t.xmdg023, #嘜頭編號
       xmdg024 LIKE xmdg_t.xmdg024, #包裝單製作
       xmdg025 LIKE xmdg_t.xmdg025, #Invoice製作
       xmdg026 LIKE xmdg_t.xmdg026, #銷售通路
       xmdg027 LIKE xmdg_t.xmdg027, #銷售分類
       xmdg028 LIKE xmdg_t.xmdg028, #預計出貨日期
       xmdg030 LIKE xmdg_t.xmdg030, #額外品名規格
       xmdg031 LIKE xmdg_t.xmdg031, #留置原因
       xmdg032 LIKE xmdg_t.xmdg032, #內外銷
       xmdg033 LIKE xmdg_t.xmdg033, #匯率計算基準
       xmdg034 LIKE xmdg_t.xmdg034, #多角性質
       xmdg050 LIKE xmdg_t.xmdg050, #總未稅金額
       xmdg051 LIKE xmdg_t.xmdg051, #總含稅金額
       xmdg052 LIKE xmdg_t.xmdg052, #總稅額
       xmdg053 LIKE xmdg_t.xmdg053, #備註
       xmdg054 LIKE xmdg_t.xmdg054, #多角貿易已拋轉
       xmdg055 LIKE xmdg_t.xmdg055, #多角序號
       xmdg200 LIKE xmdg_t.xmdg200, #調貨經銷商編號
       xmdg201 LIKE xmdg_t.xmdg201, #代送商編號
       xmdg202 LIKE xmdg_t.xmdg202, #發票客戶
       xmdg203 LIKE xmdg_t.xmdg203, #促銷方案編號
       xmdg204 LIKE xmdg_t.xmdg204, #送貨站點編號
       xmdg205 LIKE xmdg_t.xmdg205, #運輸路線編號
       xmdg206 LIKE xmdg_t.xmdg206, #No Use
       xmdg207 LIKE xmdg_t.xmdg207, #No Use
       xmdg208 LIKE xmdg_t.xmdg208, #No Use
       xmdg209 LIKE xmdg_t.xmdg209, #No Use
       xmdgownid LIKE xmdg_t.xmdgownid, #資料所屬者
       xmdgowndp LIKE xmdg_t.xmdgowndp, #資料所有部門
       xmdgcrtid LIKE xmdg_t.xmdgcrtid, #資料建立者
       xmdgcrtdp LIKE xmdg_t.xmdgcrtdp, #資料建立部門
       xmdgcrtdt LIKE xmdg_t.xmdgcrtdt, #資料創建日
       xmdgmodid LIKE xmdg_t.xmdgmodid, #資料修改者
       xmdgmoddt LIKE xmdg_t.xmdgmoddt, #最近修改日
       xmdgcnfid LIKE xmdg_t.xmdgcnfid, #資料確認者
       xmdgcnfdt LIKE xmdg_t.xmdgcnfdt, #資料確認日
       xmdgpstid LIKE xmdg_t.xmdgpstid, #資料過帳者
       xmdgpstdt LIKE xmdg_t.xmdgpstdt, #資料過帳日
       xmdgstus LIKE xmdg_t.xmdgstus, #狀態碼
       xmdg056 LIKE xmdg_t.xmdg056, #多角流程編號
       xmdg057 LIKE xmdg_t.xmdg057, #整合來源
       xmdg058 LIKE xmdg_t.xmdg058  #整合單號
END RECORD
#mod--161109-00085#10-e
DEFINE g_del_xmdi    LIKE type_t.num5      #151118-00029 20160225 s983961--ADD
DEFINE l_ac          LIKE type_t.num10     #151118-00029 20160310 s983961--add  #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE g_xmda028     LIKE xmda_t.xmda028   #161230-00019#4
#end add-point
 
{</section>}
 
{<section id="axmp520_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
 
#end add-point
 
{</section>}
 
{<section id="axmp520_02.other_dialog" >}

DIALOG axmp520_02_display01()

   DISPLAY ARRAY g_xmdg_d TO s_detail1_axmp520_02.* ATTRIBUTE(COUNT=g_detail_02_cnt)
         
      BEFORE DISPLAY
         CALL axmp520_02_fetch()

      BEFORE ROW  
         LET l_ac = DIALOG.getCurrentRow("s_detail1_axmp520_02")   
         LET g_detail_02_idx = l_ac
         CALL axmp520_02_fetch()  
                
       
   END DISPLAY    
END DIALOG

DIALOG axmp520_02_input01()
   INPUT g_gather FROM l_gather ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE l_gather
         #匯總資料時，錯誤訊息先匯總後再顯示
         CALL cl_err_collect_init()         
         CALL axmp520_02()
         CALL axmp520_02_b_fill()
         CALL axmp520_02_fetch()
         
         #匯總資料時，錯誤訊息先匯總後再顯示
         CALL cl_err_collect_show()
   END INPUT
END DIALOG

DIALOG axmp520_02_input02()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_xmdh012   LIKE xmdh_t.xmdh012
   DEFINE l_xmdh013   LIKE xmdh_t.xmdh013
   DEFINE l_xmdh014   LIKE xmdh_t.xmdh014
   DEFINE l_xmdh029   LIKE xmdh_t.xmdh029
   DEFINE l_docno     LIKE xmdl_t.xmdldocno
   DEFINE l_seq       LIKE xmdl_t.xmdlseq
   

   INPUT ARRAY g_xmdh_d FROM s_detail2_axmp520_02.*
         ATTRIBUTE(COUNT = g_detail2_02_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
         
         BEFORE ROW
           #LET l_ac = ARR_CURR()
           LET l_ac = DIALOG.getCurrentRow("s_detail2_axmp520_02")
           LET g_detail2_02_idx = l_ac
           LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*
           LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*           
           CALL axmp520_02_fetch_xmdi()
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()

         AFTER FIELD xmdh017_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh017,"0","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh017_02
           END IF         
           IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 OR g_xmdh_d_o.xmdh017 IS NULL THEN
              IF g_xmdh_d[l_ac].xmdh017 >  g_xmdh_d[l_ac].xmdh016 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "axm-00364"
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 CALL cl_err()              
                 LET g_xmdh_d[l_ac].xmdh017 = g_xmdh_d_o.xmdh017
                #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh017
                 DISPLAY g_xmdh_d[l_ac].xmdh017 TO xmdh017_02
                 NEXT FIELD CURRENT
              END IF
              #對出貨數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh017  
              #若料號有設置使用參考單位時且出貨單位與參考單位有設置換算率時，則應自動推算參考數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019
                 #對參考數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019                 
              END IF
              #若料號有使用銷售計價單位時，則輸入[C:出貨數量]時則應自動推算計價數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021
                 #對計價數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021                                      
                 #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
              END IF  
              ##查看是否已有多庫儲批，如有，則需跳出視窗修改
              #IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 AND g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
              #
              #END IF
           END IF
           LET g_xmdh_d_o.xmdh017 = g_xmdh_d[l_ac].xmdh017
          
        AFTER FIELD xmdh019_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh019,"0.000","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh019_02
           END IF
           #對參考數量進行取位
           CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
             RETURNING l_success,g_xmdh_d[l_ac].xmdh019 

        AFTER FIELD xmdh021_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh021,"0.000","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh019_02
           END IF
           IF g_xmdh_d[l_ac].xmdh021 != g_xmdh_d_o.xmdh021 OR g_xmdh_d_o.xmdh021 IS NULL THEN
              #對計價數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh021 
              #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
           END IF
           
           

        AFTER FIELD xmdh012_02
           LET g_xmdh_d[l_ac].xmdh012_desc = ''
           IF NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN 
              IF g_xmdh_d[l_ac].xmdh012 != g_xmdh_d_o.xmdh012 OR g_xmdh_d_o.xmdh012 IS NULL  THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_site
                 LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                 LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                 LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                 #庫位檢查
                 IF NOT cl_chk_exist("v_inag004_1") THEN               
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
                 #在揀量check
                 #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                 IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                            g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                            g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
              END IF
           END IF 
           CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
           LET g_xmdh_d_o.xmdh012 = g_xmdh_d[l_ac].xmdh012
           LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
           LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()        
        
         AFTER FIELD xmdh013_02
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) 
              RETURNING g_xmdh_d[l_ac].xmdh013_desc
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh013) THEN
               IF g_xmdh_d[l_ac].xmdh013 != g_xmdh_d_o.xmdh013 OR g_xmdh_d_o.xmdh013 IS NULL THEN
                  #儲位檢查
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  IF NOT cl_chk_exist("v_inag005_1") THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) 
                       RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF            
            LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
        
         AFTER FIELD xmdh014_02
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN
               
               IF g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  #批號檢查
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  LET g_chkparam.arg6 = g_xmdh_d[l_ac].xmdh014
                  IF not cl_chk_exist("v_inag006_1") THEN
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                     NEXT FIELD CURRENT
                  END IF
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                     NEXT FIELD CURRENT  
                  END IF                 
               END IF
            END IF
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
        
        ON CHANGE xmdh011_02
           IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
              CALL axmp520_03(g_site,g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq,
                              g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh015,
                              g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002)
                RETURNING l_success,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029 
              IF l_success THEN
                 IF NOT cl_null(l_xmdh012) THEN
                    LET g_xmdh_d[l_ac].xmdh011 = 'N'
                    LET g_xmdh_d[l_ac].xmdh012 = l_xmdh012
                    LET g_xmdh_d[l_ac].xmdh013 = l_xmdh013
                    LET g_xmdh_d[l_ac].xmdh014 = l_xmdh014
                    LET g_xmdh_d[l_ac].xmdh029 = l_xmdh029
                 ELSE
                    LET g_xmdh_d[l_ac].xmdh011 = 'Y'
                    LET g_xmdh_d[l_ac].xmdh012 = ' '
                    LET g_xmdh_d[l_ac].xmdh013 = ' '
                    LET g_xmdh_d[l_ac].xmdh014 = ' '
                    LET g_xmdh_d[l_ac].xmdh029 = ' '
                 END IF
                 CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012)
                   RETURNING g_xmdh_d[l_ac].xmdh012_desc
                 CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013)
                   RETURNING g_xmdh_d[l_ac].xmdh013_desc
              ELSE
                 LET g_xmdh_d[l_ac].xmdh011 = g_xmdh_d_o.xmdh011
                 NEXT FIELD CURRENT
              END IF                
           ELSE 
              IF NOT axmp520_02_delete_xmdi(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq) THEN
                 LET g_xmdh_d[l_ac].xmdh011 = g_xmdh_d_o.xmdh011
                 NEXT FIELD CURRENT
              END IF                  
           END IF
           CALL axmp520_02_fetch_xmdi()
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()               
          
           
        ON ROW CHANGE
           IF INT_FLAG THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 9001
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              LET INT_FLAG = 0
              LET g_xmdh_d[l_ac].* = g_xmdh_d_o.*
              EXIT DIALOG
           ELSE
              UPDATE  p520_tmp02            #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
                 SET  xmdh017 = g_xmdh_d[l_ac].xmdh017,
                      xmdh019 = g_xmdh_d[l_ac].xmdh019,
                      xmdh021 = g_xmdh_d[l_ac].xmdh021,
                      xmdh011 = g_xmdh_d[l_ac].xmdh011,
                      xmdh012 = g_xmdh_d[l_ac].xmdh012,
                      xmdh013 = g_xmdh_d[l_ac].xmdh013,
                      xmdh014 = g_xmdh_d[l_ac].xmdh014 
               WHERE  linkno =  g_xmdh_d_t.linkno
                 AND  linkseq = g_xmdh_d_t.linkseq   
              IF g_xmdh_d[l_ac].xmdh011 = 'N' AND NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN                 
                 CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                             g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
              END IF                            
           END IF

        ON ACTION controlp INFIELD xmdh012_02
   	     INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012  #給予default值
           LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
           LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
           CALL q_inag004_1()                                #呼叫開窗
           LET g_xmdh_d[l_ac].xmdh012 = g_qryparam.return1   #將開窗取得的值回傳到變數
           LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return2 
           LET g_xmdh_d[l_ac].xmdh014 = g_qryparam.return3 
           DISPLAY g_xmdh_d[l_ac].xmdh012 TO xmdh012_02         #顯示到畫面上
           DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013_02
           DISPLAY g_xmdh_d[l_ac].xmdh014 TO xmdh014_02
           CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
           CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
           NEXT FIELD xmdh012_02                                #返回原欄位

        ON ACTION controlp INFIELD xmdh013_02
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh013  #給予default值
            LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
            LET g_qryparam.arg3 = g_xmdh_d[l_ac].xmdh012
            CALL q_inag005_5()                                #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013_02      #顯示到畫面上
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            NEXT FIELD xmdh013_02                             #返回原欄位

   END INPUT      
END DIALOG

DIALOG axmp520_02_display02()
   DISPLAY ARRAY g_xmdi_d TO s_detail3_axmp520_02.* ATTRIBUTES(COUNT = g_detail3_02_cnt)
      BEFORE DISPLAY
         
   END DISPLAY
END DIALOG

DIALOG axmp520_02_display03()
   DISPLAY ARRAY g_xmdc_d TO s_detail4_axmp520_02.* ATTRIBUTES(COUNT = g_detail4_02_cnt)
      BEFORE DISPLAY
         
   END DISPLAY
END DIALOG

DIALOG axmp520_02_display04()
   DISPLAY ARRAY g_xmdh_d TO s_detail2_axmp520_02.* ATTRIBUTE(COUNT=g_detail2_02_cnt)
         
      BEFORE DISPLAY
         CALL axmp520_02_fetch()

      BEFORE ROW  
         LET l_ac = DIALOG.getCurrentRow("s_detail1_axmp520_02")   
         LET g_detail_02_idx = l_ac
         CALL axmp520_02_fetch()                  
       
   END DISPLAY  
END DIALOG

 
{</section>}
 
{<section id="axmp520_02.other_function" readonly="Y" >}

PUBLIC FUNCTION axmp520_02(--)
   #add-point:input段變數傳入

   #end add-point
   )
   DEFINE l_sql      STRING
   DEFINE l_linkno   LIKE type_t.num10
   DEFINE l_seq      LIKE xmdh_t.xmdhseq
   DEFINE l_xmdg_d   RECORD   
            linkno      LIKE type_t.num10,        #暫時單號
            xmdg001     LIKE xmdg_t.xmdg001,      #出貨性質
            xmdg005     LIKE xmdg_t.xmdg005,      #客戶
            xmdg006     LIKE xmdg_t.xmdg006,      #收款客戶
            xmdg007     LIKE xmdg_t.xmdg007,      #收貨客戶             
            xmdg008     LIKE xmdg_t.xmdg008,      #收款條件
            xmdg009     LIKE xmdg_t.xmdg009,      #交易條件
            xmdg010     LIKE xmdg_t.xmdg010,      #稅別
            xmdg013     LIKE xmdg_t.xmdg013,      #發票類型
            xmdg014     LIKE xmdg_t.xmdg014,      #幣別
            xmdg015     LIKE xmdg_t.xmdg015,      #匯率 
            xmdg017     LIKE xmdg_t.xmdg017,      #收貨地址
            xmdgdocno   LIKE xmdg_t.xmdgdocno,    #出貨單號                    
            result      LIKE type_t.chr500        #執行結果
                     END RECORD 
   DEFINE l_xmdcdocno   LIKE xmdc_t.xmdcdocno
   DEFINE l_xmdcseq     LIKE xmdc_t.xmdcseq
   DEFINE l_tmp_d   RECORD                     
            xmdh001  LIKE xmdh_t.xmdh001,         #訂單單號
            xmdh002  LIKE xmdh_t.xmdh002,         #訂單項次
            xmdh003  LIKE xmdh_t.xmdh003,         #訂單項序
            xmdh004  LIKE xmdh_t.xmdh004,         #訂單分批序
            xmdh017  LIKE xmdh_t.xmdh017,         #出通量
            xmdh012  LIKE xmdh_t.xmdh012,         #庫位
            xmdh013  LIKE xmdh_t.xmdh013,         #儲位
            xmdh014  LIKE xmdh_t.xmdh014,         #批號
            xmdh029  LIKE xmdh_t.xmdh029          #庫存管理特徵
                    END RECORD                     
   DEFINE l_xmdh_d  RECORD
            linkno     LIKE type_t.num10,
            linkseq    LIKE xmdh_t.xmdhseq,
            xmdhunit   LIKE xmdh_t.xmdhunit,
            xmdh001    LIKE xmdh_t.xmdh001,
            xmdh002    LIKE xmdh_t.xmdh002,
            xmdh003    LIKE xmdh_t.xmdh003,
            xmdh004    LIKE xmdh_t.xmdh004,
            xmdh005    LIKE xmdh_t.xmdh005,
            xmdh006    LIKE xmdh_t.xmdh006,
            xmdh007    LIKE xmdh_t.xmdh007,
            xmdh008    LIKE xmdh_t.xmdh008,
            xmdh009    LIKE xmdh_t.xmdh009,
            xmdh010    LIKE xmdh_t.xmdh010,
            xmdh011    LIKE xmdh_t.xmdh011,
            xmdh012    LIKE xmdh_t.xmdh012,
            xmdh013    LIKE xmdh_t.xmdh013,
            xmdh014    LIKE xmdh_t.xmdh014,
            xmdh015    LIKE xmdh_t.xmdh015,
            xmdh016    LIKE xmdh_t.xmdh016,
            xmdh017    LIKE xmdh_t.xmdh017,
            xmdh018    LIKE xmdh_t.xmdh018,
            xmdh019    LIKE xmdh_t.xmdh019,
            xmdh020    LIKE xmdh_t.xmdh020,
            xmdh021    LIKE xmdh_t.xmdh021,
            xmdh022    LIKE xmdh_t.xmdh022,
            xmdh023    LIKE xmdh_t.xmdh023,
            xmdh024    LIKE xmdh_t.xmdh024,
            xmdh025    LIKE xmdh_t.xmdh025,
            xmdh026    LIKE xmdh_t.xmdh026,
            xmdh027    LIKE xmdh_t.xmdh027,
            xmdh028    LIKE xmdh_t.xmdh028,
            xmdh029    LIKE xmdh_t.xmdh029,
            xmdh030    LIKE xmdh_t.xmdh030,
            xmdh031    LIKE xmdh_t.xmdh031,
            xmdh032    LIKE xmdh_t.xmdh032,
            xmdh033    LIKE xmdh_t.xmdh033,
            xmdh034    LIKE xmdh_t.xmdh034,
            xmdh035    LIKE xmdh_t.xmdh035,
            xmdh036    LIKE xmdh_t.xmdh036,
            xmdh050    LIKE xmdh_t.xmdh050,
            xmdh051    LIKE xmdh_t.xmdh051,
            xmdh056    LIKE xmdh_t.xmdh056
                    END RECORD
           
   DEFINE l_success   LIKE type_t.num5


   DEFINE l_oodb011   LIKE oodb_t.oodb011  
#   DEFINE l_ref_unit  LIKE type_t.chr1  #160808-00024 by whitney mark
   DEFINE l_xmda028   LIKE xmda_t.xmda028   #161230-00019#4


   #匯總方式為空時，預設1.依客戶匯總
   IF cl_null(g_gather) THEN
      LET g_gather = 1
   END IF
   
   #判斷據點參數若不使用參考單位時，則參考單位、數量不可給值
#   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0028') RETURNING l_ref_unit  #160808-00024 by whitney mark

   
   #清空tmptable
   DELETE FROM p520_tmp01           #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
   DELETE FROM p520_tmp02           #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
   DELETE FROM p520_tmp03           #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03  
  
   LET l_linkno = ''
   SELECT MAX(linkno) INTO l_linkno
     FROM p520_tmp01           #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
   IF cl_null(l_linkno) THEN
      LET l_linkno = 1
   ELSE 
      LET l_linkno = l_linkno + 1   
   END IF  
 

   #依客戶、收款條件、交易條件、稅別、幣別、匯率、收貨客戶、收款客戶、發票類型、訂單性質、收貨地址 條件做匯總  
   INITIALIZE l_xmdg_d.* TO NULL
   
   #依不同的匯總方式進行匯總
   CASE g_gather
      WHEN '1'   #依客戶匯總
           LET l_sql = "SELECT a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015, ",
                       "       a.xmda016,a.xmda021,a.xmda022,a.xmda035,a.xmda005, ",
                       "       a.xmda025,'','' ",
                       "      ,a.xmda028 ",   #161230-00019#4
                       "  FROM xmda_t a,p520_01_tmp b",
                       " WHERE a.xmdaent = '",g_enterprise,"' ",
                       "   AND a.xmdasite = '",g_site,"' ",
                       "   AND a.xmdadocno = b.xmdh001 ",
                       #161230-00019#4-s-mod
#                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025 ",
                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025,a.xmda028 ",
                       #161230-00019#4-e-mod
                       " ORDER BY a.xmda004 "
      WHEN '2'   #依來源單號匯總
           LET l_sql = "SELECT a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015, ",
                       "       a.xmda016,a.xmda021,a.xmda022,a.xmda035,a.xmda005, ",
                       "       a.xmda025,b.xmdh001,'' ",
                       "      ,a.xmda028 ",   #161230-00019#4
                       "  FROM xmda_t a,p520_01_tmp b",
                       " WHERE a.xmdaent = '",g_enterprise,"' ",
                       "   AND a.xmdasite = '",g_site,"' ",
                       "   AND a.xmdadocno = b.xmdh001 ",
                       #161230-00019#4-s-mod
#                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025,b.xmdh001 ",
                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025,b.xmdh001,a.xmda028 ",
                       #161230-00019#4-e-mod
                       " ORDER BY a.xmda004 "
      WHEN '3'   #依來源單號+項次匯總
           LET l_sql = "SELECT a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015, ",
                       "       a.xmda016,a.xmda021,a.xmda022,a.xmda035,a.xmda005, ",
                       "       a.xmda025,b.xmdh001,b.xmdh002 ",
                       "      ,a.xmda028 ",   #161230-00019#4
                       "  FROM xmda_t a,p520_01_tmp b",
                       " WHERE a.xmdaent = '",g_enterprise,"' ",
                       "   AND a.xmdasite = '",g_site,"' ",
                       "   AND a.xmdadocno = b.xmdh001 ",
                       #161230-00019#4-s-mod
#                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025,b.xmdh001,b.xmdh002 ",
                       " GROUP BY a.xmda004,a.xmda009,a.xmda010,a.xmda011,a.xmda015,a.xmda016,a.xmda022,a.xmda021,a.xmda035,a.xmda005,a.xmda025,b.xmdh001,b.xmdh002,a.xmda028 ",
                       #161230-00019#4-e-mod
                       " ORDER BY a.xmda004 "
   END CASE
 
              
   PREPARE p520_02_xmda_pr FROM l_sql
   DECLARE p520_02_xmda_cs CURSOR FOR p520_02_xmda_pr
    
   #161230-00019#4-s-mark
#   #依不同方式進行匯總
#   CASE g_gather
#      WHEN '1'   
#           #依客戶匯總
#           LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
#                       "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
#                       "  FROM p520_01_tmp a,xmda_t b ",
#                       " WHERE b.xmdaent = '",g_enterprise,"' ",
#                       "   AND b.xmdasite = '",g_site,"' ",
#                       "   AND a.xmdh001 = b.xmdadocno ",
#                       "   AND b.xmda004 = ? ",
#                       "   AND b.xmda009 = ? ",
#                       "   AND b.xmda010 = ? ",
#                       "   AND b.xmda011 = ? ",
#                       "   AND b.xmda015 = ? ",
#                       "   AND b.xmda016 = ? ",
#                       "   AND b.xmda021 = ? ",                       
#                       "   AND b.xmda022 = ? ",
#                       "   AND b.xmda035 = ? ",
#                       "   AND b.xmda005 = ? ",
#                       "   AND (b.xmda025 = ? OR b.xmda025 IS NULL) ",  #160803-00041 by whitney modify
#                       "   AND (b.xmda028 = ? OR b.xmda028 IS NULL) ",   #161230-00019#4
#                       " ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
#      WHEN '2'   
#           #依來源單號匯總
#           LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
#                       "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
#                       "  FROM p520_01_tmp a,xmda_t b ",
#                       " WHERE b.xmdaent = '",g_enterprise,"' ",
#                       "   AND b.xmdasite = '",g_site,"' ",
#                       "   AND a.xmdh001 = b.xmdadocno ",
#                       "   AND a.xmdh001 = ? ",
#                       " ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
#      WHEN '3'   
#           #依來源單號+項次匯總
#           LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
#                       "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
#                       "  FROM p520_01_tmp a,xmda_t b ",
#                       " WHERE b.xmdaent = '",g_enterprise,"' ",
#                       "   AND b.xmdasite = '",g_site,"' ",
#                       "   AND a.xmdh001 = b.xmdadocno ",
#                       "   AND a.xmdh001 = ? ",
#                       "   AND a.xmdh002 = ? ",
#                       " ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
#   END CASE
#  
#                
#   PREPARE p520_02_tmp_pr FROM l_sql
#   DECLARE p520_02_tmp_cs CURSOR FOR p520_02_tmp_pr                
   #161230-00019#4-e-mark
    
   FOREACH p520_02_xmda_cs INTO l_xmdg_d.xmdg005,l_xmdg_d.xmdg008,l_xmdg_d.xmdg009,l_xmdg_d.xmdg010,l_xmdg_d.xmdg014,
                                l_xmdg_d.xmdg015,l_xmdg_d.xmdg006,l_xmdg_d.xmdg007,l_xmdg_d.xmdg013,l_xmdg_d.xmdg001,
                                l_xmdg_d.xmdg017,l_xmdcdocno,l_xmdcseq
                               ,l_xmda028   #161230-00019#4
      
      LET l_xmdg_d.linkno = l_linkno
      #mod--161109-00085#10-s
      #INSERT INTO p520_tmp01 VALUES (l_xmdg_d.*)          #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
      INSERT INTO p520_tmp01(linkno,xmdg001,xmdg005,xmdg006,xmdg007,
                             xmdg008,xmdg009,xmdg010,xmdg013,xmdg014,
                             #161230-00019#4-s-mod
#                             xmdg015,xmdg017,xmdgdocno,result) 
                             xmdg015,xmdg017,xmdgdocno,result,xmda028) 
                             #161230-00019#4-e-mod
      
      VALUES (l_xmdg_d.linkno,l_xmdg_d.xmdg001,l_xmdg_d.xmdg005,l_xmdg_d.xmdg006,l_xmdg_d.xmdg007,
              l_xmdg_d.xmdg008,l_xmdg_d.xmdg009,l_xmdg_d.xmdg010,l_xmdg_d.xmdg013,l_xmdg_d.xmdg014,
              #161230-00019#4-s-mod
#              l_xmdg_d.xmdg015,l_xmdg_d.xmdg017,l_xmdg_d.xmdgdocno,l_xmdg_d.result)                                              
              l_xmdg_d.xmdg015,l_xmdg_d.xmdg017,l_xmdg_d.xmdgdocno,l_xmdg_d.result,l_xmda028)
              #161230-00019#4-e-mod
      #mod--161109-00085#10-e
      LET l_seq = 1   
      #將訂單單身寫入
      #161230-00019#4-s-add
      #依不同方式進行匯總
      CASE g_gather
         WHEN '1'   
              #依客戶匯總
              LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
                          "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
                          "  FROM p520_01_tmp a,xmda_t b ",
                          " WHERE b.xmdaent = '",g_enterprise,"' ",
                          "   AND b.xmdasite = '",g_site,"' ",
                          "   AND a.xmdh001 = b.xmdadocno ",
                          "   AND b.xmda004 = ? ",
                          "   AND b.xmda009 = ? ",
                          "   AND b.xmda010 = ? ",
                          "   AND b.xmda011 = ? ",
                          "   AND b.xmda015 = ? ",
                          "   AND b.xmda016 = ? ",
                          "   AND b.xmda021 = ? ",                       
                          "   AND b.xmda022 = ? ",
                          "   AND b.xmda035 = ? ",
                          "   AND b.xmda005 = ? ",
                          "   AND (b.xmda025 = ? OR b.xmda025 IS NULL) "
              IF cl_null(l_xmda028) THEN
                 LET l_sql = l_sql," AND (b.xmda028 = '' OR b.xmda028 IS NULL) "
              ELSE
                 LET l_sql = l_sql," AND b.xmda028 = ?  "
              END IF
              
              LET l_sql = l_sql," ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
         WHEN '2'   
              #依來源單號匯總
              LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
                          "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
                          "  FROM p520_01_tmp a,xmda_t b ",
                          " WHERE b.xmdaent = '",g_enterprise,"' ",
                          "   AND b.xmdasite = '",g_site,"' ",
                          "   AND a.xmdh001 = b.xmdadocno ",
                          "   AND a.xmdh001 = ? ",
                          " ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
         WHEN '3'   
              #依來源單號+項次匯總
              LET l_sql = "SELECT a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004,a.xmdh017, ",
                          "       a.xmdh012,a.xmdh013,a.xmdh014,a.xmdh029 ",
                          "  FROM p520_01_tmp a,xmda_t b ",
                          " WHERE b.xmdaent = '",g_enterprise,"' ",
                          "   AND b.xmdasite = '",g_site,"' ",
                          "   AND a.xmdh001 = b.xmdadocno ",
                          "   AND a.xmdh001 = ? ",
                          "   AND a.xmdh002 = ? ",
                          " ORDER BY a.xmdh001,a.xmdh002,a.xmdh003,a.xmdh004 "  
      END CASE
      
                   
      PREPARE p520_02_tmp_pr FROM l_sql
      DECLARE p520_02_tmp_cs CURSOR FOR p520_02_tmp_pr                
      #161230-00019#4-e-add
      CASE g_gather
         WHEN '1'   
              #依客戶匯總
              #161230-00019#4-s-mod
#              OPEN p520_02_tmp_cs USING l_xmdg_d.xmdg005,l_xmdg_d.xmdg008,l_xmdg_d.xmdg009,l_xmdg_d.xmdg010,l_xmdg_d.xmdg014,
#                                        l_xmdg_d.xmdg015,l_xmdg_d.xmdg006,l_xmdg_d.xmdg007,l_xmdg_d.xmdg013,l_xmdg_d.xmdg001,
#                                        l_xmdg_d.xmdg017
                                        
              IF cl_null(l_xmda028) THEN
                 OPEN p520_02_tmp_cs USING l_xmdg_d.xmdg005,l_xmdg_d.xmdg008,l_xmdg_d.xmdg009,l_xmdg_d.xmdg010,l_xmdg_d.xmdg014,
                                           l_xmdg_d.xmdg015,l_xmdg_d.xmdg006,l_xmdg_d.xmdg007,l_xmdg_d.xmdg013,l_xmdg_d.xmdg001,
                                           l_xmdg_d.xmdg017
              ELSE
                 OPEN p520_02_tmp_cs USING l_xmdg_d.xmdg005,l_xmdg_d.xmdg008,l_xmdg_d.xmdg009,l_xmdg_d.xmdg010,l_xmdg_d.xmdg014,
                                           l_xmdg_d.xmdg015,l_xmdg_d.xmdg006,l_xmdg_d.xmdg007,l_xmdg_d.xmdg013,l_xmdg_d.xmdg001,
                                           l_xmdg_d.xmdg017,l_xmda028
              END IF
              #161230-00019#4-e-mod
         WHEN '2'   
              #依來源單號匯總
              OPEN p520_02_tmp_cs USING l_xmdcdocno
         WHEN '3'   
              #依來源單號+項次匯總
              OPEN p520_02_tmp_cs USING l_xmdcdocno,l_xmdcseq
      END CASE
      INITIALIZE l_tmp_d.* TO NULL        
      #161109-00085#10-s
      #FOREACH p520_02_tmp_cs INTO l_tmp_d.*
      FOREACH p520_02_tmp_cs 
      INTO l_tmp_d.xmdh001,l_tmp_d.xmdh002,l_tmp_d.xmdh003,l_tmp_d.xmdh004,l_tmp_d.xmdh017,
           l_tmp_d.xmdh012,l_tmp_d.xmdh013,l_tmp_d.xmdh014,l_tmp_d.xmdh029                        
      #161109-00085#10-e
         INITIALIZE l_xmdh_d.* TO NULL
         
         SELECT xmddunit,xmdddocno,xmddseq,xmddseq1,xmddseq2,
                xmdd003 ,xmdd001  ,xmdd002,xmdc003 ,xmdc004 ,
                xmdc005 ,xmdd004 ,(xmdd006-xmdd031+xmdd016),
                xmdd024 ,xmdd026,xmdc052 ,xmdd018 ,xmdd019,
                xmdd020 ,xmdc057,xmdc036 ,xmdc037 ,xmdc038,
                xmdc027 ,xmdd008,xmdc021 ,xmdc050 ,xmda050 
           INTO l_xmdh_d.xmdhunit,l_xmdh_d.xmdh001,l_xmdh_d.xmdh002,l_xmdh_d.xmdh003,l_xmdh_d.xmdh004,
                l_xmdh_d.xmdh005 ,l_xmdh_d.xmdh006,l_xmdh_d.xmdh007,l_xmdh_d.xmdh008,l_xmdh_d.xmdh009,  
                l_xmdh_d.xmdh010 ,l_xmdh_d.xmdh015 ,l_xmdh_d.xmdh016,
                l_xmdh_d.xmdh018 ,l_xmdh_d.xmdh020,l_xmdh_d.xmdh022,l_xmdh_d.xmdh023,l_xmdh_d.xmdh024,
                l_xmdh_d.xmdh025 ,l_xmdh_d.xmdh029,l_xmdh_d.xmdh031,l_xmdh_d.xmdh032,l_xmdh_d.xmdh033,
                l_xmdh_d.xmdh034 ,l_xmdh_d.xmdh035,l_xmdh_d.xmdh036,l_xmdh_d.xmdh050,l_xmdh_d.xmdh051                
           FROM xmdd_t,xmdc_t,xmda_t
          WHERE xmddent = g_enterprise 
            AND xmdddocno = l_tmp_d.xmdh001
            AND xmddseq = l_tmp_d.xmdh002
            AND xmddseq1 = l_tmp_d.xmdh003
            AND xmddseq2 = l_tmp_d.xmdh004
            AND xmdcent = xmddent AND xmdcsite = xmddsite AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq 
            AND xmdaent = xmddent AND xmdasite = xmddsite AND xmdadocno = xmdddocno
 

                
         LET l_xmdh_d.linkno = l_xmdg_d.linkno        
         LET l_xmdh_d.linkseq = l_seq                   #項次                           
         LET l_xmdh_d.xmdh011 = 'N'                     #多庫儲批出貨 
         IF cl_null(l_tmp_d.xmdh012) THEN
            #抓取預設庫儲
            SELECT imaf091,imaf092 
              INTO l_xmdh_d.xmdh012,l_xmdh_d.xmdh013
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = l_xmdh_d.xmdh006            
         ELSE         
            LET l_xmdh_d.xmdh012 = l_tmp_d.xmdh012         #庫位         
            LET l_xmdh_d.xmdh013 = l_tmp_d.xmdh013         #儲位         
            LET l_xmdh_d.xmdh014 = l_tmp_d.xmdh014         #批號    
         END IF
         LET l_xmdh_d.xmdh029 = l_tmp_d.xmdh029          #庫存管理特徵
         LET l_xmdh_d.xmdh017 = l_tmp_d.xmdh017          #出通數量
  
         #推算參考數量
         #160808-00024 by whitney modify start
         #IF l_ref_unit = 'Y' THEN
         IF g_s_bas_0028 = 'Y' THEN
         #160808-00024 by whitney modify end
            IF NOT cl_null(l_xmdh_d.xmdh018) THEN          
               CALL s_aooi250_convert_qty(l_xmdh_d.xmdh006,l_xmdh_d.xmdh015,l_xmdh_d.xmdh018,l_xmdh_d.xmdh017)
                 RETURNING l_success,l_xmdh_d.xmdh019
            END IF
         ELSE
            LET l_xmdh_d.xmdh018 = ''
            LET l_xmdh_d.xmdh019 = 0
         END IF
         
         #若料號有使用銷售計價單位時，自動推算計價數量
         IF NOT cl_null(l_xmdh_d.xmdh020) THEN          
            CALL s_aooi250_convert_qty(l_xmdh_d.xmdh006,l_xmdh_d.xmdh015,l_xmdh_d.xmdh020,l_xmdh_d.xmdh017)
              RETURNING l_success,l_xmdh_d.xmdh021
         ELSE
            LET l_xmdh_d.xmdh020 = l_xmdh_d.xmdh015
            LET l_xmdh_d.xmdh021 = l_xmdh_d.xmdh017           
         END IF  
  
         CALL s_axmt500_get_amount_2(l_xmdh_d.xmdh017,l_xmdh_d.xmdh023,l_xmdh_d.xmdh024,l_xmdg_d.xmdg014,l_xmdg_d.xmdg015)
                  RETURNING l_xmdh_d.xmdh026,l_xmdh_d.xmdh027,l_xmdh_d.xmdh028
      
         #mod--161109-00085#10-s                         
         #INSERT INTO p520_tmp02 VALUES (l_xmdh_d.*)             #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
         INSERT INTO p520_tmp02(linkno,linkseq,xmdhunit,xmdh001,xmdh002,
                                xmdh003,xmdh004,xmdh005,xmdh006,xmdh007,
                                xmdh008,xmdh009,xmdh010,xmdh011,xmdh012,
                                xmdh013,xmdh014,xmdh015,xmdh016,xmdh017,
                                xmdh018,xmdh019,xmdh020,xmdh021,xmdh022,
                                xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,
                                xmdh028,xmdh029,xmdh030,xmdh031,xmdh032,
                                xmdh033,xmdh034,xmdh035,xmdh036,xmdh050,
                                xmdh051,xmdh056)
         VALUES (l_xmdh_d.linkno,l_xmdh_d.linkseq,l_xmdh_d.xmdhunit,l_xmdh_d.xmdh001,l_xmdh_d.xmdh002,
                 l_xmdh_d.xmdh003,l_xmdh_d.xmdh004,l_xmdh_d.xmdh005,l_xmdh_d.xmdh006,l_xmdh_d.xmdh007,
                 l_xmdh_d.xmdh008,l_xmdh_d.xmdh009,l_xmdh_d.xmdh010,l_xmdh_d.xmdh011,l_xmdh_d.xmdh012,
                 l_xmdh_d.xmdh013,l_xmdh_d.xmdh014,l_xmdh_d.xmdh015,l_xmdh_d.xmdh016,l_xmdh_d.xmdh017,
                 l_xmdh_d.xmdh018,l_xmdh_d.xmdh019,l_xmdh_d.xmdh020,l_xmdh_d.xmdh021,l_xmdh_d.xmdh022,
                 l_xmdh_d.xmdh023,l_xmdh_d.xmdh024,l_xmdh_d.xmdh025,l_xmdh_d.xmdh026,l_xmdh_d.xmdh027,
                 l_xmdh_d.xmdh028,l_xmdh_d.xmdh029,l_xmdh_d.xmdh030,l_xmdh_d.xmdh031,l_xmdh_d.xmdh032,
                 l_xmdh_d.xmdh033,l_xmdh_d.xmdh034,l_xmdh_d.xmdh035,l_xmdh_d.xmdh036,l_xmdh_d.xmdh050,
                 l_xmdh_d.xmdh051,l_xmdh_d.xmdh056)
         #庫位不為空則先新增一筆多庫儲批明細
         #mod--161109-00085#10-e
         #IF NOT cl_null(l_xmdh_d.xmdh012) THEN  #160806-00005 by whitney mark
            CALL axmp520_02_insert_xmdi(l_xmdh_d.linkno,l_xmdh_d.linkseq,l_xmdh_d.xmdh006,l_xmdh_d.xmdh007,l_xmdh_d.xmdh009,
                                        l_xmdh_d.xmdh010,l_xmdh_d.xmdh012,l_xmdh_d.xmdh013,l_xmdh_d.xmdh014,l_xmdh_d.xmdh029,
                                        l_xmdh_d.xmdh015,l_xmdh_d.xmdh017,l_xmdh_d.xmdh018,l_xmdh_d.xmdh019) 
              RETURNING l_success
 
         #END IF  #160806-00005 by whitney mark
         LET l_seq = l_seq + 1
      END FOREACH                                  
      LET l_linkno = l_linkno + 1                                
   END FOREACH   
        
   CLOSE p520_02_xmda_cs
   FREE p520_02_xmda_pr
   CLOSE p520_02_tmp_cs
   FREE p520_02_tmp_pr 
   
END FUNCTION
#畫面初始設定
PUBLIC FUNCTION axmp520_02_init()

   WHENEVER ERROR CONTINUE

     CALL cl_set_combo_scc("xmdh005_02","2055") 
     CALL cl_set_combo_scc("xmdc019","2055")     
   
    #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
    IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
       CALL cl_set_comp_visible("xmdh007,xmdh007_desc",FALSE)
       CALL cl_set_comp_visible("xmdi002,xmdi002_desc",FALSE)
       CALL cl_set_comp_visible("xmdc002,xmdc002_desc",FALSE)
    END IF
    
    #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
    IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
       CALL cl_set_comp_visible("xmdh018,xmdh018_desc,xmdh019",FALSE)
       CALL cl_set_comp_visible("xmdi010,xmdi010_desc,xmdi011",FALSE)
    END IF
   
END FUNCTION
#建立temp table
PUBLIC FUNCTION axmp520_02_create_temp_table()
  DEFINE r_success         LIKE type_t.num5 
  
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE  
      
   CREATE TEMP TABLE p520_tmp01(                  #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
            linkno      LIKE type_t.num10,        #暫時單號
            xmdg001     LIKE xmdg_t.xmdg001,      #出貨性質
            xmdg005     LIKE xmdg_t.xmdg005,      #客戶
            xmdg006     LIKE xmdg_t.xmdg006,      #收款客戶
            xmdg007     LIKE xmdg_t.xmdg007,      #收貨客戶             
            xmdg008     LIKE xmdg_t.xmdg008,      #收款條件
            xmdg009     LIKE xmdg_t.xmdg009,      #交易條件
            xmdg010     LIKE xmdg_t.xmdg010,      #稅別
            xmdg013     LIKE xmdg_t.xmdg013,      #發票類型
            xmdg014     LIKE xmdg_t.xmdg014,      #幣別
            xmdg015     LIKE xmdg_t.xmdg015,      #匯率 
            xmdg017     LIKE xmdg_t.xmdg017,      #收貨地址
            xmdgdocno   LIKE xmdg_t.xmdgdocno,    #出貨單號                    
            result      LIKE type_t.chr500,       #執行結果
            xmda028     LIKE xmda_t.xmda028       #一次性交易對象識別碼   #161230-00019#4
            )                  
                   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_tmp01'         #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   CREATE TEMP TABLE p520_tmp02(           #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
      linkno     LIKE type_t.num10,
      linkseq    LIKE xmdh_t.xmdhseq,
      xmdhunit   LIKE xmdh_t.xmdhunit,
      xmdh001    LIKE xmdh_t.xmdh001,
      xmdh002    LIKE xmdh_t.xmdh002,
      xmdh003    LIKE xmdh_t.xmdh003,
      xmdh004    LIKE xmdh_t.xmdh004,
      xmdh005    LIKE xmdh_t.xmdh005,
      xmdh006    LIKE xmdh_t.xmdh006,
      xmdh007    LIKE xmdh_t.xmdh007,
      xmdh008    LIKE xmdh_t.xmdh008,
      xmdh009    LIKE xmdh_t.xmdh009,
      xmdh010    LIKE xmdh_t.xmdh010,
      xmdh011    LIKE xmdh_t.xmdh011,
      xmdh012    LIKE xmdh_t.xmdh012,
      xmdh013    LIKE xmdh_t.xmdh013,
      xmdh014    LIKE xmdh_t.xmdh014,
      xmdh015    LIKE xmdh_t.xmdh015,
      xmdh016    LIKE xmdh_t.xmdh016,
      xmdh017    LIKE xmdh_t.xmdh017,
      xmdh018    LIKE xmdh_t.xmdh018,
      xmdh019    LIKE xmdh_t.xmdh019,
      xmdh020    LIKE xmdh_t.xmdh020,
      xmdh021    LIKE xmdh_t.xmdh021,
      xmdh022    LIKE xmdh_t.xmdh022,
      xmdh023    LIKE xmdh_t.xmdh023,
      xmdh024    LIKE xmdh_t.xmdh024,
      xmdh025    LIKE xmdh_t.xmdh025,
      xmdh026    LIKE xmdh_t.xmdh026,
      xmdh027    LIKE xmdh_t.xmdh027,
      xmdh028    LIKE xmdh_t.xmdh028,
      xmdh029    LIKE xmdh_t.xmdh029,
      xmdh030    LIKE xmdh_t.xmdh030,
      xmdh031    LIKE xmdh_t.xmdh031,
      xmdh032    LIKE xmdh_t.xmdh032,
      xmdh033    LIKE xmdh_t.xmdh033,
      xmdh034    LIKE xmdh_t.xmdh034,
      xmdh035    LIKE xmdh_t.xmdh035,
      xmdh036    LIKE xmdh_t.xmdh036,
      xmdh050    LIKE xmdh_t.xmdh050,
      xmdh051    LIKE xmdh_t.xmdh051,
      xmdh056    LIKE xmdh_t.xmdh056    
      )                  
                   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_tmp02'        #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF


   CREATE TEMP TABLE p520_tmp03(         #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03 
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
      xmdi012     LIKE xmdi_t.xmdi012,
      xmdi013     LIKE xmdi_t.xmdi013
      )           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_tmp03'         #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03 
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
END FUNCTION
#刪除temp table
PUBLIC FUNCTION axmp520_02_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
    
   DROP TABLE p520_tmp01;                      #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p520_tmp01'   #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE p520_tmp02;                              #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p520_tmp02'        #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()   #
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   DROP TABLE p520_tmp03;                         #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p520_tmp03'   #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF 
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 單頭顯示
# Memo...........:
# Usage..........: CALL axmp520_02_b_fill()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150716 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_b_fill()
   DEFINE l_sql          STRING
   DEFINE l_ac_t         LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 

   WHENEVER ERROR CONTINUE

    LET l_sql = "SELECT xmdg005,xmdg006,xmdg007,xmdg008,xmdg009, ",
                "       xmdg010,xmdg013,xmdg014,xmdg015,xmdg017, ",
                "       linkno,xmdgdocno,result ",
                "      ,xmda028 ",   #161230-00019#4
                #161205-00025#14-s-add
                ",(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = xmdg005 AND pmaal002 = '",g_dlang,"'), ",
                "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = xmdg006 AND pmaal002 = '",g_dlang,"'), ",
                "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = xmdg007 AND pmaal002 = '",g_dlang,"'), ",
                "(SELECT ooibl004 FROM ooibl_t WHERE ooiblent = ",g_enterprise," AND ooibl002 = xmdg008 AND ooibl003 = '",g_dlang,"'), ",
                "(SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '238' AND oocql002 = xmdg009 AND oocql003 = '",g_dlang,"'), ",
                "(SELECT oodbl004 FROM oodbl_t,ooef_t WHERE oodblent = ",g_enterprise," AND ooefent = oodblent AND ooef001  = '",g_site,"' AND ooef019  = oodbl001 AND oodbl002 = xmdg010 AND oodbl003 = '",g_dlang,"'), ",
                "(SELECT isacl004 FROM isacl_t,ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"' AND isacl001 = ooef019 AND isaclent = ooefent AND isacl002 = xmdg013 AND isacl003 = '",g_dlang,"'), ",
                "(SELECT ooail003 FROM ooail_t WHERE ooailent = ",g_enterprise," AND ooail001 = xmdg014 AND ooail002 = '",g_dlang,"') ",
                #161205-00025#14-e-add
                "  FROM p520_tmp01 ",         #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
                " ORDER BY linkno,xmdg005 "
                
    PREPARE axmp520_sel_xmdg_pr FROM l_sql
    DECLARE axmp520_sel_xmdg_cs CURSOR FOR axmp520_sel_xmdg_pr
    
    LET g_detail_02_idx = 1
    LET l_ac_t = l_ac
    LET l_ac = 1
   
    CALL g_xmdg_d.clear()
    FOREACH axmp520_sel_xmdg_cs INTO g_xmdg_d[l_ac].xmdg005,  g_xmdg_d[l_ac].xmdg006,g_xmdg_d[l_ac].xmdg007,g_xmdg_d[l_ac].xmdg008,g_xmdg_d[l_ac].xmdg009,
                                     g_xmdg_d[l_ac].xmdg010,  g_xmdg_d[l_ac].xmdg013,g_xmdg_d[l_ac].xmdg014,g_xmdg_d[l_ac].xmdg015,g_xmdg_d[l_ac].xmdg017,
                                     g_xmdg_d[l_ac].linkno ,g_xmdg_d[l_ac].xmdgdocno,g_xmdg_d[l_ac].result 
                                    ,g_xmda028   #161230-00019#4
                                    #161205-00025#14-s-add
                                    ,g_xmdg_d[l_ac].xmdg005_desc,g_xmdg_d[l_ac].xmdg006_desc,g_xmdg_d[l_ac].xmdg007_desc,g_xmdg_d[l_ac].xmdg008_desc,
                                     g_xmdg_d[l_ac].xmdg009_desc,g_xmdg_d[l_ac].xmdg010_desc,g_xmdg_d[l_ac].xmdg013_desc,g_xmdg_d[l_ac].xmdg014_desc
                                    #161205-00025#14-e-add

                                     
        CALL axmp520_02_detail_show("'1'")       
        LET l_ac = l_ac + 1
    END FOREACH   
    CALL g_xmdg_d.deleteElement(l_ac)
    LET l_ac = l_ac_t
    LET g_detail_02_cnt = l_ac - 1
    CLOSE axmp520_sel_xmdg_cs
    FREE axmp520_sel_xmdg_pr  

    IF l_ac > 0 THEN
       LET g_detail_02_idx = l_ac
    END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp520_02_detail_show(p_page)
#                  RETURNING 
# Input parameter: p_page    
# Return code....: 
# Date & Author..: 20150716 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_detail_show(p_page)
   DEFINE p_page      STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_oodbl004 LIKE oodbL_t.oodbl004
   DEFINE l_oodb005  LIKE oodb_t.oodb005
   DEFINE l_oodb006  LIKE oodb_t.oodb006
   DEFINE l_oodb011  LIKE oodb_t.oodb011
   DEFINE l_pmak003  LIKE pmak_t.pmak003   #161230-00019#4
   
      IF p_page.getIndexOf("'1'",1) > 0 THEN
         #161205-00025#14-s-mark
#         #訂單客戶
#         CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_d[l_ac].xmdg005)   
#           RETURNING g_xmdg_d[l_ac].xmdg005_desc         
#         #收款客戶
#         CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_d[l_ac].xmdg006)   
#           RETURNING g_xmdg_d[l_ac].xmdg006_desc
#         #收貨客戶
#         CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_d[l_ac].xmdg007)   
#           RETURNING g_xmdg_d[l_ac].xmdg007_desc
#         
#         #付款條件
#         CALL s_desc_get_ooib002_desc(g_xmdg_d[l_ac].xmdg008)   
#           RETURNING g_xmdg_d[l_ac].xmdg008_desc  
#         #交易條件
#         CALL s_desc_get_acc_desc('238',g_xmdg_d[l_ac].xmdg009) 
#           RETURNING g_xmdg_d[l_ac].xmdg009_desc
#           
#         #稅別
#         CALL s_desc_get_tax_desc1(g_site,g_xmdg_d[l_ac].xmdg010)
#           RETURNING g_xmdg_d[l_ac].xmdg010_desc
         #161205-00025#14-e-mark
         #稅率、含稅否
         CALL s_tax_chk(g_site,g_xmdg_d[l_ac].xmdg010)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         IF l_success THEN
           LET g_xmdg_d[l_ac].xmdg011 = l_oodb006
           LET g_xmdg_d[l_ac].xmdg012 = l_oodb005 
         END IF           
         #161205-00025#14-s-mark
#         #發票類別
#         CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_d[l_ac].xmdg013) 
#           RETURNING g_xmdg_d[l_ac].xmdg013_desc
#        
#         #幣別
#         CALL s_desc_get_currency_desc(g_xmdg_d[l_ac].xmdg014) 
#           RETURNING g_xmdg_d[l_ac].xmdg014_desc       
         #161205-00025#14-e-mark
         #161230-00019#4-s-add
         IF NOT cl_null(g_xmda028) THEN
            LET l_pmak003 = ''
            CALL s_desc_get_oneturn_guest_desc(g_xmda028) 
              RETURNING l_pmak003            
            IF NOT cl_null(l_pmak003) THEN
               LET g_xmdg_d[l_ac].xmdg005_desc = l_pmak003
            END IF
         END IF
         IF g_xmdg_d[l_ac].xmdg005 = g_xmdg_d[l_ac].xmdg006 THEN
            IF NOT cl_null(l_pmak003) THEN
               LET g_xmdg_d[l_ac].xmdg006_desc = l_pmak003
            END IF
         END IF
         IF g_xmdg_d[l_ac].xmdg005 = g_xmdg_d[l_ac].xmdg007 THEN
            IF NOT cl_null(l_pmak003) THEN
               LET g_xmdg_d[l_ac].xmdg007_desc = l_pmak003
            END IF
         END IF
         #161230-00019#4-e-add
      END IF   
      IF p_page.getIndexOf("'2'",1) > 0 THEN
         #品名、規格
         CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006)      
           RETURNING g_xmdh_d[l_ac].imaal003,g_xmdh_d[l_ac].imaal004
         #產品特徵
         CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
              RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
         #作業編號
         CALL s_desc_get_acc_desc('221',g_xmdh_d[l_ac].xmdh009)
           RETURNING g_xmdh_d[l_ac].xmdh009_desc      
         #出貨單位、參考單位、計價單位
         CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015)   
           RETURNING g_xmdh_d[l_ac].xmdh015_desc
         CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018)   
           RETURNING g_xmdh_d[l_ac].xmdh018_desc
         CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020)   
           RETURNING g_xmdh_d[l_ac].xmdh020_desc        
         #庫位
         CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012)  #庫位
           RETURNING g_xmdh_d[l_ac].xmdh012_desc
         #儲位     
         CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) #儲位
           RETURNING g_xmdh_d[l_ac].xmdh013_desc              
         #稅別
         CALL s_desc_get_tax_desc1(g_site,g_xmdc_d[l_ac].xmdc016)
           RETURNING g_xmdc_d[l_ac].xmdc016_desc        
      END IF      
      IF p_page.getIndexOf("'3'",1) > 0 THEN
         #品名、規格
         CALL s_desc_get_item_desc(g_xmdi_d[l_ac].xmdi001)
           RETURNING g_xmdi_d[l_ac].imaal003_3,g_xmdi_d[l_ac].imaal004_3
         #產品特徵
         CALL s_feature_description(g_xmdi_d[l_ac].xmdi001,g_xmdi_d[l_ac].xmdi002)
              RETURNING l_success,g_xmdi_d[l_ac].xmdi002_desc
         #作業編號
         CALL s_desc_get_acc_desc('221',g_xmdi_d[l_ac].xmdi003)
           RETURNING g_xmdi_d[l_ac].xmdi003_desc
         #單位、參考單位
         CALL s_desc_get_unit_desc(g_xmdi_d[l_ac].xmdi008)
           RETURNING g_xmdi_d[l_ac].xmdi008_desc
         CALL s_desc_get_unit_desc(g_xmdi_d[l_ac].xmdi010)
           RETURNING g_xmdi_d[l_ac].xmdi010_desc
         #庫位
         CALL s_desc_get_stock_desc(g_site,g_xmdi_d[l_ac].xmdi005)  #庫位
           RETURNING g_xmdi_d[l_ac].xmdi005_desc
         #儲位
         CALL s_desc_get_locator_desc(g_site,g_xmdi_d[l_ac].xmdi005,g_xmdi_d[l_ac].xmdi006) #儲位
           RETURNING g_xmdi_d[l_ac].xmdi006_desc
      END IF   
END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL axmp520_02_fetch()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150716 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_fetch()
  DEFINE l_sql     STRING
  DEFINE l_ac_t    LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 

   WHENEVER ERROR CONTINUE

    IF cl_null(g_detail_02_idx) OR g_detail_02_idx <=0 THEN
       RETURN
    END IF
    IF g_detail_02_idx > g_xmdg_d.getLength() THEN
       LET g_detail_02_idx = g_xmdg_d.getLength()
    END IF

    INITIALIZE g_xmdh_d TO NULL
    INITIALIZE g_xmdc_d TO NULL
    LET l_sql = "SELECT xmdh001,xmdh002,xmdh003,xmdh004,xmdh005, ",
                "       xmdh006,xmdh007,xmdh009,xmdh010,xmdh011, ",
                "       xmdh012,xmdh013,xmdh014,xmdh015,xmdh017, ",
                "       xmdh018,xmdh019,xmdh020,xmdh021,xmdh022, ",
                "       xmdh023,xmdh024,xmdh025,xmdh026,xmdh027, ",
#                "       xmdh028,xmdh029,linkno ,linkseq,xmdh016  ",   #161205-00025#14 mark
                #161205-00025#14-s-add
                "       xmdh028,xmdh029,linkno ,linkseq,xmdh016,  ",
                "(SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = xmdh006 AND imaal002 = '",g_dlang,"'), ",
                "(SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = xmdh006 AND imaal002 = '",g_dlang,"'), ",
                "(SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = xmdh006 AND inaml002 = xmdh007 AND inaml003 = '",g_dlang,"'), ",
                "(SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '221' AND oocql002 = xmdh009 AND oocql003 = '",g_dlang,"'), ",
                "(SELECT oocal004 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = xmdh015 AND oocal002 = '",g_dlang,"'), ",
                "(SELECT oocal004 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = xmdh018 AND oocal002 = '",g_dlang,"'), ",
                "(SELECT oocal004 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = xmdh020 AND oocal002 = '",g_dlang,"'), ",
                "(SELECT inayl003 FROM inayl_t WHERE inaylent = ",g_enterprise," AND inayl001 = xmdh012 AND inayl002 = '",g_dlang,"'), ",
                "(SELECT inab003 FROM inab_t WHERE inabent = ",g_enterprise," AND inabsite = '",g_site,"' AND inab001 = xmdh012 AND inab002 = xmdh013), ",
                "(SELECT oodbl004 FROM oodbl_t,ooef_t WHERE oodblent = ",g_enterprise," AND ooefent = oodblent AND ooef001  = '",g_site,"' AND ooef019  = oodbl001 AND oodbl002 = xmdh024 AND oodbl003 = '",g_dlang,"'), ",
                "(SELECT xmdc040 FROM xmdc_t WHERE xmdcent = ",g_enterprise," AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ), ",
                "(SELECT xmdc041 FROM xmdc_t WHERE xmdcent = ",g_enterprise," AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ), ",
                "(SELECT xmdc042 FROM xmdc_t WHERE xmdcent = ",g_enterprise," AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ), ",
                "(SELECT xmdc043 FROM xmdc_t WHERE xmdcent = ",g_enterprise," AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ), ",
                "(SELECT xmdc044 FROM xmdc_t WHERE xmdcent = ",g_enterprise," AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ) ",
                #161205-00025#14-e-add
                "  FROM p520_tmp02 ",             #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
                " WHERE linkno = '",g_xmdg_d[g_detail_02_idx].linkno,"'" ,
                " ORDER BY xmdh001,xmdh002,xmdh003,xmdh004 "
    PREPARE axmp520_sel_xmdh_pr FROM l_sql
    DECLARE axmp520_sel_xmdh_cs CURSOR FOR axmp520_sel_xmdh_pr 

    #161205-00025#14-s-mark
#    LET l_sql = "SELECT xmdc040,xmdc041,xmdc042,xmdc043,xmdc044 ",
#                "  FROM xmdc_t ",
#                " WHERE xmdcent = '",g_enterprise,"'",
#                "   AND xmdcdocno = ? ",
#                "   AND xmdcseq = ? "
#   PREPARE axmp520_02_xmdc_pre FROM l_sql
    #161205-00025#14-e-mark

   
    LET l_ac_t = l_ac
    LET l_ac = 1
    
    
    
    FOREACH  axmp520_sel_xmdh_cs INTO g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh005,
                                      g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh011,
                                      g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,
                                      g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021,g_xmdh_d[l_ac].xmdh022,
                                      g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016,g_xmdc_d[l_ac].xmdc017,g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,
                                      g_xmdc_d[l_ac].xmdc048,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq ,g_xmdh_d[l_ac].xmdh016                                   
                                      #161205-00025#14-s-add
                                     ,g_xmdh_d[l_ac].imaal003,g_xmdh_d[l_ac].imaal004,g_xmdh_d[l_ac].xmdh007_desc,g_xmdh_d[l_ac].xmdh009_desc,g_xmdh_d[l_ac].xmdh015_desc,
                                      g_xmdh_d[l_ac].xmdh018_desc,g_xmdh_d[l_ac].xmdh020_desc,g_xmdh_d[l_ac].xmdh012_desc,g_xmdh_d[l_ac].xmdh013_desc,g_xmdc_d[l_ac].xmdc016_desc,
                                      g_xmdc_d[l_ac].xmdc040,g_xmdc_d[l_ac].xmdc041,g_xmdc_d[l_ac].xmdc042,g_xmdc_d[l_ac].xmdc043,g_xmdc_d[l_ac].xmdc044
                                      #161205-00025#14-e-add
       
#       CALL axmp520_02_detail_show("'2'")   #161205-00025#14 mark
       LET g_xmdc_d[l_ac].xmdcseq = g_xmdh_d[l_ac].xmdh002
       LET g_xmdc_d[l_ac].xmdc019 = g_xmdh_d[l_ac].xmdh005
       LET g_xmdc_d[l_ac].xmdc001 = g_xmdh_d[l_ac].xmdh006
       LET g_xmdc_d[l_ac].imaal003_1 = g_xmdh_d[l_ac].imaal003
       LET g_xmdc_d[l_ac].imaal004_1 = g_xmdh_d[l_ac].imaal004
       LET g_xmdc_d[l_ac].xmdc002 = g_xmdh_d[l_ac].xmdh007
       LET g_xmdc_d[l_ac].xmdc002_desc = g_xmdh_d[l_ac].xmdh007_desc
       LET g_xmdc_d[l_ac].xmdc004 = g_xmdh_d[l_ac].xmdh009
       LET g_xmdc_d[l_ac].xmdc004_desc = g_xmdh_d[l_ac].xmdh009_desc
       LET g_xmdc_d[l_ac].xmdc005 = g_xmdh_d[l_ac].xmdh010
       LET g_xmdc_d[l_ac].xmdc006 = g_xmdh_d[l_ac].xmdh015
       LET g_xmdc_d[l_ac].xmdc006_desc = g_xmdh_d[l_ac].xmdh015_desc
       LET g_xmdc_d[l_ac].xmdc007 = g_xmdh_d[l_ac].xmdh017
       LET g_xmdc_d[l_ac].xmdc010 = g_xmdh_d[l_ac].xmdh020
       LET g_xmdc_d[l_ac].xmdc010_desc = g_xmdh_d[l_ac].xmdh020_desc
       LET g_xmdc_d[l_ac].xmdc011 = g_xmdh_d[l_ac].xmdh021  
        
       #161205-00025#14-s-mark
#       EXECUTE axmp520_02_xmdc_pre USING g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002 
#                   INTO g_xmdc_d[l_ac].xmdc040,g_xmdc_d[l_ac].xmdc041,g_xmdc_d[l_ac].xmdc042,g_xmdc_d[l_ac].xmdc043,g_xmdc_d[l_ac].xmdc044
       #161205-00025#14-e-mark

       
       LET l_ac = l_ac + 1
    END FOREACH
    CALL g_xmdh_d.deleteElement(l_ac)
    CALL g_xmdc_d.deleteElement(l_ac)
    LET l_ac = l_ac_t
    LET g_detail2_02_cnt = l_ac - 1 
    LET g_detail4_02_cnt = l_ac - 1    
    CLOSE axmp520_sel_xmdh_cs
    FREE axmp520_sel_xmdh_pr
    
    CALL axmp520_02_fetch_xmdi()
    
END FUNCTION
#欄位控卡
PRIVATE FUNCTION axmp520_02_set_entry_b()
    CALL cl_set_comp_entry("xmdh017_02,xmdh019_02,xmdh021_02",TRUE)                #出貨數量、參考數量、計價數量
    CALL cl_set_comp_entry("xmdh011_02,xmdh012_02,xmdh013_02,xmdh014_02,xmdh029_02",TRUE) 
END FUNCTION
#欄位控卡
PRIVATE FUNCTION axmp520_02_set_no_entry_b()
   DEFINE l_inaa007   LIKE inaa_t.inaa007
   DEFINE l_xmdc022   LIKE xmdc_t.xmdc022
   DEFINE l_xmdc028   LIKE xmdc_t.xmdc028
   DEFINE l_xmdc029   LIKE xmdc_t.xmdc029
   DEFINE l_xmdc030   LIKE xmdc_t.xmdc030
   DEFINE l_xmdc057   LIKE xmdc_t.xmdc057
   DEFINE l_xmdcsite  LIKE xmdc_t.xmdcsite
   DEFINE l_imaf015   LIKE imaf_t.imaf015
   DEFINE l_imaf061   LIKE imaf_t.imaf061
   DEFINE l_imaf113   LIKE imaf_t.imaf113
   DEFINE l_imaf055   LIKE imaf_t.imaf055
  #161006-00018#24-s-add
   DEFINE l_flag2     LIKE type_t.num5
   DEFINE l_ooac002   LIKE ooac_t.ooac002
   DEFINE l_ooac004   LIKE ooac_t.ooac004
  #161006-00018#24-e-add  
         
        #161006-00018#24-s-add
         CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_flag2,l_ooac002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
        #161006-00018#24-e-add         
         
         IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
            CALL cl_set_comp_entry("xmdh012_02,xmdh013_02,xmdh014_02,xmdh029_02",FALSE)
         END IF
         
         LET l_xmdc022 = ''
         LET l_xmdc028 = ''
         LET l_xmdc029 = ''
         LET l_xmdc030 = ''
         SELECT xmdc022,xmdc028,xmdc029,xmdc030,xmdc057,
                xmdcsite
           INTO l_xmdc022,l_xmdc028,l_xmdc029,l_xmdc030,l_xmdc057,
                l_xmdcsite
           FROM xmdd_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmddent AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq
          WHERE xmddent = g_enterprise
            AND xmdddocno = g_xmdh_d[l_ac].xmdh001
            AND xmddseq = g_xmdh_d[l_ac].xmdh002
            AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
            AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
         #不允許部分交貨，則不能修改數量
         IF l_xmdc022 = 'N' THEN
            LET g_xmdh_d[l_ac].xmdh017 = g_xmdh_d[l_ac].xmdh017 
            CALL cl_set_comp_entry("xmdh017_02",FALSE)
         END IF
        #161006-00018#24-e-mark 
        ##訂單是否已有限定庫儲批
        #IF NOT cl_null(l_xmdc028) THEN
        #   CALL cl_set_comp_entry("xmdh011_02,xmdh012_02",FALSE)
        #   IF NOT cl_null(l_xmdc029) THEN
        #      CALL cl_set_comp_entry("xmdh013_02",FALSE)
        #      IF NOT cl_null(l_xmdc030) THEN
        #         CALL cl_set_comp_entry("xmdh014_02",FALSE)
        #      END IF
        #   END IF
        #END IF
        #161006-00018#24-e-mark 
        #161006-00018#24-s-add
         #訂單是否已有限定庫儲批
         IF NOT cl_null(l_xmdc028) THEN
            CALL cl_set_comp_entry("xmdh011_02",FALSE)
            IF l_ooac004 = 'N' THEN  
               CALL cl_set_comp_entry("xmdh012_02",FALSE)
            END IF   
            IF NOT cl_null(l_xmdc029) THEN
               IF l_ooac004 = 'N' THEN
                  CALL cl_set_comp_entry("xmdh013_02",FALSE)
               END IF   
               IF NOT cl_null(l_xmdc030) THEN
                  IF l_ooac004 = 'N' THEN
                     CALL cl_set_comp_entry("xmdh014_02",FALSE)
                  END IF   
               END IF
            END IF
         END IF
        #161006-00018#24-e-add          
         IF NOT cl_null(l_xmdc057) THEN
            CALL cl_set_comp_entry("xmdh029_02",FALSE)
         END IF
       
         CALL axmp540_01_get_imaf(g_xmdh_d[l_ac].xmdh006)     
           RETURNING l_imaf015,l_imaf061,l_imaf113,l_imaf055
           
         #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
         IF l_imaf061 NOT MATCHES '[13]' THEN
            LET g_xmdh_d[l_ac].xmdh014 = ' '
            CALL cl_set_comp_entry("xmdh014_02",FALSE)
         END IF      
         #[T:料件據點進銷存檔]未設參考單位，參考數量不允許輸入
         IF cl_null(l_imaf015) THEN
            CALL cl_set_comp_entry("xmdh019_02",FALSE)
         END IF
         #[T:料件據點進銷存檔]未設計價單位，計價數量不允許輸入
         #160309-00005#1 20160427 modify by ming -----(S) 
         #IF cl_null(l_imaf113) THEN
         #   CALL cl_set_comp_entry("xmdh011_02",FALSE)
         #END IF    
         #IF l_imaf055 = '2' THEN
         #   CALL cl_set_comp_entry("xmdh021_02",FALSE)
         #END IF 
         
         #上面兩個判斷寫反了 
         #imaf113=>銷售計價單位 
         #xmdh011=>多庫儲批出貨 
         
         #imaf055=>庫存管理特徵 
         #xmdh021=>計價數量 
         
         IF l_imaf055 = '2' THEN
            CALL cl_set_comp_entry("xmdh011_02",FALSE)
         END IF    
         
         IF cl_null(l_imaf113) THEN
            CALL cl_set_comp_entry("xmdh021_02",FALSE)
         END IF 
         #160309-00005#1 20160427 modify by ming -----(E) 

         LET l_inaa007 = ''
         SELECT inaa007 INTO l_inaa007
           FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = l_xmdcsite
            AND inaa001 = g_xmdh_d[l_ac].xmdh012
         #儲位控管若為5.不使用儲位控管，則不能維護儲位
         IF l_inaa007 = '5' THEN
            CALL cl_set_comp_entry("xmdh013_02",FALSE)
         END IF
         


END FUNCTION
################################################################################
# Descriptions...: 產生出通單頭檔
# Memo...........:
# Usage..........: CALL axmp520_02_ins_xmdg()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150717 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_ins_xmdg()
	  DEFINE  l_linkno       LIKE type_t.num5
	  DEFINE  l_no           LIKE type_t.num5
	  DEFINE  l_sql          STRING
	  DEFINE  l_ooef019      LIKE ooef_t.ooef019
	  DEFINE  l_cnt          LIKE type_t.num5
	  DEFINE  l_success      LIKE type_t.num5
	  DEFINE  l_oodbl004     LIKE oodbl_t.oodbl004  #稅別名稱
	  DEFINE  l_oodb005      LIKE oodb_t.oodb005    #含稅否
	  DEFINE  l_oodb006      LIKE oodb_t.oodb006    #稅率
	  DEFINE  l_oodb011      LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定
	  DEFINE  l_xmdg002      LIKE xmdg_t.xmdg002
	  DEFINE  l_xmdg003      LIKE xmdg_t.xmdg003
	  DEFINE  l_xmdk018      LIKE xmdk_t.xmdk018
	  DEFINE  l_pmaa027      LIKE pmaa_t.pmaa027 
	  DEFINE  l_errno        LIKE type_t.chr10          #錯誤訊息代碼   
	  DEFINE  l_xmdastus     LIKE xmda_t.xmdastus   #add--160706-00037#12 By shiun
	
	   WHENEVER ERROR CONTINUE  
	   
	   LET l_linkno = ''
	  SELECT MAX(linkno) INTO l_linkno
	    FROM p520_tmp01                       #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
	
	  
	  #獲得當前營運據點的所屬稅區
	  LET l_ooef019 = ''
	  SELECT ooef019 INTO l_ooef019
	    FROM ooef_t
	   WHERE ooefent = g_enterprise
	     AND ooef001 = g_site  
	     
	  LET l_sql = "SELECT xmdg001,xmdg005,xmdg006,xmdg007,xmdg008, ",
	              "       xmdg009,xmdg010,xmdg013,xmdg014,xmdg015, ",
	              "       xmdg017 ",
	              "  FROM p520_tmp01 ",        #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
	              " WHERE linkno = ? "             
	  PREPARE axmp520_02_xmdg_pre FROM l_sql  
	
	
	  FOR l_no = 1 TO l_linkno
	      INITIALIZE g_xmdg.* TO NULL
	      LET g_success = 'Y' 
	      LET g_result_str = ''
	      CALL s_transaction_begin()       
	      EXECUTE axmp520_02_xmdg_pre USING l_no
	                   INTO g_xmdg.xmdg001,g_xmdg.xmdg005,g_xmdg.xmdg006,g_xmdg.xmdg007,g_xmdg.xmdg008,
	                        g_xmdg.xmdg009,g_xmdg.xmdg010,g_xmdg.xmdg013,g_xmdg.xmdg014,g_xmdg.xmdg015,
	                        g_xmdg.xmdg017
	
	      #公用欄位給值
	      LET g_xmdg.xmdgownid = g_user
	      LET g_xmdg.xmdgowndp = g_grup
	      LET g_xmdg.xmdgcrtid = g_user
	      LET g_xmdg.xmdgcrtdp = g_grup
	      LET g_xmdg.xmdgcrtdt = cl_get_current()
	      LET g_xmdg.xmdgmodid = ''
	      LET g_xmdg.xmdgmoddt = ''
	      
	      #一般欄位給值
	      IF cl_null(g_xmdg.xmdg001) THEN
	         LET g_xmdg.xmdg001 = "1"                  #出貨性質
	      END IF
	      IF NOT cl_null(g_xmdg_m.xmdg002) THEN     #業務人員/業務部門
	         LET g_xmdg.xmdg002 = g_xmdg_m.xmdg002
	         SELECT ooag003 INTO g_xmdg.xmdg003
	           FROM ooag_t
	          WHERE ooagent = g_enterprise
	            AND ooag001 = g_xmdg.xmdg002         
	      END IF        
	      IF cl_null(g_xmdg_m.xmdgdocdt) THEN   #單據日期/出貨日期
	         LET g_xmdg.xmdgdocdt = g_today  
	         LET g_xmdg.xmdg022 = g_today                  
	      ELSE
	         LET g_xmdg.xmdgdocdt = g_xmdg_m.xmdgdocdt
	         LET g_xmdg.xmdg022 = g_xmdg_m.xmdgdocdt           
	      END IF         
	      LET g_xmdg.xmdg024 = "N"              #包裝單製作
	      LET g_xmdg.xmdg025 = "N"              #Invoice製作
	      LET g_xmdg.xmdg028 = g_xmdg.xmdg022   #預計出貨日期   
	      LET g_xmdg.xmdg054 = "N"              #多角貿易已拋轉
	      LET g_xmdg.xmdgent  = g_enterprise
	      LET g_xmdg.xmdgsite  = g_site
	      LET g_xmdg.xmdgstus = 'N'   
	
	      #訂單單號
	      LET l_cnt = 0
	      SELECT COUNT(DISTINCT(xmdh001)) INTO l_cnt
	        FROM p520_tmp02             #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
	       WHERE linkno = l_no
	      IF NOT cl_null(l_cnt) AND l_cnt = 1 THEN
	         SELECT DISTINCT xmdh001 INTO g_xmdg.xmdg004  #訂單單號 
	           FROM p520_tmp02          #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
	          WHERE linkno = l_no    
	         IF cl_null(g_xmdg.xmdg002) THEN
	            SELECT xmda002,xmda003 
	              INTO g_xmdg.xmdg002,g_xmdg.xmdg003
	              FROM xmda_t
	             WHERE xmdaent = g_enterprise
	               AND xmdadocno = g_xmdg.xmdg004               
	         END IF   
	         
	         #add--160706-00037#12 By shiun--(S)
            #檢查來源單據的狀態碼(例如可拋轉的單據狀態碼應該是Y.已確認)，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
            SELECT xmdastus INTO l_xmdastus
              FROM xmda_t
             WHERE xmdaent   = g_enterprise
               AND xmdadocno = g_xmdg.xmdg004
            IF l_xmdastus <> 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'apm-01119'
               LET g_errparam.popup  = TRUE
               LET g_errparam.replace[1] = g_xmdg.xmdg004
               CALL cl_err()
               CONTINUE FOR
            END IF
            #add--160706-00037#12 By shiun--(E)
            
	         #由訂單帶出出通單資料         
	         CALL axmp520_02_xmda_default(g_xmdg.xmdg004)
	      ELSE
	         #依客戶帶出取價方式、運輸方式、交運起點、交運終點、銷售通路、銷售分類、內外銷、取匯率方式、業務人員、業務部門    
	         LET g_xmdg.xmdg034 = "1"              #多角性質
	         CALL axmp540_02_xmdk007_default(g_xmdg.xmdg002,g_xmdg.xmdg003,g_xmdg.xmdg005)
	           RETURNING l_xmdg002,l_xmdg003,l_xmdk018,g_xmdg.xmdg018,g_xmdg.xmdg019,
	                     g_xmdg.xmdg020,g_xmdg.xmdg026,g_xmdg.xmdg027,g_xmdg.xmdg032,g_xmdg.xmdg033     
	         IF cl_null(g_xmdg.xmdg002) THEN
	            IF NOT cl_null(l_xmdg002) THEN
	               LET g_xmdg.xmdg002 = l_xmdg002
	               LET g_xmdg.xmdg003 = l_xmdg003         
	            ELSE
	               LET g_xmdg.xmdg002 = g_user
	               LET g_xmdg.xmdg003 = g_dept        
	            END IF
	         END IF
	         #收貨客戶
	         LET g_xmdg.xmdg202 = g_xmdg.xmdg005
	         #收貨地址
	         IF cl_null(g_xmdg.xmdg017) THEN
	            CALL s_axmt500_get_pmaa027(g_xmdg.xmdg007) RETURNING l_pmaa027
	             DECLARE axmp520_02_cs SCROLL CURSOR FOR
	              SELECT oofb019 FROM oofb_t
	               WHERE oofbent  = g_enterprise
	                 AND oofb002  = l_pmaa027
	         #       AND oofb008  = '6'
	                 AND oofbstus = 'Y'
	               ORDER BY oofb010 DESC
	             OPEN axmp520_02_cs
	             FETCH FIRST axmp520_02_cs INTO g_xmdg.xmdg017
	         END IF	         
	      END IF	     
	      #取得稅別、單價含稅否
	      CALL s_tax_chk(g_site,g_xmdg.xmdg010)
	        RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
	      LET g_xmdg.xmdg011 = l_oodb006
	      LET g_xmdg.xmdg012 = l_oodb005  
	      #取單號
#	      CALL s_aooi200_gen_docno(g_site,g_xmdg_m.xmdgdocno,g_today,'axmt520') RETURNING l_success,g_xmdg.xmdgdocno            #170111-00026#4 mark   
	      CALL s_aooi200_gen_docno(g_site,g_xmdg_m.xmdgdocno,g_xmdg.xmdgdocdt,'axmt520') RETURNING l_success,g_xmdg.xmdgdocno   #170111-00026#4 add
	      IF NOT l_success THEN
	         LET g_success = 'N'
	         LET l_errno = 'apm-00003'
	         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
	      END IF         
	      IF g_success = 'Y' THEN
	         #寫入單頭檔
	         INSERT INTO xmdg_t(xmdgent  ,xmdgsite ,xmdgdocno,
	                            xmdg001  ,xmdg002  ,xmdg003  ,xmdg004  ,xmdg005  ,
	                            xmdg006  ,xmdg007  ,xmdg008  ,xmdg009  ,xmdg010  ,
	                            xmdg011  ,xmdg012  ,xmdg013  ,xmdg014  ,xmdg015  ,
	                            xmdg016  ,xmdg017  ,xmdg018  ,xmdg019  ,xmdg020  , 
	                            xmdg021  ,xmdg022  ,xmdg023  ,xmdg024  ,xmdg025  ,
	                            xmdg026  ,xmdg027  ,xmdg028  ,xmdg032  ,xmdg033  ,
	                            #170106-00046#1-s-mod
#	                            xmdg034  ,xmdg054  ,xmdg055  ,xmdg202  ,
	                            xmdg034  ,xmdg054  ,xmdg055  ,xmdg056  ,xmdg202  ,
	                            #170106-00046#1-e-mod
	                            xmdgstus ,xmdgdocdt,xmdgownid,xmdgowndp,xmdgcrtid,
	                            xmdgcrtdp,xmdgcrtdt,xmdgmodid,xmdgmoddt)    
	              VALUES (g_xmdg.xmdgent  ,g_xmdg.xmdgsite ,g_xmdg.xmdgdocno,
	                      g_xmdg.xmdg001  ,g_xmdg.xmdg002  ,g_xmdg.xmdg003  ,g_xmdg.xmdg004  ,g_xmdg.xmdg005  ,
	                      g_xmdg.xmdg006  ,g_xmdg.xmdg007  ,g_xmdg.xmdg008  ,g_xmdg.xmdg009  ,g_xmdg.xmdg010  ,
	                      g_xmdg.xmdg011  ,g_xmdg.xmdg012  ,g_xmdg.xmdg013  ,g_xmdg.xmdg014  ,g_xmdg.xmdg015  ,
	                      g_xmdg.xmdg016  ,g_xmdg.xmdg017  ,g_xmdg.xmdg018  ,g_xmdg.xmdg019  ,g_xmdg.xmdg020  , 
	                      g_xmdg.xmdg021  ,g_xmdg.xmdg022  ,g_xmdg.xmdg023  ,g_xmdg.xmdg024  ,g_xmdg.xmdg025  ,
	                      g_xmdg.xmdg026  ,g_xmdg.xmdg027  ,g_xmdg.xmdg028  ,g_xmdg.xmdg032  ,g_xmdg.xmdg033  ,
	                      #170106-00046#1-s-mod
#	                      g_xmdg.xmdg034  ,g_xmdg.xmdg054  ,g_xmdg.xmdg055  ,g_xmdg.xmdg202  ,
	                      g_xmdg.xmdg034  ,g_xmdg.xmdg054  ,g_xmdg.xmdg055  ,g_xmdg.xmdg056  ,g_xmdg.xmdg202  ,
	                      #170106-00046#1-e-mod
	                      g_xmdg.xmdgstus ,g_xmdg.xmdgdocdt,g_xmdg.xmdgownid,g_xmdg.xmdgowndp,g_xmdg.xmdgcrtid,
	                      g_xmdg.xmdgcrtdp,g_xmdg.xmdgcrtdt,g_xmdg.xmdgmodid,g_xmdg.xmdgmoddt)       
	         
	         IF SQLCA.sqlcode THEN
	             LET l_errno = SQLCA.sqlcode
	             LET g_result_str = g_result_str,",INSERT INTO xmdg_t",cl_getmsg(l_errno,g_lang)
	             LET g_success = 'N'
	         END IF            
	      END IF	
         IF g_success = 'Y' THEN
            #寫入單身檔
             CALL axmp520_02_ins_xmdh(l_no,g_xmdg.xmdgdocno,g_xmdg.xmdg014,g_xmdg.xmdg015)               
         END IF

         IF g_success = 'Y' THEN
            CALL s_transaction_end('Y','0')
            LET g_result_str = cl_getmsg('apm-00538',g_lang)        #建立成功   
         ELSE
            CALL s_transaction_end('N','0')
            #因為執行失敗 所以不給予單號 
             LET g_xmdg.xmdgdocno = ''        
         END IF
         #寫入顯示結果是成功或錯誤訊息
         UPDATE p520_tmp01           #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
            SET xmdgdocno = g_xmdg.xmdgdocno,
                result = g_result_str
          WHERE linkno = l_no   	      
	  END FOR
END FUNCTION

################################################################################
# Descriptions...: 由訂單帶出單頭從預設值
# Memo...........:
# Usage..........: CALL axmp520_02_xmda_default(p_xmdadocno)
#                  RETURNING 
# Input parameter: p_xmdadocno    訂單單號
# Return code....: 
# Date & Author..: 20150720 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_xmda_default(p_xmdadocno)
DEFINE p_xmdadocno   LIKE xmda_t.xmdadocno
DEFINE l_xmda031     LIKE xmda_t.xmda031
DEFINE l_xmdg034     LIKE xmdg_t.xmdg034

   LET l_xmda031 = ''
   SELECT xmda031,   
          xmda005,xmda002,xmda003,xmda004,xmda021,xmda022,xmda009,xmda010,xmda011,xmda012,
          xmda013,xmda035,xmda015,xmda016,xmda036,xmda025,xmda020,xmda037,xmda038,xmda044,
          xmda023,xmda024,xmda032,xmda048,xmda049,xmda006,xmda050,xmda203
     INTO l_xmda031,  
          g_xmdg.xmdg001,g_xmdg.xmdg002,g_xmdg.xmdg003,g_xmdg.xmdg005,g_xmdg.xmdg006,
          g_xmdg.xmdg007,g_xmdg.xmdg008,g_xmdg.xmdg009,g_xmdg.xmdg010,g_xmdg.xmdg011,
          g_xmdg.xmdg012,g_xmdg.xmdg013,g_xmdg.xmdg014,g_xmdg.xmdg015,g_xmdg.xmdg016,
          g_xmdg.xmdg017,g_xmdg.xmdg018,g_xmdg.xmdg019,g_xmdg.xmdg020,g_xmdg.xmdg023,
          g_xmdg.xmdg026,g_xmdg.xmdg027,g_xmdg.xmdg031,g_xmdg.xmdg032,g_xmdg.xmdg033,
          g_xmdg.xmdg034,g_xmdg.xmdg056,g_xmdg.xmdg202
     FROM xmda_t
    WHERE xmdaent = g_enterprise
      AND xmdadocno = p_xmdadocno


   #多角處理
   IF NOT cl_null(g_xmdg.xmdg056) THEN
      #改抓發起站之多角性質
      LET l_xmdg034 = ''
      SELECT xmda006 INTO l_xmdg034
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmda031 = l_xmda031
         AND xmdasite = (SELECT icab003
                           FROM icab_t
                          WHERE icabent = g_enterprise
                            AND icab001 = g_xmdg.xmdg056
                            AND icab002 = 0)

      IF cl_null(l_xmdg034) THEN
         LET l_xmdg034 = '7'   #7:代採購出貨
      END IF
      LET g_xmdg.xmdg034 = l_xmdg034
   END IF

END FUNCTION

################################################################################
# Descriptions...: 寫入出通單單身檔
# Memo...........:
# Usage..........: CALL axmp520_02_ins_xmdh(p_linkno,p_xmdgdocno,p_xmdg014,p_xmdg015)
#                  RETURNING 
# Input parameter: p_linkno
#                : p_xmdgdocno    出通單單號
#                : p_xmdg014      幣別
#                : p_xmdg015      匯率
# Return code....: 
# Date & Author..: 20150720 By Polly
# Modify.........: 161103-00046#1 2016/11/07 By 06948 產生出通單時，應依據參數D-BAS-0094判斷合格量
################################################################################
PRIVATE FUNCTION axmp520_02_ins_xmdh(p_linkno,p_xmdgdocno,p_xmdg014,p_xmdg015)
   DEFINE p_linkno      LIKE type_t.num10
   DEFINE p_xmdgdocno   LIKE xmdg_t.xmdgdocno
   DEFINE p_xmdg014     LIKE xmdg_t.xmdg014
   DEFINE p_xmdg015     LIKE xmdg_t.xmdg015
   DEFINE l_sql         STRING
   #mod--161109-00085#10-s
   #DEFINE l_xmdh        RECORD LIKE xmdh_t.*
   DEFINE l_xmdh RECORD  #出通單單身明細檔
       xmdhent LIKE xmdh_t.xmdhent, #企業編號
       xmdhsite LIKE xmdh_t.xmdhsite, #營運據點
       xmdhunit LIKE xmdh_t.xmdhunit, #發貨組織
       xmdhdocno LIKE xmdh_t.xmdhdocno, #單據編號
       xmdhseq LIKE xmdh_t.xmdhseq, #項次
       xmdh001 LIKE xmdh_t.xmdh001, #訂單單號
       xmdh002 LIKE xmdh_t.xmdh002, #訂單項次
       xmdh003 LIKE xmdh_t.xmdh003, #訂單項序
       xmdh004 LIKE xmdh_t.xmdh004, #訂單分批序
       xmdh005 LIKE xmdh_t.xmdh005, #子件特性
       xmdh006 LIKE xmdh_t.xmdh006, #料件編號
       xmdh007 LIKE xmdh_t.xmdh007, #產品特徵
       xmdh008 LIKE xmdh_t.xmdh008, #包裝容器
       xmdh009 LIKE xmdh_t.xmdh009, #作業編號
       xmdh010 LIKE xmdh_t.xmdh010, #製程式
       xmdh011 LIKE xmdh_t.xmdh011, #多庫儲批出貨
       xmdh012 LIKE xmdh_t.xmdh012, #限定庫位
       xmdh013 LIKE xmdh_t.xmdh013, #限定儲位
       xmdh014 LIKE xmdh_t.xmdh014, #限定批號
       xmdh015 LIKE xmdh_t.xmdh015, #出貨單位
       xmdh016 LIKE xmdh_t.xmdh016, #申請出通數量
       xmdh017 LIKE xmdh_t.xmdh017, #實際出通數量
       xmdh018 LIKE xmdh_t.xmdh018, #參考單位
       xmdh019 LIKE xmdh_t.xmdh019, #參考數量
       xmdh020 LIKE xmdh_t.xmdh020, #計價單位
       xmdh021 LIKE xmdh_t.xmdh021, #計價數量
       xmdh022 LIKE xmdh_t.xmdh022, #檢驗否
       xmdh023 LIKE xmdh_t.xmdh023, #單價
       xmdh024 LIKE xmdh_t.xmdh024, #稅別
       xmdh025 LIKE xmdh_t.xmdh025, #稅率
       xmdh026 LIKE xmdh_t.xmdh026, #未稅金額
       xmdh027 LIKE xmdh_t.xmdh027, #含稅金額
       xmdh028 LIKE xmdh_t.xmdh028, #稅額
       xmdh029 LIKE xmdh_t.xmdh029, #庫存管理特徵
       xmdh030 LIKE xmdh_t.xmdh030, #已轉出貨數量
       xmdh031 LIKE xmdh_t.xmdh031, #專案編號
       xmdh032 LIKE xmdh_t.xmdh032, #WBS編號
       xmdh033 LIKE xmdh_t.xmdh033, #活動編號
       xmdh034 LIKE xmdh_t.xmdh034, #客戶料號
       xmdh035 LIKE xmdh_t.xmdh035, #QPA
       xmdh036 LIKE xmdh_t.xmdh036, #保稅
       xmdh050 LIKE xmdh_t.xmdh050, #備註
       xmdh051 LIKE xmdh_t.xmdh051, #多角流程編號
       xmdh052 LIKE xmdh_t.xmdh052, #多角流程式號
       xmdh200 LIKE xmdh_t.xmdh200, #促銷方案
       xmdh201 LIKE xmdh_t.xmdh201, #商品條碼
       xmdh202 LIKE xmdh_t.xmdh202, #出貨包裝單位
       xmdh203 LIKE xmdh_t.xmdh203, #申請出通包裝數量
       xmdh204 LIKE xmdh_t.xmdh204, #實際出通包裝數量
       xmdh207 LIKE xmdh_t.xmdh207, #標準價
       xmdh208 LIKE xmdh_t.xmdh208, #促銷價
       xmdh209 LIKE xmdh_t.xmdh209, #交易價
       xmdh210 LIKE xmdh_t.xmdh210, #折價金額
       xmdh211 LIKE xmdh_t.xmdh211, #收貨網點
       xmdh212 LIKE xmdh_t.xmdh212, #送貨客戶
       xmdh213 LIKE xmdh_t.xmdh213, #送貨地址碼
       xmdh214 LIKE xmdh_t.xmdh214, #送貨站點
       xmdh215 LIKE xmdh_t.xmdh215, #送貨時段
       xmdh216 LIKE xmdh_t.xmdh216, #庫存鎖定等級
       xmdh217 LIKE xmdh_t.xmdh217, #銷售通路
       xmdh218 LIKE xmdh_t.xmdh218, #產品組編號
       xmdh219 LIKE xmdh_t.xmdh219, #銷售範圍編號
       xmdh220 LIKE xmdh_t.xmdh220, #交易類型
       xmdh221 LIKE xmdh_t.xmdh221, #地區編號
       xmdh222 LIKE xmdh_t.xmdh222, #縣市編號
       xmdh223 LIKE xmdh_t.xmdh223, #省區編號
       xmdh224 LIKE xmdh_t.xmdh224, #區域編號
       xmdh056 LIKE xmdh_t.xmdh056  #檢驗合格量
END RECORD
   #mod--161109-00085#10-e   
   DEFINE l_success    LIKE type_t.num5         #161103-00046#1 add
   DEFINE l_slip       LIKE ooba_t.ooba002      #161103-00046#1 add
   
   LET l_sql = " SELECT linkseq,xmdhunit,                         ",
               "        xmdh001, xmdh002,xmdh003,xmdh004,xmdh005, ",
               "        xmdh006, xmdh007,xmdh008,xmdh009,xmdh010, ",
               "        xmdh011, xmdh012,xmdh013,xmdh014,xmdh015, ",
               "        xmdh016, xmdh017,xmdh018,xmdh019,xmdh020, ",
               "        xmdh021, xmdh022,xmdh023,xmdh024,xmdh025, ",
               "        xmdh026, xmdh027,xmdh028,xmdh029,xmdh030, ",
               "        xmdh031, xmdh032,xmdh033,xmdh034,xmdh035, ",
               "        xmdh036, xmdh050,xmdh051,xmdh056 ",
               "     FROM p520_tmp02 ",           #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
               "    WHERE linkno = '",p_linkno,"' ",
               "    ORDER BY linkno "      

   PREPARE p520_02_xmdh_pr FROM l_sql
   DECLARE p520_02_xmdh_cs CURSOR FOR p520_02_xmdh_pr
   
   FOREACH p520_02_xmdh_cs INTO l_xmdh.xmdhseq,l_xmdh.xmdhunit,
                                l_xmdh.xmdh001,l_xmdh.xmdh002 ,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh005,
                                l_xmdh.xmdh006,l_xmdh.xmdh007 ,l_xmdh.xmdh008,l_xmdh.xmdh009,l_xmdh.xmdh010,
                                l_xmdh.xmdh011,l_xmdh.xmdh012 ,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,
                                l_xmdh.xmdh016,l_xmdh.xmdh017 ,l_xmdh.xmdh018,l_xmdh.xmdh019,l_xmdh.xmdh020,
                                l_xmdh.xmdh021,l_xmdh.xmdh022 ,l_xmdh.xmdh023,l_xmdh.xmdh024,l_xmdh.xmdh025,
                                l_xmdh.xmdh026,l_xmdh.xmdh027 ,l_xmdh.xmdh028,l_xmdh.xmdh029,l_xmdh.xmdh030,
                                l_xmdh.xmdh031,l_xmdh.xmdh032 ,l_xmdh.xmdh033,l_xmdh.xmdh034,l_xmdh.xmdh035,
                                l_xmdh.xmdh036,l_xmdh.xmdh050 ,l_xmdh.xmdh051,l_xmdh.xmdh056 
       LET l_xmdh.xmdhdocno = p_xmdgdocno      #給予真正的單號
       LET l_xmdh.xmdhent = g_enterprise
       LET l_xmdh.xmdhsite = g_site
       #稅額計算
       CALL s_axmt500_get_amount(l_xmdh.xmdhdocno,l_xmdh.xmdhseq,l_xmdh.xmdh021,l_xmdh.xmdh023,l_xmdh.xmdh024,p_xmdg014,p_xmdg015)
         RETURNING l_xmdh.xmdh026,l_xmdh.xmdh027,l_xmdh.xmdh028  
      #161103-00046#1 --- mark (S)
      ##160805-00054#1--(S)
      #IF l_xmdh.xmdh022 = 'N' THEN
      #  LET l_xmdh.xmdh056 = l_xmdh.xmdh017
      #END IF
      ##160805-00054#1--(E)
      #161103-00046#1 --- mark (E)
       #161103-00046#1 --- add (S)
       #預設檢驗合格量
       IF l_xmdh.xmdh022 = 'Y' AND NOT cl_null(l_xmdh.xmdh001) THEN
          #單據別參數
          CALL s_aooi200_get_slip(l_xmdh.xmdh001) RETURNING l_success,l_slip
          IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094') = '1' THEN   #OQC檢驗時機為"1出貨通知時檢驗"
             LET l_xmdh.xmdh056 = 0
          ELSE
             LET l_xmdh.xmdh056 = l_xmdh.xmdh017
          END IF
       ELSE
          LET l_xmdh.xmdh056 = l_xmdh.xmdh017
       END IF
       #161103-00046#1 --- add (E)       
       LET l_xmdh.xmdh016 = l_xmdh.xmdh017   #161101-00013#1 add  #若有調整出通量,則出通單的申請出通量應與實際出通量相同
       INSERT INTO xmdh_t(xmdhent,xmdhsite,xmdhdocno,xmdhseq,xmdhunit,
                          xmdh001,xmdh002 ,xmdh003,xmdh004,xmdh005,
                          xmdh006,xmdh007 ,xmdh008,xmdh009,xmdh010,
                          xmdh011,xmdh012 ,xmdh013,xmdh014,xmdh015,
                          xmdh016,xmdh017 ,xmdh018,xmdh019,xmdh020,
                          xmdh021,xmdh022 ,xmdh023,xmdh024,xmdh025,
                          xmdh026,xmdh027 ,xmdh028,xmdh029,xmdh030,
                          xmdh031,xmdh032 ,xmdh033,xmdh034,xmdh035,
                          xmdh036,xmdh050 ,xmdh051,xmdh056 )
           VALUES (l_xmdh.xmdhent,l_xmdh.xmdhsite,l_xmdh.xmdhdocno,l_xmdh.xmdhseq,l_xmdh.xmdhunit,
                   l_xmdh.xmdh001,l_xmdh.xmdh002 ,l_xmdh.xmdh003  ,l_xmdh.xmdh004,l_xmdh.xmdh005 ,
                   l_xmdh.xmdh006,l_xmdh.xmdh007 ,l_xmdh.xmdh008  ,l_xmdh.xmdh009,l_xmdh.xmdh010 ,
                   l_xmdh.xmdh011,l_xmdh.xmdh012 ,l_xmdh.xmdh013  ,l_xmdh.xmdh014,l_xmdh.xmdh015 ,
                   l_xmdh.xmdh016,l_xmdh.xmdh017 ,l_xmdh.xmdh018  ,l_xmdh.xmdh019,l_xmdh.xmdh020 ,
                   l_xmdh.xmdh021,l_xmdh.xmdh022 ,l_xmdh.xmdh023  ,l_xmdh.xmdh024,l_xmdh.xmdh025 ,
                   l_xmdh.xmdh026,l_xmdh.xmdh027 ,l_xmdh.xmdh028  ,l_xmdh.xmdh029,l_xmdh.xmdh030 ,
                   l_xmdh.xmdh031,l_xmdh.xmdh032 ,l_xmdh.xmdh033  ,l_xmdh.xmdh034,l_xmdh.xmdh035 ,
                   l_xmdh.xmdh036,l_xmdh.xmdh050 ,l_xmdh.xmdh051  ,l_xmdh.xmdh056) 
       IF SQLCA.sqlcode THEN
          LET g_result_str = g_result_str,",INSERT INTO xmdh_t",cl_getmsg(SQLCA.sqlcode,g_lang)
          LET g_success = 'N'         
       END IF
       IF g_success = 'Y' THEN
          #更新訂單已出通量
          CALL axmp520_02_upd_xmdd031(l_xmdh.xmdh001,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh016) 
       END IF
       IF g_success = 'Y' THEN
          #寫入多庫儲批  
          CALL axmp520_02_ins_xmdi(p_linkno,l_xmdh.xmdhseq,l_xmdh.xmdhdocno)  
       END IF
   END FOREACH                             

END FUNCTION

################################################################################
# Descriptions...: 寫入多庫儲批
# Memo...........:
# Usage..........: CALL axmp520_02_ins_xmdi(p_linkno,p_linkseq,p_xmdgdocno)
#                  RETURNING 
# Input parameter: p_linkno
#                : p_linkseq
#                : p_xmdgdocno
# Return code....: 
# Date & Author..: 20150721 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_ins_xmdi(p_linkno,p_linkseq,p_xmdgdocno)
   DEFINE p_linkno      LIKE type_t.num10
   DEFINE p_linkseq     LIKE xmdh_t.xmdhseq
   DEFINE p_xmdgdocno   LIKE xmdg_t.xmdgdocno
   #mod--161109-00085#10-s
   #DEFINE l_xmdi        RECORD LIKE xmdi_t.*
   DEFINE l_xmdi RECORD  #出通單多庫儲批出貨明細檔
       xmdient LIKE xmdi_t.xmdient, #企業編號
       xmdisite LIKE xmdi_t.xmdisite, #營運據點
       xmdidocno LIKE xmdi_t.xmdidocno, #出通單號
       xmdiseq LIKE xmdi_t.xmdiseq, #項次
       xmdiseq1 LIKE xmdi_t.xmdiseq1, #項序
       xmdi001 LIKE xmdi_t.xmdi001, #料件編號
       xmdi002 LIKE xmdi_t.xmdi002, #產品特徵
       xmdi003 LIKE xmdi_t.xmdi003, #作業編號
       xmdi004 LIKE xmdi_t.xmdi004, #製程式
       xmdi005 LIKE xmdi_t.xmdi005, #限定庫位
       xmdi006 LIKE xmdi_t.xmdi006, #限定儲位
       xmdi007 LIKE xmdi_t.xmdi007, #限定批號
       xmdi008 LIKE xmdi_t.xmdi008, #單位
       xmdi009 LIKE xmdi_t.xmdi009, #出貨數量
       xmdi010 LIKE xmdi_t.xmdi010, #參考單位
       xmdi011 LIKE xmdi_t.xmdi011, #參考數量
       xmdi012 LIKE xmdi_t.xmdi012, #已轉出貨量
       xmdi013 LIKE xmdi_t.xmdi013  #庫存管理特徵
END RECORD
   #mod--161109-00085#10-e   
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num20_6  #20150914--xianghui
   
   LET l_sql = "SELECT xmdiseq,xmdiseq1, ",
               "       xmdi001,xmdi002,xmdi003,xmdi004,xmdi005, ",
               "       xmdi006,xmdi007,xmdi008,xmdi009,xmdi010, ",
               "       xmdi011,xmdi012,xmdi013 ",
               "  FROM p520_tmp03 ",            #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
               " WHERE linkno = '",p_linkno,"' ",
               "   AND xmdiseq = '",p_linkseq,"' ",
               "    ORDER BY xmdiseq,xmdiseq1 "       
   
   PREPARE p520_02_xmdi_pr FROM l_sql
   DECLARE p520_02_xmdi_cs CURSOR FOR p520_02_xmdi_pr

   FOREACH p520_02_xmdi_cs INTO l_xmdi.xmdiseq,l_xmdi.xmdiseq1,
                                l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi003,l_xmdi.xmdi004,l_xmdi.xmdi005,
                                l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008,l_xmdi.xmdi009,l_xmdi.xmdi010,
                                l_xmdi.xmdi011,l_xmdi.xmdi012,l_xmdi.xmdi013 
       
       LET l_xmdi.xmdidocno = p_xmdgdocno
       LET l_xmdi.xmdient = g_enterprise
       LET l_xmdi.xmdisite = g_site    

       INSERT INTO xmdi_t(xmdient,xmdisite,xmdidocno,xmdiseq,xmdiseq1,
                          xmdi001,xmdi002 ,xmdi003,xmdi004,xmdi005,
                          xmdi006,xmdi007 ,xmdi008,xmdi009,xmdi010,
                          xmdi011,xmdi012 ,xmdi013)
           VALUES (l_xmdi.xmdient,l_xmdi.xmdisite,l_xmdi.xmdidocno,l_xmdi.xmdiseq,l_xmdi.xmdiseq1,
                   l_xmdi.xmdi001,l_xmdi.xmdi002 ,l_xmdi.xmdi003  ,l_xmdi.xmdi004,l_xmdi.xmdi005 ,
                   l_xmdi.xmdi006,l_xmdi.xmdi007 ,l_xmdi.xmdi008  ,l_xmdi.xmdi009,l_xmdi.xmdi010 ,
                   l_xmdi.xmdi011,l_xmdi.xmdi012 ,l_xmdi.xmdi013  )
       IF SQLCA.sqlcode THEN
          LET g_result_str = g_result_str,",INSERT INTO xmdi_t",cl_getmsg(SQLCA.sqlcode,g_lang)
          LET g_success = 'N'         
       END IF
      #20150914--xianghui--add--b
      IF g_success = 'Y' THEN 
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0048') = 'Y' THEN 
            IF NOT cl_null(l_xmdi.xmdi005) THEN 
               IF cl_null(l_xmdi.xmdi006) THEN LET l_xmdi.xmdi006 = ' ' END IF
               IF cl_null(l_xmdi.xmdi007) THEN LET l_xmdi.xmdi007 = ' ' END IF
               SELECT COUNT(*) INTO l_cnt 
                 FROM inai_t
                WHERE inaient = l_xmdi.xmdient
                  AND inaisite = l_xmdi.xmdisite
                  AND inai001 = l_xmdi.xmdi001
                  AND inai002 = l_xmdi.xmdi002
                  AND inai003 = l_xmdi.xmdi013  
                  AND inai004 = l_xmdi.xmdi005
                  AND inai005 = l_xmdi.xmdi006
                  AND inai006 = l_xmdi.xmdi007
               IF l_cnt > 0 THEN 
                  CALL s_lot_auto_sel('1',l_xmdi.xmdidocno,l_xmdi.xmdiseq,l_xmdi.xmdiseq1,l_xmdi.xmdi009,
                                      '-1','axmt520','','')
                       RETURNING g_success
               END IF
            END IF
         END IF               
      END IF
      #20150914--xianghui--add--e                 
   END FOREACH

END FUNCTION
################################################################################
# Descriptions...: 取得未稅金額、含稅金額、稅額
# Memo...........:
# Usage..........: CALL axmp520_02_get_amount(p_linkno,p_xmdh017,p_xmdh023,p_xmdh024)
# Input parameter:  p_linkno
#                :  p_xmdh021    計價數量
#                :  p_xmdh023    單價
#                :  p_xmdh024    稅別
# Return code....:  r_xmdh026    未稅金額
#                :  r_xmdh027    含稅金額
#                :  r_xmdh028    稅額
# Date & Author..: 2015/07/22 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_get_amount(p_linkno,p_xmdh021,p_xmdh023,p_xmdh024)
DEFINE p_linkno          LIKE type_t.num10      #暫時單號
DEFINE p_xmdh021         LIKE xmdh_t.xmdh021
DEFINE p_xmdh023         LIKE xmdh_t.xmdh023
DEFINE p_xmdh024         LIKE xmdh_t.xmdh024
DEFINE r_xmdh026         LIKE xmdh_t.xmdh026
DEFINE r_xmdh027         LIKE xmdh_t.xmdh027
DEFINE r_xmdh028         LIKE xmdh_t.xmdh028
DEFINE l_money           LIKE xrcd_t.xrcd113
DEFINE l_xmdg014         LIKE xmdg_t.xmdg014    #幣別
DEFINE l_xmdg015         LIKE xmdg_t.xmdg015    #匯率
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115

   LET r_xmdh026 = 0
   LET r_xmdh027 = 0
   LET r_xmdh028 = 0

   IF cl_null(p_linkno) OR cl_null(p_xmdh021) OR cl_null(p_xmdh023) OR cl_null(p_xmdh024) THEN
      RETURN r_xmdh026,r_xmdh027,r_xmdh028
   END IF

   #抓取幣別、匯率
   SELECT xmdg014,xmdg015 INTO l_xmdg014,l_xmdg015
     FROM p520_tmp01             #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01
    WHERE linkno = p_linkno
   
   LET l_money = 0
   LET l_money = p_xmdh021 * p_xmdh023

   CALL s_tax_count(g_site,p_xmdh024,l_money,p_xmdh021,l_xmdg014,l_xmdg015)
     RETURNING r_xmdh026,r_xmdh028,r_xmdh027,l_xrcd113,l_xrcd114,l_xrcd115

   IF cl_null(r_xmdh026) THEN LET r_xmdh026 = 0 END IF
   IF cl_null(r_xmdh027) THEN LET r_xmdh027 = 0 END IF
   IF cl_null(r_xmdh028) THEN LET r_xmdh028 = 0 END IF

   RETURN r_xmdh026,r_xmdh027,r_xmdh028

END FUNCTION
#單身多庫儲批顯示
PRIVATE FUNCTION axmp520_02_fetch_xmdi()
  DEFINE l_sql     STRING
  DEFINE l_ac_t    LIKE type_t.num10         #170104-00066#3 num5->num10  17/01/06 mod by rainy 

    #多庫儲批明細
    INITIALIZE g_xmdi_d TO NULL
    IF cl_null(g_detail2_02_idx) OR g_detail2_02_idx = 0 THEN
       LET g_detail2_02_idx = 1
    END IF
    LET l_sql = "SELECT xmdiseq,xmdiseq1,                        ",
                "       xmdi001,xmdi002,xmdi003,xmdi004,xmdi005, ",
                "       xmdi006,xmdi007,xmdi008,xmdi009,xmdi010, ",
#                "       xmdi011,xmdi013                          ",   #161205-00025#14 mark
                #161205-00025#14-s-add
                "       xmdi011,xmdi013,                          ",
                "(SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = xmdi001 AND imaal002 = '",g_dlang,"'), ",
                "(SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = xmdi001 AND imaal002 = '",g_dlang,"'), ",
                "(SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = xmdi001 AND inaml002 = xmdi002 AND inaml003 = '",g_dlang,"'), ",
                "(SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '221' AND oocql002 = xmdi003 AND oocql003 = '",g_dlang,"'), ",
                "(SELECT oocal004 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = xmdi008 AND oocal002 = '",g_dlang,"'), ",
                "(SELECT oocal004 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = xmdi010 AND oocal002 = '",g_dlang,"'), ",
                "(SELECT inayl003 FROM inayl_t WHERE inaylent = ",g_enterprise," AND inayl001 = xmdi005 AND inayl002 = '",g_dlang,"'), ",
                "(SELECT inab003 FROM inab_t WHERE inabent = ",g_enterprise," AND inabsite = '",g_site,"' AND inab001 = xmdi005 AND inab002 = xmdi006) ",
                #161205-00025#14-e-add
                "  FROM p520_tmp03 ",           #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
                " WHERE linkno = '",g_xmdh_d[g_detail2_02_idx].linkno,"'" ,
#                "   AND xmdiseq = '",g_xmdh_d[g_detail2_02_idx].linkseq,"'" ,  #160804-00073 by whitney mark
                " ORDER BY xmdiseq,xmdiseq1 "  
    PREPARE axmp520_sel_xmdi_pr FROM l_sql
    DECLARE axmp520_sel_xmdi_cs CURSOR FOR axmp520_sel_xmdi_pr
    LET l_ac_t = l_ac
    LET l_ac = 1               
    CALL g_xmdi_d.clear()
    FOREACH axmp520_sel_xmdi_cs INTO g_xmdi_d[l_ac].xmdiseq,g_xmdi_d[l_ac].xmdiseq1,
                                     g_xmdi_d[l_ac].xmdi001,g_xmdi_d[l_ac].xmdi002,g_xmdi_d[l_ac].xmdi003,g_xmdi_d[l_ac].xmdi004,g_xmdi_d[l_ac].xmdi005,
                                     g_xmdi_d[l_ac].xmdi006,g_xmdi_d[l_ac].xmdi007,g_xmdi_d[l_ac].xmdi008,g_xmdi_d[l_ac].xmdi009,g_xmdi_d[l_ac].xmdi010,
                                     g_xmdi_d[l_ac].xmdi011,g_xmdi_d[l_ac].xmdi013
                                     #161205-00025#14-s-add
                                    ,g_xmdi_d[l_ac].imaal003_3,g_xmdi_d[l_ac].imaal004_3,g_xmdi_d[l_ac].xmdi002_desc,g_xmdi_d[l_ac].xmdi003_desc,
                                     g_xmdi_d[l_ac].xmdi008_desc,g_xmdi_d[l_ac].xmdi010_desc,g_xmdi_d[l_ac].xmdi005_desc,g_xmdi_d[l_ac].xmdi006_desc
                                     #161205-00025#14-e-add
#       CALL axmp520_02_detail_show("'3'")
    
       LET l_ac = l_ac + 1
    END FOREACH
    CALL g_xmdi_d.deleteElement(l_ac)
    LET l_ac = l_ac_t
    LET g_detail3_02_cnt = l_ac - 1
    CLOSE axmp520_sel_xmdi_cs
    FREE axmp520_sel_xmdi_pr
END FUNCTION

################################################################################
# Descriptions...: 多庫儲批資料修改及新增
# Memo...........:
# Usage..........: CALL axmp520_02_modify_xmdi(p_linkno,p_linkseq,p_xmdh006,p_xmdh007,p_xmdh009,p_xmdh010,p_xmdh012,
#                                              p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdh018,p_xmdh019)
#                  RETURNING r_success
# Input parameter:  p_linkno                 
#                   p_linkseq                
#                   p_xmdh006    料件編號    
#                   p_xmdh007    產品特徵    
#                   p_xmdh009    作業編號    
#                   p_xmdh010    制程序      
#                   p_xmdh012    限定庫位    
#                   p_xmdh013    限定儲位    
#                   p_xmdh014    限定批號
#                   p_xmdh029    庫存管理特徵    
#                   p_xmdh015    出貨單位    
#                   p_xmdh017    實際出通數量
#                   p_xmdh018    參考單位    
#                   p_xmdh019    參考數量    
# Return code....:  r_success    TRUE/FALSE
# Date & Author..: 20150722 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_modify_xmdi(p_linkno,p_linkseq,p_xmdh006,p_xmdh007,p_xmdh009,p_xmdh010,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdh018,p_xmdh019)
    DEFINE p_linkno    LIKE type_t.num5                                       
    DEFINE p_linkseq   LIKE xmdh_t.xmdhseq                        
    DEFINE p_xmdh006   LIKE xmdh_t.xmdh006           #料件編號    
    DEFINE p_xmdh007   LIKE xmdh_t.xmdh007           #產品特徵    
    DEFINE p_xmdh009   LIKE xmdh_t.xmdh009           #作業編號    
    DEFINE p_xmdh010   LIKE xmdh_t.xmdh010           #制程序      
    DEFINE p_xmdh012   LIKE xmdh_t.xmdh012           #限定庫位    
    DEFINE p_xmdh013   LIKE xmdh_t.xmdh013           #限定儲位    
    DEFINE p_xmdh014   LIKE xmdh_t.xmdh014           #限定批號 
    DEFINE p_xmdh029   LIKE xmdh_t.xmdh029           #庫存管理特徵    
    DEFINE p_xmdh015   LIKE xmdh_t.xmdh015           #出貨單位    
    DEFINE p_xmdh017   LIKE xmdh_t.xmdh017           #實際出通數量
    DEFINE p_xmdh018   LIKE xmdh_t.xmdh018           #參考單位    
    DEFINE p_xmdh019   LIKE xmdh_t.xmdh019           #參考數量  
    DEFINE l_cnt       LIKE type_t.num5
    DEFINE r_success   LIKE type_t.num5  
    
	   WHENEVER ERROR CONTINUE  
	   
	   LET r_success = TRUE 
	   
	   LET l_cnt = 0
	   SELECT COUNT(*) INTO l_cnt
	     FROM p520_tmp03         #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
	    WHERE linkno = p_linkno
	      AND xmdiseq = p_linkseq
	   IF cl_null(l_cnt) OR l_cnt = 0 THEN
         IF NOT axmp520_02_insert_xmdi(p_linkno,p_linkseq,p_xmdh006,p_xmdh007,p_xmdh009,
                                       p_xmdh010,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,
                                       p_xmdh015,p_xmdh017,p_xmdh018,p_xmdh019) THEN
            LET r_success = FALSE  
            RETURN r_success            
         END IF   
	   ELSE
	      UPDATE p520_tmp03       #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
	         SET xmdi005 = p_xmdh012,
                xmdi006 = p_xmdh013,
                xmdi007 = p_xmdh014,
                xmdi013 = p_xmdh029,     
                xmdi009 = p_xmdh017,
                xmdi011 = p_xmdh019
          WHERE linkno = p_linkno
            AND xmdiseq = p_linkseq
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "UPDATE p520_tmp03"           #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
             LET g_errparam.popup = TRUE
             CALL cl_err()           
             LET r_success = FALSE
             RETURN r_success
          END IF                
	   END IF
      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 多庫儲批資料新增
# Memo...........:
# Usage..........: CALL axmp520_02_insert_xmdi(p_linkno,p_linkseq,p_xmdh006,p_xmdh007,p_xmdh009,p_xmdh010,p_xmdh012,
#                                              p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdh018,p_xmdh019)
#                  RETURNING  r_success
# Input parameter:  p_linkno                 
#                   p_linkseq                
#                   p_xmdh006    料件編號    
#                   p_xmdh007    產品特徵    
#                   p_xmdh009    作業編號    
#                   p_xmdh010    制程序      
#                   p_xmdh012    限定庫位    
#                   p_xmdh013    限定儲位    
#                   p_xmdh014    限定批號
#                   p_xmdh029    庫存管理特徵    
#                   p_xmdh015    出貨單位    
#                   p_xmdh017    實際出通數量
#                   p_xmdh018    參考單位    
#                   p_xmdh019    參考數量    
# Return code....:  r_success    TRUE/FALSE
# Date & Author..: 20150722 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_insert_xmdi(p_linkno,p_linkseq,p_xmdh006,p_xmdh007,p_xmdh009,p_xmdh010,p_xmdh012,p_xmdh013,p_xmdh014,p_xmdh029,p_xmdh015,p_xmdh017,p_xmdh018,p_xmdh019)
    DEFINE p_linkno    LIKE type_t.num5                                       
    DEFINE p_linkseq   LIKE xmdh_t.xmdhseq                        
    DEFINE p_xmdh006   LIKE xmdh_t.xmdh006           #料件編號    
    DEFINE p_xmdh007   LIKE xmdh_t.xmdh007           #產品特徵    
    DEFINE p_xmdh009   LIKE xmdh_t.xmdh009           #作業編號    
    DEFINE p_xmdh010   LIKE xmdh_t.xmdh010           #制程序      
    DEFINE p_xmdh012   LIKE xmdh_t.xmdh012           #限定庫位    
    DEFINE p_xmdh013   LIKE xmdh_t.xmdh013           #限定儲位    
    DEFINE p_xmdh014   LIKE xmdh_t.xmdh014           #限定批號 
    DEFINE p_xmdh029   LIKE xmdh_t.xmdh029           #庫存管理特徵    
    DEFINE p_xmdh015   LIKE xmdh_t.xmdh015           #出貨單位    
    DEFINE p_xmdh017   LIKE xmdh_t.xmdh017           #實際出通數量
    DEFINE p_xmdh018   LIKE xmdh_t.xmdh018           #參考單位    
    DEFINE p_xmdh019   LIKE xmdh_t.xmdh019           #參考數量    
    DEFINE r_success   LIKE type_t.num5  

   LET r_success = TRUE
   #庫位不為空才產生一筆多庫儲批資料   
 
      INSERT INTO p520_tmp03(linkno,xmdiseq,xmdiseq1,             #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
                                    xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,
                                    xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,
                                    xmdi011,xmdi012,xmdi013)
          VALUES(p_linkno,p_linkseq,1,
                 p_xmdh006,p_xmdh007,p_xmdh009,p_xmdh010,p_xmdh012,
                 p_xmdh013,p_xmdh014,p_xmdh015,p_xmdh017,p_xmdh018,
                 p_xmdh019,0,p_xmdh029)  
                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT p520_tmp03"              #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()    
         LET r_success = FALSE
         RETURN r_success
      END IF  
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 刪除多庫儲批出貨資料
# Memo...........:
# Usage..........: CALL axmp520_02_delete_xmdi(p_linkno,p_linkseq)
#                  RETURNING r_success
# Input parameter: p_linkno    暫存檔之key
#                : p_linkseq   項次
# Return code....: r_success   TRUE/FALSE
#                : 
# Date & Author..: 140722 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_delete_xmdi(p_linkno,p_linkseq)
   DEFINE p_linkno      LIKE type_t.num5
   DEFINE p_linkseq     LIKE xmdh_t.xmdhseq
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num10    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   
    
    LET g_del_xmdi = FALSE
    LET r_success = TRUE
    
    IF NOT cl_null(p_linkseq) AND NOT cl_null(p_linkno) THEN   
       #檢查有無多庫儲批資料
       LET l_n = 0    
       #SELECT COUNT(xmdIseq1) INTO l_n  #151118-00029 20160309 s983961--mark
       SELECT COUNT(xmdiseq1) INTO l_n   #151118-00029 20160309 s983961--add
         FROM p520_tmp03              #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
        WHERE linkno = p_linkno
          AND xmdiseq = p_linkseq               
    
       #詢問是否刪除多庫儲批
       IF l_n > 1 THEN
          IF NOT cl_ask_confirm('axm-00194') THEN   #是否取消多庫儲批出貨，且刪除對應的出通單多庫儲批出貨明細檔？
             LET r_success = FALSE
             LET g_del_xmdi = FALSE
             RETURN r_success
          END IF
       END IF
       
       LET g_del_xmdi = TRUE
       #151118-00029 20160309 s983961--mark(s)
       #DELETE FROM p520_02_xmdi_temp
       # WHERE linkno = p_linkno
       #   AND xmdiseq = p_linkseq
           
       #IF SQLCA.sqlcode THEN
       #   INITIALIZE g_errparam TO NULL
       #   LET g_errparam.code = SQLCA.sqlcode
       #   LET g_errparam.extend = "p520_02_xmdi_temp"
       #   LET g_errparam.popup = TRUE
       #   CALL cl_err()   
       #   LET r_success = FALSE
       #   RETURN r_success
       #END IF
       ##151118-00029 20160309 s983961--mark(e)
    ELSE
       LET r_success = FALSE
       RETURN r_success    
    END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 開啟出通單維護作業
# Memo...........:
# Usage..........: CALL axmp520_02_open_axmt520()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150806 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_open_axmt520()
   DEFINE la_param  RECORD
                       prog   STRING,
                       param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE i         LIKE type_t.num10     #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE ls_js     STRING
   DEFINE l_str     STRING
   DEFINE l_str2    STRING               #161124-00047#1
   DEFINE l_xmdg001 LIKE xmdg_t.xmdg001  #161124-00047#1  
   WHENEVER ERROR CONTINUE

   LET l_str = ''
   LET l_str2 = ''  #161124-00047#1-S
   FOR i = 1 TO g_xmdg_d.getLength()
       #161124-00047#1-S
       SELECT xmdg001 INTO l_xmdg001 FROM xmdg_t
        WHERE xmdgent = g_enterprise
          AND xmdgdocno = g_xmdg_d[i].xmdgdocno
       IF l_xmdg001 = '8' THEN 
          IF cl_null(l_str2) THEN
             LET l_str2 = g_xmdg_d[i].xmdgdocno,"','"
          ELSE
             LET l_str2 = l_str2,g_xmdg_d[i].xmdgdocno,"','"
          END IF
       ELSE          
       #161124-00047#1-E       
          IF cl_null(l_str) THEN
             LET l_str = g_xmdg_d[i].xmdgdocno,"','"
          ELSE
             LET l_str = l_str,g_xmdg_d[i].xmdgdocno,"','"
          END IF
       END IF  #161124-00047#1    

   END FOR

   LET l_str = l_str.subString(1,l_str.getLength()-3)
   LET l_str2 = l_str2.subString(1,l_str2.getLength()-3) #161124-00047#1-S
   IF NOT cl_null(l_str) THEN
      LET la_param.prog = 'axmt520'
      #160804-00071 by whitney modify start
      #LET la_param.param[1] = l_str
      LET la_param.param[2] = l_str
      #160804-00071 by whitney modify end
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF
   #161124-00047#1-S
   IF NOT cl_null(l_str2) THEN
      LET la_param.prog = 'axmt521'
      LET la_param.param[1] = l_str2
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF   
   #161124-00047#1-E
END FUNCTION

################################################################################
# Descriptions...: 完成時，檢查欄位是否都有輸入
# Memo...........:
# Usage..........: CALL axmp520_02_check_field()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 150806 By Polly
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_check_field()
DEFINE r_success        LIKE type_t.num5
DEFINE l_xmdh_d         type_g_xmdh_d
DEFINE l_xmdi009        LIKE xmdi_t.xmdi009
DEFINE l_n              LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5  

   WHENEVER ERROR CONTINUE   
   
   LET r_success = TRUE
   
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF   
  
   #對出貨數量進行取位
   CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017)
     RETURNING l_success,g_xmdh_d[l_ac].xmdh017  
   #若料號有設置使用參考單位時且出貨單位與參考單位有設置換算率時，則應自動推算參考數量
   IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN
      CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh017)
        RETURNING l_success,g_xmdh_d[l_ac].xmdh019
      #對參考數量進行取位
      CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
        RETURNING l_success,g_xmdh_d[l_ac].xmdh019                 
   END IF
   #若料號有使用銷售計價單位時，則輸入[C:出貨數量]時則應自動推算計價數量
   IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN
      CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh017)
        RETURNING l_success,g_xmdh_d[l_ac].xmdh021
      #對計價數量進行取位
      CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
        RETURNING l_success,g_xmdh_d[l_ac].xmdh021                                      
   END IF 

   #先更新當下這筆資料
   UPDATE  p520_tmp02            #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
      SET  xmdh017 = g_xmdh_d[l_ac].xmdh017,
           xmdh019 = g_xmdh_d[l_ac].xmdh019,
           xmdh021 = g_xmdh_d[l_ac].xmdh021,
           xmdh011 = g_xmdh_d[l_ac].xmdh011,
           xmdh012 = g_xmdh_d[l_ac].xmdh012,
           xmdh013 = g_xmdh_d[l_ac].xmdh013,
           xmdh014 = g_xmdh_d[l_ac].xmdh014 
    WHERE  linkno =  g_xmdh_d_t.linkno
      AND  linkseq = g_xmdh_d_t.linkseq
      
   IF g_xmdh_d[l_ac].xmdh011 = 'N' AND NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN   
      CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                  g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                  g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING r_success
         IF NOT r_success THEN
            RETURN r_success
         END IF
   END IF
   
   CALL cl_err_collect_init()
   
   DECLARE axmp520_check_field_cs CURSOR FOR
    SELECT linkno,linkseq,xmdh011,xmdh012,xmdh017,xmdh019,xmdh021
      FROM p520_tmp02           #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
     ORDER BY linkno,linkseq
   
   FOREACH axmp520_check_field_cs INTO l_xmdh_d.linkno ,l_xmdh_d.linkseq,l_xmdh_d.xmdh011,l_xmdh_d.xmdh012,
                                       l_xmdh_d.xmdh017,l_xmdh_d.xmdh019,l_xmdh_d.xmdh021
      #多庫儲批
      IF l_xmdh_d.xmdh011 = 'Y' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n 
           FROM p520_tmp03          #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
          WHERE linkno = l_xmdh_d.linkno
            AND xmdiseq = l_xmdh_d.linkseq
         IF cl_null(l_n) OR l_n <= 0 THEN
            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00493'   #此單據項次無多庫儲批資料！   #160318-00005#48  mark
            LET g_errparam.code = 'sub-01326'   #此單據項次無多庫儲批資料！    #160318-00005#48  add
            LET g_errparam.extend = l_xmdh_d.linkseq
            LET g_errparam.popup = TRUE
            CALL cl_err()            
            LET r_success = FALSE
         END IF
      END IF
      
      #數量
      IF cl_null(l_xmdh_d.xmdh017) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00200'     #數量不可為空！
         LET g_errparam.extend = l_xmdh_d.linkseq
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET r_success = FALSE
      ELSE
         IF g_xmdh_d[l_ac].xmdh011 = 'Y' OR (g_xmdh_d[l_ac].xmdh011 = 'N' AND NOT cl_null(g_xmdh_d[l_ac].xmdh012)) THEN
            LET l_xmdi009 = 0
            SELECT SUM(xmdi009) INTO l_xmdi009 
              FROM p520_tmp03            #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
             WHERE linkno = l_xmdh_d.linkno
               AND xmdiseq = l_xmdh_d.linkseq
            IF cl_null(l_xmdi009) THEN LET l_xmdi009 = 0 END IF
         
            IF l_xmdh_d.xmdh017 <> l_xmdi009 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00492'     #分批數量總和需等於出貨量!
               LET g_errparam.extend = l_xmdh_d.linkseq
               LET g_errparam.popup = TRUE
               CALL cl_err()            
              LET r_success = FALSE
            END IF
         END IF
      END IF      
   END FOREACH
   
   CALL cl_err_collect_show()
   RETURN r_success   

END FUNCTION
################################################################################
# Descriptions...: 回寫訂單的已轉出通量
# Memo...........:
# Usage..........: CALL axmp520_02_upd_xmdd031(p_xmdh001,p_xmdh002,p_xmdh003,p_xmdh004,p_xmdh016)
#                : 
# Input parameter: p_xmdh001   單號
#                : p_xmdh002   項次
#                : p_xmdh003   項序
#                : p_xmdh004   分批序
#                : p_xmdh016   本次登打出通量
# Return code....: 
# Date & Author..: 150831 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_upd_xmdd031(p_xmdh001,p_xmdh002,p_xmdh003,p_xmdh004,p_xmdh016)
DEFINE p_xmdh001   LIKE xmdh_t.xmdh001
DEFINE p_xmdh002   LIKE xmdh_t.xmdh002
DEFINE p_xmdh003   LIKE xmdh_t.xmdh003
DEFINE p_xmdh004   LIKE xmdh_t.xmdh004
DEFINE p_xmdh016   LIKE xmdh_t.xmdh016

   #訂單號、項次、項序、分批序且均有值時做檢核
   IF cl_null(p_xmdh001) OR cl_null(p_xmdh002) OR
      cl_null(p_xmdh003) OR cl_null(p_xmdh004) THEN
      RETURN
   END IF

   IF cl_null(p_xmdh016) THEN LET p_xmdh016 = 0 END IF   
   
   UPDATE xmdd_t
      SET xmdd031 = COALESCE(xmdd031,0) + p_xmdh016 
    WHERE xmddent = g_enterprise
      AND xmddsite = g_site
      AND xmdddocno = p_xmdh001
      AND xmddseq = p_xmdh002
      AND xmddseq1 = p_xmdh003
      AND xmddseq2 = p_xmdh004

   IF SQLCA.sqlcode THEN
      LET g_result_str = g_result_str,",update xmdd_t",cl_getmsg(SQLCA.sqlcode,g_lang)
      LET g_success = 'N'         
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 出貨明細頁籤的輸入段(input)
# Memo...........:
# Usage..........: CALL axmp520_02_b()
# Date & Author..: 20160225 By s983961
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp520_02_b()
DEFINE l_success   LIKE type_t.num5
DEFINE l_xmdh012   LIKE xmdh_t.xmdh012
DEFINE l_xmdh013   LIKE xmdh_t.xmdh013
DEFINE l_xmdh014   LIKE xmdh_t.xmdh014
DEFINE l_xmdh029   LIKE xmdh_t.xmdh029
DEFINE l_docno     LIKE xmdl_t.xmdldocno
DEFINE l_seq       LIKE xmdl_t.xmdlseq


   WHENEVER ERROR CONTINUE 
   
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_xmdh_d FROM s_detail2_axmp520_02.*
         ATTRIBUTE(COUNT = g_detail2_02_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
         
         BEFORE ROW
           LET l_ac = DIALOG.getCurrentRow("s_detail2_axmp520_02")
           LET g_detail2_02_idx = l_ac
           LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*
           LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*
           CALL axmp520_02_fetch_xmdi()
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()

         AFTER FIELD xmdh017_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh017,"0","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh017_02
           END IF         
           IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 OR g_xmdh_d_o.xmdh017 IS NULL THEN
              IF g_xmdh_d[l_ac].xmdh017 >  g_xmdh_d[l_ac].xmdh016 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "axm-00364"
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 CALL cl_err()              
                 LET g_xmdh_d[l_ac].xmdh017 = g_xmdh_d_o.xmdh017
                #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh017
                 DISPLAY g_xmdh_d[l_ac].xmdh017 TO xmdh017_02
                 NEXT FIELD CURRENT
              END IF
              #對出貨數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh017  
              #若料號有設置使用參考單位時且出貨單位與參考單位有設置換算率時，則應自動推算參考數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019
                 #對參考數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019                 
              END IF
              #若料號有使用銷售計價單位時，則輸入[C:出貨數量]時則應自動推算計價數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021
                 #對計價數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021                                      
                 #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
              END IF  
              ##查看是否已有多庫儲批，如有，則需跳出視窗修改
              #IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 AND g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
              #
              #END IF
           END IF
           LET g_xmdh_d_o.xmdh017 = g_xmdh_d[l_ac].xmdh017
          
        AFTER FIELD xmdh019_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh019,"0.000","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh019_02
           END IF
           #對參考數量進行取位
           CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
             RETURNING l_success,g_xmdh_d[l_ac].xmdh019 

        AFTER FIELD xmdh021_02
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh021,"0.000","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh019_02
           END IF
           IF g_xmdh_d[l_ac].xmdh021 != g_xmdh_d_o.xmdh021 OR g_xmdh_d_o.xmdh021 IS NULL THEN
              #對計價數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh021 
              #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
           END IF
           
           

        AFTER FIELD xmdh012_02
           LET g_xmdh_d[l_ac].xmdh012_desc = ''
           IF NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN 
              IF g_xmdh_d[l_ac].xmdh012 != g_xmdh_d_o.xmdh012 OR g_xmdh_d_o.xmdh012 IS NULL  THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_site
                 LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                 LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                 LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                 #庫位檢查
                 IF NOT cl_chk_exist("v_inag004_1") THEN               
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
                 #在揀量check
                 #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                 IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                            g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                            g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
              END IF
           END IF 
           CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
           LET g_xmdh_d_o.xmdh012 = g_xmdh_d[l_ac].xmdh012
           LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
           LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()        
        
         AFTER FIELD xmdh013_02
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) 
              RETURNING g_xmdh_d[l_ac].xmdh013_desc
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh013) THEN
               IF g_xmdh_d[l_ac].xmdh013 != g_xmdh_d_o.xmdh013 OR g_xmdh_d_o.xmdh013 IS NULL THEN
                  #儲位檢查
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  IF NOT cl_chk_exist("v_inag005_1") THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) 
                       RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF            
            LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
        
         AFTER FIELD xmdh014_02
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN
               
               IF g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  #批號檢查
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  LET g_chkparam.arg6 = g_xmdh_d[l_ac].xmdh014
                  #161207-00057#1----mark---begin------
#                  IF not cl_chk_exist("v_inag006_1") THEN
#                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
#                     NEXT FIELD CURRENT
#                  END IF
                  #161207-00057#1----mark---end-------
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                     NEXT FIELD CURRENT  
                  END IF                 
               END IF
            END IF
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
        
        ON CHANGE xmdh011_02
           IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
              CALL axmp520_03(g_site,g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq,
                              g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh015,
                              g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002)
                RETURNING l_success,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029 
              IF l_success THEN
                 IF NOT cl_null(l_xmdh012) THEN
                    LET g_xmdh_d[l_ac].xmdh011 = 'N'
                    LET g_xmdh_d[l_ac].xmdh012 = l_xmdh012
                    LET g_xmdh_d[l_ac].xmdh013 = l_xmdh013
                    LET g_xmdh_d[l_ac].xmdh014 = l_xmdh014
                    LET g_xmdh_d[l_ac].xmdh029 = l_xmdh029
                 ELSE
                    LET g_xmdh_d[l_ac].xmdh011 = 'Y'
                    LET g_xmdh_d[l_ac].xmdh012 = ' '
                    LET g_xmdh_d[l_ac].xmdh013 = ' '
                    LET g_xmdh_d[l_ac].xmdh014 = ' '
                    LET g_xmdh_d[l_ac].xmdh029 = ' '
                 END IF
                 CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012)
                   RETURNING g_xmdh_d[l_ac].xmdh012_desc
                 CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013)
                   RETURNING g_xmdh_d[l_ac].xmdh013_desc
              ELSE
                 LET g_xmdh_d[l_ac].xmdh011 = g_xmdh_d_o.xmdh011
                 NEXT FIELD CURRENT
              END IF                
           ELSE 
              IF NOT axmp520_02_delete_xmdi(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq) THEN
                 #LET g_xmdh_d[l_ac].xmdh011 = g_xmdh_d_o.xmdh011
                 LET g_xmdh_d[l_ac].xmdh011 = 'Y'
                 NEXT FIELD CURRENT
              END IF                  
           END IF
           CALL axmp520_02_fetch_xmdi()
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()    
        
            
        ON ROW CHANGE
           IF INT_FLAG THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 9001
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              LET INT_FLAG = 0
              LET g_xmdh_d[l_ac].* = g_xmdh_d_o.*
              EXIT DIALOG
           ELSE
              UPDATE  p520_tmp02           #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
                 SET  xmdh017 = g_xmdh_d[l_ac].xmdh017,
                      xmdh019 = g_xmdh_d[l_ac].xmdh019,
                      xmdh021 = g_xmdh_d[l_ac].xmdh021,
                      xmdh011 = g_xmdh_d[l_ac].xmdh011,
                      xmdh012 = g_xmdh_d[l_ac].xmdh012,
                      xmdh013 = g_xmdh_d[l_ac].xmdh013,
                      xmdh014 = g_xmdh_d[l_ac].xmdh014 
               WHERE  linkno =  g_xmdh_d_t.linkno
                 AND  linkseq = g_xmdh_d_t.linkseq   
              #20160310
              #151118-00029 20160309 s983961--add(s) 刪除對應的出通單多庫儲批出貨明細檔  
              IF NOT cl_null(g_del_xmdi) THEN
                IF g_del_xmdi THEN
                  LET g_del_xmdi = FALSE
                  DELETE FROM p520_tmp03               #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
                   WHERE linkno = g_xmdh_d[l_ac].linkno          
                     AND xmdiseq = g_xmdh_d[l_ac].linkseq           
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "p520_tmp03"          #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                  END IF             
              
                  CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                               g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                               g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
                  CALL axmp520_02_fetch_xmdi()  
                END IF              
              END IF 
              ##151118-00029 20160309 s983961--add(s)              
              IF g_xmdh_d[l_ac].xmdh011 = 'N' AND NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN                 
                 CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                             g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
              END IF                            
           END IF

        ON ACTION controlp INFIELD xmdh012_02
   	     INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012  #給予default值
           LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
           LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
           #161207-00057#1---add---begin----
           IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN
             LET g_qryparam.where = " inag006 = '",g_xmdh_d[l_ac].xmdh014, "' "          
           END IF 
           #161207-00057#1---add---end-----
           CALL q_inag004_1()                                #呼叫開窗
           LET g_xmdh_d[l_ac].xmdh012 = g_qryparam.return1   #將開窗取得的值回傳到變數
           LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return2 
           LET g_xmdh_d[l_ac].xmdh014 = g_qryparam.return3 
           DISPLAY g_xmdh_d[l_ac].xmdh012 TO xmdh012_02         #顯示到畫面上
           DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013_02
           DISPLAY g_xmdh_d[l_ac].xmdh014 TO xmdh014_02
           CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
           CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
           NEXT FIELD xmdh012_02                                #返回原欄位

        ON ACTION controlp INFIELD xmdh013_02
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh013  #給予default值
            LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
            LET g_qryparam.arg3 = g_xmdh_d[l_ac].xmdh012
            CALL q_inag005_5()                                #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013_02      #顯示到畫面上
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            NEXT FIELD xmdh013_02                             #返回原欄位
            
            
        ON ACTION accept        
          #刪除對應的出通單多庫儲批出貨明細檔  #151118-00029 20160309 s983961--add(s)
          IF NOT cl_null(g_del_xmdi) THEN
            IF g_del_xmdi THEN
              LET g_del_xmdi = FALSE
              DELETE FROM p520_tmp03                      #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
               WHERE linkno = g_xmdh_d[l_ac].linkno          
                 AND xmdiseq = g_xmdh_d[l_ac].linkseq           
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "p520_tmp03"     #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
                 LET g_errparam.popup = TRUE
                 CALL cl_err()   
              END IF             
       
              CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                           g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                           g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
              CALL axmp520_02_fetch_xmdi()  
            END IF              
          END IF 
          #實際出通數量 
           IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh017,"0","0","","","azz-00079",1) THEN
              NEXT FIELD xmdh017_02
           END IF         
           IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 OR g_xmdh_d_o.xmdh017 IS NULL THEN
              IF g_xmdh_d[l_ac].xmdh017 >  g_xmdh_d[l_ac].xmdh016 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "axm-00364"
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 CALL cl_err()              
                 LET g_xmdh_d[l_ac].xmdh017 = g_xmdh_d_o.xmdh017
                #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh017
                 DISPLAY g_xmdh_d[l_ac].xmdh017 TO xmdh017_02
                 NEXT FIELD CURRENT
              END IF
              #對出貨數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh017  
              #若料號有設置使用參考單位時且出貨單位與參考單位有設置換算率時，則應自動推算參考數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019
                 #對參考數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh019                 
              END IF
              #若料號有使用銷售計價單位時，則輸入[C:出貨數量]時則應自動推算計價數量
              IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN
                 CALL s_aooi250_convert_qty(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh017)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021
                 #對計價數量進行取位
                 CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                   RETURNING l_success,g_xmdh_d[l_ac].xmdh021                                      
                 #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
              END IF  
              ##查看是否已有多庫儲批，如有，則需跳出視窗修改
              #IF g_xmdh_d[l_ac].xmdh017 != g_xmdh_d_o.xmdh017 AND g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
              #
              #END IF
           END IF
          
          IF g_s_bas_0028 = 'Y' THEN  #160808-00024 by whitney add
             #參考數量
              IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh019,"0.000","0","","","azz-00079",1) THEN
                 NEXT FIELD xmdh019_02
              END IF
              #對參考數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh019 
          END IF  #160808-00024 by whitney add
             
          IF g_s_bas_0007 = 'Y' THEN  #160808-00024 by whitney add
             #計價數量
              IF NOT cl_ap_chk_Range(g_xmdh_d[l_ac].xmdh021,"0.000","0","","","azz-00079",1) THEN
                 NEXT FIELD xmdh019_02
              END IF
          END IF  #160808-00024 by whitney add
           IF g_xmdh_d[l_ac].xmdh021 != g_xmdh_d_o.xmdh021 OR g_xmdh_d_o.xmdh021 IS NULL THEN
              #對計價數量進行取位
              CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                RETURNING l_success,g_xmdh_d[l_ac].xmdh021 
              #重新計算[C:未稅金額]、[C:含稅金額]、[稅額] 
                 CALL axmp520_02_get_amount(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].xmdh021,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc016)
                   RETURNING g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048 
           END IF

          #限定庫位
           IF NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN 
              IF g_xmdh_d[l_ac].xmdh012 != g_xmdh_d_o.xmdh012 OR g_xmdh_d_o.xmdh012 IS NULL  THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_site
                 LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                 LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                 LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                 #庫位檢查
                 IF NOT cl_chk_exist("v_inag004_1") THEN               
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
                 #在揀量check
                 #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                 IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                            g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                            g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                    LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                    CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                    NEXT FIELD CURRENT
                 END IF
              END IF
           END IF 
           CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
           LET g_xmdh_d_o.xmdh012 = g_xmdh_d[l_ac].xmdh012
           LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
           LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
           CALL axmp520_02_set_entry_b()
           CALL axmp520_02_set_no_entry_b()        
          
          #限定儲位
           IF NOT cl_null(g_xmdh_d[l_ac].xmdh013) THEN
               IF g_xmdh_d[l_ac].xmdh013 != g_xmdh_d_o.xmdh013 OR g_xmdh_d_o.xmdh013 IS NULL THEN
                  #儲位檢查
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  IF NOT cl_chk_exist("v_inag005_1") THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) 
                       RETURNING g_xmdh_d[l_ac].xmdh013_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF            
            LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
         
           #限定批號
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN               
               IF g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  #批號檢查
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                  LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                  LET g_chkparam.arg6 = g_xmdh_d[l_ac].xmdh014
                  IF not cl_chk_exist("v_inag006_1") THEN
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                     NEXT FIELD CURRENT
                  END IF
                  #在揀量檢查
                  #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
                  IF NOT axmp520_01_inan_chk(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh012,
                                             g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh001,
                                            g_xmdh_d[l_ac].xmdh002) THEN
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                     NEXT FIELD CURRENT  
                  END IF                 
               END IF
            END IF
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
         
         #更新tmp
         IF INT_FLAG THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 9001
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              LET INT_FLAG = 0
              LET g_xmdh_d[l_ac].* = g_xmdh_d_o.*
              EXIT DIALOG
         ELSE
            UPDATE  p520_tmp02                 #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02
               SET  xmdh017 = g_xmdh_d[l_ac].xmdh017,
                    xmdh019 = g_xmdh_d[l_ac].xmdh019,
                    xmdh021 = g_xmdh_d[l_ac].xmdh021,
                    xmdh011 = g_xmdh_d[l_ac].xmdh011,
                    xmdh012 = g_xmdh_d[l_ac].xmdh012,
                    xmdh013 = g_xmdh_d[l_ac].xmdh013,
                    xmdh014 = g_xmdh_d[l_ac].xmdh014 
             WHERE  linkno =  g_xmdh_d_t.linkno
               AND  linkseq = g_xmdh_d_t.linkseq   
            IF g_xmdh_d[l_ac].xmdh011 = 'N' AND NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN                 
               CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                           g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                                           g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
            END IF                            
         END IF
         EXIT DIALOG 
         
       ON ACTION cancel 
         LET g_del_xmdi = FALSE
         LET g_xmdh_d[l_ac].*  = g_xmdh_d_t.*         
         CALL axmp520_02_del_xmdi_tmp(g_xmdh_d[l_ac].linkno,g_xmdh_d[l_ac].linkseq)  #20160310                     
         EXIT DIALOG             
           
      END INPUT      
   END DIALOG
   
END FUNCTION

################################################################################
# Descriptions...: 取消時刪除已新增的多庫儲批開窗資料
# Memo...........:
# Usage..........: CALL axmp520_02_del_xmdi_tmp(p_linkno,p_linkseq)
#                  
# Input parameter: p_linkno
#                : p_linkseq
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160310 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_02_del_xmdi_tmp(p_linkno,p_linkseq)
   #TYPE type_g_xmdi_data      RECORD
   #cost      LIKE type_t.chr1,           #成本庫否
   #xmdiseq1  LIKE xmdi_t.xmdiseq1,
   #xmdi001   LIKE xmdi_t.xmdi001,
   #xmdi002   LIKE xmdi_t.xmdi002,
   #xmdi003   LIKE xmdi_t.xmdi003,
   #xmdi004   LIKE xmdi_t.xmdi004,
   #xmdi005   LIKE xmdi_t.xmdi005,
   #xmdi006   LIKE xmdi_t.xmdi006,
   #xmdi007   LIKE xmdi_t.xmdi007,
   #xmdi008   LIKE xmdi_t.xmdi008,
   #xmdi009   LIKE xmdi_t.xmdi009,
   #xmdi010   LIKE xmdi_t.xmdi010,
   #xmdi011   LIKE xmdi_t.xmdi011,
   #xmdi012   LIKE xmdi_t.xmdi012,
   #xmdi013   LIKE xmdi_t.xmdi013
   #    END RECORD 
   DEFINE p_linkno     LIKE type_t.num5
   DEFINE p_linkseq    LIKE xmdh_t.xmdhseq    
   #DEFINE l_xmdi       type_g_xmdi_data
   DEFINE l_sql        STRING
   DEFINE l_num        LIKE type_t.num5
   DEFINE l_seq        LIKE xmdi_t.xmdiseq
   DEFINE l_n          LIKE type_t.num10      #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_success    LIKE type_t.num5

   
   IF NOT cl_null(p_linkseq) AND NOT cl_null(p_linkno) THEN   
       #檢查有無多庫儲批資料
       LET l_n = 0    
       SELECT COUNT(xmdiseq1) INTO l_n
         FROM p520_tmp03              #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
        WHERE linkno = p_linkno
          AND xmdiseq = p_linkseq               
   END IF 
   #判斷該次取消是否刪除多庫儲批
   IF l_n > 1 AND g_xmdh_d_o.xmdh011 = 'N' THEN
      
      DELETE FROM p520_tmp03          #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
       WHERE linkno = p_linkno    
         AND xmdiseq = p_linkseq
      

      #LET l_sql = "SELECT xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,",
      #            "       xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,",
      #            "       xmdi011,xmdi013",
      #            "  FROM axmp520_03_temp",
      #            " WHERE linkno = '",g_xmdh_d[l_ac].linkno,"'",
      #            "   AND xmdiseq = '",g_xmdh_d[l_ac].linkseq,"'"
      #PREPARE axmp520_03_pre1 FROM l_sql
      #DECLARE axmp520_03_cs1 CURSOR FOR axmp520_03_pre1   
      #
      #INITIALIZE l_xmdi.* TO NULL
      #LET l_seq = 0
      #FOREACH axmp520_03_cs1 INTO l_xmdi.xmdi001,l_xmdi.xmdi002,l_xmdi.xmdi003,l_xmdi.xmdi004,l_xmdi.xmdi005,
      #                            l_xmdi.xmdi006,l_xmdi.xmdi007,l_xmdi.xmdi008,l_xmdi.xmdi009,l_xmdi.xmdi010,
      #                            l_xmdi.xmdi011,l_xmdi.xmdi013
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "FOREACH:"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      EXIT FOREACH
      #   END IF
      #
      #   #要被回寫的欄位預設為0
      #   LET l_xmdi.xmdi012 = 0  #已轉出貨量
      #
      #   IF cl_null(l_xmdi.xmdi009) THEN LET l_xmdi.xmdi009 = 0 END IF  #數量
      #   IF cl_null(l_xmdi.xmdi011) THEN LET l_xmdi.xmdi011 = 0 END IF  #參考數量
      #      
      #   LET l_num = l_xmdi.xmdi009 + l_xmdi.xmdi011
      #        
      #   #無輸入任何資料不儲存
      #   IF l_num = 0 THEN
      #      CONTINUE FOREACH
      #   END IF     
      #   LET l_seq = l_seq + 1 
      #   
      #   DELETE FROM p520_02_xmdi_temp
      #    WHERE linkno = g_xmdh_d[l_ac].linkno
      #      AND xmdiseq = g_xmdh_d[l_ac].linkseq
      #      AND xmdiseq1 = l_seq
      #      AND xmdi001 = l_xmdi.xmdi001
      #      AND COALESCE(xmdi002,' ') = COALESCE(l_xmdi.xmdi002,' ') 
      #      AND COALESCE(xmdi003,' ') = COALESCE(l_xmdi.xmdi003,' ') 
      #      AND COALESCE(xmdi004,' ') = COALESCE(l_xmdi.xmdi004,' ') 
      #      AND COALESCE(xmdi005,' ') = COALESCE(l_xmdi.xmdi005,' ') 
      #      AND COALESCE(xmdi006,' ') = COALESCE(l_xmdi.xmdi006,' ') 
      #      AND COALESCE(xmdi007,' ') = COALESCE(l_xmdi.xmdi007,' ') 
      #      AND COALESCE(xmdi008,' ') = COALESCE(l_xmdi.xmdi008,' ') 
      #      AND xmdi009 = l_xmdi.xmdi009
      #      AND COALESCE(xmdi010,' ') = COALESCE(l_xmdi.xmdi010,' ') 
      #      AND xmdi011 = l_xmdi.xmdi011
      #      AND xmdi012 = l_xmdi.xmdi012
      #      AND COALESCE(xmdi013,' ') = COALESCE(l_xmdi.xmdi013,' ')
      #        
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "DELETE axmp580_02_temp_d3:"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #   END IF                  
      #END FOREACH
      CALL axmp520_02_modify_xmdi(g_xmdh_d[l_ac].linkno ,g_xmdh_d[l_ac].linkseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                               g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,
                               g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019) RETURNING l_success
      CALL axmp520_02_fetch_xmdi()                          
   END IF
   
   
      
   #CLOSE axmp520_03_cs1
   #FREE axmp520_03_pre1

END FUNCTION

 
{</section>}
 
