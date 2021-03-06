#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt420_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-10-24 15:02:15), PR版次:0011(2017-01-19 14:21:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: aapt420_01
#+ Description: 自動產生付款核銷資料
#+ Creator....: 03538(2014-10-21 16:31:36)
#+ Modifier...: 03538 -SD/PR- 00768
 
{</section>}
 
{<section id="aapt420_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150817-00025#1  2015/08/19 By Reanna 增加差異處理時要預帶科目
#160328-00012#1  2016/03/28 By fengmy 增加溢付转待抵款默认转入账款单别&科目
#160509-00004#89 2016/07/01 By 03538  來源應改為現在執行的作業
#161104-00024#3  2016/11/09 By 08729  處理DEFINE有星號
#161129-00052#1  2016/12/01 By catmoon 不論差異處理選擇何項都需預帶會計科目
#161127-00008#1  2016/12/06 By dorishsu 當付款幣別和賬款幣別為同一幣別時,差異幣別放賬款幣別,匯率為賬款幣別對本幣匯率
#161208-00026#9  2016/12/12 By 08729    針對SELECT有星號的部分進行展開
#170119-00015#1  2017/01/19 By 00768    修改汇率取得的方式，应该考虑是日汇率还是月汇率
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util  #170119-00015#1 add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apcc_m        RECORD
       type LIKE type_t.chr1, 
   apeadocno LIKE type_t.chr20, 
   apea005 LIKE type_t.chr10, 
   apeasite LIKE type_t.chr10, 
   apeacomp LIKE type_t.chr10, 
   nmcldocno1 LIKE type_t.chr20, 
   nmcldocno2 LIKE type_t.chr20
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm    RECORD 
             order01     LIKE type_t.chr1,
             order02     LIKE type_t.chr1,
             order03     LIKE type_t.chr1,
             apeasite    LIKE type_t.chr10, 
             apeadocno   LIKE type_t.chr20, 
             apeadocdt   LIKE type_t.dat, 
             apea009     LIKE type_t.chr10, 
             withouttips LIKE type_t.chr80, 
             nmad002     LIKE type_t.chr10, 
             apee012     LIKE type_t.chr10,  
             apea018     LIKE type_t.chr10,  
             apea017     LIKE type_t.chr500
             END RECORD
             
#DEFINE g_apea            RECORD LIKE apea_t.* #161104-00024#3 mark
#DEFINE g_apda            RECORD LIKE apda_t.* #161104-00024#3 mark
#161104-00024#3-add(s)
DEFINE g_apea  RECORD  #付款申請主檔
       apeaent   LIKE apea_t.apeaent, #企業編號
       apeacomp  LIKE apea_t.apeacomp, #代付法人(集團)
       apeald    LIKE apea_t.apeald, #帳套
       apeadocno LIKE apea_t.apeadocno, #請款單號
       apeadocdt LIKE apea_t.apeadocdt, #單據日期
       apeasite  LIKE apea_t.apeasite, #資金中心
       apea001   LIKE apea_t.apea001, #請款單性質
       apea003   LIKE apea_t.apea003, #帳務人員
       apea005   LIKE apea_t.apea005, #付款對象
       apea006   LIKE apea_t.apea006, #一次性交易識別碼
       apea007   LIKE apea_t.apea007, #產生方式
       apea008   LIKE apea_t.apea008, #來源參考單號
       apea009   LIKE apea_t.apea009, #沖帳批序號
       apea010   LIKE apea_t.apea010, #集團代付批號
       apea011   LIKE apea_t.apea011, #差異處理
       apea013   LIKE apea_t.apea013, #已付款註記
       apea014   LIKE apea_t.apea014, #拋轉傳票號碼
       apea015   LIKE apea_t.apea015, #作廢理由碼
       apea016   LIKE apea_t.apea016, #列印次數
       apea017   LIKE apea_t.apea017, #MEMO備註
       apea018   LIKE apea_t.apea018, #付款(攤銷)理由碼
       apea022   LIKE apea_t.apea022, #集團代付款否
       apea023   LIKE apea_t.apea023, #付款核銷者
       apea024   LIKE apea_t.apea024, #付款核銷日期
       apeaownid LIKE apea_t.apeaownid, #資料所有者
       apeaowndp LIKE apea_t.apeaowndp, #資料所屬部門
       apeacrtid LIKE apea_t.apeacrtid, #資料建立者
       apeacrtdp LIKE apea_t.apeacrtdp, #資料建立部門
       apeacrtdt LIKE apea_t.apeacrtdt, #資料創建日
       apeamodid LIKE apea_t.apeamodid, #資料修改者
       apeamoddt LIKE apea_t.apeamoddt, #最近修改日
       apeacnfid LIKE apea_t.apeacnfid, #資料確認者
       apeacnfdt LIKE apea_t.apeacnfdt, #資料確認日
       apeapstid LIKE apea_t.apeapstid, #資料過帳者
       apeapstdt LIKE apea_t.apeapstdt, #資料過帳日
       apeastus  LIKE apea_t.apeastus, #狀態碼
       apeaud001 LIKE apea_t.apeaud001, #自定義欄位(文字)001
       apeaud002 LIKE apea_t.apeaud002, #自定義欄位(文字)002
       apeaud003 LIKE apea_t.apeaud003, #自定義欄位(文字)003
       apeaud004 LIKE apea_t.apeaud004, #自定義欄位(文字)004
       apeaud005 LIKE apea_t.apeaud005, #自定義欄位(文字)005
       apeaud006 LIKE apea_t.apeaud006, #自定義欄位(文字)006
       apeaud007 LIKE apea_t.apeaud007, #自定義欄位(文字)007
       apeaud008 LIKE apea_t.apeaud008, #自定義欄位(文字)008
       apeaud009 LIKE apea_t.apeaud009, #自定義欄位(文字)009
       apeaud010 LIKE apea_t.apeaud010, #自定義欄位(文字)010
       apeaud011 LIKE apea_t.apeaud011, #自定義欄位(數字)011
       apeaud012 LIKE apea_t.apeaud012, #自定義欄位(數字)012
       apeaud013 LIKE apea_t.apeaud013, #自定義欄位(數字)013
       apeaud014 LIKE apea_t.apeaud014, #自定義欄位(數字)014
       apeaud015 LIKE apea_t.apeaud015, #自定義欄位(數字)015
       apeaud016 LIKE apea_t.apeaud016, #自定義欄位(數字)016
       apeaud017 LIKE apea_t.apeaud017, #自定義欄位(數字)017
       apeaud018 LIKE apea_t.apeaud018, #自定義欄位(數字)018
       apeaud019 LIKE apea_t.apeaud019, #自定義欄位(數字)019
       apeaud020 LIKE apea_t.apeaud020, #自定義欄位(數字)020
       apeaud021 LIKE apea_t.apeaud021, #自定義欄位(日期時間)021
       apeaud022 LIKE apea_t.apeaud022, #自定義欄位(日期時間)022
       apeaud023 LIKE apea_t.apeaud023, #自定義欄位(日期時間)023
       apeaud024 LIKE apea_t.apeaud024, #自定義欄位(日期時間)024
       apeaud025 LIKE apea_t.apeaud025, #自定義欄位(日期時間)025
       apeaud026 LIKE apea_t.apeaud026, #自定義欄位(日期時間)026
       apeaud027 LIKE apea_t.apeaud027, #自定義欄位(日期時間)027
       apeaud028 LIKE apea_t.apeaud028, #自定義欄位(日期時間)028
       apeaud029 LIKE apea_t.apeaud029, #自定義欄位(日期時間)029
       apeaud030 LIKE apea_t.apeaud030, #自定義欄位(日期時間)030
       apea019   LIKE apea_t.apea019, #請款起始年度
       apea020   LIKE apea_t.apea020, #請款起始月份
       apea025   LIKE apea_t.apea025, #請款截止年度
       apea026   LIKE apea_t.apea026, #請款截止月份
       apea027   LIKE apea_t.apea027  #對公否
           END RECORD
DEFINE g_apda  RECORD  #付款核銷單單頭檔
       apdaent   LIKE apda_t.apdaent, #企業編號
       apdacomp  LIKE apda_t.apdacomp, #法人
       apdald    LIKE apda_t.apdald, #帳套
       apdadocno LIKE apda_t.apdadocno, #單號
       apdadocdt LIKE apda_t.apdadocdt, #單據日期
       apdasite  LIKE apda_t.apdasite, #帳務組織
       apda001   LIKE apda_t.apda001, #帳款單性質
       apda002   LIKE apda_t.apda002, #NO USE
       apda003   LIKE apda_t.apda003, #帳務人員
       apda004   LIKE apda_t.apda004, #帳款核銷對象
       apda005   LIKE apda_t.apda005, #付款對象
       apda006   LIKE apda_t.apda006, #一次性交易識別碼
       apda007   LIKE apda_t.apda007, #產生方式
       apda008   LIKE apda_t.apda008, #來源參考單號
       apda009   LIKE apda_t.apda009, #沖帳批序號
       apda010   LIKE apda_t.apda010, #集團代付付單號
       apda011   LIKE apda_t.apda011, #差異處理
       apda012   LIKE apda_t.apda012, #退款類型
       apda013   LIKE apda_t.apda013, #分錄底稿是否可重新產生
       apda014   LIKE apda_t.apda014, #拋轉傳票號碼
       apda015   LIKE apda_t.apda015, #作廢理由碼
       apda016   LIKE apda_t.apda016, #列印次數
       apda017   LIKE apda_t.apda017, #MEMO備註
       apda018   LIKE apda_t.apda018, #付款(攤銷)理由碼
       apda019   LIKE apda_t.apda019, #攤銷目的方式
       apda020   LIKE apda_t.apda020, #分攤金額方式
       apda021   LIKE apda_t.apda021, #目的成本要素
       apda113   LIKE apda_t.apda113, #應核銷本幣金額
       apda123   LIKE apda_t.apda123, #應核銷本幣二金額
       apda133   LIKE apda_t.apda133, #應核銷本幣三金額
       apdaownid LIKE apda_t.apdaownid, #資料所有者
       apdaowndp LIKE apda_t.apdaowndp, #資料所屬部門
       apdacrtid LIKE apda_t.apdacrtid, #資料建立者
       apdacrtdp LIKE apda_t.apdacrtdp, #資料建立部門
       apdacrtdt LIKE apda_t.apdacrtdt, #資料創建日
       apdamodid LIKE apda_t.apdamodid, #資料修改者
       apdamoddt LIKE apda_t.apdamoddt, #最近修改日
       apdacnfid LIKE apda_t.apdacnfid, #資料確認者
       apdacnfdt LIKE apda_t.apdacnfdt, #資料確認日
       apdapstid LIKE apda_t.apdapstid, #資料過帳者
       apdapstdt LIKE apda_t.apdapstdt, #資料過帳日
       apdastus  LIKE apda_t.apdastus, #狀態碼
       apdaud001 LIKE apda_t.apdaud001, #自定義欄位(文字)001
       apdaud002 LIKE apda_t.apdaud002, #自定義欄位(文字)002
       apdaud003 LIKE apda_t.apdaud003, #自定義欄位(文字)003
       apdaud004 LIKE apda_t.apdaud004, #自定義欄位(文字)004
       apdaud005 LIKE apda_t.apdaud005, #自定義欄位(文字)005
       apdaud006 LIKE apda_t.apdaud006, #自定義欄位(文字)006
       apdaud007 LIKE apda_t.apdaud007, #自定義欄位(文字)007
       apdaud008 LIKE apda_t.apdaud008, #自定義欄位(文字)008
       apdaud009 LIKE apda_t.apdaud009, #自定義欄位(文字)009
       apdaud010 LIKE apda_t.apdaud010, #自定義欄位(文字)010
       apdaud011 LIKE apda_t.apdaud011, #自定義欄位(數字)011
       apdaud012 LIKE apda_t.apdaud012, #自定義欄位(數字)012
       apdaud013 LIKE apda_t.apdaud013, #自定義欄位(數字)013
       apdaud014 LIKE apda_t.apdaud014, #自定義欄位(數字)014
       apdaud015 LIKE apda_t.apdaud015, #自定義欄位(數字)015
       apdaud016 LIKE apda_t.apdaud016, #自定義欄位(數字)016
       apdaud017 LIKE apda_t.apdaud017, #自定義欄位(數字)017
       apdaud018 LIKE apda_t.apdaud018, #自定義欄位(數字)018
       apdaud019 LIKE apda_t.apdaud019, #自定義欄位(數字)019
       apdaud020 LIKE apda_t.apdaud020, #自定義欄位(數字)020
       apdaud021 LIKE apda_t.apdaud021, #自定義欄位(日期時間)021
       apdaud022 LIKE apda_t.apdaud022, #自定義欄位(日期時間)022
       apdaud023 LIKE apda_t.apdaud023, #自定義欄位(日期時間)023
       apdaud024 LIKE apda_t.apdaud024, #自定義欄位(日期時間)024
       apdaud025 LIKE apda_t.apdaud025, #自定義欄位(日期時間)025
       apdaud026 LIKE apda_t.apdaud026, #自定義欄位(日期時間)026
       apdaud027 LIKE apda_t.apdaud027, #自定義欄位(日期時間)027
       apdaud028 LIKE apda_t.apdaud028, #自定義欄位(日期時間)028
       apdaud029 LIKE apda_t.apdaud029, #自定義欄位(日期時間)029
       apdaud030 LIKE apda_t.apdaud030, #自定義欄位(日期時間)030
       apda104   LIKE apda_t.apda104, #原幣借方金額合計
       apda105   LIKE apda_t.apda105, #原幣貸方金額合計
       apda114   LIKE apda_t.apda114, #本幣借方金額合計
       apda115   LIKE apda_t.apda115, #本幣貸方金額合計
       apda124   LIKE apda_t.apda124, #本位幣二借方金額合計
       apda125   LIKE apda_t.apda125, #本位幣二貸方金額合計
       apda134   LIKE apda_t.apda134, #本位幣三借方金額合計
       apda135   LIKE apda_t.apda135, #本位幣三貸方金額合計
       apda022   LIKE apda_t.apda022, #經營方式
       apda023   LIKE apda_t.apda023  #請款單號
           END RECORD  
#161104-00024#3-add(e)
DEFINE g_apee            RECORD
             apee001   LIKE apee_t.apee001,
             apee002   LIKE apee_t.apee002,
             apee003   LIKE apee_t.apee003,
             apee004   LIKE apee_t.apee004,
             apee005   LIKE apee_t.apee005,
             apee006   LIKE apee_t.apee006,
             apee008   LIKE apee_t.apee008,
             apee009   LIKE apee_t.apee009,
             apee010   LIKE apee_t.apee010,
             apee011   LIKE apee_t.apee011,
             apee012   LIKE apee_t.apee012,
             apee013   LIKE apee_t.apee013,
             apee014   LIKE apee_t.apee014,
             apee015   LIKE apee_t.apee015,
             apee016   LIKE apee_t.apee016,
             apee017   LIKE apee_t.apee017,
             apee018   LIKE apee_t.apee018,
             apee021   LIKE apee_t.apee021,
             apee024   LIKE apee_t.apee024,
             apee025   LIKE apee_t.apee025,
             apee028   LIKE apee_t.apee028,
             apee031   LIKE apee_t.apee031,
             apee032   LIKE apee_t.apee032,
             apee033   LIKE apee_t.apee033,
             apee034   LIKE apee_t.apee034,
             apee100   LIKE apee_t.apee100,
             apee101   LIKE apee_t.apee101,
             apee109   LIKE apee_t.apee109,
             apee119   LIKE apee_t.apee119,
             apeecomp  LIKE apee_t.apeecomp,
             apeedocno LIKE apee_t.apeedocno,
             apeeent   LIKE apee_t.apeeent,
             apeeorga  LIKE apee_t.apeeorga,
             apeeseq   LIKE apee_t.apeeseq,
             apeesite  LIKE apee_t.apeesite
                         END RECORD  
DEFINE g_apde            RECORD
             apde001   LIKE apde_t.apde001,
             apde002   LIKE apde_t.apde002,
             apde003   LIKE apde_t.apde003,
             apde004   LIKE apde_t.apde004,
             apde006   LIKE apde_t.apde006,
             apde008   LIKE apde_t.apde008,
             apde009   LIKE apde_t.apde009,
             apde010   LIKE apde_t.apde010,
             apde011   LIKE apde_t.apde011,
             apde012   LIKE apde_t.apde012,
             apde013   LIKE apde_t.apde013,
             apde014   LIKE apde_t.apde014,
             apde015   LIKE apde_t.apde015,
             apde016   LIKE apde_t.apde016,
             apde017   LIKE apde_t.apde017,
             apde018   LIKE apde_t.apde018,
             apde021   LIKE apde_t.apde021,
             apde028   LIKE apde_t.apde028,
             apde032   LIKE apde_t.apde032,
             apde100   LIKE apde_t.apde100,
             apde101   LIKE apde_t.apde101,
             apde109   LIKE apde_t.apde109,
             apde119   LIKE apde_t.apde119,
             apdeld  LIKE apde_t.apdeld,
             apdecomp  LIKE apde_t.apdecomp,
             apdedocno LIKE apde_t.apdedocno,
             apdeent   LIKE apde_t.apdeent,
             apdeorga  LIKE apde_t.apdeorga,
             apdeseq   LIKE apde_t.apdeseq,
             apdesite  LIKE apde_t.apdesite
                         END RECORD                           
DEFINE g_crossdoc_key    RECORD                #拆單條件
             apca005    LIKE apca_t.apca005,
             apca057    LIKE apca_t.apca057,   
             apcc100    LIKE apcc_t.apcc100,
             apcc003    LIKE apcc_t.apcc003,
             apcc002    LIKE apcc_t.apcc002
                         END RECORD
DEFINE g_tmp2            RECORD
             apccdocno     LIKE apcc_t.apccdocno,
             apccseq       LIKE apcc_t.apccseq,
             apcc001       LIKE apcc_t.apcc001,
             apccent       LIKE apcc_t.apccent,
             apccld        LIKE apcc_t.apccld,
             apca005       LIKE apca_t.apca005,
             apcc002       LIKE apcc_t.apcc002,
             apcc003       LIKE apcc_t.apcc003,
             apcc100       LIKE apcc_t.apcc100,
             apca004       LIKE apca_t.apca004,
             apca057       LIKE apca_t.apca057,
             apcb002       LIKE apcb_t.apcb002    #交易單號             
                         END RECORD
DEFINE g_glaa005     LIKE glaa_t.glaa005
DEFINE g_glaacomp    LIKE glaa_t.glaacomp

#DEFINE g_apca        RECORD LIKE apca_t.* #161104-00024#3 mark
#161104-00024#3-add(s)
DEFINE g_apca  RECORD  #應付憑單單頭
       apcaent   LIKE apca_t.apcaent, #企業編號
       apcaownid LIKE apca_t.apcaownid, #資料所有者
       apcaowndp LIKE apca_t.apcaowndp, #資料所有部門
       apcacrtid LIKE apca_t.apcacrtid, #資料建立者
       apcacrtdp LIKE apca_t.apcacrtdp, #資料建立部門
       apcacrtdt LIKE apca_t.apcacrtdt, #資料創建日
       apcamodid LIKE apca_t.apcamodid, #資料修改者
       apcamoddt LIKE apca_t.apcamoddt, #最近修改日
       apcacnfid LIKE apca_t.apcacnfid, #資料確認者
       apcacnfdt LIKE apca_t.apcacnfdt, #資料確認日
       apcapstid LIKE apca_t.apcapstid, #資料過帳者
       apcapstdt LIKE apca_t.apcapstdt, #資料過帳日
       apcastus  LIKE apca_t.apcastus, #狀態碼
       apcald    LIKE apca_t.apcald, #帳套
       apcacomp  LIKE apca_t.apcacomp, #法人
       apcadocno LIKE apca_t.apcadocno, #應付帳款單號碼
       apcadocdt LIKE apca_t.apcadocdt, #帳款日期
       apcasite  LIKE apca_t.apcasite, #帳務中心
       apca001   LIKE apca_t.apca001, #帳款單性質
       apca003   LIKE apca_t.apca003, #帳務人員
       apca004   LIKE apca_t.apca004, #帳款對象編號
       apca005   LIKE apca_t.apca005, #付款對象
       apca006   LIKE apca_t.apca006, #供應商分類
       apca007   LIKE apca_t.apca007, #帳款類別
       apca008   LIKE apca_t.apca008, #付款條件編號
       apca009   LIKE apca_t.apca009, #應付款日/應扣抵日
       apca010   LIKE apca_t.apca010, #容許票據到期日
       apca011   LIKE apca_t.apca011, #稅別
       apca012   LIKE apca_t.apca012, #稅率
       apca013   LIKE apca_t.apca013, #含稅否
       apca014   LIKE apca_t.apca014, #人員編號
       apca015   LIKE apca_t.apca015, #部門編號
       apca016   LIKE apca_t.apca016, #來源作業類型
       apca017   LIKE apca_t.apca017, #產生方式
       apca018   LIKE apca_t.apca018, #來源參考單號
       apca019   LIKE apca_t.apca019, #系統產生對應單號(待抵帳款-預付)
       apca020   LIKE apca_t.apca020, #信用狀付款否
       apca021   LIKE apca_t.apca021, #商業發票號碼(IV no.)
       apca022   LIKE apca_t.apca022, #進口報單號碼
       apca025   LIKE apca_t.apca025, #差異處理(發票與帳款差異)
       apca026   LIKE apca_t.apca026, #原幣未稅差異
       apca027   LIKE apca_t.apca027, #原幣稅額差異
       apca028   LIKE apca_t.apca028, #本幣未稅差異
       apca029   LIKE apca_t.apca029, #本幣幣稅額差異
       apca030   LIKE apca_t.apca030, #差異科目
       apca031   LIKE apca_t.apca031, #產生之差異折讓單號
       apca032   LIKE apca_t.apca032, #發票類型
       apca033   LIKE apca_t.apca033, #專案編號
       apca034   LIKE apca_t.apca034, #責任中心
       apca035   LIKE apca_t.apca035, #應付(貸方)科目編號
       apca036   LIKE apca_t.apca036, #費用(借方)科目編號
       apca037   LIKE apca_t.apca037, #產生傳票否
       apca038   LIKE apca_t.apca038, #拋轉傳票號碼
       apca039   LIKE apca_t.apca039, #會計檢核附件份數
       apca040   LIKE apca_t.apca040, #留置否
       apca041   LIKE apca_t.apca041, #留置理由碼
       apca042   LIKE apca_t.apca042, #留置設定日期
       apca043   LIKE apca_t.apca043, #留置解除日期
       apca044   LIKE apca_t.apca044, #留置原幣金額
       apca045   LIKE apca_t.apca045, #留置說明
       apca046   LIKE apca_t.apca046, #關係人否
       apca047   LIKE apca_t.apca047, #多角序號
       apca048   LIKE apca_t.apca048, #集團代付/代付單號
       apca049   LIKE apca_t.apca049, #來源營運中心編號
       apca050   LIKE apca_t.apca050, #交易原始單據份數
       apca051   LIKE apca_t.apca051, #作廢理由碼
       apca052   LIKE apca_t.apca052, #列印次數
       apca053   LIKE apca_t.apca053, #備註
       apca054   LIKE apca_t.apca054, #多帳期設定
       apca055   LIKE apca_t.apca055, #繳款優惠條件
       apca056   LIKE apca_t.apca056, #會計檢核附件狀態
       apca057   LIKE apca_t.apca057, #交易對象識別碼
       apca058   LIKE apca_t.apca058, #稅別交易類型
       apca059   LIKE apca_t.apca059, #預算編號
       apca060   LIKE apca_t.apca060, #發票開立方式
       apca061   LIKE apca_t.apca061, #預開發票基準日
       apca062   LIKE apca_t.apca062, #多角性質
       apca063   LIKE apca_t.apca063, #整帳批序號
       apca064   LIKE apca_t.apca064, #訂金序次
       apca065   LIKE apca_t.apca065, #發票編號
       apca066   LIKE apca_t.apca066, #發票號碼
       apca100   LIKE apca_t.apca100, #交易原幣別
       apca101   LIKE apca_t.apca101, #原幣匯率
       apca103   LIKE apca_t.apca103, #原幣未稅金額
       apca104   LIKE apca_t.apca104, #原幣稅額
       apca106   LIKE apca_t.apca106, #原幣應稅折抵合計金額
       apca107   LIKE apca_t.apca107, #NO USE
       apca108   LIKE apca_t.apca108, #原幣應付金額
       apca113   LIKE apca_t.apca113, #本幣未稅金額
       apca114   LIKE apca_t.apca114, #本幣稅額
       apca116   LIKE apca_t.apca116, #本幣應稅折抵合計金額
       apca117   LIKE apca_t.apca117, #NO USE
       apca118   LIKE apca_t.apca118, #本幣應付金額
       apca120   LIKE apca_t.apca120, #本位幣二幣別
       apca121   LIKE apca_t.apca121, #本位幣二匯率
       apca123   LIKE apca_t.apca123, #本位幣二未稅金額
       apca124   LIKE apca_t.apca124, #本位幣二稅額
       apca126   LIKE apca_t.apca126, #本位幣二應稅折抵合計金額
       apca127   LIKE apca_t.apca127, #NO USE
       apca128   LIKE apca_t.apca128, #本位幣二應付金額
       apca130   LIKE apca_t.apca130, #本位幣三幣別
       apca131   LIKE apca_t.apca131, #本位幣三匯率
       apca133   LIKE apca_t.apca133, #本位幣三未稅金額
       apca134   LIKE apca_t.apca134, #本位幣三稅額
       apca136   LIKE apca_t.apca136, #本位幣三應稅折抵合計金額
       apca137   LIKE apca_t.apca137, #NO USE
       apca138   LIKE apca_t.apca138, #本位幣三應付金額
       apcaud001 LIKE apca_t.apcaud001, #自定義欄位(文字)001
       apcaud002 LIKE apca_t.apcaud002, #自定義欄位(文字)002
       apcaud003 LIKE apca_t.apcaud003, #自定義欄位(文字)003
       apcaud004 LIKE apca_t.apcaud004, #自定義欄位(文字)004
       apcaud005 LIKE apca_t.apcaud005, #自定義欄位(文字)005
       apcaud006 LIKE apca_t.apcaud006, #自定義欄位(文字)006
       apcaud007 LIKE apca_t.apcaud007, #自定義欄位(文字)007
       apcaud008 LIKE apca_t.apcaud008, #自定義欄位(文字)008
       apcaud009 LIKE apca_t.apcaud009, #自定義欄位(文字)009
       apcaud010 LIKE apca_t.apcaud010, #自定義欄位(文字)010
       apcaud011 LIKE apca_t.apcaud011, #自定義欄位(數字)011
       apcaud012 LIKE apca_t.apcaud012, #自定義欄位(數字)012
       apcaud013 LIKE apca_t.apcaud013, #自定義欄位(數字)013
       apcaud014 LIKE apca_t.apcaud014, #自定義欄位(數字)014
       apcaud015 LIKE apca_t.apcaud015, #自定義欄位(數字)015
       apcaud016 LIKE apca_t.apcaud016, #自定義欄位(數字)016
       apcaud017 LIKE apca_t.apcaud017, #自定義欄位(數字)017
       apcaud018 LIKE apca_t.apcaud018, #自定義欄位(數字)018
       apcaud019 LIKE apca_t.apcaud019, #自定義欄位(數字)019
       apcaud020 LIKE apca_t.apcaud020, #自定義欄位(數字)020
       apcaud021 LIKE apca_t.apcaud021, #自定義欄位(日期時間)021
       apcaud022 LIKE apca_t.apcaud022, #自定義欄位(日期時間)022
       apcaud023 LIKE apca_t.apcaud023, #自定義欄位(日期時間)023
       apcaud024 LIKE apca_t.apcaud024, #自定義欄位(日期時間)024
       apcaud025 LIKE apca_t.apcaud025, #自定義欄位(日期時間)025
       apcaud026 LIKE apca_t.apcaud026, #自定義欄位(日期時間)026
       apcaud027 LIKE apca_t.apcaud027, #自定義欄位(日期時間)027
       apcaud028 LIKE apca_t.apcaud028, #自定義欄位(日期時間)028
       apcaud029 LIKE apca_t.apcaud029, #自定義欄位(日期時間)029
       apcaud030 LIKE apca_t.apcaud030, #自定義欄位(日期時間)030
       apca067   LIKE apca_t.apca067, #管理品類
       apca068   LIKE apca_t.apca068, #經營方式
       apca069   LIKE apca_t.apca069, #no use
       apca070   LIKE apca_t.apca070, #no use
       apca071   LIKE apca_t.apca071, #no use
       apca072   LIKE apca_t.apca072, #no use
       apca073   LIKE apca_t.apca073  #信用狀申請單號
           END RECORD
#161104-00024#3-add(e)
DEFINE l_nouse       LIKE type_t.num20_6
#end add-point
 
DEFINE g_apcc_m        type_g_apcc_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt420_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt420_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_apda005 
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
   DEFINE r_wc2           STRING   
   DEFINE p_apda005       LIKE apda_t.apda005
   DEFINE l_sql           STRING
   DEFINE l_nmcl001       LIKE nmcl_t.nmcl001
   DEFINE l_str           STRING
   
   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt420_01 WITH FORM cl_ap_formpath("aap","aapt420_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('type','9955')
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
      CONSTRUCT r_wc ON apeadocno,apea005,apeasite,apeacomp
                   FROM apeadocno,apea005,apeasite,apeacomp
         BEFORE CONSTRUCT
            IF g_apcc_m.type <> '2' THEN
               LET r_wc = " 1=1 "
               NEXT FIELD type 
            END IF
            
         ON ACTION controlp INFIELD apeadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apea005 = '",p_apda005,"' AND apeastus = 'Y' "
            CALL q_apeadocno()
            DISPLAY g_qryparam.return1 TO apeadocno
            NEXT FIELD apeadocno
            
         ON ACTION controlp INFIELD apea005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apca005()                       
            DISPLAY g_qryparam.return1 TO apea005  
            NEXT FIELD apea005            
            
         ON ACTION controlp INFIELD apeasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                        
            DISPLAY g_qryparam.return1 TO apeasite  
            NEXT FIELD apeasite   

         ON ACTION controlp INFIELD apeacomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                        
            DISPLAY g_qryparam.return1 TO apeacomp  
            NEXT FIELD apeacomp
            
      END CONSTRUCT             
      CONSTRUCT r_wc2 ON nmcldocno1,nmcldocno2
                    FROM nmcldocno1,nmcldocno2
                    
         BEFORE CONSTRUCT
            IF g_apcc_m.type <> '2' THEN
               LET r_wc2 = " 1=1 "
               NEXT FIELD type 
            END IF
            
         ON ACTION controlp INFIELD nmcldocno1

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t  WHERE ooia002 = '20') ",
                                   " AND EXISTS (SELECT 1 FROM nmcl_t,apea_t
                                                         WHERE nmckent = nmclent
                                                           AND nmckdocno = nmcldocno
                                                           AND nmclent = apeaent
                                                           AND nmcl001 = apeadocno )"
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcldocno1  #顯示到畫面上
            NEXT FIELD nmcldocno1                     #返回原欄位            
            
         ON ACTION controlp INFIELD nmcldocno2

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t  WHERE ooia002 = '30')",
                                   " AND EXISTS (SELECT 1 FROM nmcl_t,apea_t
                                                         WHERE nmckent = nmclent
                                                           AND nmckdocno = nmcldocno
                                                           AND nmclent = apeaent
                                                           AND nmcl001 = apeadocno )"            
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcldocno2  #顯示到畫面上
            NEXT FIELD nmcldocno2                     #返回原欄位        

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
   IF r_wc2 <> " 1=1" THEN
      LET r_wc2 = cl_replace_str(r_wc2,'nmcldocno1','nmcldocno')
      LET r_wc2 = cl_replace_str(r_wc2,'nmcldocno2','nmcldocno')
      LET r_wc2 = cl_replace_str(r_wc2,'and','or')
      
      LET l_nmcl001 = ''
      LET l_str = ''
      LET l_sql = " SELECT DISTINCT nmcl001 FROM nmcl_t ",
                  " WHERE nmclent= '",g_enterprise CLIPPED,"' ",
                  "   AND ",r_wc2 CLIPPED
                  
      PREPARE sel_aapt420_01_nmcl_p FROM l_sql
      DECLARE sel_aapt420_01_nmcl_c CURSOR FOR sel_aapt420_01_nmcl_p   
      
      FOREACH sel_aapt420_01_nmcl_c INTO l_nmcl001
         IF NOT cl_null(l_str) THEN LET l_str = l_str,"," END IF
         LET l_str = l_str,l_nmcl001
      END FOREACH
      LET r_wc2 = "apeadocno IN ",s_fin_get_wc_str(l_str)
   END IF
   LET r_wc = r_wc," AND ",r_wc2
   
   IF INT_FLAG THEN
      LET r_wc = " 1=2 "
      LET INT_FLAG = 0
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt420_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_wc
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt420_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt420_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 差異處理產生差異單身
# Memo...........:
# Usage..........: CALL aapt420_01_apde_diff(p_apdadocno,p_apdald,p_type1,p_type2)
# Input parameter: p_apdadocno    請款單單號
#                : p_apdald       帳別
#                : p_type1        帳<付 時的差異類別
#                : p_type2        帳>付 時的差異類別
# Return code....:
# Date & Author..: 14/10/21 By apo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt420_01_apde_diff(p_apdadocno,p_apdald,p_type1,p_type2)
   DEFINE p_apdadocno   LIKE apda_t.apdadocno    #請款單號
   DEFINE p_apdald      LIKE apda_t.apdald       #帳別
   DEFINE p_type1       LIKE oocq_t.oocq002      #付款<帳款 選擇的類型
   DEFINE p_type2       LIKE oocq_t.oocq002      #付款>帳款 選擇的類別
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_where       STRING
   DEFINE l_pay         RECORD         #付款單身(第二)
                        apde119        LIKE apde_t.apde119
                        END RECORD
 
   DEFINE l_bill        RECORD         #帳款單身(第一)
                        apde119        LIKE apde_t.apde119
                        END RECORD
   DEFINE l_other       RECORD         #其他東西(第二)
                        apde015        LIKE apde_t.apde015,
                        apde119        LIKE apde_t.apde119
                        END RECORD

   DEFINE l_sum         RECORD         #總計
                        apde119        LIKE apde_t.apde119
                        END RECORD
   DEFINE l_type        LIKE oocq_t.oocq002

   WHENEVER ERROR CONTINUE
   IF cl_null(p_apdadocno) OR cl_null(p_apdald)
      OR cl_null(p_type1) OR cl_null(p_type2) THEN
      RETURN
   END IF  
   
   #取得差異金額
   CALL s_aapt420_balance_chk(p_apdald,p_apdadocno,'aapt410')
      RETURNING g_sub_success,g_errno,l_sum.apde119

   CASE
      #付款<帳款 
      WHEN l_sum.apde119 < 0 
         LET l_type = p_type1 
         
      #付款>帳款 
      WHEN l_sum.apde119 > 0 
         LET l_type = p_type2
      OTHERWISE
   END CASE 

   IF l_sum.apde119 <> 0 THEN
      CALL aapt420_01_ins_apde3(p_apdadocno,p_apdald,l_type,'1',l_sum.apde119)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 差異處理的產生單身
