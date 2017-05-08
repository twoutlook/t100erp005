#該程式已解開Section, 不再透過樣板產出!
{<section id="apmm100_04.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000042
#+ 
#+ Filename...: apmm100_04
#+ Description: 
#+ Creator....: 02295(2014/08/27)
#+ Modifier...: 02295(2014/09/01) -SD/PR- 05423
#+ Buildtype..: 應用 c01c 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="apmm100_04.global" >}

 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160224-00012#1  16/03/28  By Sarah    參數[營運據點廠商資料自動引入S-BAS-0017]或[營運據點客戶資料自動引入S-BAS-0018]='Y'的營運據點才做拋轉
#161124-00048#8  16/12/13  By zhujing  .*整批调整
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num5   
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)
TYPE type_g_detail_d RECORD
     sel LIKE type_t.chr1,
     ooef001 LIKE ooef_t.ooef001,
     ooef001_desc LIKE type_t.chr80
     END RECORD
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
DEFINE g_detail_idx LIKE type_t.num5
DEFINE l_ac         LIKE type_t.num5
DEFINE g_ooef001     STRING
DEFINE g_pmaa001     LIKE pmaa_t.pmaa001
DEFINE g_error_show         LIKE type_t.num5
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point  
 
{</section>}
 
{<section id="apmm100_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmm100_04(--)
   #add-point:construct段變數傳入
   p_pmaa001
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define
   DEFINE p_pmaa001       LIKE pmaa_t.pmaa001
   DEFINE li_idx          LIKE type_t.num5

   WHENEVER ERROR CALL cl_err_msg_log
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmm100_04 WITH FORM cl_ap_formpath("apm","apmm100_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理
   LET g_ooef001 = ''
   LET g_pmaa001 = p_pmaa001
   CALL g_detail_d.clear()
   WHILE TRUE
   #end add-point
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #輸入開始
         CONSTRUCT BY NAME g_wc ON ooef001 
         
               #add-point:自定義action
         AFTER FIELD ooef001
            LET g_ooef001 = GET_FLDBUF(ooef001)
         
         ON ACTION controlp INFIELD ooef001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            ##2015/03/17 by stellar add ----- (S)
            LET g_qryparam.where = " ooef201 = 'Y' ",   
                                   "   AND NOT EXISTS(SELECT * FROM pmab_t WHERE pmabent = ooefent AND pmabsite = ooef001 AND pmab001 = '",g_pmaa001,"')"
            ##2015/03/17 by stellar add ----- (E)
            CALL q_ooef001()                     
            DISPLAY g_qryparam.return1 TO ooef001 
            NEXT FIELD ooef001  
               #end add-point
   	  
            BEFORE CONSTRUCT
               #add-point:單頭輸入前處理
            DISPLAY g_ooef001 TO ooef001
               #end add-point
               
            AFTER CONSTRUCT
               #add-point:單頭輸入後處理

               #end add-point
            
         
 
         
       
         END CONSTRUCT
 
         #add-point:自定義construct
         INPUT ARRAY g_detail_d FROM s_detail1.* ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx

         END INPUT 
         ON ACTION selall
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR

         #取消全部
         ON ACTION selnone
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR         
         #end add-point
         
         ON ACTION accept
            LET g_action_choice = 'accept'
            CALL apmm100_04_query()
           
#         ON ACTION cancel 
#            EXIT DIALOG
    
         ON ACTION close
            LET g_action_choice = 'exit'
            EXIT DIALOG
    
         ON ACTION exit
            LET g_action_choice = 'exit'
            EXIT DIALOG
            
         ON ACTION execute
            CALL apmm100_04_execute() 
 
 
      
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG 
            
      END DIALOG
 
      #add-point:畫面關閉前
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF      
   END WHILE 
	LET g_action_choice="apmm100_04"   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_apmm100_04 
   
   #add-point:construct段after construct 
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmm100_04.other_function" readonly="Y" >}

PRIVATE FUNCTION apmm100_04_query()
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_pmaa002   LIKE pmaa_t.pmaa002   #160224-00012#1 add  #交易對象類型(1.供應商 2.客戶 3.交易對象)
DEFINE l_sql_1     STRING                #160224-00012#1 add

   CALL g_detail_d.clear()
   IF g_wc IS NULL THEN 
      LET g_wc = " 1=1"
   END IF
  #160224-00012#1 add str
  #參數[營運據點廠商資料自動引入S-BAS-0017]或[營運據點客戶資料自動引入S-BAS-0018]='Y'的營運據點才做拋轉
   SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent=g_enterprise AND pmaa001=g_pmaa001
   CASE l_pmaa002
      WHEN '1'   #供應商
         LET l_sql_1 = "   AND EXISTS (SELECT ooabsite FROM ooab_t",
                       "                WHERE ooabent = ooefent AND ooabsite = ooef001",
                       "                  AND ooab001 = 'S-BAS-0017' AND ooab002 = 'Y')"
      WHEN '2'   #客戶
         LET l_sql_1 = "   AND EXISTS (SELECT ooabsite FROM ooab_t",
                       "                WHERE ooabent = ooefent AND ooabsite = ooef001",
                       "                  AND ooab001 = 'S-BAS-0018' AND ooab002 = 'Y')"
      WHEN '3'   #交易對象
         LET l_sql_1 = "   AND EXISTS (SELECT ooabsite FROM ooab_t",
                       "                WHERE ooabent = ooefent AND ooabsite = ooef001",
                       "                  AND ((ooab001 = 'S-BAS-0017' AND ooab002 = 'Y') OR",
                       "                       (ooab001 = 'S-BAS-0018' AND ooab002 = 'Y')))"
      OTHERWISE
         LET l_sql_1 = " 1=1"
   END CASE
  #160224-00012#1 add end
   LET l_cnt = 1
   LET l_sql = "SELECT 'N',ooef001,ooefl003 ",
               "  FROM ooef_t ",
               "  LEFT OUTER JOIN ooefl_t ON ooefent = ooeflent AND ooef001 = ooefl001 AND ooefl002 = '",g_dlang,"'",
               " WHERE ooefent = '",g_enterprise,"' AND ooef201 = 'Y' AND ooefstus ='Y' AND ",g_wc,
               "   AND NOT EXISTS (SELECT * FROM pmab_t ",
               "                    WHERE pmabent = ooefent AND pmabsite = ooef001",
               "                      AND pmab001 = '",g_pmaa001,"')",
               l_sql_1 CLIPPED,   #160224-00012#1 add
               " ORDER BY ooef001"
   PREPARE b_fill_pre FROM l_sql
   DECLARE b_fill_cus CURSOR FOR b_fill_pre
   FOREACH b_fill_cus INTO g_detail_d[l_cnt].sel,g_detail_d[l_cnt].ooef001,g_detail_d[l_cnt].ooef001_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
END FUNCTION

PRIVATE FUNCTION apmm100_04_execute()
DEFINE l_i   LIKE type_t.num5
DEFINE l_n               LIKE type_t.num5
#161124-00048#8 mod-S
#DEFINE l_pmab            RECORD LIKE pmab_t.*
DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企业编号
       pmabsite LIKE pmab_t.pmabsite, #营运据点
       pmab001 LIKE pmab_t.pmab001, #交易对象编号
       pmab002 LIKE pmab_t.pmab002, #信用额度检查
       pmab003 LIKE pmab_t.pmab003, #额度交易对象
       pmab004 LIKE pmab_t.pmab004, #信用评核等级
       pmab005 LIKE pmab_t.pmab005, #额度计算币种
       pmab006 LIKE pmab_t.pmab006, #企业额度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
       pmab010 LIKE pmab_t.pmab010, #允许除外额度
       pmab011 LIKE pmab_t.pmab011, #额度警示水准一
       pmab012 LIKE pmab_t.pmab012, #水准一通知层
       pmab013 LIKE pmab_t.pmab013, #额度警示水准二
       pmab014 LIKE pmab_t.pmab014, #水准二通知层
       pmab015 LIKE pmab_t.pmab015, #额度警示水准三
       pmab016 LIKE pmab_t.pmab016, #水准三通知层
       pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
       pmab018 LIKE pmab_t.pmab018, #预期应收通知层
       pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
       pmab031 LIKE pmab_t.pmab031, #负责采购人员
       pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
       pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
       pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
       pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
       pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
       pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
       pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
       pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
       pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
       pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
       pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
       pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
       pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
       pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
       pmab046 LIKE pmab_t.pmab046, #供应商折扣率
       pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
       pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
       pmab052 LIKE pmab_t.pmab052, #可提前收货天数
       pmab053 LIKE pmab_t.pmab053, #惯用交易条件
       pmab054 LIKE pmab_t.pmab054, #惯用取价方式
       pmab055 LIKE pmab_t.pmab055, #应付账款类别
       pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
       pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
       pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
       pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
       pmab061 LIKE pmab_t.pmab061, #价格评分
       pmab062 LIKE pmab_t.pmab062, #达交率评分
       pmab063 LIKE pmab_t.pmab063, #质量评分
       pmab064 LIKE pmab_t.pmab064, #配合度评分
       pmab065 LIKE pmab_t.pmab065, #调整加减分
       pmab066 LIKE pmab_t.pmab066, #定性评分一
       pmab067 LIKE pmab_t.pmab067, #定性评分二
       pmab068 LIKE pmab_t.pmab068, #定性评分三
       pmab069 LIKE pmab_t.pmab069, #定性评分四
       pmab070 LIKE pmab_t.pmab070, #定性评分五
       pmab071 LIKE pmab_t.pmab071, #检验程度
       pmab072 LIKE pmab_t.pmab072, #检验水准
       pmab073 LIKE pmab_t.pmab073, #检验级数
       pmab080 LIKE pmab_t.pmab080, #客户ABC分类
       pmab081 LIKE pmab_t.pmab081, #负责业务人员
       pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
       pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
       pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
       pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
       pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
       pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
       pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
       pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
       pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
       pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
       pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
       pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
       pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
       pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
       pmab096 LIKE pmab_t.pmab096, #客户折扣率
       pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
       pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
       pmab102 LIKE pmab_t.pmab102, #可提前交货天数
       pmab103 LIKE pmab_t.pmab103, #惯用交易条件
       pmab104 LIKE pmab_t.pmab104, #惯用取价方式
       pmab105 LIKE pmab_t.pmab105, #应收账款类别
       pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
       pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
       pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
       pmabownid LIKE pmab_t.pmabownid, #资料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
       pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
       pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
       pmabstus LIKE pmab_t.pmabstus, #状态码
       pmab059 LIKE pmab_t.pmab059, #负责采购部门
       pmab109 LIKE pmab_t.pmab109, #负责业务部门
       pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
       pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
       pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
       pmab020 LIKE pmab_t.pmab020, #除外额有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
END RECORD
#161124-00048#8 mod-E
DEFINE l_pmaacnfdt       DATETIME YEAR TO SECOND
DEFINE l_success         LIKE type_t.num5

   #CALL s_transaction_begin()
   CALL cl_err_collect_init()
   #LET g_success = TRUE
   LET l_success = FALSE
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = 'Y' THEN 
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM pmab_t 
          WHERE pmab001 = g_pmaa001 
            AND pmabent = g_enterprise 
            AND pmabsite = g_detail_d[l_i].ooef001
         IF l_n = 0 THEN
            #161124-00048#8 mod-S
#            SELECT * INTO l_pmab.* FROM pmab_t 
#             WHERE pmab001 = g_pmaa001 
#               AND pmabent = g_enterprise 
#               AND pmabsite = 'ALL'
            SELECT pmabent,pmabsite,pmab001,pmab002,pmab003,
                   pmab004,pmab005,pmab006,pmab007,pmab008,
                   pmab009,pmab010,pmab011,pmab012,pmab013,
                   pmab014,pmab015,pmab016,pmab017,pmab018,
                   pmab030,pmab031,pmab032,pmab033,pmab034,
                   pmab035,pmab036,pmab037,pmab038,pmab039,
                   pmab040,pmab041,pmab042,pmab043,pmab044,
                   pmab045,pmab046,pmab047,pmab048,pmab049,
                   pmab050,pmab051,pmab052,pmab053,pmab054,
                   pmab055,pmab056,pmab057,pmab058,pmab060,
                   pmab061,pmab062,pmab063,pmab064,pmab065,
                   pmab066,pmab067,pmab068,pmab069,pmab070,
                   pmab071,pmab072,pmab073,pmab080,pmab081,
                   pmab082,pmab083,pmab084,pmab085,pmab086,
                   pmab087,pmab088,pmab089,pmab090,pmab091,
                   pmab092,pmab093,pmab094,pmab095,pmab096,
                   pmab097,pmab098,pmab099,pmab100,pmab101,
                   pmab102,pmab103,pmab104,pmab105,pmab106,
                   pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,
                   pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt,pmabcnfid,
                   pmabcnfdt,pmabstus,pmab059,pmab109,pmab110,
                   pmab111,pmab019,pmab020,pmab112 
              INTO l_pmab.* 
              FROM pmab_t 
             WHERE pmab001 = g_pmaa001 
               AND pmabent = g_enterprise 
               AND pmabsite = 'ALL'
            #161124-00048#8 mod-E
            LET l_pmab.pmabownid = g_user
            LET l_pmab.pmabowndp = g_dept
            LET l_pmab.pmabcrtid = g_user
            LET l_pmab.pmabcrtdp = g_dept 
            LET l_pmaacnfdt = cl_get_current()
            LET l_pmab.pmabmodid = NULL
            LET l_pmab.pmabmoddt = NULL
            LET l_pmab.pmabsite = g_detail_d[l_i].ooef001
            #--20150615--POLLY--ADD--(S)
            #不需預帶ALL的信用額度相關資料至SITE
             LET l_pmab.pmab002 = NULL
             #LET l_pmab.pmab003 = NULL
             LET l_pmab.pmab003 = g_pmaa001 #預設交易對象編號
             LET l_pmab.pmab004 = NULL
             LET l_pmab.pmab005 = NULL
             LET l_pmab.pmab006 = ''
             LET l_pmab.pmab007 = ''
             LET l_pmab.pmab008 = NULL
             LET l_pmab.pmab009 = ''
             LET l_pmab.pmab019 = ''
             LET l_pmab.pmab010 = ''
             LET l_pmab.pmab020 = ''
            #--20150615--POLLY--ADD--(E)            
            INSERT INTO pmab_t (pmabent,pmabsite,pmab001,pmab080,pmab081,
                                pmab082,pmab083,pmab084,pmab103,pmab104,
                                pmab085,pmab086,pmab087,pmab105,pmab088,
                                pmab089,pmab090,pmab091,pmab092,pmab093,
                                pmab094,pmab095,pmab096,pmab097,pmab098,
                                pmab099,pmab100,pmab101,pmab102,pmab030,
                                pmab031,pmab032,pmab033,pmab034,pmab053,
                                pmab054,pmab035,pmab036,pmab037,pmab055,
                                pmab038,pmab039,pmab040,pmab041,pmab042,
                                pmab043,pmab044,pmab045,pmab046,pmab047,
                                pmab048,pmab049,pmab050,pmab051,pmab052,
                                pmab071,pmab072,pmab073,pmab060,pmab061,
                                pmab066,pmab062,pmab067,pmab063,pmab068,
                                pmab064,pmab069,pmab065,pmab070,pmab002,
                                pmab003,pmab004,pmab005,pmab006,pmab007,
                                pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,pmab012,
                                pmab013,pmab014,pmab015,pmab016,pmab017,
                                pmab018,pmab056,pmab057,pmab058,pmab106,
                                pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,
                                pmabcrtdt,pmabcrtdp,pmabmodid,pmabmoddt,
                                pmab059,pmab109   #150304---earl---add
                                )
              VALUES (g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab080,l_pmab.pmab081,
                      l_pmab.pmab082,l_pmab.pmab083,l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,
                      l_pmab.pmab085,l_pmab.pmab086,l_pmab.pmab087,l_pmab.pmab105,l_pmab.pmab088,
                      l_pmab.pmab089,l_pmab.pmab090,l_pmab.pmab091,l_pmab.pmab092,l_pmab.pmab093,
                      l_pmab.pmab094,l_pmab.pmab095,l_pmab.pmab096,l_pmab.pmab097,l_pmab.pmab098,
                      l_pmab.pmab099,l_pmab.pmab100,l_pmab.pmab101,l_pmab.pmab102,l_pmab.pmab030,
                      l_pmab.pmab031,l_pmab.pmab032,l_pmab.pmab033,l_pmab.pmab034,l_pmab.pmab053,
                      l_pmab.pmab054,l_pmab.pmab035,l_pmab.pmab036,l_pmab.pmab037,l_pmab.pmab055,
                      l_pmab.pmab038,l_pmab.pmab039,l_pmab.pmab040,l_pmab.pmab041,l_pmab.pmab042,
                      l_pmab.pmab043,l_pmab.pmab044,l_pmab.pmab045,l_pmab.pmab046,l_pmab.pmab047,
                      l_pmab.pmab048,l_pmab.pmab049,l_pmab.pmab050,l_pmab.pmab051,l_pmab.pmab052,
                      l_pmab.pmab071,l_pmab.pmab072,l_pmab.pmab073,l_pmab.pmab060,l_pmab.pmab061,
                      l_pmab.pmab066,l_pmab.pmab062,l_pmab.pmab067,l_pmab.pmab063,l_pmab.pmab068,
                      l_pmab.pmab064,l_pmab.pmab069,l_pmab.pmab065,l_pmab.pmab070,l_pmab.pmab002,
                      l_pmab.pmab003,l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006,l_pmab.pmab007,
                      l_pmab.pmab008,l_pmab.pmab009,l_pmab.pmab019,l_pmab.pmab010,l_pmab.pmab020,l_pmab.pmab011,l_pmab.pmab012,
                      l_pmab.pmab013,l_pmab.pmab014,l_pmab.pmab015,l_pmab.pmab016,l_pmab.pmab017,
                      l_pmab.pmab018,l_pmab.pmab056,l_pmab.pmab057,l_pmab.pmab058,l_pmab.pmab106,
                      l_pmab.pmab107,l_pmab.pmab108,l_pmab.pmabownid,l_pmab.pmabowndp,l_pmab.pmabcrtid,
                      l_pmaacnfdt,l_pmab.pmabcrtdp,l_pmab.pmabmodid,l_pmab.pmabmoddt,
                      l_pmab.pmab059,l_pmab.pmab109   #150304---earl---add
                      ) 
            IF SQLCA.sqlcode THEN
               #LET g_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = l_pmab.pmabsite
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOR
            END IF
            LET l_success = TRUE
         END IF            
      END IF
   END FOR
   IF NOT l_success THEN
      CALL cl_ask_confirm3("axc-00530","")
   ELSE   
      CALL cl_ask_confirm3("std-00012","")
   END IF
   CALL cl_err_collect_show()
   CALL apmm100_04_query()
 
END FUNCTION

 
{</section>}
 
