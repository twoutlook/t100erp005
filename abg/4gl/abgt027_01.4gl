#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt027_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-06-15 10:00:21), PR版次:0004(2016-11-08 16:27:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: abgt027_01
#+ Description: 依總額自動分配至各期預算
#+ Creator....: 04152(2016-06-14 17:46:10)
#+ Modifier...: 04152 -SD/PR- 08171
 
{</section>}
 
{<section id="abgt027_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00002#2   16/09/05 By Hans          SQL無ENT補上
#161104-00024#8   16/11/08 By 08171         程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
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
PRIVATE type type_g_bgbi_m        RECORD
       l_type LIKE type_t.chr500, 
   l_bgbi023 LIKE type_t.num20_6, 
   l_bgbi0232 LIKE type_t.num20_6, 
   l_bgbi0233 LIKE type_t.num20_6, 
   l_bgbi0234 LIKE type_t.num20_6, 
   l_bgbi0235 LIKE type_t.num20_6
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_bgbi_m        type_g_bgbi_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt027_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt027_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type,p_ac,p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi017,p_bgbistus,p_wc
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
   DEFINE p_type          LIKE type_t.chr10
   DEFINE p_ac            LIKE bgbi_t.bgbiseq
   DEFINE p_bgbi002       LIKE bgbi_t.bgbi002
   DEFINE p_bgbi003       LIKE bgbi_t.bgbi003
   DEFINE p_bgbi004       LIKE bgbi_t.bgbi004
   DEFINE p_bgbi005       LIKE bgbi_t.bgbi005
   DEFINE p_bgbi017       LIKE bgbi_t.bgbi017
   DEFINE p_bgbistus      LIKE bgbi_t.bgbistus
   DEFINE p_wc            STRING
   DEFINE r_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt027_01 WITH FORM cl_ap_formpath("abg","abgt027_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_success = TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgbi_m.l_type,g_bgbi_m.l_bgbi023,g_bgbi_m.l_bgbi0232,g_bgbi_m.l_bgbi0233,g_bgbi_m.l_bgbi0234, 
          g_bgbi_m.l_bgbi0235 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_bgbi_m.l_type = '1'
            LET g_bgbi_m.l_bgbi023 = 0
            LET g_bgbi_m.l_bgbi0232 = ''
            LET g_bgbi_m.l_bgbi0233 = ''
            LET g_bgbi_m.l_bgbi0234 = ''
            LET g_bgbi_m.l_bgbi0235 = ''
            CALL cl_set_comp_entry("l_bgbi0232,l_bgbi0233,l_bgbi0234,l_bgbi0235",FALSE)
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_type
            #add-point:BEFORE FIELD l_type name="input.b.l_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_type
            
            #add-point:AFTER FIELD l_type name="input.a.l_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_type
            #add-point:ON CHANGE l_type name="input.g.l_type"
            CALL cl_set_comp_entry("l_bgbi023,l_bgbi0232,l_bgbi0233,l_bgbi0234,l_bgbi0235",TRUE)
            IF g_bgbi_m.l_type = '1' THEN
               LET g_bgbi_m.l_bgbi023 = 0
               LET g_bgbi_m.l_bgbi0232 = ''
               LET g_bgbi_m.l_bgbi0233 = ''
               LET g_bgbi_m.l_bgbi0234 = ''
               LET g_bgbi_m.l_bgbi0235 = ''
               CALL cl_set_comp_entry("l_bgbi0232,l_bgbi0233,l_bgbi0234,l_bgbi0235",FALSE)
            ELSE
               LET g_bgbi_m.l_bgbi023 = ''
               LET g_bgbi_m.l_bgbi0232 = 0
               LET g_bgbi_m.l_bgbi0233 = 0
               LET g_bgbi_m.l_bgbi0234 = 0
               LET g_bgbi_m.l_bgbi0235 = 0
               CALL cl_set_comp_entry("l_bgbi023",FALSE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgbi023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.l_bgbi023,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_bgbi023
            END IF 
 
 
 
            #add-point:AFTER FIELD l_bgbi023 name="input.a.l_bgbi023"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgbi023
            #add-point:BEFORE FIELD l_bgbi023 name="input.b.l_bgbi023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgbi023
            #add-point:ON CHANGE l_bgbi023 name="input.g.l_bgbi023"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgbi0232
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.l_bgbi0232,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_bgbi0232
            END IF 
 
 
 
            #add-point:AFTER FIELD l_bgbi0232 name="input.a.l_bgbi0232"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgbi0232
            #add-point:BEFORE FIELD l_bgbi0232 name="input.b.l_bgbi0232"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgbi0232
            #add-point:ON CHANGE l_bgbi0232 name="input.g.l_bgbi0232"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgbi0233
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.l_bgbi0233,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_bgbi0233
            END IF 
 
 
 
            #add-point:AFTER FIELD l_bgbi0233 name="input.a.l_bgbi0233"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgbi0233
            #add-point:BEFORE FIELD l_bgbi0233 name="input.b.l_bgbi0233"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgbi0233
            #add-point:ON CHANGE l_bgbi0233 name="input.g.l_bgbi0233"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgbi0234
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.l_bgbi0234,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_bgbi0234
            END IF 
 
 
 
            #add-point:AFTER FIELD l_bgbi0234 name="input.a.l_bgbi0234"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgbi0234
            #add-point:BEFORE FIELD l_bgbi0234 name="input.b.l_bgbi0234"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgbi0234
            #add-point:ON CHANGE l_bgbi0234 name="input.g.l_bgbi0234"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgbi0235
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.l_bgbi0235,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_bgbi0235
            END IF 
 
 
 
            #add-point:AFTER FIELD l_bgbi0235 name="input.a.l_bgbi0235"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgbi0235
            #add-point:BEFORE FIELD l_bgbi0235 name="input.b.l_bgbi0235"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgbi0235
            #add-point:ON CHANGE l_bgbi0235 name="input.g.l_bgbi0235"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.l_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_type
            #add-point:ON ACTION controlp INFIELD l_type name="input.c.l_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_bgbi023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgbi023
            #add-point:ON ACTION controlp INFIELD l_bgbi023 name="input.c.l_bgbi023"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_bgbi0232
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgbi0232
            #add-point:ON ACTION controlp INFIELD l_bgbi0232 name="input.c.l_bgbi0232"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_bgbi0233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgbi0233
            #add-point:ON ACTION controlp INFIELD l_bgbi0233 name="input.c.l_bgbi0233"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_bgbi0234
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgbi0234
            #add-point:ON ACTION controlp INFIELD l_bgbi0234 name="input.c.l_bgbi0234"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_bgbi0235
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgbi0235
            #add-point:ON ACTION controlp INFIELD l_bgbi0235 name="input.c.l_bgbi0235"
            
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
   CLOSE WINDOW w_abgt027_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL cl_err_collect_init()
   CALL abgt027_01_upd_abgt023(p_type,p_ac,p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi017,p_bgbistus,p_wc)
        RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt027_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 依照金額分配至各期
# Memo...........:
# Usage..........: CALL abgt027_01_upd_abgt023()
# Date & Author..: 2016/06/15 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_01_upd_abgt023(p_type,p_ac,p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi017,p_bgbistus,p_wc)
DEFINE p_type           LIKE type_t.chr10
DEFINE p_ac             LIKE bgbi_t.bgbiseq
DEFINE p_bgbi002        LIKE bgbi_t.bgbi002
DEFINE p_bgbi003        LIKE bgbi_t.bgbi003
DEFINE p_bgbi004        LIKE bgbi_t.bgbi004
DEFINE p_bgbi005        LIKE bgbi_t.bgbi005
DEFINE p_bgbi017        LIKE bgbi_t.bgbi017
DEFINE p_bgbistus       LIKE bgbi_t.bgbistus
DEFINE p_wc             STRING
DEFINE l_sql            STRING
DEFINE l_bgaa002        LIKE bgaa_t.bgaa002
DEFINE l_period         LIKE bgac_t.bgac004
DEFINE l_all_period     LIKE bgac_t.bgac004
DEFINE l_bal_money      LIKE bgbi_t.bgbi023
DEFINE l_diff           LIKE bgbi_t.bgbi023
DEFINE l_first_money    LIKE bgbi_t.bgbi023
DEFINE l_bal_money2     LIKE bgbi_t.bgbi023
DEFINE l_bal_money3     LIKE bgbi_t.bgbi023
DEFINE l_bal_money4     LIKE bgbi_t.bgbi023
DEFINE l_bal_money5     LIKE bgbi_t.bgbi023
DEFINE l_season1        LIKE bgac_t.bgac004
DEFINE l_season2        LIKE bgac_t.bgac004
DEFINE l_season3        LIKE bgac_t.bgac004
DEFINE l_season4        LIKE bgac_t.bgac004
#DEFINE l_bgbi           RECORD LIKE bgbi_t.* #161104-00024#8 mark
#161104-00024#8   --s add
DEFINE l_bgbi RECORD  #年度預算單身檔
    bgbient LIKE bgbi_t.bgbient, #企業編號
    bgbiseq LIKE bgbi_t.bgbiseq, #項次
    bgbi001 LIKE bgbi_t.bgbi001, #摘要
    bgbi002 LIKE bgbi_t.bgbi002, #預算編號
    bgbi003 LIKE bgbi_t.bgbi003, #預算版本
    bgbi004 LIKE bgbi_t.bgbi004, #預算組織
    bgbi005 LIKE bgbi_t.bgbi005, #預算細項
    bgbi006 LIKE bgbi_t.bgbi006, #預算期別
    bgbi007 LIKE bgbi_t.bgbi007, #部門
    bgbi008 LIKE bgbi_t.bgbi008, #成本利潤中心
    bgbi009 LIKE bgbi_t.bgbi009, #區域
    bgbi010 LIKE bgbi_t.bgbi010, #交易客商
    bgbi011 LIKE bgbi_t.bgbi011, #收款客商
    bgbi012 LIKE bgbi_t.bgbi012, #客群
    bgbi013 LIKE bgbi_t.bgbi013, #產品類別
    bgbi014 LIKE bgbi_t.bgbi014, #人員
    bgbi015 LIKE bgbi_t.bgbi015, #專案編號
    bgbi016 LIKE bgbi_t.bgbi016, #WBS
    bgbi017 LIKE bgbi_t.bgbi017, #預算幣別
    bgbi018 LIKE bgbi_t.bgbi018, #含稅單價
    bgbi019 LIKE bgbi_t.bgbi019, #不含稅單價
    bgbi020 LIKE bgbi_t.bgbi020, #稅別
    bgbi021 LIKE bgbi_t.bgbi021, #交易數量
    bgbi022 LIKE bgbi_t.bgbi022, #交易金額
    bgbi023 LIKE bgbi_t.bgbi023, #基準金額
    bgbi024 LIKE bgbi_t.bgbi024, #本層調整
    bgbi025 LIKE bgbi_t.bgbi025, #上層調整
    bgbi026 LIKE bgbi_t.bgbi026, #下層調整
    bgbi027 LIKE bgbi_t.bgbi027, #核准金額
    bgbi028 LIKE bgbi_t.bgbi028, #自由核算項一
    bgbi029 LIKE bgbi_t.bgbi029, #自由核算項二
    bgbi030 LIKE bgbi_t.bgbi030, #自由核算項三
    bgbi031 LIKE bgbi_t.bgbi031, #自由核算項四
    bgbi032 LIKE bgbi_t.bgbi032, #自由核算項五
    bgbi033 LIKE bgbi_t.bgbi033, #自由核算項六
    bgbi034 LIKE bgbi_t.bgbi034, #自由核算項七
    bgbi035 LIKE bgbi_t.bgbi035, #自由核算項八
    bgbi036 LIKE bgbi_t.bgbi036, #自由核算項九
    bgbi037 LIKE bgbi_t.bgbi037, #自由核算項十
    bgbi038 LIKE bgbi_t.bgbi038, #現金變動碼
    bgbi039 LIKE bgbi_t.bgbi039, #經營方式
    bgbi040 LIKE bgbi_t.bgbi040, #通路
    bgbi041 LIKE bgbi_t.bgbi041, #品牌
    bgbi042 LIKE bgbi_t.bgbi042, #稅率
    bgbi043 LIKE bgbi_t.bgbi043, #匯率
    bgbiud001 LIKE bgbi_t.bgbiud001, #自定義欄位(文字)001
    bgbiud002 LIKE bgbi_t.bgbiud002, #自定義欄位(文字)002
    bgbiud003 LIKE bgbi_t.bgbiud003, #自定義欄位(文字)003
    bgbiud004 LIKE bgbi_t.bgbiud004, #自定義欄位(文字)004
    bgbiud005 LIKE bgbi_t.bgbiud005, #自定義欄位(文字)005
    bgbiud006 LIKE bgbi_t.bgbiud006, #自定義欄位(文字)006
    bgbiud007 LIKE bgbi_t.bgbiud007, #自定義欄位(文字)007
    bgbiud008 LIKE bgbi_t.bgbiud008, #自定義欄位(文字)008
    bgbiud009 LIKE bgbi_t.bgbiud009, #自定義欄位(文字)009
    bgbiud010 LIKE bgbi_t.bgbiud010, #自定義欄位(文字)010
    bgbiud011 LIKE bgbi_t.bgbiud011, #自定義欄位(數字)011
    bgbiud012 LIKE bgbi_t.bgbiud012, #自定義欄位(數字)012
    bgbiud013 LIKE bgbi_t.bgbiud013, #自定義欄位(數字)013
    bgbiud014 LIKE bgbi_t.bgbiud014, #自定義欄位(數字)014
    bgbiud015 LIKE bgbi_t.bgbiud015, #自定義欄位(數字)015
    bgbiud016 LIKE bgbi_t.bgbiud016, #自定義欄位(數字)016
    bgbiud017 LIKE bgbi_t.bgbiud017, #自定義欄位(數字)017
    bgbiud018 LIKE bgbi_t.bgbiud018, #自定義欄位(數字)018
    bgbiud019 LIKE bgbi_t.bgbiud019, #自定義欄位(數字)019
    bgbiud020 LIKE bgbi_t.bgbiud020, #自定義欄位(數字)020
    bgbiud021 LIKE bgbi_t.bgbiud021, #自定義欄位(日期時間)021
    bgbiud022 LIKE bgbi_t.bgbiud022, #自定義欄位(日期時間)022
    bgbiud023 LIKE bgbi_t.bgbiud023, #自定義欄位(日期時間)023
    bgbiud024 LIKE bgbi_t.bgbiud024, #自定義欄位(日期時間)024
    bgbiud025 LIKE bgbi_t.bgbiud025, #自定義欄位(日期時間)025
    bgbiud026 LIKE bgbi_t.bgbiud026, #自定義欄位(日期時間)026
    bgbiud027 LIKE bgbi_t.bgbiud027, #自定義欄位(日期時間)027
    bgbiud028 LIKE bgbi_t.bgbiud028, #自定義欄位(日期時間)028
    bgbiud029 LIKE bgbi_t.bgbiud029, #自定義欄位(日期時間)029
    bgbiud030 LIKE bgbi_t.bgbiud030, #自定義欄位(日期時間)030
    bgbi044 LIKE bgbi_t.bgbi044, #資料來源
    bgbi045 LIKE bgbi_t.bgbi045, #管理組織
    bgbi046 LIKE bgbi_t.bgbi046, #預算樣表
    bgbiownid LIKE bgbi_t.bgbiownid, #資料所有者
    bgbiowndp LIKE bgbi_t.bgbiowndp, #資料所屬部門
    bgbicrtid LIKE bgbi_t.bgbicrtid, #資料建立者
    bgbicrtdp LIKE bgbi_t.bgbicrtdp, #資料建立部門
    bgbicrtdt LIKE bgbi_t.bgbicrtdt, #資料創建日
    bgbimodid LIKE bgbi_t.bgbimodid, #資料修改者
    bgbimoddt LIKE bgbi_t.bgbimoddt, #最近修改日
    bgbicnfid LIKE bgbi_t.bgbicnfid, #資料確認者
    bgbicnfdt LIKE bgbi_t.bgbicnfdt, #資料確認日
    bgbistus LIKE bgbi_t.bgbistus, #狀態碼
    bgbi047 LIKE bgbi_t.bgbi047  #上層組織
END RECORD
#161104-00024#8  --e add
DEFINE l_date           DATETIME YEAR TO SECOND
DEFINE l_i              LIKE bgbi_t.bgbi006
DEFINE l_cnt            LIKE bgbi_t.bgbi006
DEFINE l_wc             STRING
DEFINE l_now_season     LIKE bgac_t.bgac004
DEFINE l_flag           LIKE type_t.chr1
DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE

   #先得知有幾期要分
   SELECT bgaa002 INTO l_bgaa002
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = p_bgbi002
   LET l_period = 0
   SELECT COUNT(DISTINCT bgac004) INTO l_period
     FROM bgac_t
    WHERE bgacent = g_enterprise
      AND bgac001 = l_bgaa002
   IF cl_null(l_period) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_date = cl_get_current()
   IF cl_null(p_wc) THEN LET p_wc = '1=1' END IF
   
   IF g_bgbi_m.l_type = '1' THEN  #總額分全部
      #先算總共有幾期要分
      IF p_type = 'A' THEN
         LET l_all_period = l_period * p_ac
      ELSE
         LET l_all_period = l_period
      END IF
      #每一期金額分多少
      LET l_bal_money = g_bgbi_m.l_bgbi023 / l_all_period
      LET l_bal_money = s_curr_round(p_bgbi004,p_bgbi017,l_bal_money,'2')
      LET l_diff = g_bgbi_m.l_bgbi023 - (l_bal_money*l_all_period)
      #若有尾差加到第一期去
      LET l_first_money = l_bal_money+l_diff
      
      #先整批UPDATE
      LET l_sql = "UPDATE bgbi_t SET bgbi018 = '",l_bal_money,"',bgbi019 = '",l_bal_money,"',",
                  "                  bgbi022 = '",l_bal_money,"',bgbi023 = '",l_bal_money,"',",
                  "                  bgbi027 = '",l_bal_money,"',bgbimoddt = ?",
                  " WHERE bgbient = ",g_enterprise,
                  "   AND bgbi002 = '",p_bgbi002,"'",
                  "   AND bgbi003 = '",p_bgbi003,"'",
                  "   AND bgbi004 = '",p_bgbi004,"'",
                  "   AND bgbi005 = '",p_bgbi005,"'",
                  "   AND bgbi044 = '1'",
                  "   AND bgbistus = '",p_bgbistus,"'",
                  "   AND ",p_wc
      PREPARE abgt027_01_upd_pb1 FROM l_sql
      EXECUTE abgt027_01_upd_pb1 USING l_date
      IF SQLCA.SQLCODE THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   ELSE
      #12期依季分，取得每一期金額
      #第一季
      SELECT COUNT(DISTINCT bgac004) INTO l_season1
        FROM bgac_t
       WHERE bgacent = g_enterprise
         AND bgac001 = l_bgaa002
         AND bgac003 = 1
      IF cl_null(l_season1) THEN LET l_season1 = 0 END IF
      IF p_type = 'A' THEN
         LET l_bal_money2 = g_bgbi_m.l_bgbi0232 / (l_season1 * p_ac)
      ELSE
         LET l_bal_money2 = g_bgbi_m.l_bgbi0232 / l_season1
      END IF
      LET l_bal_money2 = s_curr_round(p_bgbi004,p_bgbi017,l_bal_money2,'2')
      #第二季
      SELECT COUNT(DISTINCT bgac004) INTO l_season2
        FROM bgac_t
       WHERE bgacent = g_enterprise
         AND bgac001 = l_bgaa002
         AND bgac003 = 2
      IF cl_null(l_season2) THEN LET l_season2 = 0 END IF
      IF p_type = 'A' THEN
         LET l_bal_money3 = g_bgbi_m.l_bgbi0233 / (l_season2 * p_ac)
      ELSE
         LET l_bal_money3 = g_bgbi_m.l_bgbi0233 / l_season2
      END IF
      LET l_bal_money3 = s_curr_round(p_bgbi004,p_bgbi017,l_bal_money3,'2')
      #第三季
      SELECT COUNT(DISTINCT bgac004) INTO l_season3
        FROM bgac_t
       WHERE bgacent = g_enterprise
         AND bgac001 = l_bgaa002
         AND bgac003 = 3
      IF cl_null(l_season3) THEN LET l_season3 = 0 END IF
      IF p_type = 'A' THEN
         LET l_bal_money4 = g_bgbi_m.l_bgbi0234 / (l_season3 * p_ac)
      ELSE
         LET l_bal_money4 = g_bgbi_m.l_bgbi0234 / l_season3
      END IF
      LET l_bal_money4 = s_curr_round(p_bgbi004,p_bgbi017,l_bal_money4,'2')
      #第四季
      SELECT COUNT(DISTINCT bgac004) INTO l_season4
        FROM bgac_t
       WHERE bgacent = g_enterprise
         AND bgac001 = l_bgaa002
         AND bgac003 = 4
      IF cl_null(l_season4) THEN LET l_season4 = 0 END IF
      IF p_type = 'A' THEN
         LET l_bal_money5 = g_bgbi_m.l_bgbi0235 / (l_season4 * p_ac)
      ELSE
         LET l_bal_money5 = g_bgbi_m.l_bgbi0235 / l_season4
      END IF
      LET l_bal_money5 = s_curr_round(p_bgbi004,p_bgbi017,l_bal_money5,'2')
      
      IF p_type = 'A' THEN
         LET l_diff = (g_bgbi_m.l_bgbi0232+g_bgbi_m.l_bgbi0233+g_bgbi_m.l_bgbi0234+g_bgbi_m.l_bgbi0235)-((l_bal_money2*(l_season1*p_ac))+(l_bal_money3*(l_season2*p_ac))+(l_bal_money4*(l_season3*p_ac))+(l_bal_money5*(l_season4*p_ac)))
      ELSE
         LET l_diff = (g_bgbi_m.l_bgbi0232+g_bgbi_m.l_bgbi0233+g_bgbi_m.l_bgbi0234+g_bgbi_m.l_bgbi0235)-((l_bal_money2*l_season1)+(l_bal_money3*l_season2)+(l_bal_money4*l_season3)+(l_bal_money5*l_season4))
      END IF
      #若有尾差加到第一期去
      LET l_first_money = l_bal_money2+l_diff
      
      #先把每一期金額UPDATE
      FOR l_i = 1 TO l_period
         LET l_bal_money = 0
         #先找出每一期是屬於哪一季
         SELECT DISTINCT bgac003 INTO l_now_season
           FROM bgac_t
          WHERE bgacent = g_enterprise
            AND bgac001 = l_bgaa002
            AND bgac004 = l_i
         CASE l_now_season
            WHEN 1
               LET l_bal_money = l_bal_money2
            WHEN 2
               LET l_bal_money = l_bal_money3
            WHEN 3
               LET l_bal_money = l_bal_money4
            WHEN 4
               LET l_bal_money = l_bal_money5
         END CASE
         
         #先整批UPDATE
         LET l_sql = "UPDATE bgbi_t SET bgbi018 = '",l_bal_money,"',bgbi019 = '",l_bal_money,"',",
                     "                  bgbi022 = '",l_bal_money,"',bgbi023 = '",l_bal_money,"',",
                     "                  bgbi027 = '",l_bal_money,"',bgbimoddt = ?",
                     " WHERE bgbient = ",g_enterprise,
                     "   AND bgbi002 = '",p_bgbi002,"'",
                     "   AND bgbi003 = '",p_bgbi003,"'",
                     "   AND bgbi004 = '",p_bgbi004,"'",
                     "   AND bgbi005 = '",p_bgbi005,"'",
                     "   AND bgbi044 = '1'",
                     "   AND bgbistus = '",p_bgbistus,"'",
                     "   AND bgbi006 = '",l_i,"'",
                     "   AND ",p_wc
         PREPARE abgt027_01_upd_pb2 FROM l_sql
         EXECUTE abgt027_01_upd_pb2 USING l_date
         IF SQLCA.SQLCODE THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOR

   END IF
   
   #在清點沒有的期別要INSERT
   LET l_sql = "SELECT DISTINCT bgbi038,",                                  #現金變動碼
               "                bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",  #固定核算項
               "                bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,",  #固定核算項
               "                bgbi039,bgbi040,bgbi041,",                  #固定核算項
               "                bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",  #自由核算項1~5
               "                bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,",  #自由核算項6~10
               "                bgbi045,bgbi046,",
               "                bgbistus,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,",
               "                bgbicrtdt,bgbimodid",
               "  FROM bgbi_t",
               " WHERE bgbient = ",g_enterprise,
               "   AND bgbi002 = '",p_bgbi002,"'",
               "   AND bgbi003 = '",p_bgbi003,"'",
               "   AND bgbi004 = '",p_bgbi004,"'",
               "   AND bgbi005 = '",p_bgbi005,"'",
               "   AND bgbi044 = '1' ",
               "   AND bgbistus = '",p_bgbistus,"'",
               "   AND ",p_wc,
               " ORDER BY bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",
               "          bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,",
               "          bgbi039,bgbi040,bgbi041,",                
               "          bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",
               "          bgbi033,bgbi034,bgbi035,bgbi036,bgbi037"
   PREPARE abgt027_01_sel_pre1 FROM l_sql
   DECLARE abgt027_01_sel_cur1 CURSOR FOR abgt027_01_sel_pre1
   LET l_flag = "Y"  #判斷是否為第一項次
   FOREACH abgt027_01_sel_cur1 INTO l_bgbi.bgbi038,
                                    l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,l_bgbi.bgbi011,
                                    l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,l_bgbi.bgbi016,
                                    l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                                    l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,
                                    l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,
                                    l_bgbi.bgbi045,l_bgbi.bgbi046,
                                    l_bgbi.bgbistus,l_bgbi.bgbiownid,l_bgbi.bgbiowndp,l_bgbi.bgbicrtid,l_bgbi.bgbicrtdp,
                                    l_bgbi.bgbicrtdt,l_bgbi.bgbimodid
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_wc = " 1=1 "
      IF NOT cl_null(l_bgbi.bgbi038) THEN LET l_wc = l_wc, " AND bgbi038 = '",l_bgbi.bgbi038,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi007) THEN LET l_wc = l_wc, " AND bgbi007 = '",l_bgbi.bgbi007,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi008) THEN LET l_wc = l_wc, " AND bgbi008 = '",l_bgbi.bgbi008,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi009) THEN LET l_wc = l_wc, " AND bgbi009 = '",l_bgbi.bgbi009,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi010) THEN LET l_wc = l_wc, " AND bgbi010 = '",l_bgbi.bgbi010,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi011) THEN LET l_wc = l_wc, " AND bgbi011 = '",l_bgbi.bgbi011,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi012) THEN LET l_wc = l_wc, " AND bgbi012 = '",l_bgbi.bgbi012,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi013) THEN LET l_wc = l_wc, " AND bgbi013 = '",l_bgbi.bgbi013,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi014) THEN LET l_wc = l_wc, " AND bgbi014 = '",l_bgbi.bgbi014,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi015) THEN LET l_wc = l_wc, " AND bgbi015 = '",l_bgbi.bgbi015,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi016) THEN LET l_wc = l_wc, " AND bgbi016 = '",l_bgbi.bgbi016,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi039) THEN LET l_wc = l_wc, " AND bgbi039 = '",l_bgbi.bgbi039,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi040) THEN LET l_wc = l_wc, " AND bgbi040 = '",l_bgbi.bgbi040,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi041) THEN LET l_wc = l_wc, " AND bgbi041 = '",l_bgbi.bgbi041,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi028) THEN LET l_wc = l_wc, " AND bgbi028 = '",l_bgbi.bgbi028,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi029) THEN LET l_wc = l_wc, " AND bgbi029 = '",l_bgbi.bgbi029,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi030) THEN LET l_wc = l_wc, " AND bgbi030 = '",l_bgbi.bgbi030,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi031) THEN LET l_wc = l_wc, " AND bgbi031 = '",l_bgbi.bgbi031,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi032) THEN LET l_wc = l_wc, " AND bgbi032 = '",l_bgbi.bgbi032,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi033) THEN LET l_wc = l_wc, " AND bgbi033 = '",l_bgbi.bgbi033,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi034) THEN LET l_wc = l_wc, " AND bgbi034 = '",l_bgbi.bgbi034,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi035) THEN LET l_wc = l_wc, " AND bgbi035 = '",l_bgbi.bgbi035,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi036) THEN LET l_wc = l_wc, " AND bgbi036 = '",l_bgbi.bgbi036,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi037) THEN LET l_wc = l_wc, " AND bgbi037 = '",l_bgbi.bgbi037,"'" END IF
      
      
      #撈看看每一期別是否存在，不存在新增
      FOR l_i = 1 TO l_period
         LET l_cnt = 0
         LET l_sql = "SELECT COUNT(*)",
                     "  FROM bgbi_t",
                     " WHERE bgbient = ",g_enterprise,
                     "   AND bgbi002 = '",p_bgbi002,"'",
                     "   AND bgbi003 = '",p_bgbi003,"'",
                     "   AND bgbi004 = '",p_bgbi004,"'",
                     "   AND bgbi005 = '",p_bgbi005,"'",
                     "   AND bgbi044 = '1' ",
                     "   AND bgbistus = '",p_bgbistus,"'",
                     "   AND ",l_wc,
                     "   AND bgbi006 = '",l_i,"'",
                     " ORDER BY bgbi006"
         PREPARE abgt027_01_sel_pre2 FROM l_sql
         EXECUTE abgt027_01_sel_pre2 INTO l_cnt
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt = 0 THEN
            SELECT MAX(bgbiseq)+1 INTO l_bgbi.bgbiseq
              FROM bgbi_t
             WHERE bgbi002 = p_bgbi002
               AND bgbi003 = p_bgbi003
               AND bgbi004 = p_bgbi004
               AND bgbi005 = p_bgbi005
               AND bgbi044 = '1'
               AND bgbient = g_enterprise       #160905-00002#2 
            IF cl_null(l_bgbi.bgbiseq)THEN LET l_bgbi.bgbiseq = 1 END IF
            
            IF g_bgbi_m.l_type = '2' THEN  #總額依季分
               LET l_bal_money = 0
               #先找出每一期是屬於哪一季
               SELECT DISTINCT bgac003 INTO l_now_season
                 FROM bgac_t
                WHERE bgacent = g_enterprise
                  AND bgac001 = l_bgaa002
                  AND bgac004 = l_i
               CASE l_now_season
                  WHEN 1
                     LET l_bal_money = l_bal_money2
                  WHEN 2
                     LET l_bal_money = l_bal_money3
                  WHEN 3
                     LET l_bal_money = l_bal_money4
                  WHEN 4
                     LET l_bal_money = l_bal_money5
               END CASE
               IF l_bal_money = 0 THEN CONTINUE FOR END IF
            END IF
            
            INSERT INTO bgbi_t (bgbient,bgbi002,bgbi003,bgbi045,bgbi004,bgbi005,
                                bgbi017,bgbi046,bgbi044,
                                bgbiseq,bgbi006,
                                bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,
                                bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,
                                bgbi039,bgbi040,bgbi041,
                                bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                                bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,
                                bgbi023,
                                bgbi018,bgbi019,bgbi020,bgbi021,bgbi022,
                                bgbi024,bgbi025,bgbi026,bgbi027,bgbi038,
                                bgbi043,bgbistus,
                                bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,
                                bgbimodid,bgbimoddt
                                ) 
            VALUES(g_enterprise,p_bgbi002,p_bgbi003,l_bgbi.bgbi045,p_bgbi004,p_bgbi005,
                   p_bgbi017,l_bgbi.bgbi046,'1',
                   l_bgbi.bgbiseq,l_i,
                   l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,l_bgbi.bgbi011,
                   l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,l_bgbi.bgbi016,
                   l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                   l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032, 
                   l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,
                   l_bal_money,
                   l_bal_money,l_bal_money,'',1,l_bal_money,
                   0,0,0,l_bal_money,l_bgbi.bgbi038,
                   '1','N',
                   l_bgbi.bgbiownid,l_bgbi.bgbiowndp,l_bgbi.bgbicrtid,l_bgbi.bgbicrtdp,l_bgbi.bgbicrtdt,
                   l_bgbi.bgbimodid,l_date
                   )
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
      END FOR
      
      #若有尾差，找出第一筆第一期UPDATE
      IF l_diff <> 0 AND l_flag = "Y" THEN
         LET l_sql = "UPDATE bgbi_t SET bgbi018 = '",l_first_money,"',bgbi019 = '",l_first_money,"',",
                     "                  bgbi022 = '",l_first_money,"',bgbi023 = '",l_first_money,"',",
                     "                  bgbi027 = '",l_first_money,"'",
                     " WHERE bgbient = ",g_enterprise,
                     "   AND bgbi002 = '",p_bgbi002,"'",
                     "   AND bgbi003 = '",p_bgbi003,"'",
                     "   AND bgbi004 = '",p_bgbi004,"'",
                     "   AND bgbi005 = '",p_bgbi005,"'",
                     "   AND bgbi044 = '1'",
                     "   AND bgbistus = '",p_bgbistus,"'",
                     "   AND bgbi006 = '1'",
                     "   AND ",l_wc
         PREPARE abgt027_01_upd_pb3 FROM l_sql
         EXECUTE abgt027_01_upd_pb3
         IF SQLCA.SQLCODE THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      LET l_flag = "N"
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