# Memo...........:
# Usage..........: CALL aapt420_01_ins_apde3(p_apdadocno,p_apdald,p_type,p_field,p_apde1x9)
# Input parameter: 
#                : 
# Return code....:
# Date & Author..: 14/10/21 By apo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt420_01_ins_apde3(p_apdadocno,p_apdald,p_type,p_field,p_apde1x9)
   DEFINE p_apdadocno       LIKE apda_t.apdadocno   #請款單號
   DEFINE p_apdald          LIKE apda_t.apdald      #帳別
   DEFINE p_type            LIKE oocq_t.oocq002     #apde002 帳款類別
   DEFINE p_field           LIKE type_t.chr1        #1:本幣 2:本幣二 3:本幣三
   DEFINE p_apde1x9         LIKE apde_t.apde119
   DEFINE l_balance_apde119 LIKE type_t.num5
   DEFINE l_glaa            RECORD
                glaa001     LIKE glaa_t.glaa001,    #161127-00008#1 add
                glaa018     LIKE glaa_t.glaa018,
                glaa022     LIKE glaa_t.glaa022
               ,glaa025     LIKE glaa_t.glaa025     #161127-00008#1 add 
                            END RECORD
   DEFINE l_apdadocdt       LIKE apda_t.apdadocdt
   DEFINE l_dc              LIKE type_t.chr1
   DEFINE l_success         LIKE type_t.num5        #160328-00012#1 add
   DEFINE l_slip            LIKE apde_t.apdedocno   #160328-00012#1 add
   DEFINE l_glaa024         LIKE glaa_t.glaa024     #160328-00012#1 add
   DEFINE l_cnt             LIKE type_t.num5        #161127-00008#1 add
   DEFINE l_sql             STRING                  #161127-00008#1 add
   #170119-00015#1 add--s
   DEFINE l_apde121         LIKE apde_t.apde121
   DEFINE l_apde131         LIKE apde_t.apde131
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD
   #170119-00015#1 add--e

   WHENEVER ERROR CONTINUE


   INITIALIZE g_apda.* TO NULL
   #SELECT * INTO g_apda.* FROM apda_t    #161208-00026#9 mark
   #161208-00026#9-add(s)
   SELECT apdaent,apdacomp,apdald,apdadocno,apdadocdt,
          apdasite,apda001,apda002,apda003,apda004,
          apda005,apda006,apda007,apda008,apda009,
          apda010,apda011,apda012,apda013,apda014,
          apda015,apda016,apda017,apda018,apda019,
          apda020,apda021,apda113,apda123,apda133,
          apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,
          apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,
          apdapstdt,apdastus,apdaud001,apdaud002,apdaud003,
          apdaud004,apdaud005,apdaud006,apdaud007,apdaud008,
          apdaud009,apdaud010,apdaud011,apdaud012,apdaud013,
          apdaud014,apdaud015,apdaud016,apdaud017,apdaud018,
          apdaud019,apdaud020,apdaud021,apdaud022,apdaud023,
          apdaud024,apdaud025,apdaud026,apdaud027,apdaud028,
          apdaud029,apdaud030,apda104,apda105,apda114,
          apda115,apda124,apda125,apda134,apda135,
          apda022,apda023 
     INTO g_apda.* 
     FROM apda_t 
   #161208-00026#9-add(e)
    WHERE apdadocno = p_apdadocno
      AND apdald    = p_apdald
      AND apdaent   = g_enterprise 

   INITIALIZE g_apde.* TO NULL
   LET g_apde.apdeent  = g_apda.apdaent
   LET g_apde.apdeld = g_apda.apdald
   LET g_apde.apdecomp = g_apda.apdacomp
   LET g_apde.apdeorga = g_apda.apdacomp
   LET g_apde.apdesite = g_apda.apdasite
   LET g_apde.apdedocno = g_apda.apdadocno
   SELECT MAX(apdeseq) INTO g_apde.apdeseq FROM apde_t
    WHERE apdeent   = g_apde.apdeent
      AND apdedocno = g_apde.apdedocno
   IF cl_null(g_apde.apdeseq)THEN LET g_apde.apdeseq = 0 END IF
   LET g_apde.apdeseq = g_apde.apdeseq + 1 
  #LET g_apde.apde001 = 'aapt420'   #160509-00004#89 mark
   LET g_apde.apde001 = g_prog      #160509-00004#89
   LET g_apde.apde009 = 'N'
   LET g_apde.apde028 = '0'
   LET g_apde.apde002 = p_type 
   LET g_apde.apde109 = 0
   
   CASE
      WHEN p_field = '1'  
         #apde119
         LET g_apde.apde119 = p_apde1x9 
         LET g_apde.apde119 = s_math_abs(g_apde.apde119)
   END CASE
   IF cl_null(g_apde.apde119)THEN LET g_apde.apde119 = 0 END IF


   LET l_glaa.glaa018 = NULL
   LET l_glaa.glaa022 = NULL
   SELECT glaa001
     INTO g_apde.apde100
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_apdald

   #本幣不平且不選擇匯兌
   IF p_field = '1' AND p_type <> '12' AND p_type <> '11' THEN
      LET l_glaa.glaa018 = NULL
      LET l_glaa.glaa022 = NULL
      LET l_glaa.glaa025 = NULL   #161127-00008#1 add
      #SELECT glaa001,glaa018,glaa022                        #161127-00008#1 mark
      #  INTO g_apde.apde100,l_glaa.glaa018,l_glaa.glaa022   #161127-00008#1 mark
      SELECT glaa001,glaa018,glaa022,glaa025                               #161127-00008#1 add
        INTO l_glaa.glaa001,l_glaa.glaa018,l_glaa.glaa022,l_glaa.glaa025   #161127-00008#1 add
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = p_apdald
      LET g_apde.apde100 = l_glaa.glaa001   #161127-00008#1 add   
      LET g_apde.apde101 = 1
      LET g_apde.apde109 = g_apde.apde119
      
      #161127-00008#1---add---str--
      #計算二個單身,一共有幾種幣別
      LET l_cnt = 0
      LET l_sql = "SELECT COUNT(DISTINCT apce100) ",
                  "  FROM ",
                  "  ( ",
                  "  SELECT DISTINCT apce100 apce100 ",
                  "    FROM apce_t ",
                  "   WHERE apceent = ",g_enterprise,
                  "     AND apceld = '",p_apdald,"'",
                  "     AND apcedocno = '",g_apde.apdedocno,"'",
                  "   UNION ",
                  "  SELECT DISTINCT apde100 apde100 ",
                  "    FROM apde_t ",
                  "   WHERE apdeent = ",g_enterprise,
                  "     AND apdeld = '",p_apdald,"'",
                  "     AND apdedocno = '",g_apde.apdedocno,"'",
                  "  ) "
      PREPARE aapt420_01_apce100_cnt_pre FROM l_sql
      EXECUTE aapt420_01_apce100_cnt_pre INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 1 THEN
         LET g_apde.apde100 = ''
         SELECT DISTINCT apde100 INTO g_apde.apde100
           FROM apde_t
          WHERE apdeent = g_enterprise
            AND apdeld = p_apdald
            AND apdedocno = g_apde.apdedocno
         IF cl_null(g_apde.apde100) THEN
            SELECT DISTINCT apce100 INTO g_apde.apde100
              FROM apce_t
             WHERE apceent = g_enterprise
               AND apceld = p_apdald
               AND apcedocno = g_apde.apdedocno
         END IF
         
         SELECT apdadocdt INTO l_apdadocdt FROM apda_t
          WHERE apdaent = g_enterprise
            AND apdald = p_apdald
            AND apdadocno = g_apde.apdedocno
         #重新计算汇率
         #170119-00015#1 mod--s
         #                    #匯率參照表;帳套; 日期;       來源幣別
         #CALL s_aooi160_get_exrate('2',p_apdald,l_apdadocdt,g_apde.apde100,
         #                          #目的幣別;   交易金額;  匯類類型
         #                          l_glaa.glaa001,0,l_glaa.glaa025)
         #     RETURNING g_apde.apde101
         INITIALIZE lc_param.* TO NULL
         LET lc_param.apca004 = g_apda.apda005
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_apda.apdacomp,g_apda.apdald,g_apda.apdadocdt,g_apde.apde100,ls_js)
            RETURNING g_apde.apde101,l_apde121,l_apde131
         #170119-00015#1 mod--e

         LET g_apde.apde109 = g_apde.apde119 / g_apde.apde101
      END IF
      #161127-00008#1---add---end--
   END IF
   #匯兌損益:寫入一筆本幣紀錄匯兌損失或收益,因此原幣金額等於本幣金額
   IF p_type = '11' OR p_type = '12' THEN
      LET g_apde.apde109 = g_apde.apde119
   END IF
   
   IF p_type <> '19' THEN
      #沖銷加減項
      SELECT gzcb003 INTO g_apde.apde015 
        FROM gzcb_t
       WHERE gzcb001 = '8506'
         AND gzcb002 = g_apde.apde002     #應付核銷類型
         


   ELSE
      #19類要判斷是帳款>付款
      #            正 C
      #          OR 付款>帳款
      #            負 D
      CALL s_aapt420_balance_chk(g_apda.apdald,g_apda.apdadocno,'aapt410')
           RETURNING g_sub_success,g_errno,l_balance_apde119           
      IF l_balance_apde119 > 0 THEN
         LET g_apde.apde015 = 'D'
      ELSE
         LET g_apde.apde015 = 'C'
      END IF
   END IF 
   #-150211--(s)
   #取上一筆項次摘要做預設值
   SELECT apde010 INTO g_apde.apde010
     FROM apde_t
    WHERE apdeent  = g_enterprise
      AND apdeld   = g_apde.apdeld
      AND apdedocno= g_apde.apdedocno
      AND apdeseq  = g_apde.apdeseq - 1
   #-150211--(e)
   #銀行存提碼
   LET g_apde.apde011 = ''
   
   #現金變動碼
   LET g_apde.apde012 = ''
   
   #20/21/22類型,帶單頭帳款對象預設
   IF p_type[1,1] = '2' THEN               #150527apo
      LET g_apde.apde013 = g_apda.apda005  #150527apo
   ELSE                                    #150527apo
      LET g_apde.apde013 = ''
   END IF                                  #150527apo
   #160328-00012#1 -----------------begin
   IF p_type = '20' THEN                   
      CALL s_aooi200_fin_get_slip(g_apde.apdedocno) RETURNING l_success,l_slip
      CALL s_ld_sel_glaa(g_apde.apdeld,'glaa024')
          RETURNING l_success,l_glaa024
      SELECT ooac004 INTO g_apde.apde014
        FROM ooac_t
       WHERE ooacent = g_enterprise
         AND ooac001 = l_glaa024
         AND ooac002 = l_slip
         AND ooac003 = 'D-FIN-3005'      
   ELSE
   #160328-00012#1 -----------------end
      LET g_apde.apde014 = ''
   END IF     #160328-00012#1 add
   #LET g_apde.apde016 = ''  #150817-00025#1 mark
   
   #161129-00052#1--mark--start--
   ##150817-00025#1 add ------
   #IF p_type = '11' OR p_type = '12' OR p_type[1,1] = '2' THEN   #160328-00012#1 add p_type[1,1] = '2'
   #   LET g_apde.apde016 = s_aapt420_bring_acc_code2(g_apde.apdeld,g_apde.apdesite,g_apda.apda005,p_type,g_apde.apde006,'')
   #ELSE
   #   LET g_apde.apde016 = ''
   #END IF
   #150817-00025#1 add end---
   #161129-00052#1--mark--end----
   #161129-00052#1--add---start--
    LET g_apde.apde016 = s_aapt420_bring_acc_code2(g_apde.apdeld,g_apde.apdesite,g_apda.apda005,p_type,g_apde.apde006,'')
    IF cl_null(g_apde.apde016) THEN 
       LET g_apde.apde016 = '' 
    END IF
   #161129-00052#1--add---end----
   
   IF cl_null(g_apde.apde101) THEN LET g_apde.apde101 = 1 END IF
   IF cl_null(g_apde.apde109) THEN LET g_apde.apde109 = 0 END IF
   IF cl_null(g_apde.apde119) THEN LET g_apde.apde119 = 0 END IF
   
   LET g_apde.apde032 = NULL
   SELECT apdadocdt INTO g_apde.apde032 FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdadocno = g_apde.apdedocno      
   
   INSERT INTO apde_t(apdeent,
                      apdeld,apdecomp,apdesite,apdedocno,apdeseq,
                      apde001,apde009,apde028,apde002,apde015,
                      apde003,apde004,apdeorga,apde006,apde010,
                      apde011,apde012,apde013,apde014,apde016,
                      apde017,apde018,apde021,apde032,apde100,
                      apde101,apde109,apde119)
          VALUES(g_apde.apdeent,
                 g_apde.apdeld,g_apde.apdecomp,g_apde.apdesite,g_apde.apdedocno,g_apde.apdeseq,
                 g_apde.apde001,g_apde.apde009,g_apde.apde028,g_apde.apde002,g_apde.apde015,
                 g_apde.apde003,g_apde.apde004,g_apde.apdeorga,g_apde.apde006,g_apde.apde010,
                 g_apde.apde011,g_apde.apde012,g_apde.apde013,g_apde.apde014,g_apde.apde016,
                 g_apde.apde017,g_apde.apde018,g_apde.apde021,g_apde.apde032,g_apde.apde100,
                 g_apde.apde101,g_apde.apde109,g_apde.apde119)
   IF SQLCA.SQLCODE THEN END IF
END FUNCTION

 
{</section>}
 
