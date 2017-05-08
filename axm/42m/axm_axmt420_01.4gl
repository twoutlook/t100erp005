#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt420_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-06-16 15:12:43), PR版次:0004(2016-12-07 13:12:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000175
#+ Filename...: axmt420_01
#+ Description: 核價分量計價維護作業
#+ Creator....: 03080(2014-02-06 16:30:22)
#+ Modifier...: 07024 -SD/PR- 08171
 
{</section>}
 
{<section id="axmt420_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161109-00085#6   2016/11/10  By 08993      整批調整系統星號寫法
#161109-00085#64  2016/11/30  By 08171      整批調整系統星號寫法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdv_d        RECORD
       xmdvdocno LIKE xmdv_t.xmdvdocno, 
   xmdvseq LIKE xmdv_t.xmdvseq, 
   xmdv001 LIKE xmdv_t.xmdv001, 
   xmdv002 LIKE xmdv_t.xmdv002, 
   xmdv003 LIKE xmdv_t.xmdv003, 
   xmdv004 LIKE xmdv_t.xmdv004
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE p_xmdvent             LIKE xmdv_t.xmdvent
DEFINE g_xmdvdocno           LIKE xmdv_t.xmdvdocno
DEFINE g_xmdvseq             LIKE xmdv_t.xmdvseq
DEFINE l_ac_t                LIKE type_t.num5
DEFINE g_xmdu008             LIKE xmdu_t.xmdu008
DEFINE g_chk_transaction     LIKE type_t.num5        ##用來判斷在外層是否有開transaction，有的話就不再開/關

#end add-point
 
DEFINE g_xmdv_d          DYNAMIC ARRAY OF type_g_xmdv_d
DEFINE g_xmdv_d_t        type_g_xmdv_d
 
 
DEFINE g_xmdvdocno_t   LIKE xmdv_t.xmdvdocno    #Key值備份
DEFINE g_xmdvseq_t      LIKE xmdv_t.xmdvseq    #Key值備份
DEFINE g_xmdv001_t      LIKE xmdv_t.xmdv001    #Key值備份
DEFINE g_xmdv002_t      LIKE xmdv_t.xmdv002    #Key值備份
 
 
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
 
{<section id="axmt420_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt420_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdvdocno,p_xmdvseq,p_xmdu002,p_xmdu003,p_xmdu031,p_xmdu032
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
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_stus          LIKE type_t.chr1
   #161109-00085#6-mod-s
   #DEFINE l_xmdv   RECORD LIKE xmdv_t.*   #161109-00085#6   mark
   DEFINE l_xmdv          RECORD  #核價分量計價檔
       xmdvent LIKE xmdv_t.xmdvent, #企業編號
       xmdvsite LIKE xmdv_t.xmdvsite, #營運據點
       xmdvdocno LIKE xmdv_t.xmdvdocno, #單號
       xmdvseq LIKE xmdv_t.xmdvseq, #項次
       xmdv001 LIKE xmdv_t.xmdv001, #起始數量
       xmdv002 LIKE xmdv_t.xmdv002, #截止數量
       xmdv003 LIKE xmdv_t.xmdv003, #單價
      #xmdv004 LIKE xmdv_t.xmdv004 #折扣率 #161109-00085#64 mark
       #161109-00085#64 --s add
       xmdv004 LIKE xmdv_t.xmdv004, #折扣率
       xmdvud001 LIKE xmdv_t.xmdvud001, #自定義欄位(文字)001
       xmdvud002 LIKE xmdv_t.xmdvud002, #自定義欄位(文字)002
       xmdvud003 LIKE xmdv_t.xmdvud003, #自定義欄位(文字)003
       xmdvud004 LIKE xmdv_t.xmdvud004, #自定義欄位(文字)004
       xmdvud005 LIKE xmdv_t.xmdvud005, #自定義欄位(文字)005
       xmdvud006 LIKE xmdv_t.xmdvud006, #自定義欄位(文字)006
       xmdvud007 LIKE xmdv_t.xmdvud007, #自定義欄位(文字)007
       xmdvud008 LIKE xmdv_t.xmdvud008, #自定義欄位(文字)008
       xmdvud009 LIKE xmdv_t.xmdvud009, #自定義欄位(文字)009
       xmdvud010 LIKE xmdv_t.xmdvud010, #自定義欄位(文字)010
       xmdvud011 LIKE xmdv_t.xmdvud011, #自定義欄位(數字)011
       xmdvud012 LIKE xmdv_t.xmdvud012, #自定義欄位(數字)012
       xmdvud013 LIKE xmdv_t.xmdvud013, #自定義欄位(數字)013
       xmdvud014 LIKE xmdv_t.xmdvud014, #自定義欄位(數字)014
       xmdvud015 LIKE xmdv_t.xmdvud015, #自定義欄位(數字)015
       xmdvud016 LIKE xmdv_t.xmdvud016, #自定義欄位(數字)016
       xmdvud017 LIKE xmdv_t.xmdvud017, #自定義欄位(數字)017
       xmdvud018 LIKE xmdv_t.xmdvud018, #自定義欄位(數字)018
       xmdvud019 LIKE xmdv_t.xmdvud019, #自定義欄位(數字)019
       xmdvud020 LIKE xmdv_t.xmdvud020, #自定義欄位(數字)020
       xmdvud021 LIKE xmdv_t.xmdvud021, #自定義欄位(日期時間)021
       xmdvud022 LIKE xmdv_t.xmdvud022, #自定義欄位(日期時間)022
       xmdvud023 LIKE xmdv_t.xmdvud023, #自定義欄位(日期時間)023
       xmdvud024 LIKE xmdv_t.xmdvud024, #自定義欄位(日期時間)024
       xmdvud025 LIKE xmdv_t.xmdvud025, #自定義欄位(日期時間)025
       xmdvud026 LIKE xmdv_t.xmdvud026, #自定義欄位(日期時間)026
       xmdvud027 LIKE xmdv_t.xmdvud027, #自定義欄位(日期時間)027
       xmdvud028 LIKE xmdv_t.xmdvud028, #自定義欄位(日期時間)028
       xmdvud029 LIKE xmdv_t.xmdvud029, #自定義欄位(日期時間)029
       xmdvud030 LIKE xmdv_t.xmdvud030  #自定義欄位(日期時間)030
       #161109-00085#64 --e add   
          END RECORD
   #161109-00085#6-mod-e 
   
   DEFINE l_forupd_sql    STRING
   #161109-00085#6-mod-s
   #DEFINE l_xmdu   RECORD LIKE xmdu_t.*   #161109-00085#6   mark
   DEFINE l_xmdu          RECORD  #銷售核價單明細檔
       xmduent LIKE xmdu_t.xmduent, #企業編號   
       xmdusite LIKE xmdu_t.xmdusite, #營運據點
       xmdudocno LIKE xmdu_t.xmdudocno, #單號
       xmduseq LIKE xmdu_t.xmduseq, #項次
       xmdu001 LIKE xmdu_t.xmdu001, #委外否
       xmdu002 LIKE xmdu_t.xmdu002, #料件編號
       xmdu003 LIKE xmdu_t.xmdu003, #產品特徵
       xmdu004 LIKE xmdu_t.xmdu004, #包裝容器
       xmdu005 LIKE xmdu_t.xmdu005, #客戶料號
       xmdu006 LIKE xmdu_t.xmdu006, #作業編號
       xmdu007 LIKE xmdu_t.xmdu007, #製程式
       xmdu008 LIKE xmdu_t.xmdu008, #核價單位
       xmdu009 LIKE xmdu_t.xmdu009, #分量計價否
       xmdu010 LIKE xmdu_t.xmdu010, #上次單價
       xmdu011 LIKE xmdu_t.xmdu011, #單價
       xmdu012 LIKE xmdu_t.xmdu012, #稅率
       xmdu013 LIKE xmdu_t.xmdu013, #折扣率
       xmdu014 LIKE xmdu_t.xmdu014, #運輸方式
       xmdu015 LIKE xmdu_t.xmdu015, #理由碼
       xmdu030 LIKE xmdu_t.xmdu030, #備註
       #161109-00085#64 --s add      
       xmduud001 LIKE xmdu_t.xmduud001, #自定義欄位(文字)001
       xmduud002 LIKE xmdu_t.xmduud002, #自定義欄位(文字)002
       xmduud003 LIKE xmdu_t.xmduud003, #自定義欄位(文字)003
       xmduud004 LIKE xmdu_t.xmduud004, #自定義欄位(文字)004
       xmduud005 LIKE xmdu_t.xmduud005, #自定義欄位(文字)005
       xmduud006 LIKE xmdu_t.xmduud006, #自定義欄位(文字)006
       xmduud007 LIKE xmdu_t.xmduud007, #自定義欄位(文字)007
       xmduud008 LIKE xmdu_t.xmduud008, #自定義欄位(文字)008
       xmduud009 LIKE xmdu_t.xmduud009, #自定義欄位(文字)009
       xmduud010 LIKE xmdu_t.xmduud010, #自定義欄位(文字)010
       xmduud011 LIKE xmdu_t.xmduud011, #自定義欄位(數字)011
       xmduud012 LIKE xmdu_t.xmduud012, #自定義欄位(數字)012
       xmduud013 LIKE xmdu_t.xmduud013, #自定義欄位(數字)013
       xmduud014 LIKE xmdu_t.xmduud014, #自定義欄位(數字)014
       xmduud015 LIKE xmdu_t.xmduud015, #自定義欄位(數字)015
       xmduud016 LIKE xmdu_t.xmduud016, #自定義欄位(數字)016
       xmduud017 LIKE xmdu_t.xmduud017, #自定義欄位(數字)017
       xmduud018 LIKE xmdu_t.xmduud018, #自定義欄位(數字)018
       xmduud019 LIKE xmdu_t.xmduud019, #自定義欄位(數字)019
       xmduud020 LIKE xmdu_t.xmduud020, #自定義欄位(數字)020
       xmduud021 LIKE xmdu_t.xmduud021, #自定義欄位(日期時間)021
       xmduud022 LIKE xmdu_t.xmduud022, #自定義欄位(日期時間)022
       xmduud023 LIKE xmdu_t.xmduud023, #自定義欄位(日期時間)023
       xmduud024 LIKE xmdu_t.xmduud024, #自定義欄位(日期時間)024
       xmduud025 LIKE xmdu_t.xmduud025, #自定義欄位(日期時間)025
       xmduud026 LIKE xmdu_t.xmduud026, #自定義欄位(日期時間)026
       xmduud027 LIKE xmdu_t.xmduud027, #自定義欄位(日期時間)027
       xmduud028 LIKE xmdu_t.xmduud028, #自定義欄位(日期時間)028
       xmduud029 LIKE xmdu_t.xmduud029, #自定義欄位(日期時間)029
       xmduud030 LIKE xmdu_t.xmduud030, #自定義欄位(日期時間)030
       #161109-00085#64 --e add
       xmdu031 LIKE xmdu_t.xmdu031, #系列
       xmdu032 LIKE xmdu_t.xmdu032 #產品分類
          END RECORD
   #161109-00085#6-mod-e
   
   #161109-00085#6-mod-s 
   #DEFINE l_xmdt   RECORD LIKE xmdt_t.*   #161109-00085#6    mark 
   DEFINE l_xmdt RECORD  #銷售核價單單頭檔
          xmdtent LIKE xmdt_t.xmdtent, #企業編號
          xmdtsite LIKE xmdt_t.xmdtsite, #營運據點
          xmdtdocno LIKE xmdt_t.xmdtdocno, #單號
          xmdtdocdt LIKE xmdt_t.xmdtdocdt, #單據日期
          xmdt001 LIKE xmdt_t.xmdt001, #委外否
          xmdt002 LIKE xmdt_t.xmdt002, #申請人員
          xmdt003 LIKE xmdt_t.xmdt003, #申請部門
          xmdt004 LIKE xmdt_t.xmdt004, #核價客戶
          xmdt005 LIKE xmdt_t.xmdt005, #幣別
          xmdt006 LIKE xmdt_t.xmdt006, #稅別
          xmdt007 LIKE xmdt_t.xmdt007, #稅率
          xmdt008 LIKE xmdt_t.xmdt008, #單價含稅否
          xmdt009 LIKE xmdt_t.xmdt009, #收款條件
          xmdt010 LIKE xmdt_t.xmdt010, #限定收款條件否
          xmdt011 LIKE xmdt_t.xmdt011, #交易條件
          xmdt012 LIKE xmdt_t.xmdt012, #限定交易條件否
          xmdt013 LIKE xmdt_t.xmdt013, #限定幣別否
          xmdt014 LIKE xmdt_t.xmdt014, #限定稅別否
          xmdt015 LIKE xmdt_t.xmdt015, #生效日期
          xmdt016 LIKE xmdt_t.xmdt016, #失效日期
          xmdt017 LIKE xmdt_t.xmdt017, #核價對象管制
          xmdt018 LIKE xmdt_t.xmdt018, #核價使用管制
          xmdt019 LIKE xmdt_t.xmdt019, #銷售通路
          xmdt020 LIKE xmdt_t.xmdt020, #限定銷售通路
          xmdt030 LIKE xmdt_t.xmdt030, #備註
          xmdtownid LIKE xmdt_t.xmdtownid, #資料所有者
          xmdtowndp LIKE xmdt_t.xmdtowndp, #資料所屬部門
          xmdtcrtid LIKE xmdt_t.xmdtcrtid, #資料建立者
          xmdtcrtdp LIKE xmdt_t.xmdtcrtdp, #資料建立部門
          xmdtcrtdt LIKE xmdt_t.xmdtcrtdt, #資料創建日
          xmdtmodid LIKE xmdt_t.xmdtmodid, #資料修改者
          xmdtmoddt LIKE xmdt_t.xmdtmoddt, #最近修改日
          xmdtcnfid LIKE xmdt_t.xmdtcnfid, #資料確認者
          xmdtcnfdt LIKE xmdt_t.xmdtcnfdt, #資料確認日
          xmdtpstid LIKE xmdt_t.xmdtpstid, #資料過帳者
          xmdtpstdt LIKE xmdt_t.xmdtpstdt, #資料過帳日
         #xmdtstus LIKE xmdt_t.xmdtstus  #狀態碼 #161109-00085#64 mark
          #161109-00085#64 --s add
          xmdtstus LIKE xmdt_t.xmdtstus, #狀態碼
          xmdtud001 LIKE xmdt_t.xmdtud001, #自定義欄位(文字)001
          xmdtud002 LIKE xmdt_t.xmdtud002, #自定義欄位(文字)002
          xmdtud003 LIKE xmdt_t.xmdtud003, #自定義欄位(文字)003
          xmdtud004 LIKE xmdt_t.xmdtud004, #自定義欄位(文字)004
          xmdtud005 LIKE xmdt_t.xmdtud005, #自定義欄位(文字)005
          xmdtud006 LIKE xmdt_t.xmdtud006, #自定義欄位(文字)006
          xmdtud007 LIKE xmdt_t.xmdtud007, #自定義欄位(文字)007
          xmdtud008 LIKE xmdt_t.xmdtud008, #自定義欄位(文字)008
          xmdtud009 LIKE xmdt_t.xmdtud009, #自定義欄位(文字)009
          xmdtud010 LIKE xmdt_t.xmdtud010, #自定義欄位(文字)010
          xmdtud011 LIKE xmdt_t.xmdtud011, #自定義欄位(數字)011
          xmdtud012 LIKE xmdt_t.xmdtud012, #自定義欄位(數字)012
          xmdtud013 LIKE xmdt_t.xmdtud013, #自定義欄位(數字)013
          xmdtud014 LIKE xmdt_t.xmdtud014, #自定義欄位(數字)014
          xmdtud015 LIKE xmdt_t.xmdtud015, #自定義欄位(數字)015
          xmdtud016 LIKE xmdt_t.xmdtud016, #自定義欄位(數字)016
          xmdtud017 LIKE xmdt_t.xmdtud017, #自定義欄位(數字)017
          xmdtud018 LIKE xmdt_t.xmdtud018, #自定義欄位(數字)018
          xmdtud019 LIKE xmdt_t.xmdtud019, #自定義欄位(數字)019
          xmdtud020 LIKE xmdt_t.xmdtud020, #自定義欄位(數字)020
          xmdtud021 LIKE xmdt_t.xmdtud021, #自定義欄位(日期時間)021
          xmdtud022 LIKE xmdt_t.xmdtud022, #自定義欄位(日期時間)022
          xmdtud023 LIKE xmdt_t.xmdtud023, #自定義欄位(日期時間)023
          xmdtud024 LIKE xmdt_t.xmdtud024, #自定義欄位(日期時間)024
          xmdtud025 LIKE xmdt_t.xmdtud025, #自定義欄位(日期時間)025
          xmdtud026 LIKE xmdt_t.xmdtud026, #自定義欄位(日期時間)026
          xmdtud027 LIKE xmdt_t.xmdtud027, #自定義欄位(日期時間)027
          xmdtud028 LIKE xmdt_t.xmdtud028, #自定義欄位(日期時間)028
          xmdtud029 LIKE xmdt_t.xmdtud029, #自定義欄位(日期時間)029
          xmdtud030 LIKE xmdt_t.xmdtud030  #自定義欄位(日期時間)030
          #161109-00085#64 --e add
   END RECORD
   #161109-00085#6-mod-e
   DEFINE l_imaal         RECORD
                          imaal003  LIKE imaal_t.imaal003,
                          imaal004  LIKE imaal_t.imaal004
                          END RECORD
   DEFINE l_xmdv001       LIKE xmdv_t.xmdv001
   DEFINE l_xmdv002       LIKE xmdv_t.xmdv002
   DEFINE l_ooca002   LIKE ooca_t.ooca002     
   DEFINE l_ooca004   LIKE ooca_t.ooca004 
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_round     LIKE xmdv_t.xmdv001
   DEFINE l_num       LIKE xmdv_t.xmdv001
   DEFINE p_xmdvdocno           LIKE xmdv_t.xmdvdocno
   DEFINE p_xmdvseq             LIKE xmdv_t.xmdvseq
   DEFINE p_xmdu002             LIKE xmdu_t.xmdu002 
   DEFINE p_xmdu003             LIKE xmdu_t.xmdu003 
   DEFINE p_xmdu031             LIKE xmdu_t.xmdu031 
   DEFINE p_xmdu032             LIKE xmdu_t.xmdu032
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt420_01 WITH FORM cl_ap_formpath("axm","axmt420_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE

   #預設進入時是無transaction的 
   LET g_chk_transaction = 'N' 
   #如果進來時是有開transaction的話，就做個記錄，之後不會關掉transaction 
   IF g_intrans = 'Y' THEN 
      LET g_chk_transaction = 'Y' 
   END IF
   
   DISPLAY p_xmdvdocno TO xmdudocno
   DISPLAY p_xmdvseq   TO xmduseq
   INITIALIZE l_xmdu.* TO NULL
   INITIALIZE l_xmdt.* TO NULL
   
   LET g_xmdvdocno = p_xmdvdocno
   LET g_xmdvseq   = p_xmdvseq
   #161109-00085#6-mod-s
#   SELECT * INTO l_xmdu.* FROM xmdu_t   #161109-00085#6   mark
   #161109-00085#64 --s mark
   #SELECT xmduent,xmdusite,xmdudocno,xmduseq,xmdu001,xmdu002,xmdu003,xmdu004,xmdu005,xmdu006,xmdu007,
   #       xmdu008,xmdu009,xmdu010,xmdu011,xmdu012,xmdu013,xmdu014,xmdu015,xmdu030,xmdu031,xmdu032
   # INTO l_xmdu.xmduent,l_xmdu.xmdusite,l_xmdu.xmdudocno,l_xmdu.xmduseq,l_xmdu.xmdu001,l_xmdu.xmdu002,
   #      l_xmdu.xmdu003,l_xmdu.xmdu004,l_xmdu.xmdu005,l_xmdu.xmdu006,l_xmdu.xmdu007,l_xmdu.xmdu008,
   #      l_xmdu.xmdu009,l_xmdu.xmdu010,l_xmdu.xmdu011,l_xmdu.xmdu012,l_xmdu.xmdu013,l_xmdu.xmdu014,
   #      l_xmdu.xmdu015,l_xmdu.xmdu030,l_xmdu.xmdu031,l_xmdu.xmdu032 
   #161109-00085#64 --e mark
   #161109-00085#64 --s add
   SELECT xmduent,xmdusite,xmdudocno,xmduseq,xmdu001,
          xmdu002,xmdu003,xmdu004,xmdu005,xmdu006,
          xmdu007,xmdu008,xmdu009,xmdu010,xmdu011,
          xmdu012,xmdu013,xmdu014,xmdu015,xmdu030,
          xmduud001,xmduud002,xmduud003,xmduud004,xmduud005,
          xmduud006,xmduud007,xmduud008,xmduud009,xmduud010,
          xmduud011,xmduud012,xmduud013,xmduud014,xmduud015,
          xmduud016,xmduud017,xmduud018,xmduud019,xmduud020,
          xmduud021,xmduud022,xmduud023,xmduud024,xmduud025,
          xmduud026,xmduud027,xmduud028,xmduud029,xmduud030,
          xmdu031,xmdu032
     INTO l_xmdu.xmduent,l_xmdu.xmdusite,l_xmdu.xmdudocno,l_xmdu.xmduseq,l_xmdu.xmdu001,
          l_xmdu.xmdu002,l_xmdu.xmdu003,l_xmdu.xmdu004,l_xmdu.xmdu005,l_xmdu.xmdu006,
          l_xmdu.xmdu007,l_xmdu.xmdu008,l_xmdu.xmdu009,l_xmdu.xmdu010,l_xmdu.xmdu011,
          l_xmdu.xmdu012,l_xmdu.xmdu013,l_xmdu.xmdu014,l_xmdu.xmdu015,l_xmdu.xmdu030,
          l_xmdu.xmduud001,l_xmdu.xmduud002,l_xmdu.xmduud003,l_xmdu.xmduud004,l_xmdu.xmduud005,
          l_xmdu.xmduud006,l_xmdu.xmduud007,l_xmdu.xmduud008,l_xmdu.xmduud009,l_xmdu.xmduud010,
          l_xmdu.xmduud011,l_xmdu.xmduud012,l_xmdu.xmduud013,l_xmdu.xmduud014,l_xmdu.xmduud015,
          l_xmdu.xmduud016,l_xmdu.xmduud017,l_xmdu.xmduud018,l_xmdu.xmduud019,l_xmdu.xmduud020,
          l_xmdu.xmduud021,l_xmdu.xmduud022,l_xmdu.xmduud023,l_xmdu.xmduud024,l_xmdu.xmduud025,
          l_xmdu.xmduud026,l_xmdu.xmduud027,l_xmdu.xmduud028,l_xmdu.xmduud029,l_xmdu.xmduud030,
          l_xmdu.xmdu031,l_xmdu.xmdu032
   #161109-00085#64 --e add
     FROM xmdu_t
   #161109-00085#6-mod-e
    WHERE xmdudocno = p_xmdvdocno
      AND xmduseq   = p_xmdvseq
      AND xmduent   = g_enterprise
   #161109-00085#6-mod-s   
#   SELECT * INTO l_xmdt.* FROM xmdt_t   #161109-00085#6   mark
   #161109-00085#64 --s mark
   #SELECT xmdtent,xmdtsite,xmdtdocno,xmdtdocdt,xmdt001,xmdt002,xmdt003,xmdt004,xmdt005,xmdt006,
   #       xmdt007,xmdt008,xmdt009,xmdt010,xmdt011,xmdt012,xmdt013,xmdt014,xmdt015,xmdt016,xmdt017,
   #       xmdt018,xmdt019,xmdt020,xmdt030,xmdtownid,xmdtowndp,xmdtcrtid,xmdtcrtdp,xmdtcrtdt,xmdtmodid,
   #       xmdtmoddt,xmdtcnfid,xmdtcnfdt,xmdtpstid,xmdtpstdt,xmdtstus 
   # INTO l_xmdt.xmdtent,l_xmdt.xmdtsite,l_xmdt.xmdtdocno,l_xmdt.xmdtdocdt,l_xmdt.xmdt001,l_xmdt.xmdt002,
   #      l_xmdt.xmdt003,l_xmdt.xmdt004,l_xmdt.xmdt005,l_xmdt.xmdt006,l_xmdt.xmdt007,l_xmdt.xmdt008,l_xmdt.xmdt009,
   #      l_xmdt.xmdt010,l_xmdt.xmdt011,l_xmdt.xmdt012,l_xmdt.xmdt013,l_xmdt.xmdt014,l_xmdt.xmdt015,l_xmdt.xmdt016,
   #      l_xmdt.xmdt017,l_xmdt.xmdt018,l_xmdt.xmdt019,l_xmdt.xmdt020,l_xmdt.xmdt030,l_xmdt.xmdtownid,l_xmdt.xmdtowndp,
   #      l_xmdt.xmdtcrtid,l_xmdt.xmdtcrtdp,l_xmdt.xmdtcrtdt,l_xmdt.xmdtmodid,l_xmdt.xmdtmoddt,l_xmdt.xmdtcnfid,
   #      l_xmdt.xmdtcnfdt,l_xmdt.xmdtpstid,l_xmdt.xmdtpstdt,l_xmdt.xmdtstus 
   #161109-00085#64 --e mark
   #161109-00085#64 --s add
   SELECT xmdtent,xmdtsite,xmdtdocno,xmdtdocdt,xmdt001,
          xmdt002,xmdt003,xmdt004,xmdt005,xmdt006,
          xmdt007,xmdt008,xmdt009,xmdt010,xmdt011,
          xmdt012,xmdt013,xmdt014,xmdt015,xmdt016,
          xmdt017,xmdt018,xmdt019,xmdt020,xmdt030,
          xmdtownid,xmdtowndp,xmdtcrtid,xmdtcrtdp,xmdtcrtdt,
          xmdtmodid,xmdtmoddt,xmdtcnfid,xmdtcnfdt,xmdtpstid,
          xmdtpstdt,xmdtstus,xmdtud001,xmdtud002,xmdtud003,
          xmdtud004,xmdtud005,xmdtud006,xmdtud007,xmdtud008,
          xmdtud009,xmdtud010,xmdtud011,xmdtud012,xmdtud013,
          xmdtud014,xmdtud015,xmdtud016,xmdtud017,xmdtud018,
          xmdtud019,xmdtud020,xmdtud021,xmdtud022,xmdtud023,
          xmdtud024,xmdtud025,xmdtud026,xmdtud027,xmdtud028,
          xmdtud029,xmdtud030
     INTO l_xmdt.xmdtent,l_xmdt.xmdtsite,l_xmdt.xmdtdocno,l_xmdt.xmdtdocdt,l_xmdt.xmdt001,
          l_xmdt.xmdt002,l_xmdt.xmdt003,l_xmdt.xmdt004,l_xmdt.xmdt005,l_xmdt.xmdt006,
          l_xmdt.xmdt007,l_xmdt.xmdt008,l_xmdt.xmdt009,l_xmdt.xmdt010,l_xmdt.xmdt011,
          l_xmdt.xmdt012,l_xmdt.xmdt013,l_xmdt.xmdt014,l_xmdt.xmdt015,l_xmdt.xmdt016,
          l_xmdt.xmdt017,l_xmdt.xmdt018,l_xmdt.xmdt019,l_xmdt.xmdt020,l_xmdt.xmdt030,
          l_xmdt.xmdtownid,l_xmdt.xmdtowndp,l_xmdt.xmdtcrtid,l_xmdt.xmdtcrtdp,l_xmdt.xmdtcrtdt,
          l_xmdt.xmdtmodid,l_xmdt.xmdtmoddt,l_xmdt.xmdtcnfid,l_xmdt.xmdtcnfdt,l_xmdt.xmdtpstid,
          l_xmdt.xmdtpstdt,l_xmdt.xmdtstus,l_xmdt.xmdtud001,l_xmdt.xmdtud002,l_xmdt.xmdtud003,
          l_xmdt.xmdtud004,l_xmdt.xmdtud005,l_xmdt.xmdtud006,l_xmdt.xmdtud007,l_xmdt.xmdtud008,
          l_xmdt.xmdtud009,l_xmdt.xmdtud010,l_xmdt.xmdtud011,l_xmdt.xmdtud012,l_xmdt.xmdtud013,
          l_xmdt.xmdtud014,l_xmdt.xmdtud015,l_xmdt.xmdtud016,l_xmdt.xmdtud017,l_xmdt.xmdtud018,
          l_xmdt.xmdtud019,l_xmdt.xmdtud020,l_xmdt.xmdtud021,l_xmdt.xmdtud022,l_xmdt.xmdtud023,
          l_xmdt.xmdtud024,l_xmdt.xmdtud025,l_xmdt.xmdtud026,l_xmdt.xmdtud027,l_xmdt.xmdtud028,
          l_xmdt.xmdtud029,l_xmdt.xmdtud030
   #161109-00085#64 --e add
     FROM xmdt_t
   #161109-00085#6-mod-e
    WHERE xmdtdocno = p_xmdvdocno
      AND xmdtent   = g_enterprise   
      
   LET g_xmdu008 = l_xmdu.xmdu008
   LET l_xmdu.xmdu002 = p_xmdu002 
   LET l_xmdu.xmdu003 = p_xmdu003 
   LET l_xmdu.xmdu031 = p_xmdu031 
   LET l_xmdu.xmdu032 = p_xmdu032
   
   DISPLAY BY NAME l_xmdt.xmdt005,l_xmdu.xmdu002,l_xmdu.xmdu003,l_xmdu.xmdu004,l_xmdu.xmdu006,l_xmdu.xmdu007
   DISPLAY BY NAME l_xmdu.xmdu031,l_xmdu.xmdu032
   
   INITIALIZE l_imaal.* TO NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_xmdu.xmdu002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_imaal.imaal003 = g_rtn_fields[1]
   LET l_imaal.imaal004 = g_rtn_fields[2]
   
   DISPLAY BY NAME l_imaal.imaal003,l_imaal.imaal004
   
   WHENEVER ERROR CALL cl_err_msg_log
   #b_fill單身跟show單頭
   CALL axmt420_01_b_fill(p_xmdvdocno,p_xmdvseq)

   LET l_stus = ''
   SELECT xmdtstus INTO l_stus FROM xmdt_t
    WHERE xmdtent = g_enterprise
      AND xmdtdocno = p_xmdvdocno
   IF l_stus != 'N' THEN
   #   CALL ammt320_01_ui_dialog()
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_axmt420_01
      RETURN
   END IF
   LET l_forupd_sql = " SELECT xmdvdocno,xmdvseq,xmdv001,xmdv002,xmdv003,xmdv004 ",
                      "   FROM xmdv_t ",
                      "  WHERE xmdvent = '",g_enterprise,"' ",
                      "    AND xmdvdocno = ? AND xmdvseq = ? AND xmdv001 = ? AND xmdv002 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   PREPARE axmt420_01_b FROM l_forupd_sql
   DECLARE axmt420_01_cs CURSOR FOR axmt420_01_b
   LET INT_FLAG = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdv_d FROM s_detail1.*
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
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx

            IF g_chk_transaction = 'N' THEN 
               CALL s_transaction_begin()
            END IF

            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               LET g_xmdv_d_t.* = g_xmdv_d[l_ac].*  #BACKUP
               OPEN axmt420_01_cs USING p_xmdvdocno,p_xmdvseq,g_xmdv_d[l_ac].xmdv001,g_xmdv_d[l_ac].xmdv002
		   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "axmt420_01_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt420_01_cs INTO g_xmdv_d[l_ac].*
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
           #      CALL ammt320_01_mmam003_ref()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            BEFORE INSERT
               IF g_chk_transaction = 'N' THEN 
                  CALL s_transaction_begin()
               END IF
               LET l_cmd = 'a'
               INITIALIZE g_xmdv_d_t.* TO NULL
               INITIALIZE g_xmdv_d[l_ac].* TO NULL 
               LET g_xmdv_d[l_ac].xmdvdocno = p_xmdvdocno
               LET g_xmdv_d[l_ac].xmdvseq   = p_xmdvseq
               #LET g_xmdv_d[l_ac].xmdv001   = 0 
               #LET g_xmdv_d[l_ac].xmdv002   = 0 
               LET g_xmdv_d[l_ac].xmdv003   = 0 
               LET g_xmdv_d[l_ac].xmdv004   = 0 
               
               #起始數量初始化，最大的截止數量 根據當前單位加上截取位數的小數數值
               LET l_xmdv002 = 0
               SELECT MAX(xmdv002) INTO l_xmdv002 FROM xmdv_t
                WHERE xmdvent = g_enterprise 
                  AND xmdvdocno = p_xmdvdocno
                  AND xmdvseq = p_xmdvseq
               IF cl_null(l_xmdv002) THEN
                  LET l_xmdv002 = 0
               END IF
               
               IF NOT cl_null(g_xmdu008) THEN
                  LET l_ooca002 = 0
                  LET l_ooca004 = NULL
		       
                  LET l_round = 0
                  LET l_num = 0
                  CALL s_aooi250_get_msg(g_xmdu008) RETURNING l_success,l_ooca002,l_ooca004
                  IF l_success THEN
                     LET l_round = util.Math.pow(10,l_ooca002)
                     LET l_num = 1 / l_round
                     LET g_xmdv_d[l_ac].xmdv001 = l_xmdv002 + l_num
                  END IF
               END IF
               #CALL axmt420_01_xmdv001_round(g_xmdv_d[l_ac].xmdv001) RETURNING g_xmdv_d[l_ac].xmdv001
               LET g_xmdv_d_t.* = g_xmdv_d[l_ac].*     #新輸入資料
               CALL cl_show_fld_cont()

            AFTER INSERT
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF
		       
               INITIALIZE l_xmdv.* TO NULL
               LET l_xmdv.xmdvdocno = g_xmdv_d[l_ac].xmdvdocno 
               LET l_xmdv.xmdvent   = g_enterprise
               LET l_xmdv.xmdvsite  = g_site
               LET l_xmdv.xmdvseq = g_xmdvseq  
               LET l_xmdv.xmdv001 = g_xmdv_d[l_ac].xmdv001   
               LET l_xmdv.xmdv002 = g_xmdv_d[l_ac].xmdv002   
               LET l_xmdv.xmdv003 = g_xmdv_d[l_ac].xmdv003   
               LET l_xmdv.xmdv004 = g_xmdv_d[l_ac].xmdv004   
               
               SELECT COUNT(*) INTO l_count FROM xmdv_t 
                WHERE xmdvent = g_enterprise
                  AND xmdvdocno = p_xmdvkdocno
                  AND xmdvseq   = p_xmdvseq
                  AND xmdv001   = g_xmdv_d[l_ac].xmdv001
                  AND xmdv002   = g_xmdv_d[l_ac].xmdv002
                   
               #資料未重複, 插入新增資料
               IF l_count = 0 THEN
                  
                  #161109-00085#6-mod-s
                  #INSERT INTO xmdv_t VALUES (l_xmdv.*)   #161109-00085#6   mark               
                  #161109-00085#64 --s mark
                  #INSERT INTO xmdv_t (xmdvent,xmdvsite,xmdvdocno,xmdvseq,xmdv001,xmdv002,xmdv003,xmdv004)
                  #            VALUES (l_xmdv.xmdvent,l_xmdv.xmdvsite,l_xmdv.xmdvdocno,
                  #                    l_xmdv.xmdvseq,l_xmdv.xmdv001,l_xmdv.xmdv002,l_xmdv.xmdv003,l_xmdv.xmdv004)
                  #161109-00085#64 --e mark
                  #161109-00085#6-mod-e
                  #161109-00085#64 --s add
                  INSERT INTO xmdv_t(xmdvent,xmdvsite,xmdvdocno,xmdvseq,xmdv001,
                                     xmdv002,xmdv003,xmdv004,xmdvud001,xmdvud002,
                                     xmdvud003,xmdvud004,xmdvud005,xmdvud006,xmdvud007,
                                     xmdvud008,xmdvud009,xmdvud010,xmdvud011,xmdvud012,
                                     xmdvud013,xmdvud014,xmdvud015,xmdvud016,xmdvud017,
                                     xmdvud018,xmdvud019,xmdvud020,xmdvud021,xmdvud022,
                                     xmdvud023,xmdvud024,xmdvud025,xmdvud026,xmdvud027,
                                     xmdvud028,xmdvud029,xmdvud030)
                  VALUES(l_xmdv.xmdvent,l_xmdv.xmdvsite,l_xmdv.xmdvdocno,l_xmdv.xmdvseq,l_xmdv.xmdv001,
                         l_xmdv.xmdv002,l_xmdv.xmdv003,l_xmdv.xmdv004,l_xmdv.xmdvud001,l_xmdv.xmdvud002,
                         l_xmdv.xmdvud003,l_xmdv.xmdvud004,l_xmdv.xmdvud005,l_xmdv.xmdvud006,l_xmdv.xmdvud007,
                         l_xmdv.xmdvud008,l_xmdv.xmdvud009,l_xmdv.xmdvud010,l_xmdv.xmdvud011,l_xmdv.xmdvud012,
                         l_xmdv.xmdvud013,l_xmdv.xmdvud014,l_xmdv.xmdvud015,l_xmdv.xmdvud016,l_xmdv.xmdvud017,
                         l_xmdv.xmdvud018,l_xmdv.xmdvud019,l_xmdv.xmdvud020,l_xmdv.xmdvud021,l_xmdv.xmdvud022,
                         l_xmdv.xmdvud023,l_xmdv.xmdvud024,l_xmdv.xmdvud025,l_xmdv.xmdvud026,l_xmdv.xmdvud027,
                         l_xmdv.xmdvud028,l_xmdv.xmdvud029,l_xmdv.xmdvud030)
                  #161109-00085#64 --e add
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdv_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF
               ELSE    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00006"
                  LET g_errparam.extend = 'INSERT'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  INITIALIZE g_xmdv_d[l_ac].* TO NULL
                  IF g_chk_transaction = 'N' THEN 
                     CALL s_transaction_end('N',0)
                  END IF
                  CANCEL INSERT
               END IF
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdv_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                  IF g_chk_transaction = 'N' THEN 
                     CALL s_transaction_end('N',0)                   
                  END IF                
                  CANCEL INSERT
               ELSE
                  IF g_chk_transaction = 'N' THEN 
                     CALL s_transaction_end('Y',0)
                  END IF
                  ERROR 'INSERT O.K'
                  LET g_rec_b = g_rec_b + 1
               END IF
               
            BEFORE DELETE                            #是否取消單身
               IF NOT cl_null(p_xmdvdocno) AND NOT cl_null(p_xmdvseq) 
                  AND NOT cl_null(g_xmdv_d[l_ac].xmdv001) 
                  AND NOT cl_null(g_xmdv_d[l_ac].xmdv002) THEN
		       
                  IF NOT cl_ask_del_detail() THEN
                     CANCEL DELETE
                  END IF
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CANCEL DELETE
                  END IF
                  DELETE FROM xmdv_t
                   WHERE xmdvent = g_enterprise 
                     AND xmdvdocno = p_xmdvdocno
                     AND xmdv001 = g_xmdv_d_t.xmdv001
                     AND xmdv002 = g_xmdv_d_t.xmdv002
               
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdv_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     IF g_chk_transaction = 'N' THEN 
                        CALL s_transaction_end('N',0)
                     END IF
                     CANCEL DELETE   
                  ELSE
                     LET g_rec_b = g_rec_b-1
                     IF g_chk_transaction = 'N' THEN 
                        CALL s_transaction_end('Y',0)
                     END IF
                  END IF 
                  CLOSE axmt420_01_cs
               END IF 
               
               
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  LET g_xmdv_d[l_ac].* = g_xmdv_d_t.*
                  CLOSE axmt420_01_cs
                  IF g_chk_transaction = 'N' THEN 
                     CALL s_transaction_end('N',0)
                  END IF
                  EXIT DIALOG 
               END IF
                 
               IF l_lock_sw = 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = -263
                  LET g_errparam.extend = l_xmdv.xmdv001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xmdv_d[l_ac].* = g_xmdv_d_t.*
               ELSE
                  UPDATE xmdv_t SET (xmdv001,xmdv002,xmdv003,xmdv004) = 
                                    (g_xmdv_d[l_ac].xmdv001,g_xmdv_d[l_ac].xmdv002,g_xmdv_d[l_ac].xmdv003,
                                     g_xmdv_d[l_ac].xmdv004)
                   WHERE xmdvent = g_enterprise
                     AND xmdvdocno = p_xmdvdocno
                     AND xmdvseq = p_xmdvseq
                     AND xmdv001 = g_xmdv_d_t.xmdv001
                     AND xmdv002 = g_xmdv_d_t.xmdv002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdv_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     LET g_xmdv_d[l_ac].* = g_xmdv_d_t.*
                     IF g_chk_transaction = 'N' THEN 
                        CALL s_transaction_end('N',0)
                     END IF
                  ELSE
                     IF g_chk_transaction = 'N' THEN 
                        CALL s_transaction_end('Y',0)               
                     END IF               
                  END IF
               END IF
               
            AFTER ROW
               CLOSE axmt420_01_cs
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdvdocno
            #add-point:BEFORE FIELD xmdvdocno name="input.b.page1.xmdvdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdvdocno
            
            #add-point:AFTER FIELD xmdvdocno name="input.a.page1.xmdvdocno"
            #此段落由子樣板a05產生
            IF  g_xmdv_d[l_ac].xmdvdocno IS NOT NULL AND g_xmdv_d[l_ac].xmdvseq IS NOT NULL AND g_xmdv_d[l_ac].xmdv001 IS NOT NULL AND g_xmdv_d[l_ac].xmdv002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdv_d[l_ac].xmdvdocno != g_xmdv_d_t.xmdvdocno OR g_xmdv_d[l_ac].xmdvseq != g_xmdv_d_t.xmdvseq OR g_xmdv_d[l_ac].xmdv001 != g_xmdv_d_t.xmdv001 OR g_xmdv_d[l_ac].xmdv002 != g_xmdv_d_t.xmdv002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdv_t WHERE "||"xmdvent = '" ||g_enterprise|| "' AND "||"xmdvdocno = '"||g_xmdv_d[l_ac].xmdvdocno ||"' AND "|| "xmdvseq = '"||g_xmdv_d[l_ac].xmdvseq ||"' AND "|| "xmdv001 = '"||g_xmdv_d[l_ac].xmdv001 ||"' AND "|| "xmdv002 = '"||g_xmdv_d[l_ac].xmdv002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdvdocno
            #add-point:ON CHANGE xmdvdocno name="input.g.page1.xmdvdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdvseq
            #add-point:BEFORE FIELD xmdvseq name="input.b.page1.xmdvseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdvseq
            
            #add-point:AFTER FIELD xmdvseq name="input.a.page1.xmdvseq"
            #此段落由子樣板a05產生
            IF  g_xmdv_d[l_ac].xmdvdocno IS NOT NULL AND g_xmdv_d[l_ac].xmdvseq IS NOT NULL AND g_xmdv_d[l_ac].xmdv001 IS NOT NULL AND g_xmdv_d[l_ac].xmdv002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdv_d[l_ac].xmdvdocno != g_xmdv_d_t.xmdvdocno OR g_xmdv_d[l_ac].xmdvseq != g_xmdv_d_t.xmdvseq OR g_xmdv_d[l_ac].xmdv001 != g_xmdv_d_t.xmdv001 OR g_xmdv_d[l_ac].xmdv002 != g_xmdv_d_t.xmdv002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdv_t WHERE "||"xmdvent = '" ||g_enterprise|| "' AND "||"xmdvdocno = '"||g_xmdv_d[l_ac].xmdvdocno ||"' AND "|| "xmdvseq = '"||g_xmdv_d[l_ac].xmdvseq ||"' AND "|| "xmdv001 = '"||g_xmdv_d[l_ac].xmdv001 ||"' AND "|| "xmdv002 = '"||g_xmdv_d[l_ac].xmdv002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdvseq
            #add-point:ON CHANGE xmdvseq name="input.g.page1.xmdvseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdv001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdv_d[l_ac].xmdv001,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmdv001
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdv001 name="input.a.page1.xmdv001"
            #此段落由子樣板a05產生
            
            IF NOT cl_ap_chk_Range(g_xmdv_d[l_ac].xmdv001,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdv001
            END IF

            IF NOT cl_null(g_xmdv_d[l_ac].xmdv001) THEN  
               IF NOT cl_null(g_xmdv_d[l_ac].xmdv002) THEN
                  IF g_xmdv_d[l_ac].xmdv001 > g_xmdv_d[l_ac].xmdv002 THEN  #起始數量不可大於截止數量
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00228'
                     LET g_errparam.extend = g_xmdv_d[l_ac].xmdv001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xmdv_d[l_ac].xmdv001 = g_xmdv_d_t.xmdv001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT axmt420_01_xmdv001_chk(g_xmdv_d[l_ac].xmdv001,g_xmdv_d[l_ac].xmdv002) THEN
                  LET g_xmdv_d[l_ac].xmdv001 = g_xmdv_d_t.xmdv001
                  NEXT FIELD CURRENT
               END IF                 
            END IF

            IF  g_xmdv_d[l_ac].xmdvdocno IS NOT NULL AND g_xmdv_d[l_ac].xmdvseq IS NOT NULL AND g_xmdv_d[l_ac].xmdv001 IS NOT NULL AND g_xmdv_d[l_ac].xmdv002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdv_d[l_ac].xmdvdocno != g_xmdv_d_t.xmdvdocno OR g_xmdv_d[l_ac].xmdvseq != g_xmdv_d_t.xmdvseq OR g_xmdv_d[l_ac].xmdv001 != g_xmdv_d_t.xmdv001 OR g_xmdv_d[l_ac].xmdv002 != g_xmdv_d_t.xmdv002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdv_t WHERE "||"xmdvent = '" ||g_enterprise|| "' AND "||"xmdvdocno = '"||g_xmdv_d[l_ac].xmdvdocno ||"' AND "|| "xmdvseq = '"||g_xmdv_d[l_ac].xmdvseq ||"' AND "|| "xmdv001 = '"||g_xmdv_d[l_ac].xmdv001 ||"' AND "|| "xmdv002 = '"||g_xmdv_d[l_ac].xmdv002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdv001
            #add-point:BEFORE FIELD xmdv001 name="input.b.page1.xmdv001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdv001
            #add-point:ON CHANGE xmdv001 name="input.g.page1.xmdv001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdv002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdv_d[l_ac].xmdv002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmdv002
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdv002 name="input.a.page1.xmdv002"
            #此段落由子樣板a05產生

            IF NOT cl_ap_chk_Range(g_xmdv_d[l_ac].xmdv002,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdv002
            END IF


            IF NOT cl_null(g_xmdv_d[l_ac].xmdv002) THEN
               IF NOT cl_null(g_xmdv_d[l_ac].xmdv001) THEN
                  IF g_xmdv_d[l_ac].xmdv002 < g_xmdv_d[l_ac].xmdv002 THEN   #截止數量不可小於起始數量
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00229'
                     LET g_errparam.extend = g_xmdv_d[l_ac].xmdv002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xmdv_d[l_ac].xmdv002 = g_xmdv_d_t.xmdv002
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT axmt420_01_xmdv001_chk(g_xmdv_d[l_ac].xmdv001,g_xmdv_d[l_ac].xmdv002) THEN
                  LET g_xmdv_d[l_ac].xmdv002 = g_xmdv_d_t.xmdv002
                  NEXT FIELD CURRENT
               END IF                  
            END IF
            
            IF g_xmdv_d[l_ac].xmdvdocno IS NOT NULL AND g_xmdv_d[l_ac].xmdvseq IS NOT NULL AND g_xmdv_d[l_ac].xmdv001 IS NOT NULL AND g_xmdv_d[l_ac].xmdv002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdv_d[l_ac].xmdvdocno != g_xmdv_d_t.xmdvdocno OR g_xmdv_d[l_ac].xmdvseq != g_xmdv_d_t.xmdvseq OR g_xmdv_d[l_ac].xmdv001 != g_xmdv_d_t.xmdv001 OR g_xmdv_d[l_ac].xmdv002 != g_xmdv_d_t.xmdv002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdv_t WHERE "||"xmdvent = '" ||g_enterprise|| "' AND "||"xmdvdocno = '"||g_xmdv_d[l_ac].xmdvdocno ||"' AND "|| "xmdvseq = '"||g_xmdv_d[l_ac].xmdvseq ||"' AND "|| "xmdv001 = '"||g_xmdv_d[l_ac].xmdv001 ||"' AND "|| "xmdv002 = '"||g_xmdv_d[l_ac].xmdv002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            CALL axmt420_01_xmdv001_round(g_xmdv_d[l_ac].xmdv002) RETURNING g_xmdv_d[l_ac].xmdv002
            DISPLAY BY NAME g_xmdv_d[l_ac].xmdv002   


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdv002
            #add-point:BEFORE FIELD xmdv002 name="input.b.page1.xmdv002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdv002
            #add-point:ON CHANGE xmdv002 name="input.g.page1.xmdv002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdv003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdv_d[l_ac].xmdv003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmdv003
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdv003 name="input.a.page1.xmdv003"
            IF NOT cl_ap_chk_Range(g_xmdv_d[l_ac].xmdv003,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdv003
            END IF

            IF NOT cl_null(g_xmdv_d[l_ac].xmdv003) THEN
               #呼叫幣別取位應用元件對單價作取位(依詢價單單頭幣別做取位基準)
               CALL s_curr_round(g_site,l_xmdt.xmdt005,g_xmdv_d[l_ac].xmdv003,'1') RETURNING g_xmdv_d[l_ac].xmdv003
               
               DISPLAY BY NAME g_xmdv_d[l_ac].xmdv003
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdv003
            #add-point:BEFORE FIELD xmdv003 name="input.b.page1.xmdv003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdv003
            #add-point:ON CHANGE xmdv003 name="input.g.page1.xmdv003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdv004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdv_d[l_ac].xmdv004,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD xmdv004
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdv004 name="input.a.page1.xmdv004"
            IF NOT cl_ap_chk_Range(g_xmdv_d[l_ac].xmdv004,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmdv004
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdv004
            #add-point:BEFORE FIELD xmdv004 name="input.b.page1.xmdv004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdv004
            #add-point:ON CHANGE xmdv004 name="input.g.page1.xmdv004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdvdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdvdocno
            #add-point:ON ACTION controlp INFIELD xmdvdocno name="input.c.page1.xmdvdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdvseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdvseq
            #add-point:ON ACTION controlp INFIELD xmdvseq name="input.c.page1.xmdvseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdv001
            #add-point:ON ACTION controlp INFIELD xmdv001 name="input.c.page1.xmdv001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdv002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdv002
            #add-point:ON ACTION controlp INFIELD xmdv002 name="input.c.page1.xmdv002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdv003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdv003
            #add-point:ON ACTION controlp INFIELD xmdv003 name="input.c.page1.xmdv003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdv004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdv004
            #add-point:ON ACTION controlp INFIELD xmdv004 name="input.c.page1.xmdv004"
            
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
   CALL axmt420_01_upd_xmdu(p_xmdvdocno,p_xmdvseq)
   #把放棄的狀態還原，才不會影響到主程式 
   IF INT_FLAG THEN 
      LET INT_FLAG = FALSE 
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axmt420_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt420_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt420_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 分量計價單身填充
# Memo...........:
# Usage..........: CALL axmt420_01_b_fill(p_xmdvdocno,p_xmdvseq)
# Input parameter: 
# Return code....: 
# Date & Author..: 14/02/11 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION axmt420_01_b_fill(p_xmdvdocno,p_xmdvseq)
   DEFINE l_sql   STRING 
   DEFINE p_xmdvdocno   LIKE xmdv_t.xmdvdocno
   DEFINE p_xmdvseq     LIKE xmdv_t.xmdvseq
   
   LET l_sql = "SELECT xmdvdocno,xmdvseq,xmdv001,xmdv002,xmdv003,xmdv004 ",
               "  FROM xmdv_t ",
               " WHERE xmdvdocno = '",p_xmdvdocno CLIPPED,"' ",
               "   AND xmdvseq   = ",p_xmdvseq," ",
               "   AND xmdvent   = '",g_enterprise CLIPPED,"' "
   PREPARE axmt420_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR axmt420_01_pb 
   
   CALL g_xmdv_d.clear()
   LET l_ac_t = l_ac
   LET l_ac = 1
   #FOREACH b_fill_curs INTO g_xmdv_d[l_ac].* #161109-00085#64 mark
   #161109-00085#64 --s add
   FOREACH b_fill_curs INTO g_xmdv_d[l_ac].xmdvdocno,g_xmdv_d[l_ac].xmdvseq,g_xmdv_d[l_ac].xmdv001,g_xmdv_d[l_ac].xmdv002,g_xmdv_d[l_ac].xmdv003,
                            g_xmdv_d[l_ac].xmdv004
   #161109-00085#64 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH 
   CALL g_xmdv_d.deleteElement(g_xmdv_d.getLength())   
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = l_ac_t
   CLOSE b_fill_curs
   FREE axmt420_01_pb
END FUNCTION
################################################################################
# Descriptions...: 離開程式前更新主程式單身單價資訊
# Memo...........:
# Usage..........: CALL axmt420_01_upd_xmdu(p_xmdvdocno,p_xmdvseq)
# Input parameter: 
# Return code....: 
# Date & Author..: 14/02/11 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION axmt420_01_upd_xmdu(p_xmdvdocno,p_xmdvseq)
   DEFINE l_amt         LIKE type_t.num20_6
   DEFINE p_xmdvdocno   LIKE xmdv_t.xmdvdocno
   DEFINE p_xmdvseq     LIKE xmdv_t.xmdvseq
   DEFINE l_xmdv        RECORD
                xmdv001 LIKE xmdv_t.xmdv001,
                xmdv002 LIKE xmdv_t.xmdv002,
                xmdv003 LIKE xmdv_t.xmdv003,
                xmdv004 LIKE xmdv_t.xmdv004
                        END RECORD
   
   INITIALIZE l_xmdv.* TO NULL
   SELECT xmdv001,xmdv002,xmdv003,xmdv004 
     INTO l_xmdv.xmdv001,l_xmdv.xmdv002,l_xmdv.xmdv003,l_xmdv.xmdv004
     FROM xmdv_t
    WHERE xmdvdocno = p_xmdvdocno
      AND xmdvseq   = p_xmdvseq
      AND xmdvent   = g_enterprise
      AND xmdv003 > 0 
    ORDER BY xmdv003

      
   IF cl_null(l_xmdv.xmdv003)THEN LET l_xmdv.xmdv003 = 0 END IF
   IF cl_null(l_xmdv.xmdv004)THEN LET l_xmdv.xmdv004 = 0 END IF
   
   UPDATE xmdu_t SET xmdu011 = l_xmdv.xmdv003,
                     xmdu013 = l_xmdv.xmdv004
    WHERE xmdudocno = p_xmdvdocno
      AND xmduseq   = p_xmdvseq
      AND xmduent   = g_enterprise
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'axmt420_01_upd_xmdu'
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
      
END FUNCTION
################################################################################
# Descriptions...: 起始數量檢查
# Memo...........:
# Usage..........: CALL axmt420_01_xmdv001_chk(p_xmdv001,p_xmdv002)
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 14/02/13 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION axmt420_01_xmdv001_chk(p_xmdv001,p_xmdv002)
   DEFINE l_count   LIKE type_t.num5
   DEFINE p_xmdv001 LIKE xmdv_t.xmdv001
   DEFINE p_xmdv002 LIKE xmdv_t.xmdv002
   DEFINE l_xmdv001 LIKE xmdv_t.xmdv001
   DEFINE l_xmdv002 LIKE xmdv_t.xmdv002
   DEFINE l_sql     STRING

   #如果之前沒資料就不檢查
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xmdv_t
    WHERE xmdvent = g_enterprise
      AND xmdvdocno = g_xmdvdocno
      AND xmdvseq   = g_xmdvseq 
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN RETURN TRUE END IF

   #起始值或截止值落入先前存在的區間(排除此筆)
   LET l_count = NULL
   #SELECT COUNT(*) INTO l_count FROM xmdv_t
   # WHERE xmdvent = g_enterprise
   #   AND xmdvdocno = g_xmdvdocno
   #   AND xmdvseq   = g_xmdvseq
   #   AND ((xmdv001   BETWEEN p_xmdv001 AND p_xmdv002) 
   #        OR (xmdv002 BETWEEN p_xmdv001 AND p_xmdv002))
   #   AND xmdv001 <> g_xmdv_d_t.xmdv001
   #   AND xmdv002 <> g_xmdv_d_t.xmdv002     
      
   LET l_sql = "SELECT COUNT(*) FROM xmdv_t ",
               " WHERE xmdvent = '",g_enterprise,"' ",
               "   AND xmdvdocno = '",g_xmdvdocno,"' ",
               "   AND xmdvseq   = ",g_xmdvseq," ",
               "   AND ((xmdv001   BETWEEN ",p_xmdv001," AND ",p_xmdv002,")  ",
               "   OR (xmdv002 BETWEEN ",p_xmdv001," AND ",p_xmdv002,")) "
               
   IF NOT cl_null(g_xmdv_d_t.xmdv001) AND NOT cl_null(g_xmdv_d_t.xmdv002)THEN
      LET l_sql = l_sql CLIPPED," AND xmdv001 <> ",g_xmdv_d_t.xmdv001," ",
                                " AND xmdv002 <> ",g_xmdv_d_t.xmdv002," "
   END IF
   PREPARE sel_xmdv001_chkp1 FROM l_sql
   EXECUTE sel_xmdv001_chkp1 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF

   IF l_count = 0 THEN
      #起始值或截止值落入輸入的區間(排除此筆)
      LET l_count = NULL
      #SELECT COUNT(*) INTO l_count FROM xmdv_t
      # WHERE xmdvent = g_enterprise
      #   AND xmdvdocno = g_xmdvdocno
      #   AND xmdvseq   = g_xmdvseq
      #   AND ((xmdv001 <= p_xmdv001
      #         AND xmdv002 >= p_xmdv001)
      #         OR (xmdv002 >=p_xmdv002 AND xmdv001 <= p_xmdv002))
      #   AND xmdv001 <> g_xmdv_d_t.xmdv001
      #   AND xmdv002 <> g_xmdv_d_t.xmdv002     
         
      LET l_sql = " SELECT COUNT(*) FROM xmdv_t ",
                  "  WHERE xmdvent = '",g_enterprise,"' ",
                  "    AND xmdvdocno = '",g_xmdvdocno,"' ",
                  "    AND xmdvseq   =  ",g_xmdvseq," ",
                  "    AND ((xmdv001 <= ",p_xmdv001," ",
                  "          AND xmdv002 >= ",p_xmdv001,") ",
                  "         OR (xmdv002 >= ",p_xmdv002," AND xmdv001 <= ",p_xmdv002,")) "
                  
      IF NOT cl_null(g_xmdv_d_t.xmdv001) AND NOT cl_null(g_xmdv_d_t.xmdv002)THEN
         LET l_sql = l_sql CLIPPED," AND xmdv001 <> ",g_xmdv_d_t.xmdv001," ",
                                   " AND xmdv002 <> ",g_xmdv_d_t.xmdv002," "
      END IF   
      PREPARE sel_xmdv001_chkp2 FROM l_sql
      EXECUTE sel_xmdv001_chkp2 INTO l_count
      
      IF cl_null(l_count)THEN LET l_count = 0 END IF     
      IF l_count = 0 THEN
      ELSE
         #起始值或截止值落入輸入的區間(排除此筆)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00227'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF      
   ELSE
      #起始值或截止值落入先前存在的區間(排除此筆)
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00227'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN FALSE
   END IF
   
   RETURN TRUE
   
END FUNCTION

PUBLIC FUNCTION axmt420_01_xmdv001_round(p_xmdv001)
   DEFINE p_xmdv001   LIKE xmdv_t.xmdv001
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooca002   LIKE ooca_t.ooca002     
   DEFINE l_ooca004   LIKE ooca_t.ooca004      
   DEFINE r_xmdv001   LIKE xmdv_t.xmdv001

       LET l_success = NULL
       LET l_ooca002 = 0
       LET l_ooca004 = NULL

       LET r_xmdv001 = p_xmdv001

       IF NOT cl_null(p_xmdv001) THEN
          IF NOT cl_null(g_xmdu008) THEN
             CALL s_aooi250_get_msg(g_xmdu008) RETURNING l_success,l_ooca002,l_ooca004
             IF l_success THEN
                CALL s_num_round(l_ooca004,p_xmdv001,l_ooca002) RETURNING r_xmdv001
             END IF
          END IF
       END IF
       RETURN r_xmdv001
END FUNCTION

 
{</section>}
 
