#該程式未解開Section, 採用最新樣板產出!
{<section id="aecm200_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2013-11-14 17:57:05), PR版次:0006(2016-12-06 14:52:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000168
#+ Filename...: aecm200_04
#+ Description: 製程轉BOM
#+ Creator....: 02482()
#+ Modifier...: 02482 -SD/PR- 08734
 
{</section>}
 
{<section id="aecm200_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#8  2016/03/23 by 07675      將重複內容的錯誤訊息置換為公用錯誤訊息
#160406-00016#1  2016/04/20 By xianghui 在插入BOM资料时生效日期的格式不对
#160509-00021#1  2016/05/11 By catmoon 過料號時判斷若特性值為NULL則帶入空字串" "
#                                      拋轉完成時，應顯示訊息
#160518-00005#1  2016/06/12 By lixh    製程轉BOM時，預設imaf.imaf034(據點為ALL)的保稅否欄位給bmba_t.bmba035
#161124-00048#1  2016/12/06 By 08734   星号整批调整
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
PRIVATE type type_g_bmbc_m        RECORD
       bmbc003 LIKE bmbc_t.bmbc003, 
   bmbc004 LIKE bmbc_t.bmbc004, 
   bmbc007 LIKE bmbc_t.bmbc007, 
   bmbc008 LIKE bmbc_t.bmbc008, 
   bmbc009 LIKE bmbc_t.bmbc009, 
   bmbcsite LIKE bmbc_t.bmbcsite, 
   bmbc001 LIKE bmbc_t.bmbc001, 
   bmbc002 LIKE bmbc_t.bmbc002, 
   bmfa005 LIKE bmfa_t.bmfa005
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ecba001       LIKE ecba_t.ecba001
DEFINE g_ecba002       LIKE ecba_t.ecba002
#end add-point
 
DEFINE g_bmbc_m        type_g_bmbc_m
 
   DEFINE g_bmbc003_t LIKE bmbc_t.bmbc003
DEFINE g_bmbc004_t LIKE bmbc_t.bmbc004
DEFINE g_bmbc007_t LIKE bmbc_t.bmbc007
DEFINE g_bmbc008_t LIKE bmbc_t.bmbc008
DEFINE g_bmbc009_t LIKE bmbc_t.bmbc009
DEFINE g_bmbcsite_t LIKE bmbc_t.bmbcsite
DEFINE g_bmbc001_t LIKE bmbc_t.bmbc001
DEFINE g_bmbc002_t LIKE bmbc_t.bmbc002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aecm200_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION aecm200_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ecba001,p_ecba002
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
   DEFINE p_ecba001       LIKE ecba_t.ecba001     #製程料號
   DEFINE p_ecba002       LIKE ecba_t.ecba001     #製程編號
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aecm200_04 WITH FORM cl_ap_formpath("aec","aecm200_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   INITIALIZE g_bmbc_m.* TO NULL
   LET g_ecba001 = p_ecba001
   LET g_ecba002 = p_ecba002
   LET g_bmbc_m.bmbc001 = g_ecba001
   LET g_bmbc_m.bmfa005 = cl_get_current()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bmbc_m.bmbc003,g_bmbc_m.bmbc004,g_bmbc_m.bmbc007,g_bmbc_m.bmbc008,g_bmbc_m.bmbc009, 
          g_bmbc_m.bmbcsite,g_bmbc_m.bmbc001,g_bmbc_m.bmbc002,g_bmbc_m.bmfa005 ATTRIBUTE(WITHOUT DEFAULTS) 
 
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_bmbc_m.bmbc001 = g_ecba001
            LET g_bmbc_m.bmfa005 = cl_get_current()
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc003
            #add-point:BEFORE FIELD bmbc003 name="input.b.bmbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc003
            
            #add-point:AFTER FIELD bmbc003 name="input.a.bmbc003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc003
            #add-point:ON CHANGE bmbc003 name="input.g.bmbc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc004
            #add-point:BEFORE FIELD bmbc004 name="input.b.bmbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc004
            
            #add-point:AFTER FIELD bmbc004 name="input.a.bmbc004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc004
            #add-point:ON CHANGE bmbc004 name="input.g.bmbc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc007
            #add-point:BEFORE FIELD bmbc007 name="input.b.bmbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc007
            
            #add-point:AFTER FIELD bmbc007 name="input.a.bmbc007"
  



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc007
            #add-point:ON CHANGE bmbc007 name="input.g.bmbc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc008
            #add-point:BEFORE FIELD bmbc008 name="input.b.bmbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc008
            
            #add-point:AFTER FIELD bmbc008 name="input.a.bmbc008"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc008
            #add-point:ON CHANGE bmbc008 name="input.g.bmbc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc009
            #add-point:BEFORE FIELD bmbc009 name="input.b.bmbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc009
            
            #add-point:AFTER FIELD bmbc009 name="input.a.bmbc009"
            #此段落由子樣板a05產生
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc009
            #add-point:ON CHANGE bmbc009 name="input.g.bmbc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbcsite
            #add-point:BEFORE FIELD bmbcsite name="input.b.bmbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbcsite
            
            #add-point:AFTER FIELD bmbcsite name="input.a.bmbcsite"
            #此段落由子樣板a05產生
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbcsite
            #add-point:ON CHANGE bmbcsite name="input.g.bmbcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc001
            #add-point:BEFORE FIELD bmbc001 name="input.b.bmbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc001
            
            #add-point:AFTER FIELD bmbc001 name="input.a.bmbc001"
            #此段落由子樣板a05產生
            #160509-00021#1--add--start--
            IF cl_null(g_bmbc_m.bmbc002) THEN
               LET g_bmbc_m.bmbc002=" "
            END IF
            #160509-00021#1--add--end----
            IF NOT cl_null(g_bmbc_m.bmbc001) AND g_bmbc_m.bmbc002 IS NOT NULL THEN
               CALL aecm200_04_chk_bmaa()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bmbc_m.bmbc001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmbc_m.bmbc001 = g_bmbc001_t
                  NEXT FIELD bmbc001
               END IF
            END IF
            IF NOT cl_null(g_bmbc_m.bmbc001) THEN
               CALL aecm200_04_chk_ecba001()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bmbc_m.bmbc001
                  #160318-00005#8 --add--str
                  LET g_errparam.replace[1] ='aecm200'
                  LET g_errparam.replace[2] = cl_get_progname('aecm200',g_lang,"2")
                  LET g_errparam.exeprog    ='aecm200'
                  #160318-00005#8 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmbc_m.bmbc001 = g_bmbc001_t
                  NEXT FIELD bmbc001
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc001
            #add-point:ON CHANGE bmbc001 name="input.g.bmbc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc002
            #add-point:BEFORE FIELD bmbc002 name="input.b.bmbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc002
            
            #add-point:AFTER FIELD bmbc002 name="input.a.bmbc002"
            #此段落由子樣板a05產生
            IF cl_null(g_bmbc_m.bmbc002) THEN
               LET g_bmbc_m.bmbc002 = ' '
            END IF
            IF NOT cl_null(g_bmbc_m.bmbc001) AND g_bmbc_m.bmbc002 IS NOT NULL THEN
               CALL aecm200_04_chk_bmaa()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bmbc_m.bmbc002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmbc_m.bmbc002 = g_bmbc002_t
                  NEXT FIELD bmbc002
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmbc002
            #add-point:ON CHANGE bmbc002 name="input.g.bmbc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfa005
            #add-point:BEFORE FIELD bmfa005 name="input.b.bmfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfa005
            
            #add-point:AFTER FIELD bmfa005 name="input.a.bmfa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfa005
            #add-point:ON CHANGE bmfa005 name="input.g.bmfa005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bmbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc003
            #add-point:ON ACTION controlp INFIELD bmbc003 name="input.c.bmbc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc004
            #add-point:ON ACTION controlp INFIELD bmbc004 name="input.c.bmbc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc007
            #add-point:ON ACTION controlp INFIELD bmbc007 name="input.c.bmbc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc008
            #add-point:ON ACTION controlp INFIELD bmbc008 name="input.c.bmbc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc009
            #add-point:ON ACTION controlp INFIELD bmbc009 name="input.c.bmbc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbcsite
            #add-point:ON ACTION controlp INFIELD bmbcsite name="input.c.bmbcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc001
            #add-point:ON ACTION controlp INFIELD bmbc001 name="input.c.bmbc001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmbc_m.bmbc001             #給予default值

            #給予arg

            CALL q_ecba001_1()                                #呼叫開窗

            LET g_bmbc_m.bmbc001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmbc_m.bmbc001 TO bmbc001              #顯示到畫面上

            NEXT FIELD bmbc001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc002
            #add-point:ON ACTION controlp INFIELD bmbc002 name="input.c.bmbc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmfa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfa005
            #add-point:ON ACTION controlp INFIELD bmfa005 name="input.c.bmfa005"
            
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
   IF NOT INT_FLAG THEN
      CALL aecm200_04_ins()
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aecm200_04 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aecm200_04.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 檢查主件料號+特征是否已經存在BOM資料中
# Memo...........:
# Usage..........: CALL aecm200_04_chk_bmaa()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/10/30 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_04_chk_bmaa()
DEFINE l_n           LIKE type_t.num5

   LET g_errno = ""
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM bmaa_t
    WHERE bmaaent = g_enterprise
      AND bmaasite = 'ALL'
      AND bmaa001 = g_bmbc_m.bmbc001
      AND bmaa002 = g_bmbc_m.bmbc002
   IF l_n > 0 THEN
      LET g_errno = 'aec-00014'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 批量新增BOM資料
# Memo...........:
# Usage..........: CALL aecm200_04_ins()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/10/30 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_04_ins()
#DEFINE l_bmaa            RECORD LIKE bmaa_t.*  #161124-00048#1   2016/12/06  By 08734 mark
#161124-00048#1   2016/12/06  By 08734 add(S)
DEFINE l_bmaa RECORD  #產品結構單頭檔
       bmaaent LIKE bmaa_t.bmaaent, #企业编号
       bmaasite LIKE bmaa_t.bmaasite, #营运据点
       bmaastus LIKE bmaa_t.bmaastus, #状态码
       bmaa001 LIKE bmaa_t.bmaa001, #主件料号
       bmaa002 LIKE bmaa_t.bmaa002, #特性
       bmaa003 LIKE bmaa_t.bmaa003, #批次数量
       bmaa004 LIKE bmaa_t.bmaa004, #生产单位
       bmaaownid LIKE bmaa_t.bmaaownid, #资料所有者
       bmaaowndp LIKE bmaa_t.bmaaowndp, #资料所有部门
       bmaacrtid LIKE bmaa_t.bmaacrtid, #资料录入者
       bmaacrtdp LIKE bmaa_t.bmaacrtdp, #资料录入部门
       bmaacrtdt LIKE bmaa_t.bmaacrtdt, #资料创建日
       bmaamodid LIKE bmaa_t.bmaamodid, #资料更改者
       bmaamoddt LIKE bmaa_t.bmaamoddt, #最近更改日
       bmaacnfid LIKE bmaa_t.bmaacnfid, #资料审核者
       bmaacnfdt LIKE bmaa_t.bmaacnfdt #数据审核日
END RECORD
#161124-00048#1   2016/12/06  By 08734 add(E)
#DEFINE l_bmba            RECORD LIKE bmba_t.*  #161124-00048#1   2016/12/06  By 08734 mark
#161124-00048#1   2016/12/06  By 08734 add(S)
DEFINE l_bmba      RECORD                 #dt-datetime响应日期时间型限制
                 bmbaent    LIKE bmba_t.bmbaent,   #企業代碼
                 bmbasite   LIKE bmba_t.bmbasite,  #營運據點
                 bmba001    LIKE bmba_t.bmba001,   #主件料號
                 bmba002    LIKE bmba_t.bmba002,   #特性
                 bmba003    LIKE bmba_t.bmba003,   #元件料號
                 bmba004    LIKE bmba_t.bmba004,   #部位編號
                 bmba005    DATETIME YEAR TO SECOND,  #datetime生效日期時間
                 bmba006    DATETIME YEAR TO SECOND,  #datetime失效日期時間
                 bmba007    LIKE bmba_t.bmba007,   #作業編號
                 bmba008    LIKE bmba_t.bmba008,   #製程段號
                 bmba009    LIKE bmba_t.bmba009,   #項次
                 bmba010    LIKE bmba_t.bmba010,   #發料單位
                 bmba011    LIKE bmba_t.bmba011,   #組成用量
                 bmba012    LIKE bmba_t.bmba012,   #主件底數
                 bmba013    LIKE bmba_t.bmba013,   #必要
                 bmba014    LIKE bmba_t.bmba014,   #特徵管理
                 bmba015    LIKE bmba_t.bmba015,   #指定發料庫位
                 bmba016    LIKE bmba_t.bmba016,   #指定發料儲位
                 bmba017    LIKE bmba_t.bmba017,   #FAS選擇群組
                 bmba018    LIKE bmba_t.bmba018,   #插件位置
                 bmba019    LIKE bmba_t.bmba019,   #參照研發中心
                 bmba020    LIKE bmba_t.bmba020,   #可選件
                 bmba021    LIKE bmba_t.bmba021,   #工單展開選項
                 bmba022    LIKE bmba_t.bmba022,   #代買料
                 bmba023    LIKE bmba_t.bmba023,   #元件投料時距
                 bmba024    LIKE bmba_t.bmba024,   #主要替代料
                 bmba025    LIKE bmba_t.bmba025,   #附屬零件
                 bmba026    LIKE bmba_t.bmba026,   #ECN單號
                 bmba027    LIKE bmba_t.bmba027,   #用量是否使用公式
                 bmba028    LIKE bmba_t.bmba028,   #用量公式
                 bmba029    LIKE bmba_t.bmba029,   #損耗率型態
                 bmba030    LIKE bmba_t.bmba030,   #倒扣料
                 bmba031    LIKE bmba_t.bmba031,   #客供料
                 bmba032    LIKE bmba_t.bmba032,   #库存管理特征
                 bmba033    LIKE bmba_t.bmba033,   #損耗率是否使用公式   
                 bmba034    LIKE bmba_t.bmba034,   #損耗率公式         
                 bmba035    LIKE bmba_t.bmba035    #保税否       
END RECORD
#161124-00048#1   2016/12/06  By 08734 add(E)
#DEFINE l_bmbb            RECORD LIKE bmbb_t.*  #161124-00048#1   2016/12/06  By 08734 mark
#161124-00048#1   2016/11/30  By 08734 add(S)
DEFINE l_bmbb       RECORD              #dt-datetime响应日期时间型限制
                 bmbbent    LIKE bmbb_t.bmbbent,   #企業代碼
                 bmbbsite   LIKE bmbb_t.bmbbsite,  #營運據點
                 bmbb001    LIKE bmbb_t.bmbb001,   #主件料號
                 bmbb002    LIKE bmbb_t.bmbb002,   #特性
                 bmbb003    LIKE bmbb_t.bmbb003,   #元件料號
                 bmbb004    LIKE bmbb_t.bmbb004,   #部位編號
                 bmbb005    DATETIME YEAR TO SECOND,   #datetime生效日期时间
                 bmbb007    LIKE bmbb_t.bmbb007,   #作業編號
                 bmbb008    LIKE bmbb_t.bmbb008,   #製程段號
                 bmbb009    LIKE bmbb_t.bmbb009,   #起始生產數量
                 bmbb010    LIKE bmbb_t.bmbb010,   #截止生產數量
                 bmbb011    LIKE bmbb_t.bmbb011,   #變動損耗率
                 bmbb012    LIKE bmbb_t.bmbb012    #固定損耗率
END RECORD
#161124-00048#1   2016/12/06  By 08734 add(E)
DEFINE l_imae016         LIKE imae_t.imae016
DEFINE l_imae021         LIKE imae_t.imae021
DEFINE l_success         LIKE type_t.chr1
#DEFINE l_ecbb            RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
DEFINE l_ecbb RECORD  #料件製程單身檔
       ecbbent LIKE ecbb_t.ecbbent, #企业编号
       ecbbsite LIKE ecbb_t.ecbbsite, #营运据点
       ecbb001 LIKE ecbb_t.ecbb001, #工艺料号
       ecbb002 LIKE ecbb_t.ecbb002, #工艺编号
       ecbb003 LIKE ecbb_t.ecbb003, #项次
       ecbb004 LIKE ecbb_t.ecbb004, #本站作业
       ecbb005 LIKE ecbb_t.ecbb005, #作业序
       ecbb006 LIKE ecbb_t.ecbb006, #群组性质
       ecbb007 LIKE ecbb_t.ecbb007, #群组
       ecbb008 LIKE ecbb_t.ecbb008, #上站作业
       ecbb009 LIKE ecbb_t.ecbb009, #上站作业序
       ecbb010 LIKE ecbb_t.ecbb010, #下站作业
       ecbb011 LIKE ecbb_t.ecbb011, #下站作业序
       ecbb012 LIKE ecbb_t.ecbb012, #工作站
       ecbb013 LIKE ecbb_t.ecbb013, #允许委外
       ecbb014 LIKE ecbb_t.ecbb014, #主要加工厂
       ecbb015 LIKE ecbb_t.ecbb015, #Move in
       ecbb016 LIKE ecbb_t.ecbb016, #Check in
       ecbb017 LIKE ecbb_t.ecbb017, #报工站
       ecbb018 LIKE ecbb_t.ecbb018, #PQC
       ecbb019 LIKE ecbb_t.ecbb019, #Check out
       ecbb020 LIKE ecbb_t.ecbb020, #Move out
       ecbb021 LIKE ecbb_t.ecbb021, #转出单位
       ecbb022 LIKE ecbb_t.ecbb022, #转出单位转换率分子
       ecbb023 LIKE ecbb_t.ecbb023, #转出单位转换率分母
       ecbb024 LIKE ecbb_t.ecbb024, #固定工时
       ecbb025 LIKE ecbb_t.ecbb025, #标准工时
       ecbb026 LIKE ecbb_t.ecbb026, #固定机时
       ecbb027 LIKE ecbb_t.ecbb027, #标准机时
       ecbb028 LIKE ecbb_t.ecbb028, #完成度
       ecbb029 LIKE ecbb_t.ecbb029, #标准单价
       ecbb030 LIKE ecbb_t.ecbb030, #转入单位
       ecbb031 LIKE ecbb_t.ecbb031, #转入单位转换分子
       ecbb032 LIKE ecbb_t.ecbb032, #转入单位转换分母
       ecbb033 LIKE ecbb_t.ecbb033, #回收站
       ecbb034 LIKE ecbb_t.ecbb034, #后置时间
       ecbb035 LIKE ecbb_t.ecbb035, #X轴
       ecbb036 LIKE ecbb_t.ecbb036, #Y轴
       ecbb037 LIKE ecbb_t.ecbb037, #资源群组
       ecbb038 LIKE ecbb_t.ecbb038 #工具群组
END RECORD
#161124-00048#1  16/12/06 By 08734 add(E)
#DEFINE l_date            LIKE type_t.dat       #160406-00016#1 mark
DEFINE l_date            LIKE bmfa_t.bmfa005   #160406-00016#1
DEFINE l_sql             STRING

   CALL s_transaction_begin()
   LET l_success = 'Y'
   IF cl_null(g_bmbc_m.bmbc002) THEN LET g_bmbc_m.bmbc002 = ' ' END IF
   SELECT imae016,imae021 INTO l_imae016,l_imae021
     FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite = g_site
      AND imae001 = g_bmbc_m.bmbc001
   LET l_date = g_bmbc_m.bmfa005
   INITIALIZE l_bmaa.* TO NULL
   LET l_bmaa.bmaasite = 'ALL'
   LET l_bmaa.bmaaent = g_enterprise
   LET l_bmaa.bmaastus = 'N'
   LET l_bmaa.bmaa001 = g_bmbc_m.bmbc001
   LET l_bmaa.bmaa002 = g_bmbc_m.bmbc002
   LET l_bmaa.bmaa003 = NULL
   LET l_bmaa.bmaa004 = l_imae016
   LET l_bmaa.bmaaownid = g_user
   LET l_bmaa.bmaaowndp = g_dept
   LET l_bmaa.bmaacrtid = g_user
   LET l_bmaa.bmaacrtdp = g_dept
   LET l_bmaa.bmaacrtdt = cl_get_current()
   LET l_bmaa.bmaamodid = g_user
   LET l_bmaa.bmaamoddt = cl_get_current()
   LET l_bmaa.bmaacnfid = ""
   LET l_bmaa.bmaacnfdt = ""   
   #INSERT INTO bmaa_t VALUES(l_bmaa.*)  #161124-00048#1 2016/12/06 By 08734 mark
   INSERT INTO bmaa_t(bmaaent,bmaasite,bmaastus,bmaa001,bmaa002,bmaa003,bmaa004,bmaaownid,bmaaowndp,bmaacrtid,bmaacrtdp,bmaacrtdt,bmaamodid,bmaamoddt,bmaacnfid,bmaacnfdt) VALUES (l_bmaa.bmaaent,l_bmaa.bmaasite,l_bmaa.bmaastus,l_bmaa.bmaa001,l_bmaa.bmaa002,l_bmaa.bmaa003,l_bmaa.bmaa004,l_bmaa.bmaaownid,l_bmaa.bmaaowndp,l_bmaa.bmaacrtid,l_bmaa.bmaacrtdp,l_bmaa.bmaacrtdt,l_bmaa.bmaamodid,l_bmaa.bmaamoddt,l_bmaa.bmaacnfid,l_bmaa.bmaacnfdt) #161124-00048#1 2016/12/06 By 08734 add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_bmbc_m.bmbc001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET l_success = 'N'
   END IF

  # LET l_sql = " SELECT * FROM ecbb_t ", #161124-00048#1   2016/12/06  By 08734 mark
   LET l_sql = " SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 FROM ecbb_t ", #161124-00048#1   2016/12/06  By 08734 add
               "  WHERE ecbbent = '",g_enterprise,"' ",
               "    AND ecbbsite = '",g_site,"' ",
               "    AND ecbb001 = '",g_ecba001,"' ",
               "    AND ecbb002 = '",g_ecba002,"' "
   PREPARE aecm200_04_sel_ecbb_p FROM l_sql
   DECLARE aecm200_04_sel_ecbb_c CURSOR FOR aecm200_04_sel_ecbb_p
   FOREACH aecm200_04_sel_ecbb_c INTO l_ecbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_bmbc_m.bmbc001
      LET g_errparam.popup = FALSE
      CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF
      
      LET l_sql = " INSERT INTO bmba_t(bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010, ",
                  "                    bmba011,bmba012,bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022, ",
                  "                    bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba035) ",   #160518-00005#1 add bmba035 
                  #" SELECT '",g_enterprise,"','ALL','",g_bmbc_m.bmbc001,"','",g_bmbc_m.bmbc002,"',ecbc005,ecbc006,'",l_date,"',",        #160406-00016#1 mark
                  " SELECT '",g_enterprise,"','ALL','",g_bmbc_m.bmbc001,"','",g_bmbc_m.bmbc002,"',ecbc005,ecbc006,to_date('",l_date,"','YYYY-MM-DD hh24:mi:ss'),",     #160406-00016#1 add
                  "        '','",l_ecbb.ecbb004,"','",l_ecbb.ecbb005,"',ecbc004*10,ecbc009,ecbc007,ecbc008,'1','N','','','','N','1','N','",l_imae021,"','N','','','N','','N','',ecbc010,'N' ",
                  "        ,imaf034 ",  #160518-00005#1 add by lixh
                  "   FROM ecbc_t ",
                  "   LEFT JOIN imaf_t ON ecbcent = imafent AND imafsite = 'ALL' AND imaf001 = ecbc005 ", #160518-00005#1 add by lixh
                  "  WHERE ecbcent = '",g_enterprise,"' ",
                  "    AND ecbcsite = '",g_site,"' ",
                  "    AND ecbc001 = '",g_ecba001,"' ",
                  "    AND ecbc002 = '",g_ecba002,"' ",
                  "    AND ecbc003 = '",l_ecbb.ecbb003,"'"
      PREPARE aecm200_04_ins_bmba_pre FROM l_sql
      EXECUTE aecm200_04_ins_bmba_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_bmbc_m.bmbc001
      LET g_errparam.popup = FALSE
      CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF
      LET l_sql = " INSERT INTO bmbb_t(bmbbent,bmbbsite,bmbb001,bmbb002,bmbb003,bmbb004,bmbb005,bmbb007,bmbb008, ",
                  "                    bmbb009,bmbb010,bmbb011,bmbb012) ",
                  #" SELECT '",g_enterprise,"','ALL','",g_bmbc_m.bmbc001,"','",g_bmbc_m.bmbc002,"',ecbc005,ecbc006,'",l_date,"',",   #160406-00016#1 mark
                  " SELECT '",g_enterprise,"','ALL','",g_bmbc_m.bmbc001,"','",g_bmbc_m.bmbc002,"',ecbc005,ecbc006,to_date('",l_date,"','YYYY-MM-DD hh24:mi:ss'),",   #160406-00016#1 add
                  "        '",l_ecbb.ecbb004,"','",l_ecbb.ecbb005,"',ecbd005,ecbd006,ecbd007,ecbd008 ",
                  "  FROM ecbc_t,ecbd_t ",
                  " WHERE ecbcent = ecbdent ",
                  "   AND ecbcsite = ecbdsite",
                  "   AND ecbc001 = ecbd001 ",
                  "   AND ecbc002 = ecbd002 ",
                  "   AND ecbc003 = ecbd003 ",
                  "   AND ecbc004 = ecbd004 ",
                  "   AND ecbdent = '",g_enterprise,"' ",
                  "   AND ecbdsite = '",g_site,"' ",
                  "   AND ecbd001 = '",g_ecba001,"' ",
                  "   AND ecbd002 = '",g_ecba002,"' ",
                  "   AND ecbd003 = '",l_ecbb.ecbb003,"'"
      PREPARE aecm200_04_ins_bmbb_pre FROM l_sql
      EXECUTE aecm200_04_ins_bmbb_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_bmbc_m.bmbc001
      LET g_errparam.popup = FALSE
      CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH

   IF l_success = 'N' THEN
     #CALL s_transaction_end('N','0') #160509-00021#1 mark
      CALL s_transaction_end('N','1') #160509-00021#1 add
   ELSE
     #CALL s_transaction_end('Y','0') #160509-00021#1 mark
      CALL s_transaction_end('Y','1') #160509-00021#1 add
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 检查料号是否存在于製程檔且有效
# Memo...........:
# Usage..........: CALL aecm200_04_chk_ecba001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/15 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_04_chk_ecba001()
DEFINE l_ecbastus    LIKE ecba_t.ecbastus

   LET g_errno = ''
   LET l_ecbastus = ''
   SELECT ecbastus INTO l_ecbastus
     FROM ecba_t
    WHERE ecbaent = g_enterprise 
      AND ecbasite = g_site
      AND ecba001 = g_bmbc_m.bmbc001
      AND ecba002 = g_ecba002
   CASE
      WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aec-00011'
      WHEN l_ecbastus = 'X'        LET g_errno = 'sub-01302'      #'aec-00012'  #160318-00005#8   mod
      WHEN l_ecbastus = 'N'        LET g_errno = 'sub-01302'      #'aec-00019'  #160318-00005#8   mod
   END CASE
END FUNCTION

 
{</section>}
 
