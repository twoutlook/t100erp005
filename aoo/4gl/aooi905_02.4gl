#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi905_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-09-11 16:50:45), PR版次:0006(2016-12-14 15:20:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: aooi905_02
#+ Description: 整批複製
#+ Creator....: 02003(2014-09-02 16:03:28)
#+ Modifier...: 02003 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi905_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#33  2016/03/27   By 07900    重复错误信息修改
#160905-00007#9   2016/09/05   By 01531    调整系统中无ENT的SQL条件增加ent
#161124-00048#13  2016/12/14   By 08734    星号整批调整
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
PRIVATE type type_g_ooif_m        RECORD
       ooif000_1 LIKE type_t.chr10, 
   ooif000_1_desc LIKE type_t.chr80, 
   ooif001_1 LIKE type_t.chr10, 
   ooif001_1_desc LIKE type_t.chr80, 
   ooif000_2 LIKE type_t.chr10, 
   ooif000_2_desc LIKE type_t.chr80, 
   chk LIKE type_t.chr500, 
   ooif001_2 LIKE type_t.chr10, 
   ooif001_2_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooif_m_t        type_g_ooif_m
#end add-point
 
DEFINE g_ooif_m        type_g_ooif_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi905_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi905_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooif000,p_ooif001
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
   DEFINE p_ooif000      LIKE ooif_t.ooif000
   DEFINE p_ooif001       LIKE ooif_t.ooif001
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi905_02 WITH FORM cl_ap_formpath("aoo","aooi905_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('ooif003_1','8310') 
   CALL cl_set_combo_scc('ooif003_2','8310') 
   LET g_ooif_m.ooif000_1 = p_ooif000
   LET g_ooif_m.ooif001_1 = p_ooif001
   LET g_ooif_m.chk = 'N'
   LET g_ooif_m_t.* = g_ooif_m.* 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooif_m.ooif000_1,g_ooif_m.ooif001_1,g_ooif_m.ooif000_2,g_ooif_m.chk,g_ooif_m.ooif001_2  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CALL aooi905_02_display()
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif000_1
            
            #add-point:AFTER FIELD ooif000_1 name="input.a.ooif000_1"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooif_m.ooif000_1
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooif_m.ooif000_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooif_m.ooif000_1_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif000_1
            #add-point:BEFORE FIELD ooif000_1 name="input.b.ooif000_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif000_1
            #add-point:ON CHANGE ooif000_1 name="input.g.ooif000_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif001_1
            
            #add-point:AFTER FIELD ooif001_1 name="input.a.ooif001_1"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooif_m.ooif001_1
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooif_m.ooif001_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooif_m.ooif001_1_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif001_1
            #add-point:BEFORE FIELD ooif001_1 name="input.b.ooif001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif001_1
            #add-point:ON CHANGE ooif001_1 name="input.g.ooif001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif000_2
            
            #add-point:AFTER FIELD ooif000_2 name="input.a.ooif000_2"
            CALL aooi905_02_ooif000_2_desc()


            IF NOT cl_null(g_ooif_m.ooif000_2) THEN
               IF NOT ap_chk_notDup(g_ooif_m.ooif000_2,"SELECT COUNT(*) FROM ooif_t WHERE "||"ooifent = '" ||g_enterprise|| "' AND "||"ooif000 = '"||g_ooif_m.ooif000_2 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF            
               IF NOT ap_chk_isExist(g_ooif_m.ooif000_2,"SELECT COUNT(*) FROM rtaa_t WHERE "||"rtaaent = '" ||g_enterprise|| "' AND "||"rtaa001 = ? ",'aoo-00373',0) THEN 
                  LET g_ooif_m.ooif000_2 = g_ooif_m_t.ooif000_2 
                  NEXT FIELD CURRENT
               END IF  
               #20150603--huangrh add--rtak
               IF NOT ap_chk_isExist(g_ooif_m.ooif000_2,"SELECT COUNT(*) FROM rtaa_t,rtak_t WHERE "||"rtaaent = '" ||g_enterprise|| "' AND "||"rtaa001 = ?  AND rtaaent=rtakent AND rtaa001=rtak001  AND rtak002='5' AND rtak003='Y' ",'aoo-00374',0) THEN 
                  LET g_ooif_m.ooif000_2 = g_ooif_m_t.ooif000_2 
                  NEXT FIELD CURRENT
               END IF  
               IF NOT ap_chk_isExist(g_ooif_m.ooif000_2,"SELECT COUNT(*) FROM rtaa_t WHERE "||"rtaaent = '" ||g_enterprise|| "' AND "||"rtaa001 = ?  AND rtaastus = 'Y' ",'art-00067',0) THEN 
                  LET g_ooif_m.ooif000_2 = g_ooif_m_t.ooif000_2 
                  NEXT FIELD CURRENT
               END IF               
            END IF
            CALL aooi905_02_ooif000_2_desc()           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif000_2
            #add-point:BEFORE FIELD ooif000_2 name="input.b.ooif000_2"
            CALL aooi905_02_ooif000_2_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif000_2
            #add-point:ON CHANGE ooif000_2 name="input.g.ooif000_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            IF g_ooif_m.chk = 'N' THEN 
               CALL cl_set_comp_entry("ooif001_2",TRUE)
            ELSE
               LET g_ooif_m.ooif001_2 = ''
               LET g_ooif_m.ooif001_2_desc = ''
               DISPLAY BY NAME g_ooif_m.ooif001_2,g_ooif_m.ooif001_2_desc
               CALL cl_set_comp_entry("ooif001_2",FALSE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif001_2
            
            #add-point:AFTER FIELD ooif001_2 name="input.a.ooif001_2"
            CALL aooi905_02_ooif001_2_desc()
            
            IF NOT cl_null(g_ooif_m.ooif001_2) THEN 
               IF NOT cl_null(g_ooif_m.ooif000_2) THEN 
                  IF NOT ap_chk_notDup(g_ooif_m.ooif001_2,"SELECT COUNT(*) FROM ooif_t WHERE "||"ooifent = '" ||g_enterprise|| "' AND "||"ooif000 = '"||g_ooif_m.ooif000_2 ||"' AND "|| "ooif001 = '"||g_ooif_m.ooif001_2 ||"'",'std-00004',0) THEN 
                     LET g_ooif_m.ooif001_2 = g_ooif_m_t.ooif001_2
                     NEXT FIELD CURRENT
                  END IF
               END IF            
               IF NOT ap_chk_isExist(g_ooif_m.ooif001_2,"SELECT COUNT(*) FROM ooia_t WHERE "||"ooiaent = '" ||g_enterprise|| "' AND "||"ooia001 = ? ",'aoo-00195',0) THEN 
                  LET g_ooif_m.ooif001_2 = g_ooif_m_t.ooif001_2
                  NEXT FIELD CURRENT
               END IF     
               IF NOT ap_chk_isExist(g_ooif_m.ooif001_2,"SELECT COUNT(*) FROM ooia_t WHERE "||"ooiaent = '" ||g_enterprise|| "' AND "||"ooia001 = ? AND ooiastus = 'Y' ",'sub-01302',"aooi713") THEN  #aoo-00196 #160318-00005#33 by 07900 --mod
                  LET g_ooif_m.ooif001_2 = g_ooif_m_t.ooif001_2
                  NEXT FIELD CURRENT
               END IF   
            END IF  
            
            CALL aooi905_02_ooif001_2_desc()           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif001_2
            #add-point:BEFORE FIELD ooif001_2 name="input.b.ooif001_2"
            CALL aooi905_02_ooif001_2_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif001_2
            #add-point:ON CHANGE ooif001_2 name="input.g.ooif001_2"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooif000_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif000_1
            #add-point:ON ACTION controlp INFIELD ooif000_1 name="input.c.ooif000_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooif001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif001_1
            #add-point:ON ACTION controlp INFIELD ooif001_1 name="input.c.ooif001_1"
 
            #END add-point
 
 
         #Ctrlp:input.c.ooif000_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif000_2
            #add-point:ON ACTION controlp INFIELD ooif000_2 name="input.c.ooif000_2"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooif_m.ooif000_2             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '5'
            CALL q_rtaa001_4()                                #呼叫開窗

            LET g_ooif_m.ooif000_2 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooif_m.ooif000_2 TO ooif000_2              #顯示到畫面上
            CALL aooi905_02_ooif000_2_desc()
            
            NEXT FIELD ooif000_2                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooif001_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif001_2
            #add-point:ON ACTION controlp INFIELD ooif001_2 name="input.c.ooif001_2"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooif_m.ooif001_2             #給予default值

            #給予arg

            CALL q_ooia001_04()                                #呼叫開窗

            LET g_ooif_m.ooif001_2 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooif_m.ooif001_2 TO ooif001_2              #顯示到畫面上
            CALL aooi905_02_ooif001_2_desc()
            NEXT FIELD ooif001_2                          #返回原欄位


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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aooi905_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN 
      CALL aooi905_02_copy()
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi905_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi905_02.other_function" readonly="Y" >}
#+ 來源資料顯示
PRIVATE FUNCTION aooi905_02_display()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooif_m.ooif000_1
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooif_m.ooif000_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooif_m.ooif000_1_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooif_m.ooif001_1
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooif_m.ooif001_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooif_m.ooif001_1_desc
  
END FUNCTION
#+ 資料複製
PRIVATE FUNCTION aooi905_02_copy()
#DEFINE l_ooif    RECORD LIKE ooif_t.*  #161124-00048#13  2016/12/14 By 08734 mark
#161124-00048#13  2016/12/14 By 08734 add(S)
DEFINE l_ooif RECORD  #店群款別主檔
       ooifent LIKE ooif_t.ooifent, #企业编号
       ooifstus LIKE ooif_t.ooifstus, #状态及异动
       ooif000 LIKE ooif_t.ooif000, #店群编号
       ooif001 LIKE ooif_t.ooif001, #款别编号
       ooif002 LIKE ooif_t.ooif002, #款别指定币种
       ooif003 LIKE ooif_t.ooif003, #第三方代收缴款否
       ooif004 LIKE ooif_t.ooif004, #代收机构
       ooif005 LIKE ooif_t.ooif005, #代收手续费费率
       ooif006 LIKE ooif_t.ooif006, #代收手续费金额
       ooif007 LIKE ooif_t.ooif007, #生成代收账款单否
       ooif008 LIKE ooif_t.ooif008, #默认款别否
       ooif009 LIKE ooif_t.ooif009, #对应款别编号
       ooif010 LIKE ooif_t.ooif010, #显示名称
       ooif011 LIKE ooif_t.ooif011, #打印名称
       ooif012 LIKE ooif_t.ooif012, #是否实收折让
       ooif013 LIKE ooif_t.ooif013, #储值付款单次使用否
       ooif014 LIKE ooif_t.ooif014, #录入号码最小长度
       ooif015 LIKE ooif_t.ooif015, #可退款
       ooif016 LIKE ooif_t.ooif016, #可找零
       ooif017 LIKE ooif_t.ooif017, #下传款别
       ooif018 LIKE ooif_t.ooif018, #可溢收
       ooif019 LIKE ooif_t.ooif019, #是否运行接口程序
       ooif020 LIKE ooif_t.ooif020, #扣款金额自动取值
       ooif021 LIKE ooif_t.ooif021, #接口小数倍数
       ooif022 LIKE ooif_t.ooif022, #允许空单交易
       ooif023 LIKE ooif_t.ooif023, #transflag标记
       ooif024 LIKE ooif_t.ooif024, #接口程序返回的打印文件
       ooif025 LIKE ooif_t.ooif025, #运行的接口程序
       ooif026 LIKE ooif_t.ooif026, #运行接口传入的文件名
       ooif027 LIKE ooif_t.ooif027, #运行接口传入档数据类型ID
       ooif028 LIKE ooif_t.ooif028, #运行接口后返回接口档
       ooif029 LIKE ooif_t.ooif029, #运行接口返回档数据类型
       ooifstamp LIKE ooif_t.ooifstamp, #时间戳记
       ooifownid LIKE ooif_t.ooifownid, #资料所有者
       ooifowndp LIKE ooif_t.ooifowndp, #资料所有部门
       ooifcrtid LIKE ooif_t.ooifcrtid, #资料录入者
       ooifcrtdp LIKE ooif_t.ooifcrtdp, #资料录入部门
       ooifcrtdt LIKE ooif_t.ooifcrtdt, #资料创建日
       ooifmodid LIKE ooif_t.ooifmodid, #资料更改者
       ooifmoddt LIKE ooif_t.ooifmoddt, #最近更改日
       ooif031 LIKE ooif_t.ooif031, #标准手续费费率
       ooif032 LIKE ooif_t.ooif032, #券消费认列方式
       ooif033 LIKE ooif_t.ooif033, #资金入账是否当前据点
       ooif034 LIKE ooif_t.ooif034, #代收银否
       ooif035 LIKE ooif_t.ooif035, #代收银据点
       ooif036 LIKE ooif_t.ooif036, #刷卡上限金额
       ooif037 LIKE ooif_t.ooif037, #上限手续费率
       ooif038 LIKE ooif_t.ooif038, #税额扣抵顺序
       ooif039 LIKE ooif_t.ooif039 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.chr1

   CALL s_transaction_begin()
   LET l_success = 'Y'
   #LET l_sql = " SELECT * FROM ooif_t WHERE ooif000 = '",g_ooif_m.ooif000_1,"'",  #161124-00048#13  2016/12/14 By 08734 mark
   LET l_sql = " SELECT ooifent,ooifstus,ooif000,ooif001,ooif002,ooif003,ooif004,ooif005,ooif006,ooif007,ooif008,ooif009,ooif010,ooif011,ooif012,ooif013,ooif014,ooif015,",
               "ooif016,ooif017,ooif018,ooif019,ooif020,ooif021,ooif022,ooif023,ooif024,ooif025,ooif026,ooif027,ooif028,ooif029,ooifstamp,ooifownid,ooifowndp,",
               "ooifcrtid,ooifcrtdp,ooifcrtdt,ooifmodid,ooifmoddt,ooif031,ooif032,ooif033,ooif034,ooif035,ooif036,ooif037,ooif038,ooif039 FROM ooif_t WHERE ooif000 = '",g_ooif_m.ooif000_1,"'",  #161124-00048#13  2016/12/14 By 08734 add
               "    AND ooifent = ",g_enterprise #160905-00007#9 

   IF g_ooif_m.chk = 'N' THEN 
      LET l_sql = l_sql," AND ooif001 = '",g_ooif_m.ooif001_1,"'"   
   END IF
   PREPARE ooif_copy_p FROM l_sql
   DECLARE ooif_copy_c CURSOR FOR ooif_copy_p
   FOREACH ooif_copy_c INTO l_ooif.*
      LET l_ooif.ooif000 = g_ooif_m.ooif000_2
      IF g_ooif_m.chk = 'N' THEN
         LET l_ooif.ooif001 = g_ooif_m.ooif001_2
      END IF
      LET l_ooif.ooifstus ='Y'
      
      #INSERT INTO ooif_t VALUES(l_ooif.*)  #161124-00048#13  2016/12/14 By 08734 mark
      INSERT INTO ooif_t(ooifent,ooifstus,ooif000,ooif001,ooif002,ooif003,ooif004,ooif005,ooif006,ooif007,ooif008,ooif009,ooif010,ooif011,ooif012,ooif013,ooif014,ooif015,
                         ooif016,ooif017,ooif018,ooif019,ooif020,ooif021,ooif022,ooif023,ooif024,ooif025,ooif026,ooif027,ooif028,ooif029,ooifstamp,ooifownid,ooifowndp,
                         ooifcrtid,ooifcrtdp,ooifcrtdt,ooifmodid,ooifmoddt,ooif031,ooif032,ooif033,ooif034,ooif035,ooif036,ooif037,ooif038,ooif039)   #161124-00048#13  2016/12/14 By 08734 add
         VALUES(l_ooif.ooifent,l_ooif.ooifstus,l_ooif.ooif000,l_ooif.ooif001,l_ooif.ooif002,l_ooif.ooif003,l_ooif.ooif004,l_ooif.ooif005,l_ooif.ooif006,l_ooif.ooif007,l_ooif.ooif008,l_ooif.ooif009,l_ooif.ooif010,l_ooif.ooif011,l_ooif.ooif012,l_ooif.ooif013,l_ooif.ooif014,l_ooif.ooif015,
                l_ooif.ooif016,l_ooif.ooif017,l_ooif.ooif018,l_ooif.ooif019,l_ooif.ooif020,l_ooif.ooif021,l_ooif.ooif022,l_ooif.ooif023,l_ooif.ooif024,l_ooif.ooif025,l_ooif.ooif026,l_ooif.ooif027,l_ooif.ooif028,l_ooif.ooif029,l_ooif.ooifstamp,l_ooif.ooifownid,l_ooif.ooifowndp,
                l_ooif.ooifcrtid,l_ooif.ooifcrtdp,l_ooif.ooifcrtdt,l_ooif.ooifmodid,l_ooif.ooifmoddt,l_ooif.ooif031,l_ooif.ooif032,l_ooif.ooif033,l_ooif.ooif034,l_ooif.ooif035,l_ooif.ooif036,l_ooif.ooif037,l_ooif.ooif038,l_ooif.ooif039)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF      
   END FOREACH
   IF l_success = 'N' THEN 
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF
   CLOSE ooif_copy_p
END FUNCTION
#+
PRIVATE FUNCTION aooi905_02_ooif000_2_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooif_m.ooif000_2
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooif_m.ooif000_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooif_m.ooif000_2_desc

END FUNCTION
#+
PRIVATE FUNCTION aooi905_02_ooif001_2_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooif_m.ooif001_2
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooif_m.ooif001_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooif_m.ooif001_2_desc             
END FUNCTION

 
{</section>}
 
