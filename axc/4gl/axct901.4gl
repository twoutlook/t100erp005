#該程式未解開Section, 採用最新樣板產出!
{<section id="axct901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-10-11 14:49:51), PR版次:0015(2017-03-28 19:31:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: axct901
#+ Description: 工單發料成本傳票產生維護作業
#+ Creator....: 02114(2016-01-25 18:07:39)
#+ Modifier...: 02040 -SD/PR- 08734
 
{</section>}
 
{<section id="axct901.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150812-00010#3     2015/08/28 by apo       部門開窗與控卡調整
#150824-00001#4     2015/10/09 By zhangllc  增加发出商品的两支作业axct711,axct712
#151202-00017#2     2015/12/17 BY zhujing   增加项目结转成本 axct714
#160318-00005#47    2016/3/31  By pengxin   修正azzi902重复定义之错误讯息
#160318-00025#13    2016/04/15 By 07673     將重複內容的錯誤訊息置換為公用錯誤訊息
#160527-00019#1     2016/05/27 By lixiang   axct907删除时，xceaua001因是客制字段，改成产品上的字段xceb132(因是从客户环境回收至产品)
#160523-00028#1     2016/06/13 By xianghui  D-FIN-0030（产生帐务交易分录）否改为D-FIN-0032(是否直接抛转凭证)
#160705-00042#10    2016/07/13 By sakura    程式中寫死g_prog部分改寫MATCHES方式
#160705-00042#11    2016/07/15 By sakura    查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160727-00019#22    2016/08/04 By 08742     系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod   axct901_glgb_tmp--> axct901_tmp01  ， axct901_xceb_tmp--> axct901_tmp02 
#                                           Mod   axct901_xcec_tmp--> axct901_tmp03 
#160902-00048#3     2016/09/05 By 02040     條件增加ENT 
#160802-00020#6     2016/10/07 By 02040     增加帳套權限管控、法人權限管控
#160927-00006#1     2016/10/11 By 08734     新增查询时营运据点开窗
#161019-00017#3     2016/10/20 By lixh      据点组织开窗资料整批调整
#160824-00007#224   2016/12/05 By lori      修正舊值備份寫法
#170215-00016#1     2017/02/16 By xujing    搜尋 中 s_voucher_xc_group後，將之調整成vouc_grp_tmp01
#170111-00005#9     2017/02/27 By lixiang   增加控卡提示，科目有做專案管理和wbs時，如果為空，僅提示即可。（并入#170227-00006#1 中处理）
#170227-00006#1     2017/02/27 By lixiang   单身品类、项目编号、WBS：当科目做了对应的核算项管理，则对应栏位开放可维护，处理可参考axct701
#170301-00023#11    2017/03/08 By 09256     "為因應行業包，g_prog整批調整加上'*'
#160711-00040#35    2017/03/28 By 08734     T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                           CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xcea_m        RECORD
       xceald LIKE xcea_t.xceald, 
   xceald_desc LIKE type_t.chr80, 
   xceadocno LIKE xcea_t.xceadocno, 
   xceasite LIKE xcea_t.xceasite, 
   xceasite_desc LIKE type_t.chr80, 
   xcea001 LIKE xcea_t.xcea001, 
   xceacomp LIKE xcea_t.xceacomp, 
   xceacomp_desc LIKE type_t.chr80, 
   xcea002 LIKE xcea_t.xcea002, 
   xcea006 LIKE xcea_t.xcea006, 
   xcea006_desc LIKE type_t.chr80, 
   xcea004 LIKE xcea_t.xcea004, 
   xcea005 LIKE xcea_t.xcea005, 
   xcea003 LIKE xcea_t.xcea003, 
   xcea003_desc LIKE type_t.chr80, 
   xcea101 LIKE xcea_t.xcea101, 
   xceastus LIKE xcea_t.xceastus, 
   xceaownid LIKE xcea_t.xceaownid, 
   xceaownid_desc LIKE type_t.chr80, 
   xceaowndp LIKE xcea_t.xceaowndp, 
   xceaowndp_desc LIKE type_t.chr80, 
   xceacrtid LIKE xcea_t.xceacrtid, 
   xceacrtid_desc LIKE type_t.chr80, 
   xceacrtdp LIKE xcea_t.xceacrtdp, 
   xceacrtdp_desc LIKE type_t.chr80, 
   xceacrtdt LIKE xcea_t.xceacrtdt, 
   xceamodid LIKE xcea_t.xceamodid, 
   xceamodid_desc LIKE type_t.chr80, 
   xceamoddt LIKE xcea_t.xceamoddt, 
   xceacnfid LIKE xcea_t.xceacnfid, 
   xceacnfid_desc LIKE type_t.chr80, 
   xceacnfdt LIKE xcea_t.xceacnfdt, 
   xceapstid LIKE xcea_t.xceapstid, 
   xceapstid_desc LIKE type_t.chr80, 
   xceapstdt LIKE xcea_t.xceapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xceb_d        RECORD
       xcebseq LIKE xceb_t.xcebseq, 
   xceb001 LIKE xceb_t.xceb001, 
   xceb003 LIKE xceb_t.xceb003, 
   xceb004 LIKE xceb_t.xceb004, 
   xceb005 LIKE xceb_t.xceb005, 
   xceb101 LIKE xceb_t.xceb101, 
   xceb101_desc LIKE type_t.chr500, 
   xceb102 LIKE xceb_t.xceb102, 
   xceb103 LIKE xceb_t.xceb103, 
   xceb103_desc LIKE type_t.chr500, 
   xceb110 LIKE xceb_t.xceb110, 
   xceb117 LIKE xceb_t.xceb117, 
   xceb118 LIKE xceb_t.xceb118, 
   xceb114 LIKE xceb_t.xceb114, 
   xceb115 LIKE xceb_t.xceb115, 
   xceb116 LIKE xceb_t.xceb116, 
   xceb119 LIKE xceb_t.xceb119, 
   xceb120 LIKE xceb_t.xceb120, 
   xceb107 LIKE xceb_t.xceb107, 
   xceb107_desc LIKE type_t.chr500, 
   xceb108 LIKE xceb_t.xceb108, 
   xceb108_desc LIKE type_t.chr500, 
   xceb109 LIKE xceb_t.xceb109, 
   xceb109_desc LIKE type_t.chr500, 
   xceb111 LIKE xceb_t.xceb111, 
   xceb111_desc LIKE type_t.chr500, 
   xceb112 LIKE xceb_t.xceb112, 
   xceb113 LIKE xceb_t.xceb113, 
   xceb121 LIKE xceb_t.xceb121, 
   xceb122 LIKE xceb_t.xceb122, 
   xceb123 LIKE xceb_t.xceb123, 
   xceb124 LIKE xceb_t.xceb124, 
   xceb125 LIKE xceb_t.xceb125, 
   xceb126 LIKE xceb_t.xceb126, 
   xceb127 LIKE xceb_t.xceb127, 
   xceb128 LIKE xceb_t.xceb128, 
   xceb129 LIKE xceb_t.xceb129, 
   xceb130 LIKE xceb_t.xceb130, 
   xceb201 LIKE xceb_t.xceb201, 
   xceb202 LIKE xceb_t.xceb202, 
   xceb202a LIKE xceb_t.xceb202a, 
   xceb202b LIKE xceb_t.xceb202b, 
   xceb202c LIKE xceb_t.xceb202c, 
   xceb202d LIKE xceb_t.xceb202d, 
   xceb202e LIKE xceb_t.xceb202e, 
   xceb202f LIKE xceb_t.xceb202f, 
   xceb202g LIKE xceb_t.xceb202g, 
   xceb202h LIKE xceb_t.xceb202h, 
   xceb212 LIKE xceb_t.xceb212, 
   xceb212a LIKE xceb_t.xceb212a, 
   xceb212b LIKE xceb_t.xceb212b, 
   xceb212c LIKE xceb_t.xceb212c, 
   xceb212d LIKE xceb_t.xceb212d, 
   xceb212e LIKE xceb_t.xceb212e, 
   xceb212f LIKE xceb_t.xceb212f, 
   xceb212g LIKE xceb_t.xceb212g, 
   xceb212h LIKE xceb_t.xceb212h, 
   xceb222 LIKE xceb_t.xceb222, 
   xceb222a LIKE xceb_t.xceb222a, 
   xceb222b LIKE xceb_t.xceb222b, 
   xceb222c LIKE xceb_t.xceb222c, 
   xceb222d LIKE xceb_t.xceb222d, 
   xceb222e LIKE xceb_t.xceb222e, 
   xceb222f LIKE xceb_t.xceb222f, 
   xceb222g LIKE xceb_t.xceb222g, 
   xceb222h LIKE xceb_t.xceb222h, 
   xceb301 LIKE xceb_t.xceb301, 
   xceb302 LIKE xceb_t.xceb302, 
   xcebcomp LIKE xceb_t.xcebcomp
       END RECORD
PRIVATE TYPE type_g_xceb4_d RECORD
       xcecseq LIKE xcec_t.xcecseq, 
   xcec001 LIKE xcec_t.xcec001, 
   xcec003 LIKE xcec_t.xcec003, 
   xcec004 LIKE xcec_t.xcec004, 
   xcec005 LIKE xcec_t.xcec005, 
   xcec101 LIKE xcec_t.xcec101, 
   xcec101_desc LIKE type_t.chr500, 
   xcec102 LIKE xcec_t.xcec102, 
   xcec103 LIKE xcec_t.xcec103, 
   xcec103_desc LIKE type_t.chr500, 
   xcec110 LIKE xcec_t.xcec110, 
   xcec117 LIKE xcec_t.xcec117, 
   xcec118 LIKE xcec_t.xcec118, 
   xcec114 LIKE xcec_t.xcec114, 
   xcec115 LIKE xcec_t.xcec115, 
   xcec116 LIKE xcec_t.xcec116, 
   xcec119 LIKE xcec_t.xcec119, 
   xcec120 LIKE xcec_t.xcec120, 
   xcec107 LIKE xcec_t.xcec107, 
   xcec107_desc LIKE type_t.chr500, 
   xcec108 LIKE xcec_t.xcec108, 
   xcec108_desc LIKE type_t.chr500, 
   xcec109 LIKE xcec_t.xcec109, 
   xcec109_desc LIKE type_t.chr500, 
   xcec111 LIKE xcec_t.xcec111, 
   xcec111_desc LIKE type_t.chr500, 
   xcec112 LIKE xcec_t.xcec112, 
   xcec113 LIKE xcec_t.xcec113, 
   xcec121 LIKE xcec_t.xcec121, 
   xcec122 LIKE xcec_t.xcec122, 
   xcec123 LIKE xcec_t.xcec123, 
   xcec124 LIKE xcec_t.xcec124, 
   xcec125 LIKE xcec_t.xcec125, 
   xcec126 LIKE xcec_t.xcec126, 
   xcec127 LIKE xcec_t.xcec127, 
   xcec128 LIKE xcec_t.xcec128, 
   xcec129 LIKE xcec_t.xcec129, 
   xcec130 LIKE xcec_t.xcec130, 
   xcec201 LIKE xcec_t.xcec201, 
   xcec202 LIKE xcec_t.xcec202, 
   xcec202a LIKE xcec_t.xcec202a, 
   xcec202b LIKE xcec_t.xcec202b, 
   xcec202c LIKE xcec_t.xcec202c, 
   xcec202d LIKE xcec_t.xcec202d, 
   xcec202e LIKE xcec_t.xcec202e, 
   xcec202f LIKE xcec_t.xcec202f, 
   xcec202g LIKE xcec_t.xcec202g, 
   xcec202h LIKE xcec_t.xcec202h, 
   xcec212 LIKE xcec_t.xcec212, 
   xcec212a LIKE xcec_t.xcec212a, 
   xcec212b LIKE xcec_t.xcec212b, 
   xcec212c LIKE xcec_t.xcec212c, 
   xcec212d LIKE xcec_t.xcec212d, 
   xcec212e LIKE xcec_t.xcec212e, 
   xcec212f LIKE xcec_t.xcec212f, 
   xcec212g LIKE xcec_t.xcec212g, 
   xcec212h LIKE xcec_t.xcec212h, 
   xcec222 LIKE xcec_t.xcec222, 
   xcec222a LIKE xcec_t.xcec222a, 
   xcec222b LIKE xcec_t.xcec222b, 
   xcec222c LIKE xcec_t.xcec222c, 
   xcec222d LIKE xcec_t.xcec222d, 
   xcec222e LIKE xcec_t.xcec222e, 
   xcec222f LIKE xcec_t.xcec222f, 
   xcec222g LIKE xcec_t.xcec222g, 
   xcec222h LIKE xcec_t.xcec222h, 
   xcec301 LIKE xcec_t.xcec301, 
   xcec302 LIKE xcec_t.xcec302, 
   xceccomp LIKE xcec_t.xceccomp
       END RECORD
PRIVATE TYPE type_g_xceb8_d RECORD
       xcebseq LIKE xceb_t.xcebseq, 
   xceb117 LIKE xceb_t.xceb117, 
   xceb115 LIKE xceb_t.xceb115, 
   xceb202 LIKE xceb_t.xceb202, 
   xceb202a LIKE xceb_t.xceb202a, 
   xceb202b LIKE xceb_t.xceb202b, 
   xceb202c LIKE xceb_t.xceb202c, 
   xceb202d LIKE xceb_t.xceb202d, 
   xceb202e LIKE xceb_t.xceb202e, 
   xceb202f LIKE xceb_t.xceb202f, 
   xceb202g LIKE xceb_t.xceb202g, 
   xceb202h LIKE xceb_t.xceb202h, 
   xceb212 LIKE xceb_t.xceb212, 
   xceb212a LIKE xceb_t.xceb212a, 
   xceb212b LIKE xceb_t.xceb212b, 
   xceb212c LIKE xceb_t.xceb212c, 
   xceb212d LIKE xceb_t.xceb212d, 
   xceb212e LIKE xceb_t.xceb212e, 
   xceb212f LIKE xceb_t.xceb212f, 
   xceb212g LIKE xceb_t.xceb212g, 
   xceb212h LIKE xceb_t.xceb212h, 
   xceb222 LIKE xceb_t.xceb222, 
   xceb222a LIKE xceb_t.xceb222a, 
   xceb222b LIKE xceb_t.xceb222b, 
   xceb222c LIKE xceb_t.xceb222c, 
   xceb222d LIKE xceb_t.xceb222d, 
   xceb222e LIKE xceb_t.xceb222e, 
   xceb222f LIKE xceb_t.xceb222f, 
   xceb222g LIKE xceb_t.xceb222g, 
   xceb222h LIKE xceb_t.xceb222h
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xceald LIKE xcea_t.xceald,
      b_xceadocno LIKE xcea_t.xceadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單身 type 宣告
 TYPE type_g_xceb2_d        RECORD
   xcebseq LIKE xceb_t.xcebseq, 
   xceb001 LIKE xceb_t.xceb001, 
   xceb003 LIKE xceb_t.xceb003, 
   xceb004 LIKE xceb_t.xceb004,
   xceb005 LIKE xceb_t.xceb005,   
   xceb101 LIKE xceb_t.xceb101, 
   xceb101_desc LIKE type_t.chr500, 
   xceb102 LIKE xceb_t.xceb102, 
   xceb103 LIKE xceb_t.xceb103, 
   xceb103_desc LIKE type_t.chr500, 
   xceb110 LIKE xceb_t.xceb110,    
   xceb117 LIKE xceb_t.xceb117,
   xceb118 LIKE xceb_t.xceb118,    
   xceb114 LIKE xceb_t.xceb114, 
   xceb115 LIKE xceb_t.xceb115, 
   xceb116 LIKE xceb_t.xceb116, 
   xceb119 LIKE xceb_t.xceb119, 
   xceb120 LIKE xceb_t.xceb120, 
   xceb107 LIKE xceb_t.xceb107, 
   xceb107_desc LIKE type_t.chr500, 
   xceb108 LIKE xceb_t.xceb108, 
   xceb108_desc LIKE type_t.chr500, 
   xceb109 LIKE xceb_t.xceb109, 
   xceb109_desc LIKE type_t.chr500,
   xceb111 LIKE xceb_t.xceb111, 
   xceb111_desc LIKE type_t.chr500, 
   xceb112 LIKE xceb_t.xceb112,    
   xceb113 LIKE xceb_t.xceb113, 
   xceb121 LIKE xceb_t.xceb121, 
   xceb122 LIKE xceb_t.xceb122, 
   xceb123 LIKE xceb_t.xceb123, 
   xceb124 LIKE xceb_t.xceb124, 
   xceb125 LIKE xceb_t.xceb125, 
   xceb126 LIKE xceb_t.xceb126, 
   xceb127 LIKE xceb_t.xceb127, 
   xceb128 LIKE xceb_t.xceb128, 
   xceb129 LIKE xceb_t.xceb129, 
   xceb130 LIKE xceb_t.xceb130, 
   xceb201 LIKE xceb_t.xceb201,
   xceb212 LIKE xceb_t.xceb212, 
   xceb212a LIKE xceb_t.xceb212a, 
   xceb212b LIKE xceb_t.xceb212b, 
   xceb212c LIKE xceb_t.xceb212c, 
   xceb212d LIKE xceb_t.xceb212d, 
   xceb212e LIKE xceb_t.xceb212e, 
   xceb212f LIKE xceb_t.xceb212f, 
   xceb212g LIKE xceb_t.xceb212g, 
   xceb212h LIKE xceb_t.xceb212h
       END RECORD
       
 TYPE type_g_xceb3_d        RECORD
   xcebseq LIKE xceb_t.xcebseq, 
   xceb001 LIKE xceb_t.xceb001, 
   xceb003 LIKE xceb_t.xceb003, 
   xceb004 LIKE xceb_t.xceb004, 
   xceb005 LIKE xceb_t.xceb005, 
   xceb101 LIKE xceb_t.xceb101, 
   xceb101_desc LIKE type_t.chr500, 
   xceb102 LIKE xceb_t.xceb102, 
   xceb103 LIKE xceb_t.xceb103, 
   xceb103_desc LIKE type_t.chr500,
   xceb110 LIKE xceb_t.xceb110,    
   xceb117 LIKE xceb_t.xceb117,
   xceb118 LIKE xceb_t.xceb118,    
   xceb114 LIKE xceb_t.xceb114, 
   xceb115 LIKE xceb_t.xceb115, 
   xceb116 LIKE xceb_t.xceb116, 
   xceb119 LIKE xceb_t.xceb119, 
   xceb120 LIKE xceb_t.xceb120,
   xceb107 LIKE xceb_t.xceb107, 
   xceb107_desc LIKE type_t.chr500, 
   xceb108 LIKE xceb_t.xceb108, 
   xceb108_desc LIKE type_t.chr500, 
   xceb109 LIKE xceb_t.xceb109, 
   xceb109_desc LIKE type_t.chr500,   
   xceb111 LIKE xceb_t.xceb111, 
   xceb111_desc LIKE type_t.chr500, 
   xceb112 LIKE xceb_t.xceb112,    
   xceb113 LIKE xceb_t.xceb113,
   xceb121 LIKE xceb_t.xceb121, 
   xceb122 LIKE xceb_t.xceb122, 
   xceb123 LIKE xceb_t.xceb123, 
   xceb124 LIKE xceb_t.xceb124, 
   xceb125 LIKE xceb_t.xceb125, 
   xceb126 LIKE xceb_t.xceb126, 
   xceb127 LIKE xceb_t.xceb127, 
   xceb128 LIKE xceb_t.xceb128, 
   xceb129 LIKE xceb_t.xceb129, 
   xceb130 LIKE xceb_t.xceb130, 
   xceb201 LIKE xceb_t.xceb201,   
   xceb222 LIKE xceb_t.xceb222, 
   xceb222a LIKE xceb_t.xceb222a, 
   xceb222b LIKE xceb_t.xceb222b, 
   xceb222c LIKE xceb_t.xceb222c, 
   xceb222d LIKE xceb_t.xceb222d, 
   xceb222e LIKE xceb_t.xceb222e, 
   xceb222f LIKE xceb_t.xceb222f, 
   xceb222g LIKE xceb_t.xceb222g, 
   xceb222h LIKE xceb_t.xceb222h
       END RECORD
       
 TYPE type_g_xceb5_d RECORD
   xcecseq LIKE xcec_t.xcecseq, 
   xcec001 LIKE xcec_t.xcec001, 
   xcec003 LIKE xcec_t.xcec003, 
   xcec004 LIKE xcec_t.xcec004,
   xcec005 LIKE xcec_t.xcec005,   
   xcec101 LIKE xcec_t.xcec101, 
   xcec101_desc LIKE type_t.chr500, 
   xcec102 LIKE xcec_t.xcec102, 
   xcec103 LIKE xcec_t.xcec103, 
   xcec103_desc LIKE type_t.chr500, 
   xcec110 LIKE xcec_t.xcec110,    
   xcec117 LIKE xcec_t.xcec117, 
   xcec118 LIKE xcec_t.xcec118,      
   xcec114 LIKE xcec_t.xcec114,
   xcec115 LIKE xcec_t.xcec115,
   xcec116 LIKE xcec_t.xcec116,    
   xcec119 LIKE xcec_t.xcec119, 
   xcec120 LIKE xcec_t.xcec120,
   xcec107 LIKE xcec_t.xcec107, 
   xcec107_desc LIKE type_t.chr500, 
   xcec108 LIKE xcec_t.xcec108, 
   xcec108_desc LIKE type_t.chr500, 
   xcec109 LIKE xcec_t.xcec109, 
   xcec109_desc LIKE type_t.chr500,    
   xcec111 LIKE xcec_t.xcec111, 
   xcec111_desc LIKE type_t.chr500,
   xcec112 LIKE xcec_t.xcec112,    
   xcec113 LIKE xcec_t.xcec113,
   xcec121 LIKE xcec_t.xcec121, 
   xcec122 LIKE xcec_t.xcec122, 
   xcec123 LIKE xcec_t.xcec123, 
   xcec124 LIKE xcec_t.xcec124, 
   xcec125 LIKE xcec_t.xcec125, 
   xcec126 LIKE xcec_t.xcec126, 
   xcec127 LIKE xcec_t.xcec127, 
   xcec128 LIKE xcec_t.xcec128, 
   xcec129 LIKE xcec_t.xcec129, 
   xcec130 LIKE xcec_t.xcec130,    
   xcec201 LIKE xcec_t.xcec201, 
   xcec212 LIKE xcec_t.xcec212, 
   xcec212a LIKE xcec_t.xcec212a, 
   xcec212b LIKE xcec_t.xcec212b, 
   xcec212c LIKE xcec_t.xcec212c, 
   xcec212d LIKE xcec_t.xcec212d, 
   xcec212e LIKE xcec_t.xcec212e, 
   xcec212f LIKE xcec_t.xcec212f, 
   xcec212g LIKE xcec_t.xcec212g, 
   xcec212h LIKE xcec_t.xcec212h 
       END RECORD
       
 TYPE type_g_xceb6_d RECORD
   xcecseq LIKE xcec_t.xcecseq, 
   xcec001 LIKE xcec_t.xcec001, 
   xcec003 LIKE xcec_t.xcec003, 
   xcec004 LIKE xcec_t.xcec004,
   xcec005 LIKE xcec_t.xcec005,   
   xcec101 LIKE xcec_t.xcec101, 
   xcec101_desc LIKE type_t.chr500, 
   xcec102 LIKE xcec_t.xcec102, 
   xcec103 LIKE xcec_t.xcec103, 
   xcec103_desc LIKE type_t.chr500, 
   xcec110 LIKE xcec_t.xcec110,    
   xcec117 LIKE xcec_t.xcec117, 
   xcec118 LIKE xcec_t.xcec118,    
   xcec114 LIKE xcec_t.xcec114,
   xcec115 LIKE xcec_t.xcec115, 
   xcec116 LIKE xcec_t.xcec116,    
   xcec119 LIKE xcec_t.xcec119, 
   xcec120 LIKE xcec_t.xcec120,
   xcec107 LIKE xcec_t.xcec107, 
   xcec107_desc LIKE type_t.chr500, 
   xcec108 LIKE xcec_t.xcec108, 
   xcec108_desc LIKE type_t.chr500, 
   xcec109 LIKE xcec_t.xcec109, 
   xcec109_desc LIKE type_t.chr500,    
   xcec111 LIKE xcec_t.xcec111, 
   xcec111_desc LIKE type_t.chr500,
   xcec112 LIKE xcec_t.xcec112,    
   xcec113 LIKE xcec_t.xcec113, 
   xcec121 LIKE xcec_t.xcec121, 
   xcec122 LIKE xcec_t.xcec122, 
   xcec123 LIKE xcec_t.xcec123, 
   xcec124 LIKE xcec_t.xcec124, 
   xcec125 LIKE xcec_t.xcec125, 
   xcec126 LIKE xcec_t.xcec126, 
   xcec127 LIKE xcec_t.xcec127, 
   xcec128 LIKE xcec_t.xcec128, 
   xcec129 LIKE xcec_t.xcec129, 
   xcec130 LIKE xcec_t.xcec130, 
   xcec201 LIKE xcec_t.xcec201, 
   xcec222 LIKE xcec_t.xcec222, 
   xcec222a LIKE xcec_t.xcec222a, 
   xcec222b LIKE xcec_t.xcec222b, 
   xcec222c LIKE xcec_t.xcec222c, 
   xcec222d LIKE xcec_t.xcec222d, 
   xcec222e LIKE xcec_t.xcec222e, 
   xcec222f LIKE xcec_t.xcec222f, 
   xcec222g LIKE xcec_t.xcec222g, 
   xcec222h LIKE xcec_t.xcec222h
       END RECORD       
 
DEFINE g_xceb2_d          DYNAMIC ARRAY OF type_g_xceb2_d
DEFINE g_xceb2_d_t        type_g_xceb2_d
DEFINE g_xceb3_d          DYNAMIC ARRAY OF type_g_xceb3_d
DEFINE g_xceb3_d_t        type_g_xceb3_d 
DEFINE g_xceb5_d          DYNAMIC ARRAY OF type_g_xceb5_d
DEFINE g_xceb5_d_t        type_g_xceb5_d
DEFINE g_xceb6_d          DYNAMIC ARRAY OF type_g_xceb6_d
DEFINE g_xceb6_d_t        type_g_xceb6_d 


TYPE type_g_xceb7_d RECORD
   xcebdocno LIKE xceb_t.xcebdocno,
   xcea001 LIKE xcea_t.xcea001,
   xcebseq LIKE xceb_t.xcebseq, 
   xceb102 LIKE xceb_t.xceb102, 
   xceb101 LIKE type_t.chr500, 
   xceb202 LIKE xceb_t.xceb222, 
   xceb202a LIKE xceb_t.xceb202a, 
   xceb202b LIKE xceb_t.xceb202b, 
   xceb202c LIKE xceb_t.xceb202c, 
   xceb202d LIKE xceb_t.xceb202d, 
   xceb202e LIKE xceb_t.xceb202e,
   imag1    LIKE type_t.chr500
       END RECORD
 
DEFINE g_xceb7_d          DYNAMIC ARRAY OF type_g_xceb7_d
DEFINE g_xceb7_d_t        type_g_xceb7_d
DEFINE g_prog_name1   LIKE type_t.chr20
DEFINE g_glaa001    LIKE glaa_t.glaa001
DEFINE g_glaa003    LIKE glaa_t.glaa003
DEFINE g_glaa004    LIKE glaa_t.glaa004
DEFINE g_glaa015    LIKE glaa_t.glaa015
DEFINE g_glaa016    LIKE glaa_t.glaa016
DEFINE g_glaa018    LIKE glaa_t.glaa018
DEFINE g_glaa019    LIKE glaa_t.glaa019
DEFINE g_glaa020    LIKE glaa_t.glaa020
DEFINE g_glaa022    LIKE glaa_t.glaa022
DEFINE g_glaa024    LIKE glaa_t.glaa024

TYPE type_g_xced_d RECORD
   xceddocno LIKE xced_t.xceddocno,
   xcedld    LIKE xced_t.xcedld,
   xcedseq   LIKE xced_t.xcedseq,
   xced001   LIKE xced_t.xced001, 
   xced101   LIKE xced_t.xced101, 
   xced101_desc LIKE type_t.chr500,
   xced102   LIKE xced_t.xced102, 
   xced117   LIKE xced_t.xced117, 
   xced114   LIKE xced_t.xced114, 
   xced119   LIKE xced_t.xced119, 
   xced120   LIKE xced_t.xced120, 
   xced111   LIKE xced_t.xced111,
   xced113   LIKE xced_t.xced113,
   xced202   LIKE xced_t.xced202,
   xced212   LIKE xced_t.xced212,
   xced222   LIKE xced_t.xced222
       END RECORD
DEFINE g_xced_d          DYNAMIC ARRAY OF type_g_xced_d
DEFINE g_xced_d_t        type_g_xced_d  
DEFINE g_glaa121         LIKE glaa_t.glaa121

#20150731--add--str--lujh
 TYPE type_g_xceb9_d RECORD
       xceb115         LIKE xceb_t.xceb115, 
       xceb117         LIKE xceb_t.xceb117, 
       xceb117_4_desc  LIKE type_t.chr500, 
       xceb202         LIKE xceb_t.xceb202
       END RECORD
       
 TYPE type_g_xceb10_d RECORD
       xcec115         LIKE xcec_t.xcec115, 
       xcec117         LIKE xcec_t.xcec117, 
       xcec117_4_desc  LIKE type_t.chr500, 
       xcec202         LIKE xcec_t.xcec202
       END RECORD

DEFINE g_xceb9_d          DYNAMIC ARRAY OF type_g_xceb9_d
DEFINE g_xceb9_d_t        type_g_xceb9_d 
DEFINE g_xceb10_d         DYNAMIC ARRAY OF type_g_xceb10_d
DEFINE g_xceb10_d_t       type_g_xceb10_d 
#20150731--add--end--lujh
#160802-00020#6-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#6-e-add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xcea_m          type_g_xcea_m
DEFINE g_xcea_m_t        type_g_xcea_m
DEFINE g_xcea_m_o        type_g_xcea_m
DEFINE g_xcea_m_mask_o   type_g_xcea_m #轉換遮罩前資料
DEFINE g_xcea_m_mask_n   type_g_xcea_m #轉換遮罩後資料
 
   DEFINE g_xceald_t LIKE xcea_t.xceald
DEFINE g_xceadocno_t LIKE xcea_t.xceadocno
 
 
DEFINE g_xceb_d          DYNAMIC ARRAY OF type_g_xceb_d
DEFINE g_xceb_d_t        type_g_xceb_d
DEFINE g_xceb_d_o        type_g_xceb_d
DEFINE g_xceb_d_mask_o   DYNAMIC ARRAY OF type_g_xceb_d #轉換遮罩前資料
DEFINE g_xceb_d_mask_n   DYNAMIC ARRAY OF type_g_xceb_d #轉換遮罩後資料
DEFINE g_xceb4_d          DYNAMIC ARRAY OF type_g_xceb4_d
DEFINE g_xceb4_d_t        type_g_xceb4_d
DEFINE g_xceb4_d_o        type_g_xceb4_d
DEFINE g_xceb4_d_mask_o   DYNAMIC ARRAY OF type_g_xceb4_d #轉換遮罩前資料
DEFINE g_xceb4_d_mask_n   DYNAMIC ARRAY OF type_g_xceb4_d #轉換遮罩後資料
DEFINE g_xceb8_d          DYNAMIC ARRAY OF type_g_xceb8_d
DEFINE g_xceb8_d_t        type_g_xceb8_d
DEFINE g_xceb8_d_o        type_g_xceb8_d
DEFINE g_xceb8_d_mask_o   DYNAMIC ARRAY OF type_g_xceb8_d #轉換遮罩前資料
DEFINE g_xceb8_d_mask_n   DYNAMIC ARRAY OF type_g_xceb8_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axct901.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #160802-00020#6-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#6-e-add  
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xceald,'',xceadocno,xceasite,'',xcea001,xceacomp,'',xcea002,xcea006,'', 
       xcea004,xcea005,xcea003,'',xcea101,xceastus,xceaownid,'',xceaowndp,'',xceacrtid,'',xceacrtdp, 
       '',xceacrtdt,xceamodid,'',xceamoddt,xceacnfid,'',xceacnfdt,xceapstid,'',xceapstdt", 
                      " FROM xcea_t",
                      " WHERE xceaent= ? AND xceald=? AND xceadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xceald,t0.xceadocno,t0.xceasite,t0.xcea001,t0.xceacomp,t0.xcea002, 
       t0.xcea006,t0.xcea004,t0.xcea005,t0.xcea003,t0.xcea101,t0.xceastus,t0.xceaownid,t0.xceaowndp, 
       t0.xceacrtid,t0.xceacrtdp,t0.xceacrtdt,t0.xceamodid,t0.xceamoddt,t0.xceacnfid,t0.xceacnfdt,t0.xceapstid, 
       t0.xceapstdt,t1.glaal002 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooag011 ,t5.xcatl003 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM xcea_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.xceald AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xceasite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.xceacomp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.xcea006  ",
               " LEFT JOIN xcatl_t t5 ON t5.xcatlent="||g_enterprise||" AND t5.xcatl001=t0.xcea003 AND t5.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xceaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.xceaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xceacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.xceacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xceamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.xceacnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.xceapstid  ",
 
               " WHERE t0.xceaent = " ||g_enterprise|| " AND t0.xceald = ? AND t0.xceadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct901_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct901 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct901_init()   
 
      #進入選單 Menu (="N")
      CALL axct901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct901
      
   END IF 
   
   CLOSE axct901_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct901_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xceastus','13','N,Y,A,D,R,W')
 
      CALL cl_set_combo_scc('xcea002','8920') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','3',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("xceb003",'8924')
   CALL cl_set_combo_scc("xceb003_1",'8924')
   CALL cl_set_combo_scc("xceb003_2",'8924')
   CALL cl_set_combo_scc("xcec003",'8924')
   CALL cl_set_combo_scc("xcec003_1",'8924')
   CALL cl_set_combo_scc("xcec003_2",'8924')
   #20150806--add--str--lujh
   CALL cl_set_combo_scc('xceb115','6013')
   CALL cl_set_combo_scc('xcec115','6013')
   CALL cl_set_combo_scc('xceb115_4','6013')
   CALL cl_set_combo_scc('xcec115_4','6013')
   #20150806--add--end--lujh 

   CALL cl_set_act_visible_toolbaritem("open_axct702_s01",FALSE)    #除702，705，其他都隐藏
   
   IF g_argv[1] = '8' OR g_argv[1] = '6' THEN   #axct908  axct906
      CALL cl_set_combo_scc("xceb003",'8924')
      CALL cl_set_combo_scc("xceb003_1",'8924')
      CALL cl_set_combo_scc("xceb003_2",'8924')
      CALL cl_set_combo_scc("xcec003",'8924')
      CALL cl_set_combo_scc("xcec003_1",'8924')
      CALL cl_set_combo_scc("xcec003_2",'8924')
   END IF
   CALL cl_set_act_visible("insert",FALSE)
   IF g_argv[1] = '1' THEN   #axct901
      CALL cl_set_act_visible_toolbaritem("call_axcq512",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_1",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_2",FALSE)    
      CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_2',FALSE)   
      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',FALSE)
      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',FALSE)  
      CALL cl_set_comp_visible('xceb110_1,xceb118_1,xceb115_1,xceb116_1,xceb112_1',FALSE)
      CALL cl_set_comp_visible('xceb110_2,xceb118_2,xceb115_2,xceb116_2,xceb112_2',FALSE)    
      CALL cl_set_comp_visible('xcec110_1,xcec118_1,xcec115_1,xcec116_1,xcec112_1',FALSE)       
      CALL cl_set_comp_visible('xcec110_2,xcec118_2,xcec115_2,xcec116_2,xcec112_2',FALSE)       
   END IF
   IF g_argv[1] = '2' OR g_argv[1] = '5' THEN  #axct902  axct905
      CALL cl_set_act_visible_toolbaritem("call_axcq512",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_1",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_2",FALSE)
      CALL cl_set_act_visible_toolbaritem("open_axct702_s01",TRUE) 
      IF g_argv[1] = '2' THEN      
         CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_2',TRUE)  
      ELSE
         CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_2',FALSE) 
      END IF      
      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',FALSE)
      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',FALSE)
      CALL cl_set_comp_visible('xceb110_1,xceb118_1,xceb115_1,xceb116_1,xceb112_1',FALSE)
      CALL cl_set_comp_visible('xceb110_2,xceb118_2,xceb115_2,xceb116_2,xceb112_2',FALSE)
      CALL cl_set_comp_visible('xcec110_1,xcec118_1,xcec115_1,xcec116_1,xcec112_1',FALSE)       
      CALL cl_set_comp_visible('xcec110_2,xcec118_2,xcec115_2,xcec116_2,xcec112_2',FALSE)        
   END IF
   IF g_argv[1] = '7' OR g_argv[1] = '8' THEN  #axct907  axct908
      CALL cl_set_act_visible_toolbaritem("call_axcq512",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_1",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_2",FALSE)      
      CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_2',TRUE)
      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',TRUE)
      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',TRUE) 
      CALL cl_set_comp_visible('xceb110_1,xceb118_1,xceb115_1,xceb116_1,xceb112_1',TRUE)
      CALL cl_set_comp_visible('xcec110_2,xcec118_2,xcec115_2,xcec116_2,xcec112_2',TRUE)        
      CALL cl_set_comp_visible('xceb001,xcec001',FALSE)
      CALL cl_set_comp_visible('xceb001_1,xcec001_1',FALSE)
      CALL cl_set_comp_visible('xceb001_2,xcec001_2',FALSE)     
   END IF   
   IF g_argv[1] = '9' THEN    #axct909的
      CALL cl_set_combo_scc("xceb003",'8908')
      CALL cl_set_combo_scc("xceb003_1",'8908')
      CALL cl_set_combo_scc("xceb003_2",'8908')
      CALL cl_set_combo_scc("xcec003",'8909')
      CALL cl_set_combo_scc("xcec003_1",'8909')
      CALL cl_set_combo_scc("xcec003_2",'8909')
      CALL cl_set_act_visible_toolbaritem("call_axcq512",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_1",FALSE)
      CALL cl_set_act_visible_toolbaritem("call_axcq512_2",FALSE)
      CALL cl_set_comp_visible('xceb001,xceb004,xceb005,xceb201,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xcec301,xceb302,xcebcomp',FALSE)
      CALL cl_set_comp_visible('xcec001,xcec004,xcec005,xcec201,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp',FALSE)
      CALL cl_set_comp_visible('xceb001_1,xceb004_1,xceb005_1,xceb201_1,xceb202a_1,xceb202b_1,xceb202c_1,xceb202d_1,xceb202e_1,xceb202f_1,xceb202g_1,xceb202h_1,xceb212a_1,xceb212b_1,xceb212c_1,xceb212d_1,xceb212e_1,xceb212f_1,xceb212g_1,xceb212h_1,xceb222a_1,xceb222b_1,xceb222c_1,xceb222d_1,xceb222e_1,xceb222f_1,xceb222g_1,xceb222h_1',FALSE)
      CALL cl_set_comp_visible('xcec001_1,xcec004_1,xcec005_1,xcec201_1,xcec202a_1,xcec202b_1,xcec202c_1,xcec202d_1,xcec202e_1,xcec202f_1,xcec202g_1,xcec202h_1,xcec212a_1,xcec212b_1,xcec212c_1,xcec212d_1,xcec212e_1,xcec212f_1,xcec212g_1,xcec212h_1,xcec222a_1,xcec222b_1,xcec222c_1,xcec222d_1,xcec222e_1,xcec222f_1,xcec222g_1,xcec222h_1',FALSE)
      CALL cl_set_comp_visible('xceb001_2,xceb004_2,xceb005_2,xceb201_2,xceb202a_2,xceb202b_2,xceb202c_2,xceb202d_2,xceb202e_2,xceb202f_2,xceb202g_2,xceb202h_2,xecb212_2,xceb212a_2,xceb212b_2,xceb212c_2,xceb212d_2,xceb212e_2,xceb212f_2,xceb212g_2,xceb212h_2,xceb222_2,xceb222a_2,xceb222b_2,xceb222c_2,xceb222d_2,xceb222e_2,xceb222f_2,xceb222g_2,xceb222h_2',FALSE)
      CALL cl_set_comp_visible('xcec001_2,xcec004_2,xcec005_2,xcec201_2,xcec202a_2,xcec202b_2,xcec202c_2,xcec202d_2,xcec202e_2,xcec202f_2,xcec202g_2,xcec202h_2,xcec212_2,xcec212a_2,xcec212b_2,xcec212c_2,xcec212d_2,xcec212e_2,xcec212f_2,xcec212g_2,xcec212h_2,xcec222_2,xcec222a_2,xcec222b_2,xcec222c_2,xcec222d_2,xcec222e_2,xcec222f_2,xcec222g_2,xcec222h_2',FALSE)
   END IF
   IF g_argv[1] = '4' THEN   #axct904
      CALL cl_set_combo_scc("xceb003",'8916')
      CALL cl_set_combo_scc("xceb003_1",'8916')
      CALL cl_set_combo_scc("xceb003_3",'8916')
      CALL cl_set_combo_scc("xcec003",'8916')
      CALL cl_set_combo_scc("xcec003_1",'8916')
      CALL cl_set_combo_scc("xcec003_3",'8916')
      CALL cl_set_comp_visible('xceb001,xceb003,xceb001_1,xceb003_1,xceb001_3,xceb003_3',TRUE)
      CALL cl_set_comp_visible('xcec001,xcec003,xcec001_1,xcec003_1,xcec001_3,xcec003_3',TRUE)
      CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_3',TRUE)
      CALL cl_set_comp_visible('xcec201,xcec201_1,xcec201_3',TRUE)
   END IF
   IF g_argv[1] = '3' THEN   #axct903
      CALL cl_set_combo_scc("xceb003",'8916')
      CALL cl_set_combo_scc("xceb003_1",'8916')
      CALL cl_set_combo_scc("xceb003_3",'8916')
      CALL cl_set_combo_scc("xcec003",'8916')
      CALL cl_set_combo_scc("xcec003_1",'8916')
      CALL cl_set_combo_scc("xcec003_3",'8916')
      CALL cl_set_comp_visible('xceb001,xceb003,xceb001_1,xceb003_1,xceb001_3,xceb003_3',TRUE)
      CALL cl_set_comp_visible('xcec001,xcec003,xcec001_1,xcec003_1,xcec001_3,xcec003_3',TRUE)
      CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_3',FALSE)
      CALL cl_set_comp_visible('xcec201,xcec201_1,xcec201_3',FALSE)
   END IF
   IF g_argv[1] = '10' THEN   #axct910
      CALL cl_set_combo_scc("xceb003",'8916')
      CALL cl_set_combo_scc("xceb003_1",'8916')
      CALL cl_set_combo_scc("xceb003_3",'8916')
      CALL cl_set_combo_scc("xcec003",'8916')
      CALL cl_set_combo_scc("xcec003_1",'8916')
      CALL cl_set_combo_scc("xcec003_3",'8916')
      CALL cl_set_comp_visible('xceb001,xceb003,xceb001_1,xceb003_1,xceb001_3,xceb003_3',FALSE)
      CALL cl_set_comp_visible('xcec001,xcec003,xcec001_1,xcec003_1,xcec001_3,xcec003_3',FALSE)
      CALL cl_set_comp_visible('xceb201,xceb201_1,xceb201_3',FALSE)
      CALL cl_set_comp_visible('xcec201,xcec201_1,xcec201_3',FALSE)
   END IF
   #add zhangllc 151009 --begin
   IF g_argv[1] = '11' THEN   #axct911
      CALL cl_set_combo_scc_part('xcea002','8920','11')
      CALL cl_set_combo_scc("xceb003",'8916')
      CALL cl_set_combo_scc("xceb003_1",'8916')
      CALL cl_set_combo_scc("xceb003_3",'8916')
      CALL cl_set_combo_scc("xcec003",'8916')
      CALL cl_set_combo_scc("xcec003_1",'8916')
      CALL cl_set_combo_scc("xcec003_3",'8916')
      
      CALL cl_set_comp_visible('xceb001,xceb107,xceb107_desc,xceb108,xceb108_desc,xceb109,xceb109_desc',FALSE)
      CALL cl_set_comp_visible('xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130',FALSE)
      CALL cl_set_comp_visible('xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp',FALSE)
      
      CALL cl_set_comp_visible('xceb001_1,xceb107_1,xceb107_1_desc,xceb108_1,xceb108_1_desc,xceb109_1,xceb109_1_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_1,xceb122_1,xceb123_1,xceb124_1,xceb125_1,xceb126_1,xceb127_1,xceb128_1,xceb129_1,xceb130_1',FALSE)
      
      CALL cl_set_comp_visible('xceb001_2,xceb107_2,xceb107_2_desc,xceb108_2,xceb108_2_desc,xceb109_2,xceb109_2_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_2,xceb122_2,xceb123_2,xceb124_2,xceb125_2,xceb126_2,xceb127_2,xceb128_2,xceb129_2,xceb130_2',FALSE)
      
      
      CALL cl_set_comp_visible('xcec001,xcec107,xcec107_desc,xcec108,xcec108_desc,xcec109,xcec109_desc',FALSE)
      CALL cl_set_comp_visible('xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130',FALSE)
      CALL cl_set_comp_visible('xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp',FALSE)
      
      CALL cl_set_comp_visible('xcec001_1,xcec107_1,xcec107_1_desc,xcec108_1,xcec108_1_desc,xcec109_1,xcec109_1_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_1,xcec122_1,xcec123_1,xcec124_1,xcec125_1,xcec126_1,xcec127_1,xcec128_1,xcec129_1,xcec130_1',FALSE)
      
      CALL cl_set_comp_visible('xcec001_2,xcec107_2,xcec107_2_desc,xcec108_2,xcec108_2_desc,xcec109_2,xcec109_2_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_2,xcec122_2,xcec123_2,xcec124_2,xcec125_2,xcec126_2,xcec127_2,xcec128_2,xcec129_2,xcec130_2',FALSE)
   END IF
   IF g_argv[1] = '12' THEN   #axct912
      CALL cl_set_combo_scc_part('xcea002','8920','12')
      CALL cl_set_combo_scc("xceb003",'8916')
      CALL cl_set_combo_scc("xceb003_1",'8916')
      CALL cl_set_combo_scc("xceb003_3",'8916')
      CALL cl_set_combo_scc("xcec003",'8916')
      CALL cl_set_combo_scc("xcec003_1",'8916')
      CALL cl_set_combo_scc("xcec003_3",'8916')
      
      CALL cl_set_comp_visible('xceb001,xceb107,xceb107_desc,xceb108,xceb108_desc,xceb109,xceb109_desc',FALSE)
      CALL cl_set_comp_visible('xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130',FALSE)
      CALL cl_set_comp_visible('xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp',FALSE)
      
      CALL cl_set_comp_visible('xceb001_1,xceb107_1,xceb107_1_desc,xceb108_1,xceb108_1_desc,xceb109_1,xceb109_1_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_1,xceb122_1,xceb123_1,xceb124_1,xceb125_1,xceb126_1,xceb127_1,xceb128_1,xceb129_1,xceb130_1',FALSE)
      
      CALL cl_set_comp_visible('xceb001_2,xceb107_2,xceb107_2_desc,xceb108_2,xceb108_2_desc,xceb109_2,xceb109_2_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_2,xceb122_2,xceb123_2,xceb124_2,xceb125_2,xceb126_2,xceb127_2,xceb128_2,xceb129_2,xceb130_2',FALSE)
      
      
      CALL cl_set_comp_visible('xcec001,xcec107,xcec107_desc,xcec108,xcec108_desc,xcec109,xcec109_desc',FALSE)
      CALL cl_set_comp_visible('xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130',FALSE)
      CALL cl_set_comp_visible('xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp',FALSE)
      
      CALL cl_set_comp_visible('xcec001_1,xcec107_1,xcec107_1_desc,xcec108_1,xcec108_1_desc,xcec109_1,xcec109_1_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_1,xcec122_1,xcec123_1,xcec124_1,xcec125_1,xcec126_1,xcec127_1,xcec128_1,xcec129_1,xcec130_1',FALSE)
      
      CALL cl_set_comp_visible('xcec001_2,xcec107_2,xcec107_2_desc,xcec108_2,xcec108_2_desc,xcec109_2,xcec109_2_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_2,xcec122_2,xcec123_2,xcec124_2,xcec125_2,xcec126_2,xcec127_2,xcec128_2,xcec129_2,xcec130_2',FALSE)
   END IF
   #add zhangllc 151009 --end
   #add zhujing 2015-12-14 --begin
   IF g_argv[1] = '14' THEN   #axct914
      CALL cl_set_combo_scc_part('xcea002','8920','14')
      CALL cl_set_combo_scc_part("xceb003",'10000','2')			#结转出	
      CALL cl_set_combo_scc_part("xceb003_1",'10000','2')
      CALL cl_set_combo_scc_part("xceb003_3",'10000','2')
      CALL cl_set_combo_scc_part("xcec003",'10000','2')
      CALL cl_set_combo_scc_part("xcec003_1",'10000','2')
      CALL cl_set_combo_scc_part("xcec003_3",'10000','2')
      
      CALL cl_set_comp_visible('xceb001,xceb107,xceb107_desc,xceb108,xceb108_desc,xceb109,xceb109_desc',FALSE)
      CALL cl_set_comp_visible('xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130',FALSE)
      CALL cl_set_comp_visible('xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp',FALSE)
      
      CALL cl_set_comp_visible('xceb001_1,xceb107_1,xceb107_1_desc,xceb108_1,xceb108_1_desc,xceb109_1,xceb109_1_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_1,xceb122_1,xceb123_1,xceb124_1,xceb125_1,xceb126_1,xceb127_1,xceb128_1,xceb129_1,xceb130_1',FALSE)
      
      CALL cl_set_comp_visible('xceb001_2,xceb107_2,xceb107_2_desc,xceb108_2,xceb108_2_desc,xceb109_2,xceb109_2_desc',FALSE)
      CALL cl_set_comp_visible('xceb121_2,xceb122_2,xceb123_2,xceb124_2,xceb125_2,xceb126_2,xceb127_2,xceb128_2,xceb129_2,xceb130_2',FALSE)
      
      
      CALL cl_set_comp_visible('xcec001,xcec107,xcec107_desc,xcec108,xcec108_desc,xcec109,xcec109_desc',FALSE)
      CALL cl_set_comp_visible('xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130',FALSE)
      CALL cl_set_comp_visible('xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp',FALSE)
      
      CALL cl_set_comp_visible('xcec001_1,xcec107_1,xcec107_1_desc,xcec108_1,xcec108_1_desc,xcec109_1,xcec109_1_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_1,xcec122_1,xcec123_1,xcec124_1,xcec125_1,xcec126_1,xcec127_1,xcec128_1,xcec129_1,xcec130_1',FALSE)
      
      CALL cl_set_comp_visible('xcec001_2,xcec107_2,xcec107_2_desc,xcec108_2,xcec108_2_desc,xcec109_2,xcec109_2_desc',FALSE)
      CALL cl_set_comp_visible('xcec121_2,xcec122_2,xcec123_2,xcec124_2,xcec125_2,xcec126_2,xcec127_2,xcec128_2,xcec129_2,xcec130_2',FALSE)
   END IF
   #add zhujing 2015-12-14 --end
#   IF g_argv[1] = '6' THEN   #axct906
#      CALL cl_set_combo_scc("xceb003",'8916')
#      CALL cl_set_combo_scc("xceb003_1",'8916')
#      CALL cl_set_combo_scc("xceb003_3",'8916')
#      CALL cl_set_combo_scc("xcec003",'8916')
#      CALL cl_set_combo_scc("xcec003_1",'8916')
#      CALL cl_set_combo_scc("xcec003_3",'8916')
#      CALL cl_set_comp_visible('xceb001,xceb001_1,xceb001_3',FALSE)
#      CALL cl_set_comp_visible('xcec001,xcec001_1,xcec001_3',FALSE)
#   END IF
   CALL cl_set_comp_entry('xcea002',FALSE)
   CALL axct901_set_desc()
   #end add-point
   
   #初始化搜尋條件
   CALL axct901_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct901.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct901_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_slip    LIKE type_t.chr20
   DEFINE l_gl_slip    LIKE type_t.chr20
   DEFINE l_ooac004 LIKE ooac_t.ooac004
   DEFINE l_chr     LIKE type_t.chr1       #狀態碼 
   DEFINE l_date    LIKE xcea_t.xcea001   
   DEFINE l_xceald  LIKE xcea_t.xceald
   DEFINE l_xceadocno LIKE xcea_t.xceadocno
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcea_m.* TO NULL
         CALL g_xceb_d.clear()
         CALL g_xceb4_d.clear()
         CALL g_xceb8_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct901_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xceb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axct901_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axct901_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               IF g_argv[1] = '9' THEN
                  CALL cl_set_act_visible_toolbaritem("call_axcq512",TRUE)
                  CALL cl_set_act_visible_toolbaritem("call_axcq512_1",FALSE)
               END IF
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION call_axcq512
            LET g_action_choice="call_axcq512"
            IF cl_auth_chk_act("call_axcq512") THEN
               
               #add-point:ON ACTION call_axcq512 name="menu.detail_show.page1.call_axcq512"
               
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xceb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axct901_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axct901_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xceb8_d TO s_detail8.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axct901_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body8.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axct901_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body8.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body8.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xceb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 3
               IF g_argv[1] = '9' THEN
                  CALL cl_set_act_visible_toolbaritem("call_axcq512",FALSE)
                  CALL cl_set_act_visible_toolbaritem("call_axcq512_1",TRUE)
               END IF
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 4
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
         
         END DISPLAY
         
         #20150731--add--str--lujh
         DISPLAY ARRAY g_xceb9_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct901_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作
         
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_current_page = 9
               #顯示單身筆數
               CALL axct901_idx_chk()
               #add-point:page3自定義行為
         
               #end add-point
         
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為
         
            #end add-point
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb10_d TO s_detail10.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axct901_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail10")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail10")
               LET g_current_page = 10
               #顯示單身筆數
               CALL axct901_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         #20150731--add--end--lujh
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axct901_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axct901_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct901_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axct901_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axct901_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axct901_set_act_visible()   
            CALL axct901_set_act_no_visible()
            IF NOT (g_xcea_m.xceald IS NULL
              OR g_xcea_m.xceadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xceaent = " ||g_enterprise|| " AND",
                                  " xceald = '", g_xcea_m.xceald, "' "
                                  ," AND xceadocno = '", g_xcea_m.xceadocno, "' "
 
               #填到對應位置
               CALL axct901_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xceb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcec_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axct901_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xceb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcec_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axct901_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axct901_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct901_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct901_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct901_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct901_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct901_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct901_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct901_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct901_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct901_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct901_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xceb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xceb4_d)
                  LET g_export_id[2]   = "s_detail4"
                  LET g_export_node[3] = base.typeInfo.create(g_xceb8_d)
                  LET g_export_id[3]   = "s_detail8"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_xceb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xceb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xceb3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_xceb4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_xceb5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_xceb6_d)
                  LET g_export_id[6]   = "s_detail6"
                  LET g_export_node[9] = base.typeInfo.create(g_xceb9_d)
                  LET g_export_id[9]   = "s_detail9"
                  LET g_export_node[10] = base.typeInfo.create(g_xceb9_d)
                  LET g_export_id[10]   = "s_detail10"
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct901_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct901_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct702_s01
            LET g_action_choice="open_axct702_s01"
            IF cl_auth_chk_act("open_axct702_s01") THEN
               
               #add-point:ON ACTION open_axct702_s01 name="menu.open_axct702_s01"
               CALL axct901_axct702_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               IF NOT cl_null(g_xcea_m.xceadocno) AND g_xcea_m.xceastus = 'N' THEN
                  #获取单别
                  CALL s_aooi200_fin_get_slip(g_xcea_m.xceadocno) RETURNING l_success,l_slip

                  #是否抛傳票
                  CALL s_fin_get_doc_para(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip,'D-FIN-0030') RETURNING l_ooac004

                  IF l_ooac004 = 'N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_slip
                     LET g_errparam.code   = 'axr-00225'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     EXIT DIALOG
                  END IF
                  IF NOT axct701_02_create_tmp_table() THEN
                     RETURN
                  END IF
  
                  CALL s_transaction_begin()
                  CALL cl_err_collect_init()
                  CALL s_pre_voucher_ins('XC','C10',g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xcea001,g_xcea_m.xcea002)
                     RETURNING l_success
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('Y','0')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct901_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct901_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct901_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_voucher
            LET g_action_choice="gen_voucher"
            IF cl_auth_chk_act("gen_voucher") THEN
               
               #add-point:ON ACTION gen_voucher name="menu.gen_voucher"
               #科目及核算項預覽
               IF g_xcea_m.xceastus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00255'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #已產生傳票,不可執行
               CALL la_param.param.clear()
               IF cl_null(g_xcea_m.xcea101) THEN
                  CALL s_aooi200_fin_get_slip(g_xcea_m.xceadocno) RETURNING l_success,l_slip               
                  #CALL s_fin_get_doc_para(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip,'D-FIN-0030') RETURNING l_chr   #160523-00028#1 mark
                  CALL s_fin_get_doc_para(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip,'D-FIN-0032') RETURNING l_chr    #160523-00028#1  add
                  IF l_chr = 'Y' THEN
                     #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
                     LET l_gl_slip = ''
                     CALL s_fin_get_doc_para(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
                     IF cl_null(l_gl_slip) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00219'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
#凭证日期预设画面期别最后一天
                     CALL s_fin_date_get_lastday(g_xcea_m.xceald,g_xcea_m.xceacomp,g_xcea_m.xcea004,g_xcea_m.xcea005,'')
                     RETURNING l_success,l_date
                     LET la_param.prog     = "axcp701"
                     LET la_param.param[1] = g_xcea_m.xceald
                     LET la_param.param[2] = g_xcea_m.xceacomp
                     LET la_param.param[3] = '1'    #这个是指汇总方式
                     LET la_param.param[4] = l_gl_slip
                     LET la_param.param[5] = g_xcea_m.xcea001
                     LET la_param.param[6] = " xceadocno ='",g_xcea_m.xceadocno,"' "
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                     CALL axct901_refresh_stus()
                     CALL axct901_show()
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00054'
                     LET g_errparam.extend = l_slip
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
               ELSE
                  LET la_param.prog = 'aglt310'
                  LET la_param.param[1] = g_xcea_m.xceald
                  LET la_param.param[2] = g_xcea_m.xcea101
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct901_query()
               #add-point:ON ACTION query name="menu.query"
               NEXT FIELD xceb115_4
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail8",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION redo_gen_voucher
            LET g_action_choice="redo_gen_voucher"
            IF cl_auth_chk_act("redo_gen_voucher") THEN
               
               #add-point:ON ACTION redo_gen_voucher name="menu.redo_gen_voucher"
               IF g_xcea_m.xcea101 IS NOT NULL THEN
                  CALL la_param.param.clear()
                  LET la_param.prog     = "axcp702"
                  LET la_param.param[1] = g_xcea_m.xceald
                  LET la_param.param[2] = " xceadocno ='",g_xcea_m.xceadocno,"' "
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun_wait(ls_js)
                  CALL axct901_refresh_stus()
                  CALL axct901_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct701_s01
            LET g_action_choice="open_axct701_s01"
            IF cl_auth_chk_act("open_axct701_s01") THEN
               
               #add-point:ON ACTION open_axct701_s01 name="menu.open_axct701_s01"
               CALL s_ld_sel_glaa(g_xcea_m.xceald,'glaa121') RETURNING  l_success,g_glaa121
               IF g_glaa121 = 'Y' THEN
                  CALL s_pre_voucher('XC','C10',g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xcea001)
               ELSE
                  CALL axct701_02(g_xcea_m.xceald,g_xcea_m.xceadocno,g_argv[1],'N')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct901_01
            LET g_action_choice="open_axct901_01"
            IF cl_auth_chk_act("open_axct901_01") THEN
               
               #add-point:ON ACTION open_axct901_01 name="menu.open_axct901_01"
               LET l_xceald = g_xcea_m.xceald
               LET l_xceadocno = g_xcea_m.xceadocno           
               CALL axct901_01(g_argv[1]) RETURNING g_xcea_m.xceald,g_xcea_m.xceadocno
               IF g_xcea_m.xceald IS NOT NULL AND g_xcea_m.xceadocno IS NOT NULL THEN
                  CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
                  CALL axct901_refresh_stus()
                  CALL axct901_show()  
               ELSE   #如果产生失败，要还回去旧值的，不然会有错误，不信mark掉再试试看点状态图片闹
                  LET g_xcea_m.xceald = l_xceald
                  LET g_xcea_m.xceadocno = l_xceadocno             
               END IF       
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct901_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="axct901.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct901_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   CASE
      WHEN g_argv[1] = '1'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '1' "
      WHEN g_argv[1] = '2'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '2' "
      WHEN g_argv[1] = '3'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '3' "
      WHEN g_argv[1] = '4'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '4' "
      WHEN g_argv[1] = '5'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '5' "
      WHEN g_argv[1] = '6'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '6' "   
      WHEN g_argv[1] = '7'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '7' "
      WHEN g_argv[1] = '8'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '8' "
      WHEN g_argv[1] = '9'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '9' "
      WHEN g_argv[1] = '10'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '10' "
      #add zhangllc 151009
      WHEN g_argv[1] = '11'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '11' "
      WHEN g_argv[1] = '12'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '12' "
      #add zhangllc 151009 end
      #add zhujing 2015-12-15 begin
      WHEN g_argv[1] = '13'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '13' "
      WHEN g_argv[1] = '14'
         LET l_wc = l_wc CLIPPED," AND xcea002 = '14' "
      #add zhujing 2015-12-15 end
   END CASE
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xceald,xceadocno ",
                      " FROM xcea_t ",
                      " ",
                      " LEFT JOIN xceb_t ON xcebent = xceaent AND xceald = xcebld AND xceadocno = xcebdocno ", "  ",
                      #add-point:browser_fill段sql(xceb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xcec_t ON xcecent = xceaent AND xceald = xcecld AND xceadocno = xcecdocno", "  ",
                      #add-point:browser_fill段sql(xcec_t1) name="browser_fill.cnt.join.xcec_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xceaent = " ||g_enterprise|| " AND xcebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xceald,xceadocno ",
                      " FROM xcea_t ", 
                      "  ",
                      "  ",
                      " WHERE xceaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160802-00020#6-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xceald IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xceacomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#6-e-add
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_argv[1] = '1' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '1' )"
   END IF
   IF g_argv[1] = '2' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '2' )"
   END IF
   IF g_argv[1] = '3' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '3' )"
   END IF
   IF g_argv[1] = '4' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '4' )"
   END IF
   IF g_argv[1] = '5' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '5' )"
   END IF   
   IF g_argv[1] = '6' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '6' )"
   END IF 
   IF g_argv[1] = '7' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '7' )"
   END IF
   IF g_argv[1] = '8' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '8' )"
   END IF
   IF g_argv[1] = '9' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '9' )"
   END IF
   IF g_argv[1] = '10' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '10' )"
   END IF
   #add zhangllc 151009
   IF g_argv[1] = '11' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '11' )"
   END IF
   IF g_argv[1] = '12' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '12' )"
   END IF
   #add zhangllc 151009 end
   #add zhujing 2015-12-15 begin
   IF g_argv[1] = '13' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '13' )"
   END IF
   IF g_argv[1] = '14' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xcea002 = '14' )"
   END IF
   #add zhujing 2015-12-15 end
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xcea_m.* TO NULL
      CALL g_xceb_d.clear()        
      CALL g_xceb4_d.clear() 
      CALL g_xceb8_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xceald,t0.xceadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xceastus,t0.xceald,t0.xceadocno ",
                  " FROM xcea_t t0",
                  "  ",
                  "  LEFT JOIN xceb_t ON xcebent = xceaent AND xceald = xcebld AND xceadocno = xcebdocno ", "  ", 
                  #add-point:browser_fill段sql(xceb_t1) name="browser_fill.join.xceb_t1"
                  
                  #end add-point
                  "  LEFT JOIN xcec_t ON xcecent = xceaent AND xceald = xcecld AND xceadocno = xcecdocno", "  ", 
                  #add-point:browser_fill段sql(xcec_t1) name="browser_fill.join.xcec_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.xceaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xcea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xceastus,t0.xceald,t0.xceadocno ",
                  " FROM xcea_t t0",
                  "  ",
                  
                  " WHERE t0.xceaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xcea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #160802-00020#6-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xceald IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xceacomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#6-e-add
   #end add-point
   LET g_sql = g_sql, " ORDER BY xceald,xceadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
   IF cl_null(g_current_idx) OR g_current_idx = 0  THEN LET g_current_idx = 1 END IF
   LET g_cnt = g_current_idx
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xceald,g_browser[g_cnt].b_xceadocno 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_xceald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct901_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcea_m.xceald = g_browser[g_current_idx].b_xceald   
   LET g_xcea_m.xceadocno = g_browser[g_current_idx].b_xceadocno   
 
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
   CALL axct901_xcea_t_mask()
   CALL axct901_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axct901.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct901_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail8",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct901_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xceald = g_xcea_m.xceald 
         AND g_browser[l_i].b_xceadocno = g_xcea_m.xceadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct901_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xcea_m.* TO NULL
   CALL g_xceb_d.clear()        
   CALL g_xceb4_d.clear() 
   CALL g_xceb8_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xceald,xceadocno,xceasite,xcea001,xceacomp,xcea002,xcea006,xcea004,xcea005, 
          xcea003,xcea101,xceastus,xceaownid,xceaowndp,xceacrtid,xceacrtdp,xceacrtdt,xceamodid,xceamoddt, 
          xceacnfid,xceacnfdt,xceapstid,xceapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xceacrtdt>>----
         AFTER FIELD xceacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xceamoddt>>----
         AFTER FIELD xceamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xceacnfdt>>----
         AFTER FIELD xceacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xceapstdt>>----
         AFTER FIELD xceapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xceald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceald
            #add-point:ON ACTION controlp INFIELD xceald name="construct.c.xceald"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#6-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#6-e-add              
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceald  #顯示到畫面上
            NEXT FIELD xceald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceald
            #add-point:BEFORE FIELD xceald name="construct.b.xceald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceald
            
            #add-point:AFTER FIELD xceald name="construct.a.xceald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceadocno
            #add-point:BEFORE FIELD xceadocno name="construct.b.xceadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceadocno
            
            #add-point:AFTER FIELD xceadocno name="construct.a.xceadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xceadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceadocno
            #add-point:ON ACTION controlp INFIELD xceadocno name="construct.c.xceadocno"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " xcea002 ='",g_argv[1],"'"
            CALL q_xceadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceadocno  #顯示到畫面上

            NEXT FIELD xceadocno                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.xceasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceasite
            #add-point:ON ACTION controlp INFIELD xceasite name="construct.c.xceasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160927-00006#1  2016/10/11 By 08734—-(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()   #161019-00017#3
            CALL q_ooef001_1()  #161019-00017#3 
            DISPLAY g_qryparam.return1 TO xceasite  #顯示到畫面上
            NEXT FIELD xceasite                     #返回原欄位
            #160927-00006#1  2016/10/11 By 08734--(E)



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceasite
            #add-point:BEFORE FIELD xceasite name="construct.b.xceasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceasite
            
            #add-point:AFTER FIELD xceasite name="construct.a.xceasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea001
            #add-point:BEFORE FIELD xcea001 name="construct.b.xcea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea001
            
            #add-point:AFTER FIELD xcea001 name="construct.a.xcea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea001
            #add-point:ON ACTION controlp INFIELD xcea001 name="construct.c.xcea001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xceacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceacomp
            #add-point:ON ACTION controlp INFIELD xceacomp name="construct.c.xceacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #160802-00020#6-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
           #160802-00020#6-e-add  
            #CALL q_ooef001_8()    #161019-00017#3
            CALL q_ooef001_2()     #161019-00017#3
            DISPLAY g_qryparam.return1 TO xceacomp  #顯示到畫面上
            NEXT FIELD xceacomp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacomp
            #add-point:BEFORE FIELD xceacomp name="construct.b.xceacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceacomp
            
            #add-point:AFTER FIELD xceacomp name="construct.a.xceacomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea002
            #add-point:BEFORE FIELD xcea002 name="construct.b.xcea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea002
            
            #add-point:AFTER FIELD xcea002 name="construct.a.xcea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea002
            #add-point:ON ACTION controlp INFIELD xcea002 name="construct.c.xcea002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea006
            #add-point:ON ACTION controlp INFIELD xcea006 name="construct.c.xcea006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcea006  #顯示到畫面上
            NEXT FIELD xcea006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea006
            #add-point:BEFORE FIELD xcea006 name="construct.b.xcea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea006
            
            #add-point:AFTER FIELD xcea006 name="construct.a.xcea006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea004
            #add-point:BEFORE FIELD xcea004 name="construct.b.xcea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea004
            
            #add-point:AFTER FIELD xcea004 name="construct.a.xcea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea004
            #add-point:ON ACTION controlp INFIELD xcea004 name="construct.c.xcea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea005
            #add-point:BEFORE FIELD xcea005 name="construct.b.xcea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea005
            
            #add-point:AFTER FIELD xcea005 name="construct.a.xcea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea005
            #add-point:ON ACTION controlp INFIELD xcea005 name="construct.c.xcea005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea003
            #add-point:ON ACTION controlp INFIELD xcea003 name="construct.c.xcea003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcea003  #顯示到畫面上
            NEXT FIELD xcea003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea003
            #add-point:BEFORE FIELD xcea003 name="construct.b.xcea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea003
            
            #add-point:AFTER FIELD xcea003 name="construct.a.xcea003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea101
            #add-point:BEFORE FIELD xcea101 name="construct.b.xcea101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea101
            
            #add-point:AFTER FIELD xcea101 name="construct.a.xcea101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcea101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea101
            #add-point:ON ACTION controlp INFIELD xcea101 name="construct.c.xcea101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceastus
            #add-point:BEFORE FIELD xceastus name="construct.b.xceastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceastus
            
            #add-point:AFTER FIELD xceastus name="construct.a.xceastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xceastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceastus
            #add-point:ON ACTION controlp INFIELD xceastus name="construct.c.xceastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xceaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceaownid
            #add-point:ON ACTION controlp INFIELD xceaownid name="construct.c.xceaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceaownid  #顯示到畫面上
            NEXT FIELD xceaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceaownid
            #add-point:BEFORE FIELD xceaownid name="construct.b.xceaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceaownid
            
            #add-point:AFTER FIELD xceaownid name="construct.a.xceaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xceaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceaowndp
            #add-point:ON ACTION controlp INFIELD xceaowndp name="construct.c.xceaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceaowndp  #顯示到畫面上
            NEXT FIELD xceaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceaowndp
            #add-point:BEFORE FIELD xceaowndp name="construct.b.xceaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceaowndp
            
            #add-point:AFTER FIELD xceaowndp name="construct.a.xceaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xceacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceacrtid
            #add-point:ON ACTION controlp INFIELD xceacrtid name="construct.c.xceacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceacrtid  #顯示到畫面上
            NEXT FIELD xceacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacrtid
            #add-point:BEFORE FIELD xceacrtid name="construct.b.xceacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceacrtid
            
            #add-point:AFTER FIELD xceacrtid name="construct.a.xceacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xceacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceacrtdp
            #add-point:ON ACTION controlp INFIELD xceacrtdp name="construct.c.xceacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceacrtdp  #顯示到畫面上
            NEXT FIELD xceacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacrtdp
            #add-point:BEFORE FIELD xceacrtdp name="construct.b.xceacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceacrtdp
            
            #add-point:AFTER FIELD xceacrtdp name="construct.a.xceacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacrtdt
            #add-point:BEFORE FIELD xceacrtdt name="construct.b.xceacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xceamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceamodid
            #add-point:ON ACTION controlp INFIELD xceamodid name="construct.c.xceamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceamodid  #顯示到畫面上
            NEXT FIELD xceamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceamodid
            #add-point:BEFORE FIELD xceamodid name="construct.b.xceamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceamodid
            
            #add-point:AFTER FIELD xceamodid name="construct.a.xceamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceamoddt
            #add-point:BEFORE FIELD xceamoddt name="construct.b.xceamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xceacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceacnfid
            #add-point:ON ACTION controlp INFIELD xceacnfid name="construct.c.xceacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceacnfid  #顯示到畫面上
            NEXT FIELD xceacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacnfid
            #add-point:BEFORE FIELD xceacnfid name="construct.b.xceacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceacnfid
            
            #add-point:AFTER FIELD xceacnfid name="construct.a.xceacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacnfdt
            #add-point:BEFORE FIELD xceacnfdt name="construct.b.xceacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xceapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceapstid
            #add-point:ON ACTION controlp INFIELD xceapstid name="construct.c.xceapstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceapstid  #顯示到畫面上
            NEXT FIELD xceapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceapstid
            #add-point:BEFORE FIELD xceapstid name="construct.b.xceapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceapstid
            
            #add-point:AFTER FIELD xceapstid name="construct.a.xceapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceapstdt
            #add-point:BEFORE FIELD xceapstdt name="construct.b.xceapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102,xceb103,xceb117, 
          xceb118,xceb114,xceb116,xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,xceb112,xceb113,xceb121, 
          xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201,xceb202,xceb202a, 
          xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c, 
          xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e, 
          xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp,xcebseq_3,xceb117_3,xceb115_3,xceb202_3, 
          xceb202a_3,xceb202b_3,xceb202c_3,xceb202d_3,xceb202e_3,xceb202f_3,xceb202g_3,xceb202h_3,xceb212_3, 
          xceb212a_3,xceb212b_3,xceb212c_3,xceb212d_3,xceb212e_3,xceb212f_3,xceb212g_3,xceb212h_3,xceb222_3, 
          xceb222a_3,xceb222b_3,xceb222c_3,xceb222d_3,xceb222e_3,xceb222f_3,xceb222g_3,xceb222h_3
           FROM s_detail1[1].xcebseq,s_detail1[1].xceb001,s_detail1[1].xceb003,s_detail1[1].xceb004, 
               s_detail1[1].xceb005,s_detail1[1].xceb101,s_detail1[1].xceb102,s_detail1[1].xceb103,s_detail1[1].xceb117, 
               s_detail1[1].xceb118,s_detail1[1].xceb114,s_detail1[1].xceb116,s_detail1[1].xceb119,s_detail1[1].xceb120, 
               s_detail1[1].xceb107,s_detail1[1].xceb108,s_detail1[1].xceb109,s_detail1[1].xceb111,s_detail1[1].xceb112, 
               s_detail1[1].xceb113,s_detail1[1].xceb121,s_detail1[1].xceb122,s_detail1[1].xceb123,s_detail1[1].xceb124, 
               s_detail1[1].xceb125,s_detail1[1].xceb126,s_detail1[1].xceb127,s_detail1[1].xceb128,s_detail1[1].xceb129, 
               s_detail1[1].xceb130,s_detail1[1].xceb201,s_detail1[1].xceb202,s_detail1[1].xceb202a, 
               s_detail1[1].xceb202b,s_detail1[1].xceb202c,s_detail1[1].xceb202d,s_detail1[1].xceb202e, 
               s_detail1[1].xceb202f,s_detail1[1].xceb202g,s_detail1[1].xceb202h,s_detail1[1].xceb212, 
               s_detail1[1].xceb212a,s_detail1[1].xceb212b,s_detail1[1].xceb212c,s_detail1[1].xceb212d, 
               s_detail1[1].xceb212e,s_detail1[1].xceb212f,s_detail1[1].xceb212g,s_detail1[1].xceb212h, 
               s_detail1[1].xceb222,s_detail1[1].xceb222a,s_detail1[1].xceb222b,s_detail1[1].xceb222c, 
               s_detail1[1].xceb222d,s_detail1[1].xceb222e,s_detail1[1].xceb222f,s_detail1[1].xceb222g, 
               s_detail1[1].xceb222h,s_detail1[1].xceb301,s_detail1[1].xceb302,s_detail1[1].xcebcomp, 
               s_detail8[1].xcebseq_3,s_detail8[1].xceb117_3,s_detail8[1].xceb115_3,s_detail8[1].xceb202_3, 
               s_detail8[1].xceb202a_3,s_detail8[1].xceb202b_3,s_detail8[1].xceb202c_3,s_detail8[1].xceb202d_3, 
               s_detail8[1].xceb202e_3,s_detail8[1].xceb202f_3,s_detail8[1].xceb202g_3,s_detail8[1].xceb202h_3, 
               s_detail8[1].xceb212_3,s_detail8[1].xceb212a_3,s_detail8[1].xceb212b_3,s_detail8[1].xceb212c_3, 
               s_detail8[1].xceb212d_3,s_detail8[1].xceb212e_3,s_detail8[1].xceb212f_3,s_detail8[1].xceb212g_3, 
               s_detail8[1].xceb212h_3,s_detail8[1].xceb222_3,s_detail8[1].xceb222a_3,s_detail8[1].xceb222b_3, 
               s_detail8[1].xceb222c_3,s_detail8[1].xceb222d_3,s_detail8[1].xceb222e_3,s_detail8[1].xceb222f_3, 
               s_detail8[1].xceb222g_3,s_detail8[1].xceb222h_3
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebseq
            #add-point:BEFORE FIELD xcebseq name="construct.b.page1.xcebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebseq
            
            #add-point:AFTER FIELD xcebseq name="construct.a.page1.xcebseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebseq
            #add-point:ON ACTION controlp INFIELD xcebseq name="construct.c.page1.xcebseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xceb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb001
            #add-point:ON ACTION controlp INFIELD xceb001 name="construct.c.page1.xceb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb001  #顯示到畫面上
            NEXT FIELD xceb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb001
            #add-point:BEFORE FIELD xceb001 name="construct.b.page1.xceb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb001
            
            #add-point:AFTER FIELD xceb001 name="construct.a.page1.xceb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb003
            #add-point:BEFORE FIELD xceb003 name="construct.b.page1.xceb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb003
            
            #add-point:AFTER FIELD xceb003 name="construct.a.page1.xceb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb003
            #add-point:ON ACTION controlp INFIELD xceb003 name="construct.c.page1.xceb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xceb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb004
            #add-point:ON ACTION controlp INFIELD xceb004 name="construct.c.page1.xceb004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb004  #顯示到畫面上
            NEXT FIELD xceb004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb004
            #add-point:BEFORE FIELD xceb004 name="construct.b.page1.xceb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb004
            
            #add-point:AFTER FIELD xceb004 name="construct.a.page1.xceb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb005
            #add-point:ON ACTION controlp INFIELD xceb005 name="construct.c.page1.xceb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xceb005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb005  #顯示到畫面上
            NEXT FIELD xceb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb005
            #add-point:BEFORE FIELD xceb005 name="construct.b.page1.xceb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb005
            
            #add-point:AFTER FIELD xceb005 name="construct.a.page1.xceb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb101
            #add-point:ON ACTION controlp INFIELD xceb101 name="construct.c.page1.xceb101"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb101  #顯示到畫面上
            NEXT FIELD xceb101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb101
            #add-point:BEFORE FIELD xceb101 name="construct.b.page1.xceb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb101
            
            #add-point:AFTER FIELD xceb101 name="construct.a.page1.xceb101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb102
            #add-point:BEFORE FIELD xceb102 name="construct.b.page1.xceb102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb102
            
            #add-point:AFTER FIELD xceb102 name="construct.a.page1.xceb102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb102
            #add-point:ON ACTION controlp INFIELD xceb102 name="construct.c.page1.xceb102"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xceb103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb103
            #add-point:ON ACTION controlp INFIELD xceb103 name="construct.c.page1.xceb103"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb103  #顯示到畫面上
            NEXT FIELD xceb103                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb103
            #add-point:BEFORE FIELD xceb103 name="construct.b.page1.xceb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb103
            
            #add-point:AFTER FIELD xceb103 name="construct.a.page1.xceb103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb117
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb117
            #add-point:ON ACTION controlp INFIELD xceb117 name="construct.c.page1.xceb117"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb117  #顯示到畫面上
            NEXT FIELD xceb117                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb117
            #add-point:BEFORE FIELD xceb117 name="construct.b.page1.xceb117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb117
            
            #add-point:AFTER FIELD xceb117 name="construct.a.page1.xceb117"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb118
            #add-point:BEFORE FIELD xceb118 name="construct.b.page1.xceb118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb118
            
            #add-point:AFTER FIELD xceb118 name="construct.a.page1.xceb118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb118
            #add-point:ON ACTION controlp INFIELD xceb118 name="construct.c.page1.xceb118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb114
            #add-point:BEFORE FIELD xceb114 name="construct.b.page1.xceb114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb114
            
            #add-point:AFTER FIELD xceb114 name="construct.a.page1.xceb114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb114
            #add-point:ON ACTION controlp INFIELD xceb114 name="construct.c.page1.xceb114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb115
            #add-point:BEFORE FIELD xceb115 name="construct.b.page1.xceb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb115
            
            #add-point:AFTER FIELD xceb115 name="construct.a.page1.xceb115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb115
            #add-point:ON ACTION controlp INFIELD xceb115 name="construct.c.page1.xceb115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb116
            #add-point:BEFORE FIELD xceb116 name="construct.b.page1.xceb116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb116
            
            #add-point:AFTER FIELD xceb116 name="construct.a.page1.xceb116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb116
            #add-point:ON ACTION controlp INFIELD xceb116 name="construct.c.page1.xceb116"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xceb119
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb119
            #add-point:ON ACTION controlp INFIELD xceb119 name="construct.c.page1.xceb119"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb119  #顯示到畫面上
            NEXT FIELD xceb119                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb119
            #add-point:BEFORE FIELD xceb119 name="construct.b.page1.xceb119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb119
            
            #add-point:AFTER FIELD xceb119 name="construct.a.page1.xceb119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb120
            #add-point:ON ACTION controlp INFIELD xceb120 name="construct.c.page1.xceb120"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb120  #顯示到畫面上
            NEXT FIELD xceb120                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb120
            #add-point:BEFORE FIELD xceb120 name="construct.b.page1.xceb120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb120
            
            #add-point:AFTER FIELD xceb120 name="construct.a.page1.xceb120"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb107
            #add-point:ON ACTION controlp INFIELD xceb107 name="construct.c.page1.xceb107"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb107  #顯示到畫面上
            NEXT FIELD xceb107                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb107
            #add-point:BEFORE FIELD xceb107 name="construct.b.page1.xceb107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb107
            
            #add-point:AFTER FIELD xceb107 name="construct.a.page1.xceb107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb108
            #add-point:ON ACTION controlp INFIELD xceb108 name="construct.c.page1.xceb108"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb108  #顯示到畫面上
            NEXT FIELD xceb108                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb108
            #add-point:BEFORE FIELD xceb108 name="construct.b.page1.xceb108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb108
            
            #add-point:AFTER FIELD xceb108 name="construct.a.page1.xceb108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb109
            #add-point:ON ACTION controlp INFIELD xceb109 name="construct.c.page1.xceb109"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb109  #顯示到畫面上
            NEXT FIELD xceb109                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb109
            #add-point:BEFORE FIELD xceb109 name="construct.b.page1.xceb109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb109
            
            #add-point:AFTER FIELD xceb109 name="construct.a.page1.xceb109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb111
            #add-point:ON ACTION controlp INFIELD xceb111 name="construct.c.page1.xceb111"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb111  #顯示到畫面上
            NEXT FIELD xceb111                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb111
            #add-point:BEFORE FIELD xceb111 name="construct.b.page1.xceb111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb111
            
            #add-point:AFTER FIELD xceb111 name="construct.a.page1.xceb111"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb112
            #add-point:BEFORE FIELD xceb112 name="construct.b.page1.xceb112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb112
            
            #add-point:AFTER FIELD xceb112 name="construct.a.page1.xceb112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb112
            #add-point:ON ACTION controlp INFIELD xceb112 name="construct.c.page1.xceb112"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb113
            #add-point:BEFORE FIELD xceb113 name="construct.b.page1.xceb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb113
            
            #add-point:AFTER FIELD xceb113 name="construct.a.page1.xceb113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb113
            #add-point:ON ACTION controlp INFIELD xceb113 name="construct.c.page1.xceb113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb121
            #add-point:BEFORE FIELD xceb121 name="construct.b.page1.xceb121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb121
            
            #add-point:AFTER FIELD xceb121 name="construct.a.page1.xceb121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb121
            #add-point:ON ACTION controlp INFIELD xceb121 name="construct.c.page1.xceb121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb122
            #add-point:BEFORE FIELD xceb122 name="construct.b.page1.xceb122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb122
            
            #add-point:AFTER FIELD xceb122 name="construct.a.page1.xceb122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb122
            #add-point:ON ACTION controlp INFIELD xceb122 name="construct.c.page1.xceb122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb123
            #add-point:BEFORE FIELD xceb123 name="construct.b.page1.xceb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb123
            
            #add-point:AFTER FIELD xceb123 name="construct.a.page1.xceb123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb123
            #add-point:ON ACTION controlp INFIELD xceb123 name="construct.c.page1.xceb123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb124
            #add-point:BEFORE FIELD xceb124 name="construct.b.page1.xceb124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb124
            
            #add-point:AFTER FIELD xceb124 name="construct.a.page1.xceb124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb124
            #add-point:ON ACTION controlp INFIELD xceb124 name="construct.c.page1.xceb124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb125
            #add-point:BEFORE FIELD xceb125 name="construct.b.page1.xceb125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb125
            
            #add-point:AFTER FIELD xceb125 name="construct.a.page1.xceb125"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb125
            #add-point:ON ACTION controlp INFIELD xceb125 name="construct.c.page1.xceb125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb126
            #add-point:BEFORE FIELD xceb126 name="construct.b.page1.xceb126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb126
            
            #add-point:AFTER FIELD xceb126 name="construct.a.page1.xceb126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb126
            #add-point:ON ACTION controlp INFIELD xceb126 name="construct.c.page1.xceb126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb127
            #add-point:BEFORE FIELD xceb127 name="construct.b.page1.xceb127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb127
            
            #add-point:AFTER FIELD xceb127 name="construct.a.page1.xceb127"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb127
            #add-point:ON ACTION controlp INFIELD xceb127 name="construct.c.page1.xceb127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb128
            #add-point:BEFORE FIELD xceb128 name="construct.b.page1.xceb128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb128
            
            #add-point:AFTER FIELD xceb128 name="construct.a.page1.xceb128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb128
            #add-point:ON ACTION controlp INFIELD xceb128 name="construct.c.page1.xceb128"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb129
            #add-point:BEFORE FIELD xceb129 name="construct.b.page1.xceb129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb129
            
            #add-point:AFTER FIELD xceb129 name="construct.a.page1.xceb129"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb129
            #add-point:ON ACTION controlp INFIELD xceb129 name="construct.c.page1.xceb129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb130
            #add-point:BEFORE FIELD xceb130 name="construct.b.page1.xceb130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb130
            
            #add-point:AFTER FIELD xceb130 name="construct.a.page1.xceb130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb130
            #add-point:ON ACTION controlp INFIELD xceb130 name="construct.c.page1.xceb130"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb201
            #add-point:BEFORE FIELD xceb201 name="construct.b.page1.xceb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb201
            
            #add-point:AFTER FIELD xceb201 name="construct.a.page1.xceb201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb201
            #add-point:ON ACTION controlp INFIELD xceb201 name="construct.c.page1.xceb201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202
            #add-point:BEFORE FIELD xceb202 name="construct.b.page1.xceb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202
            
            #add-point:AFTER FIELD xceb202 name="construct.a.page1.xceb202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202
            #add-point:ON ACTION controlp INFIELD xceb202 name="construct.c.page1.xceb202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202a
            #add-point:BEFORE FIELD xceb202a name="construct.b.page1.xceb202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202a
            
            #add-point:AFTER FIELD xceb202a name="construct.a.page1.xceb202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202a
            #add-point:ON ACTION controlp INFIELD xceb202a name="construct.c.page1.xceb202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202b
            #add-point:BEFORE FIELD xceb202b name="construct.b.page1.xceb202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202b
            
            #add-point:AFTER FIELD xceb202b name="construct.a.page1.xceb202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202b
            #add-point:ON ACTION controlp INFIELD xceb202b name="construct.c.page1.xceb202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202c
            #add-point:BEFORE FIELD xceb202c name="construct.b.page1.xceb202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202c
            
            #add-point:AFTER FIELD xceb202c name="construct.a.page1.xceb202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202c
            #add-point:ON ACTION controlp INFIELD xceb202c name="construct.c.page1.xceb202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202d
            #add-point:BEFORE FIELD xceb202d name="construct.b.page1.xceb202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202d
            
            #add-point:AFTER FIELD xceb202d name="construct.a.page1.xceb202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202d
            #add-point:ON ACTION controlp INFIELD xceb202d name="construct.c.page1.xceb202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202e
            #add-point:BEFORE FIELD xceb202e name="construct.b.page1.xceb202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202e
            
            #add-point:AFTER FIELD xceb202e name="construct.a.page1.xceb202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202e
            #add-point:ON ACTION controlp INFIELD xceb202e name="construct.c.page1.xceb202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202f
            #add-point:BEFORE FIELD xceb202f name="construct.b.page1.xceb202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202f
            
            #add-point:AFTER FIELD xceb202f name="construct.a.page1.xceb202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202f
            #add-point:ON ACTION controlp INFIELD xceb202f name="construct.c.page1.xceb202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202g
            #add-point:BEFORE FIELD xceb202g name="construct.b.page1.xceb202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202g
            
            #add-point:AFTER FIELD xceb202g name="construct.a.page1.xceb202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202g
            #add-point:ON ACTION controlp INFIELD xceb202g name="construct.c.page1.xceb202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202h
            #add-point:BEFORE FIELD xceb202h name="construct.b.page1.xceb202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202h
            
            #add-point:AFTER FIELD xceb202h name="construct.a.page1.xceb202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202h
            #add-point:ON ACTION controlp INFIELD xceb202h name="construct.c.page1.xceb202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212
            #add-point:BEFORE FIELD xceb212 name="construct.b.page1.xceb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212
            
            #add-point:AFTER FIELD xceb212 name="construct.a.page1.xceb212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212
            #add-point:ON ACTION controlp INFIELD xceb212 name="construct.c.page1.xceb212"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212a
            #add-point:BEFORE FIELD xceb212a name="construct.b.page1.xceb212a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212a
            
            #add-point:AFTER FIELD xceb212a name="construct.a.page1.xceb212a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212a
            #add-point:ON ACTION controlp INFIELD xceb212a name="construct.c.page1.xceb212a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212b
            #add-point:BEFORE FIELD xceb212b name="construct.b.page1.xceb212b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212b
            
            #add-point:AFTER FIELD xceb212b name="construct.a.page1.xceb212b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212b
            #add-point:ON ACTION controlp INFIELD xceb212b name="construct.c.page1.xceb212b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212c
            #add-point:BEFORE FIELD xceb212c name="construct.b.page1.xceb212c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212c
            
            #add-point:AFTER FIELD xceb212c name="construct.a.page1.xceb212c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212c
            #add-point:ON ACTION controlp INFIELD xceb212c name="construct.c.page1.xceb212c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212d
            #add-point:BEFORE FIELD xceb212d name="construct.b.page1.xceb212d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212d
            
            #add-point:AFTER FIELD xceb212d name="construct.a.page1.xceb212d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212d
            #add-point:ON ACTION controlp INFIELD xceb212d name="construct.c.page1.xceb212d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212e
            #add-point:BEFORE FIELD xceb212e name="construct.b.page1.xceb212e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212e
            
            #add-point:AFTER FIELD xceb212e name="construct.a.page1.xceb212e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212e
            #add-point:ON ACTION controlp INFIELD xceb212e name="construct.c.page1.xceb212e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212f
            #add-point:BEFORE FIELD xceb212f name="construct.b.page1.xceb212f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212f
            
            #add-point:AFTER FIELD xceb212f name="construct.a.page1.xceb212f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212f
            #add-point:ON ACTION controlp INFIELD xceb212f name="construct.c.page1.xceb212f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212g
            #add-point:BEFORE FIELD xceb212g name="construct.b.page1.xceb212g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212g
            
            #add-point:AFTER FIELD xceb212g name="construct.a.page1.xceb212g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212g
            #add-point:ON ACTION controlp INFIELD xceb212g name="construct.c.page1.xceb212g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212h
            #add-point:BEFORE FIELD xceb212h name="construct.b.page1.xceb212h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212h
            
            #add-point:AFTER FIELD xceb212h name="construct.a.page1.xceb212h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb212h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212h
            #add-point:ON ACTION controlp INFIELD xceb212h name="construct.c.page1.xceb212h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222
            #add-point:BEFORE FIELD xceb222 name="construct.b.page1.xceb222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222
            
            #add-point:AFTER FIELD xceb222 name="construct.a.page1.xceb222"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222
            #add-point:ON ACTION controlp INFIELD xceb222 name="construct.c.page1.xceb222"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222a
            #add-point:BEFORE FIELD xceb222a name="construct.b.page1.xceb222a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222a
            
            #add-point:AFTER FIELD xceb222a name="construct.a.page1.xceb222a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222a
            #add-point:ON ACTION controlp INFIELD xceb222a name="construct.c.page1.xceb222a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222b
            #add-point:BEFORE FIELD xceb222b name="construct.b.page1.xceb222b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222b
            
            #add-point:AFTER FIELD xceb222b name="construct.a.page1.xceb222b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222b
            #add-point:ON ACTION controlp INFIELD xceb222b name="construct.c.page1.xceb222b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222c
            #add-point:BEFORE FIELD xceb222c name="construct.b.page1.xceb222c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222c
            
            #add-point:AFTER FIELD xceb222c name="construct.a.page1.xceb222c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222c
            #add-point:ON ACTION controlp INFIELD xceb222c name="construct.c.page1.xceb222c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222d
            #add-point:BEFORE FIELD xceb222d name="construct.b.page1.xceb222d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222d
            
            #add-point:AFTER FIELD xceb222d name="construct.a.page1.xceb222d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222d
            #add-point:ON ACTION controlp INFIELD xceb222d name="construct.c.page1.xceb222d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222e
            #add-point:BEFORE FIELD xceb222e name="construct.b.page1.xceb222e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222e
            
            #add-point:AFTER FIELD xceb222e name="construct.a.page1.xceb222e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222e
            #add-point:ON ACTION controlp INFIELD xceb222e name="construct.c.page1.xceb222e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222f
            #add-point:BEFORE FIELD xceb222f name="construct.b.page1.xceb222f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222f
            
            #add-point:AFTER FIELD xceb222f name="construct.a.page1.xceb222f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222f
            #add-point:ON ACTION controlp INFIELD xceb222f name="construct.c.page1.xceb222f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222g
            #add-point:BEFORE FIELD xceb222g name="construct.b.page1.xceb222g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222g
            
            #add-point:AFTER FIELD xceb222g name="construct.a.page1.xceb222g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222g
            #add-point:ON ACTION controlp INFIELD xceb222g name="construct.c.page1.xceb222g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222h
            #add-point:BEFORE FIELD xceb222h name="construct.b.page1.xceb222h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222h
            
            #add-point:AFTER FIELD xceb222h name="construct.a.page1.xceb222h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb222h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222h
            #add-point:ON ACTION controlp INFIELD xceb222h name="construct.c.page1.xceb222h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb301
            #add-point:BEFORE FIELD xceb301 name="construct.b.page1.xceb301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb301
            
            #add-point:AFTER FIELD xceb301 name="construct.a.page1.xceb301"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb301
            #add-point:ON ACTION controlp INFIELD xceb301 name="construct.c.page1.xceb301"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb302
            #add-point:BEFORE FIELD xceb302 name="construct.b.page1.xceb302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb302
            
            #add-point:AFTER FIELD xceb302 name="construct.a.page1.xceb302"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xceb302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb302
            #add-point:ON ACTION controlp INFIELD xceb302 name="construct.c.page1.xceb302"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebcomp
            #add-point:BEFORE FIELD xcebcomp name="construct.b.page1.xcebcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebcomp
            
            #add-point:AFTER FIELD xcebcomp name="construct.a.page1.xcebcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcebcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebcomp
            #add-point:ON ACTION controlp INFIELD xcebcomp name="construct.c.page1.xcebcomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebseq_3
            #add-point:BEFORE FIELD xcebseq_3 name="construct.b.page8.xcebseq_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebseq_3
            
            #add-point:AFTER FIELD xcebseq_3 name="construct.a.page8.xcebseq_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xcebseq_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebseq_3
            #add-point:ON ACTION controlp INFIELD xcebseq_3 name="construct.c.page8.xcebseq_3"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page8.xceb117_3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb117_3
            #add-point:ON ACTION controlp INFIELD xceb117_3 name="construct.c.page8.xceb117_3"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xceb117_3  #顯示到畫面上
            NEXT FIELD xceb117_3                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb117_3
            #add-point:BEFORE FIELD xceb117_3 name="construct.b.page8.xceb117_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb117_3
            
            #add-point:AFTER FIELD xceb117_3 name="construct.a.page8.xceb117_3"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb115_3
            #add-point:BEFORE FIELD xceb115_3 name="construct.b.page8.xceb115_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb115_3
            
            #add-point:AFTER FIELD xceb115_3 name="construct.a.page8.xceb115_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb115_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb115_3
            #add-point:ON ACTION controlp INFIELD xceb115_3 name="construct.c.page8.xceb115_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202_3
            #add-point:BEFORE FIELD xceb202_3 name="construct.b.page8.xceb202_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202_3
            
            #add-point:AFTER FIELD xceb202_3 name="construct.a.page8.xceb202_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202_3
            #add-point:ON ACTION controlp INFIELD xceb202_3 name="construct.c.page8.xceb202_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202a_3
            #add-point:BEFORE FIELD xceb202a_3 name="construct.b.page8.xceb202a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202a_3
            
            #add-point:AFTER FIELD xceb202a_3 name="construct.a.page8.xceb202a_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202a_3
            #add-point:ON ACTION controlp INFIELD xceb202a_3 name="construct.c.page8.xceb202a_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202b_3
            #add-point:BEFORE FIELD xceb202b_3 name="construct.b.page8.xceb202b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202b_3
            
            #add-point:AFTER FIELD xceb202b_3 name="construct.a.page8.xceb202b_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202b_3
            #add-point:ON ACTION controlp INFIELD xceb202b_3 name="construct.c.page8.xceb202b_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202c_3
            #add-point:BEFORE FIELD xceb202c_3 name="construct.b.page8.xceb202c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202c_3
            
            #add-point:AFTER FIELD xceb202c_3 name="construct.a.page8.xceb202c_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202c_3
            #add-point:ON ACTION controlp INFIELD xceb202c_3 name="construct.c.page8.xceb202c_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202d_3
            #add-point:BEFORE FIELD xceb202d_3 name="construct.b.page8.xceb202d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202d_3
            
            #add-point:AFTER FIELD xceb202d_3 name="construct.a.page8.xceb202d_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202d_3
            #add-point:ON ACTION controlp INFIELD xceb202d_3 name="construct.c.page8.xceb202d_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202e_3
            #add-point:BEFORE FIELD xceb202e_3 name="construct.b.page8.xceb202e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202e_3
            
            #add-point:AFTER FIELD xceb202e_3 name="construct.a.page8.xceb202e_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202e_3
            #add-point:ON ACTION controlp INFIELD xceb202e_3 name="construct.c.page8.xceb202e_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202f_3
            #add-point:BEFORE FIELD xceb202f_3 name="construct.b.page8.xceb202f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202f_3
            
            #add-point:AFTER FIELD xceb202f_3 name="construct.a.page8.xceb202f_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202f_3
            #add-point:ON ACTION controlp INFIELD xceb202f_3 name="construct.c.page8.xceb202f_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202g_3
            #add-point:BEFORE FIELD xceb202g_3 name="construct.b.page8.xceb202g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202g_3
            
            #add-point:AFTER FIELD xceb202g_3 name="construct.a.page8.xceb202g_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202g_3
            #add-point:ON ACTION controlp INFIELD xceb202g_3 name="construct.c.page8.xceb202g_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202h_3
            #add-point:BEFORE FIELD xceb202h_3 name="construct.b.page8.xceb202h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202h_3
            
            #add-point:AFTER FIELD xceb202h_3 name="construct.a.page8.xceb202h_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb202h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202h_3
            #add-point:ON ACTION controlp INFIELD xceb202h_3 name="construct.c.page8.xceb202h_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212_3
            #add-point:BEFORE FIELD xceb212_3 name="construct.b.page8.xceb212_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212_3
            
            #add-point:AFTER FIELD xceb212_3 name="construct.a.page8.xceb212_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212_3
            #add-point:ON ACTION controlp INFIELD xceb212_3 name="construct.c.page8.xceb212_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212a_3
            #add-point:BEFORE FIELD xceb212a_3 name="construct.b.page8.xceb212a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212a_3
            
            #add-point:AFTER FIELD xceb212a_3 name="construct.a.page8.xceb212a_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212a_3
            #add-point:ON ACTION controlp INFIELD xceb212a_3 name="construct.c.page8.xceb212a_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212b_3
            #add-point:BEFORE FIELD xceb212b_3 name="construct.b.page8.xceb212b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212b_3
            
            #add-point:AFTER FIELD xceb212b_3 name="construct.a.page8.xceb212b_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212b_3
            #add-point:ON ACTION controlp INFIELD xceb212b_3 name="construct.c.page8.xceb212b_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212c_3
            #add-point:BEFORE FIELD xceb212c_3 name="construct.b.page8.xceb212c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212c_3
            
            #add-point:AFTER FIELD xceb212c_3 name="construct.a.page8.xceb212c_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212c_3
            #add-point:ON ACTION controlp INFIELD xceb212c_3 name="construct.c.page8.xceb212c_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212d_3
            #add-point:BEFORE FIELD xceb212d_3 name="construct.b.page8.xceb212d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212d_3
            
            #add-point:AFTER FIELD xceb212d_3 name="construct.a.page8.xceb212d_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212d_3
            #add-point:ON ACTION controlp INFIELD xceb212d_3 name="construct.c.page8.xceb212d_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212e_3
            #add-point:BEFORE FIELD xceb212e_3 name="construct.b.page8.xceb212e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212e_3
            
            #add-point:AFTER FIELD xceb212e_3 name="construct.a.page8.xceb212e_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212e_3
            #add-point:ON ACTION controlp INFIELD xceb212e_3 name="construct.c.page8.xceb212e_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212f_3
            #add-point:BEFORE FIELD xceb212f_3 name="construct.b.page8.xceb212f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212f_3
            
            #add-point:AFTER FIELD xceb212f_3 name="construct.a.page8.xceb212f_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212f_3
            #add-point:ON ACTION controlp INFIELD xceb212f_3 name="construct.c.page8.xceb212f_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212g_3
            #add-point:BEFORE FIELD xceb212g_3 name="construct.b.page8.xceb212g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212g_3
            
            #add-point:AFTER FIELD xceb212g_3 name="construct.a.page8.xceb212g_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212g_3
            #add-point:ON ACTION controlp INFIELD xceb212g_3 name="construct.c.page8.xceb212g_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212h_3
            #add-point:BEFORE FIELD xceb212h_3 name="construct.b.page8.xceb212h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212h_3
            
            #add-point:AFTER FIELD xceb212h_3 name="construct.a.page8.xceb212h_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb212h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212h_3
            #add-point:ON ACTION controlp INFIELD xceb212h_3 name="construct.c.page8.xceb212h_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222_3
            #add-point:BEFORE FIELD xceb222_3 name="construct.b.page8.xceb222_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222_3
            
            #add-point:AFTER FIELD xceb222_3 name="construct.a.page8.xceb222_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222_3
            #add-point:ON ACTION controlp INFIELD xceb222_3 name="construct.c.page8.xceb222_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222a_3
            #add-point:BEFORE FIELD xceb222a_3 name="construct.b.page8.xceb222a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222a_3
            
            #add-point:AFTER FIELD xceb222a_3 name="construct.a.page8.xceb222a_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222a_3
            #add-point:ON ACTION controlp INFIELD xceb222a_3 name="construct.c.page8.xceb222a_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222b_3
            #add-point:BEFORE FIELD xceb222b_3 name="construct.b.page8.xceb222b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222b_3
            
            #add-point:AFTER FIELD xceb222b_3 name="construct.a.page8.xceb222b_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222b_3
            #add-point:ON ACTION controlp INFIELD xceb222b_3 name="construct.c.page8.xceb222b_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222c_3
            #add-point:BEFORE FIELD xceb222c_3 name="construct.b.page8.xceb222c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222c_3
            
            #add-point:AFTER FIELD xceb222c_3 name="construct.a.page8.xceb222c_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222c_3
            #add-point:ON ACTION controlp INFIELD xceb222c_3 name="construct.c.page8.xceb222c_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222d_3
            #add-point:BEFORE FIELD xceb222d_3 name="construct.b.page8.xceb222d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222d_3
            
            #add-point:AFTER FIELD xceb222d_3 name="construct.a.page8.xceb222d_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222d_3
            #add-point:ON ACTION controlp INFIELD xceb222d_3 name="construct.c.page8.xceb222d_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222e_3
            #add-point:BEFORE FIELD xceb222e_3 name="construct.b.page8.xceb222e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222e_3
            
            #add-point:AFTER FIELD xceb222e_3 name="construct.a.page8.xceb222e_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222e_3
            #add-point:ON ACTION controlp INFIELD xceb222e_3 name="construct.c.page8.xceb222e_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222f_3
            #add-point:BEFORE FIELD xceb222f_3 name="construct.b.page8.xceb222f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222f_3
            
            #add-point:AFTER FIELD xceb222f_3 name="construct.a.page8.xceb222f_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222f_3
            #add-point:ON ACTION controlp INFIELD xceb222f_3 name="construct.c.page8.xceb222f_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222g_3
            #add-point:BEFORE FIELD xceb222g_3 name="construct.b.page8.xceb222g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222g_3
            
            #add-point:AFTER FIELD xceb222g_3 name="construct.a.page8.xceb222g_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222g_3
            #add-point:ON ACTION controlp INFIELD xceb222g_3 name="construct.c.page8.xceb222g_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222h_3
            #add-point:BEFORE FIELD xceb222h_3 name="construct.b.page8.xceb222h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222h_3
            
            #add-point:AFTER FIELD xceb222h_3 name="construct.a.page8.xceb222h_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.xceb222h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222h_3
            #add-point:ON ACTION controlp INFIELD xceb222h_3 name="construct.c.page8.xceb222h_3"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102,xcec103,xcec117, 
          xcec114,xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,xcec113,xcec121,xcec122,xcec123,xcec124, 
          xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,xcec201,xcec202,xcec202a,xcec202b,xcec202c, 
          xcec202d,xcec202e,xcec202f,xcec202g,xcec202h,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e, 
          xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g, 
          xcec222h,xcec301,xcec302,xceccomp
           FROM s_detail4[1].xcecseq,s_detail4[1].xcec001,s_detail4[1].xcec003,s_detail4[1].xcec004, 
               s_detail4[1].xcec005,s_detail4[1].xcec101,s_detail4[1].xcec102,s_detail4[1].xcec103,s_detail4[1].xcec117, 
               s_detail4[1].xcec114,s_detail4[1].xcec119,s_detail4[1].xcec120,s_detail4[1].xcec107,s_detail4[1].xcec108, 
               s_detail4[1].xcec109,s_detail4[1].xcec111,s_detail4[1].xcec113,s_detail4[1].xcec121,s_detail4[1].xcec122, 
               s_detail4[1].xcec123,s_detail4[1].xcec124,s_detail4[1].xcec125,s_detail4[1].xcec126,s_detail4[1].xcec127, 
               s_detail4[1].xcec128,s_detail4[1].xcec129,s_detail4[1].xcec130,s_detail4[1].xcec201,s_detail4[1].xcec202, 
               s_detail4[1].xcec202a,s_detail4[1].xcec202b,s_detail4[1].xcec202c,s_detail4[1].xcec202d, 
               s_detail4[1].xcec202e,s_detail4[1].xcec202f,s_detail4[1].xcec202g,s_detail4[1].xcec202h, 
               s_detail4[1].xcec212,s_detail4[1].xcec212a,s_detail4[1].xcec212b,s_detail4[1].xcec212c, 
               s_detail4[1].xcec212d,s_detail4[1].xcec212e,s_detail4[1].xcec212f,s_detail4[1].xcec212g, 
               s_detail4[1].xcec212h,s_detail4[1].xcec222,s_detail4[1].xcec222a,s_detail4[1].xcec222b, 
               s_detail4[1].xcec222c,s_detail4[1].xcec222d,s_detail4[1].xcec222e,s_detail4[1].xcec222f, 
               s_detail4[1].xcec222g,s_detail4[1].xcec222h,s_detail4[1].xcec301,s_detail4[1].xcec302, 
               s_detail4[1].xceccomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcecseq
            #add-point:BEFORE FIELD xcecseq name="construct.b.page4.xcecseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcecseq
            
            #add-point:AFTER FIELD xcecseq name="construct.a.page4.xcecseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcecseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcecseq
            #add-point:ON ACTION controlp INFIELD xcecseq name="construct.c.page4.xcecseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xcec001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec001
            #add-point:ON ACTION controlp INFIELD xcec001 name="construct.c.page4.xcec001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec001  #顯示到畫面上
            NEXT FIELD xcec001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec001
            #add-point:BEFORE FIELD xcec001 name="construct.b.page4.xcec001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec001
            
            #add-point:AFTER FIELD xcec001 name="construct.a.page4.xcec001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec003
            #add-point:BEFORE FIELD xcec003 name="construct.b.page4.xcec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec003
            
            #add-point:AFTER FIELD xcec003 name="construct.a.page4.xcec003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec003
            #add-point:ON ACTION controlp INFIELD xcec003 name="construct.c.page4.xcec003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xcec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec004
            #add-point:ON ACTION controlp INFIELD xcec004 name="construct.c.page4.xcec004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec004  #顯示到畫面上
            NEXT FIELD xcec004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec004
            #add-point:BEFORE FIELD xcec004 name="construct.b.page4.xcec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec004
            
            #add-point:AFTER FIELD xcec004 name="construct.a.page4.xcec004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec005
            #add-point:ON ACTION controlp INFIELD xcec005 name="construct.c.page4.xcec005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcec005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec005  #顯示到畫面上
            NEXT FIELD xcec005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec005
            #add-point:BEFORE FIELD xcec005 name="construct.b.page4.xcec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec005
            
            #add-point:AFTER FIELD xcec005 name="construct.a.page4.xcec005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec101
            #add-point:ON ACTION controlp INFIELD xcec101 name="construct.c.page4.xcec101"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec101  #顯示到畫面上
            NEXT FIELD xcec101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec101
            #add-point:BEFORE FIELD xcec101 name="construct.b.page4.xcec101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec101
            
            #add-point:AFTER FIELD xcec101 name="construct.a.page4.xcec101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec102
            #add-point:BEFORE FIELD xcec102 name="construct.b.page4.xcec102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec102
            
            #add-point:AFTER FIELD xcec102 name="construct.a.page4.xcec102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec102
            #add-point:ON ACTION controlp INFIELD xcec102 name="construct.c.page4.xcec102"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xcec103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec103
            #add-point:ON ACTION controlp INFIELD xcec103 name="construct.c.page4.xcec103"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec103  #顯示到畫面上
            NEXT FIELD xcec103                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec103
            #add-point:BEFORE FIELD xcec103 name="construct.b.page4.xcec103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec103
            
            #add-point:AFTER FIELD xcec103 name="construct.a.page4.xcec103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec117
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec117
            #add-point:ON ACTION controlp INFIELD xcec117 name="construct.c.page4.xcec117"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec117  #顯示到畫面上
            NEXT FIELD xcec117                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec117
            #add-point:BEFORE FIELD xcec117 name="construct.b.page4.xcec117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec117
            
            #add-point:AFTER FIELD xcec117 name="construct.a.page4.xcec117"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec114
            #add-point:BEFORE FIELD xcec114 name="construct.b.page4.xcec114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec114
            
            #add-point:AFTER FIELD xcec114 name="construct.a.page4.xcec114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec114
            #add-point:ON ACTION controlp INFIELD xcec114 name="construct.c.page4.xcec114"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xcec119
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec119
            #add-point:ON ACTION controlp INFIELD xcec119 name="construct.c.page4.xcec119"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec119  #顯示到畫面上
            NEXT FIELD xcec119                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec119
            #add-point:BEFORE FIELD xcec119 name="construct.b.page4.xcec119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec119
            
            #add-point:AFTER FIELD xcec119 name="construct.a.page4.xcec119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec120
            #add-point:ON ACTION controlp INFIELD xcec120 name="construct.c.page4.xcec120"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec120  #顯示到畫面上
            NEXT FIELD xcec120                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec120
            #add-point:BEFORE FIELD xcec120 name="construct.b.page4.xcec120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec120
            
            #add-point:AFTER FIELD xcec120 name="construct.a.page4.xcec120"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec107
            #add-point:ON ACTION controlp INFIELD xcec107 name="construct.c.page4.xcec107"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec107  #顯示到畫面上
            NEXT FIELD xcec107                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec107
            #add-point:BEFORE FIELD xcec107 name="construct.b.page4.xcec107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec107
            
            #add-point:AFTER FIELD xcec107 name="construct.a.page4.xcec107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec108
            #add-point:ON ACTION controlp INFIELD xcec108 name="construct.c.page4.xcec108"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec108  #顯示到畫面上
            NEXT FIELD xcec108                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec108
            #add-point:BEFORE FIELD xcec108 name="construct.b.page4.xcec108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec108
            
            #add-point:AFTER FIELD xcec108 name="construct.a.page4.xcec108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec109
            #add-point:ON ACTION controlp INFIELD xcec109 name="construct.c.page4.xcec109"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec109  #顯示到畫面上
            NEXT FIELD xcec109                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec109
            #add-point:BEFORE FIELD xcec109 name="construct.b.page4.xcec109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec109
            
            #add-point:AFTER FIELD xcec109 name="construct.a.page4.xcec109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec111
            #add-point:ON ACTION controlp INFIELD xcec111 name="construct.c.page4.xcec111"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcec111  #顯示到畫面上
            NEXT FIELD xcec111                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec111
            #add-point:BEFORE FIELD xcec111 name="construct.b.page4.xcec111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec111
            
            #add-point:AFTER FIELD xcec111 name="construct.a.page4.xcec111"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec113
            #add-point:BEFORE FIELD xcec113 name="construct.b.page4.xcec113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec113
            
            #add-point:AFTER FIELD xcec113 name="construct.a.page4.xcec113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec113
            #add-point:ON ACTION controlp INFIELD xcec113 name="construct.c.page4.xcec113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec121
            #add-point:BEFORE FIELD xcec121 name="construct.b.page4.xcec121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec121
            
            #add-point:AFTER FIELD xcec121 name="construct.a.page4.xcec121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec121
            #add-point:ON ACTION controlp INFIELD xcec121 name="construct.c.page4.xcec121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec122
            #add-point:BEFORE FIELD xcec122 name="construct.b.page4.xcec122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec122
            
            #add-point:AFTER FIELD xcec122 name="construct.a.page4.xcec122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec122
            #add-point:ON ACTION controlp INFIELD xcec122 name="construct.c.page4.xcec122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec123
            #add-point:BEFORE FIELD xcec123 name="construct.b.page4.xcec123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec123
            
            #add-point:AFTER FIELD xcec123 name="construct.a.page4.xcec123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec123
            #add-point:ON ACTION controlp INFIELD xcec123 name="construct.c.page4.xcec123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec124
            #add-point:BEFORE FIELD xcec124 name="construct.b.page4.xcec124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec124
            
            #add-point:AFTER FIELD xcec124 name="construct.a.page4.xcec124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec124
            #add-point:ON ACTION controlp INFIELD xcec124 name="construct.c.page4.xcec124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec125
            #add-point:BEFORE FIELD xcec125 name="construct.b.page4.xcec125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec125
            
            #add-point:AFTER FIELD xcec125 name="construct.a.page4.xcec125"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec125
            #add-point:ON ACTION controlp INFIELD xcec125 name="construct.c.page4.xcec125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec126
            #add-point:BEFORE FIELD xcec126 name="construct.b.page4.xcec126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec126
            
            #add-point:AFTER FIELD xcec126 name="construct.a.page4.xcec126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec126
            #add-point:ON ACTION controlp INFIELD xcec126 name="construct.c.page4.xcec126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec127
            #add-point:BEFORE FIELD xcec127 name="construct.b.page4.xcec127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec127
            
            #add-point:AFTER FIELD xcec127 name="construct.a.page4.xcec127"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec127
            #add-point:ON ACTION controlp INFIELD xcec127 name="construct.c.page4.xcec127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec128
            #add-point:BEFORE FIELD xcec128 name="construct.b.page4.xcec128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec128
            
            #add-point:AFTER FIELD xcec128 name="construct.a.page4.xcec128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec128
            #add-point:ON ACTION controlp INFIELD xcec128 name="construct.c.page4.xcec128"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec129
            #add-point:BEFORE FIELD xcec129 name="construct.b.page4.xcec129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec129
            
            #add-point:AFTER FIELD xcec129 name="construct.a.page4.xcec129"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec129
            #add-point:ON ACTION controlp INFIELD xcec129 name="construct.c.page4.xcec129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec130
            #add-point:BEFORE FIELD xcec130 name="construct.b.page4.xcec130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec130
            
            #add-point:AFTER FIELD xcec130 name="construct.a.page4.xcec130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec130
            #add-point:ON ACTION controlp INFIELD xcec130 name="construct.c.page4.xcec130"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec201
            #add-point:BEFORE FIELD xcec201 name="construct.b.page4.xcec201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec201
            
            #add-point:AFTER FIELD xcec201 name="construct.a.page4.xcec201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec201
            #add-point:ON ACTION controlp INFIELD xcec201 name="construct.c.page4.xcec201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202
            #add-point:BEFORE FIELD xcec202 name="construct.b.page4.xcec202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202
            
            #add-point:AFTER FIELD xcec202 name="construct.a.page4.xcec202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202
            #add-point:ON ACTION controlp INFIELD xcec202 name="construct.c.page4.xcec202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202a
            #add-point:BEFORE FIELD xcec202a name="construct.b.page4.xcec202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202a
            
            #add-point:AFTER FIELD xcec202a name="construct.a.page4.xcec202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202a
            #add-point:ON ACTION controlp INFIELD xcec202a name="construct.c.page4.xcec202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202b
            #add-point:BEFORE FIELD xcec202b name="construct.b.page4.xcec202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202b
            
            #add-point:AFTER FIELD xcec202b name="construct.a.page4.xcec202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202b
            #add-point:ON ACTION controlp INFIELD xcec202b name="construct.c.page4.xcec202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202c
            #add-point:BEFORE FIELD xcec202c name="construct.b.page4.xcec202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202c
            
            #add-point:AFTER FIELD xcec202c name="construct.a.page4.xcec202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202c
            #add-point:ON ACTION controlp INFIELD xcec202c name="construct.c.page4.xcec202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202d
            #add-point:BEFORE FIELD xcec202d name="construct.b.page4.xcec202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202d
            
            #add-point:AFTER FIELD xcec202d name="construct.a.page4.xcec202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202d
            #add-point:ON ACTION controlp INFIELD xcec202d name="construct.c.page4.xcec202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202e
            #add-point:BEFORE FIELD xcec202e name="construct.b.page4.xcec202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202e
            
            #add-point:AFTER FIELD xcec202e name="construct.a.page4.xcec202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202e
            #add-point:ON ACTION controlp INFIELD xcec202e name="construct.c.page4.xcec202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202f
            #add-point:BEFORE FIELD xcec202f name="construct.b.page4.xcec202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202f
            
            #add-point:AFTER FIELD xcec202f name="construct.a.page4.xcec202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202f
            #add-point:ON ACTION controlp INFIELD xcec202f name="construct.c.page4.xcec202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202g
            #add-point:BEFORE FIELD xcec202g name="construct.b.page4.xcec202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202g
            
            #add-point:AFTER FIELD xcec202g name="construct.a.page4.xcec202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202g
            #add-point:ON ACTION controlp INFIELD xcec202g name="construct.c.page4.xcec202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202h
            #add-point:BEFORE FIELD xcec202h name="construct.b.page4.xcec202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202h
            
            #add-point:AFTER FIELD xcec202h name="construct.a.page4.xcec202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202h
            #add-point:ON ACTION controlp INFIELD xcec202h name="construct.c.page4.xcec202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212
            #add-point:BEFORE FIELD xcec212 name="construct.b.page4.xcec212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212
            
            #add-point:AFTER FIELD xcec212 name="construct.a.page4.xcec212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212
            #add-point:ON ACTION controlp INFIELD xcec212 name="construct.c.page4.xcec212"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212a
            #add-point:BEFORE FIELD xcec212a name="construct.b.page4.xcec212a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212a
            
            #add-point:AFTER FIELD xcec212a name="construct.a.page4.xcec212a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212a
            #add-point:ON ACTION controlp INFIELD xcec212a name="construct.c.page4.xcec212a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212b
            #add-point:BEFORE FIELD xcec212b name="construct.b.page4.xcec212b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212b
            
            #add-point:AFTER FIELD xcec212b name="construct.a.page4.xcec212b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212b
            #add-point:ON ACTION controlp INFIELD xcec212b name="construct.c.page4.xcec212b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212c
            #add-point:BEFORE FIELD xcec212c name="construct.b.page4.xcec212c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212c
            
            #add-point:AFTER FIELD xcec212c name="construct.a.page4.xcec212c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212c
            #add-point:ON ACTION controlp INFIELD xcec212c name="construct.c.page4.xcec212c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212d
            #add-point:BEFORE FIELD xcec212d name="construct.b.page4.xcec212d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212d
            
            #add-point:AFTER FIELD xcec212d name="construct.a.page4.xcec212d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212d
            #add-point:ON ACTION controlp INFIELD xcec212d name="construct.c.page4.xcec212d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212e
            #add-point:BEFORE FIELD xcec212e name="construct.b.page4.xcec212e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212e
            
            #add-point:AFTER FIELD xcec212e name="construct.a.page4.xcec212e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212e
            #add-point:ON ACTION controlp INFIELD xcec212e name="construct.c.page4.xcec212e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212f
            #add-point:BEFORE FIELD xcec212f name="construct.b.page4.xcec212f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212f
            
            #add-point:AFTER FIELD xcec212f name="construct.a.page4.xcec212f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212f
            #add-point:ON ACTION controlp INFIELD xcec212f name="construct.c.page4.xcec212f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212g
            #add-point:BEFORE FIELD xcec212g name="construct.b.page4.xcec212g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212g
            
            #add-point:AFTER FIELD xcec212g name="construct.a.page4.xcec212g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212g
            #add-point:ON ACTION controlp INFIELD xcec212g name="construct.c.page4.xcec212g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212h
            #add-point:BEFORE FIELD xcec212h name="construct.b.page4.xcec212h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212h
            
            #add-point:AFTER FIELD xcec212h name="construct.a.page4.xcec212h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec212h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212h
            #add-point:ON ACTION controlp INFIELD xcec212h name="construct.c.page4.xcec212h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222
            #add-point:BEFORE FIELD xcec222 name="construct.b.page4.xcec222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222
            
            #add-point:AFTER FIELD xcec222 name="construct.a.page4.xcec222"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222
            #add-point:ON ACTION controlp INFIELD xcec222 name="construct.c.page4.xcec222"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222a
            #add-point:BEFORE FIELD xcec222a name="construct.b.page4.xcec222a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222a
            
            #add-point:AFTER FIELD xcec222a name="construct.a.page4.xcec222a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222a
            #add-point:ON ACTION controlp INFIELD xcec222a name="construct.c.page4.xcec222a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222b
            #add-point:BEFORE FIELD xcec222b name="construct.b.page4.xcec222b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222b
            
            #add-point:AFTER FIELD xcec222b name="construct.a.page4.xcec222b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222b
            #add-point:ON ACTION controlp INFIELD xcec222b name="construct.c.page4.xcec222b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222c
            #add-point:BEFORE FIELD xcec222c name="construct.b.page4.xcec222c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222c
            
            #add-point:AFTER FIELD xcec222c name="construct.a.page4.xcec222c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222c
            #add-point:ON ACTION controlp INFIELD xcec222c name="construct.c.page4.xcec222c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222d
            #add-point:BEFORE FIELD xcec222d name="construct.b.page4.xcec222d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222d
            
            #add-point:AFTER FIELD xcec222d name="construct.a.page4.xcec222d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222d
            #add-point:ON ACTION controlp INFIELD xcec222d name="construct.c.page4.xcec222d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222e
            #add-point:BEFORE FIELD xcec222e name="construct.b.page4.xcec222e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222e
            
            #add-point:AFTER FIELD xcec222e name="construct.a.page4.xcec222e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222e
            #add-point:ON ACTION controlp INFIELD xcec222e name="construct.c.page4.xcec222e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222f
            #add-point:BEFORE FIELD xcec222f name="construct.b.page4.xcec222f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222f
            
            #add-point:AFTER FIELD xcec222f name="construct.a.page4.xcec222f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222f
            #add-point:ON ACTION controlp INFIELD xcec222f name="construct.c.page4.xcec222f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222g
            #add-point:BEFORE FIELD xcec222g name="construct.b.page4.xcec222g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222g
            
            #add-point:AFTER FIELD xcec222g name="construct.a.page4.xcec222g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222g
            #add-point:ON ACTION controlp INFIELD xcec222g name="construct.c.page4.xcec222g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222h
            #add-point:BEFORE FIELD xcec222h name="construct.b.page4.xcec222h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222h
            
            #add-point:AFTER FIELD xcec222h name="construct.a.page4.xcec222h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec222h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222h
            #add-point:ON ACTION controlp INFIELD xcec222h name="construct.c.page4.xcec222h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec301
            #add-point:BEFORE FIELD xcec301 name="construct.b.page4.xcec301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec301
            
            #add-point:AFTER FIELD xcec301 name="construct.a.page4.xcec301"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec301
            #add-point:ON ACTION controlp INFIELD xcec301 name="construct.c.page4.xcec301"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec302
            #add-point:BEFORE FIELD xcec302 name="construct.b.page4.xcec302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec302
            
            #add-point:AFTER FIELD xcec302 name="construct.a.page4.xcec302"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xcec302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec302
            #add-point:ON ACTION controlp INFIELD xcec302 name="construct.c.page4.xcec302"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceccomp
            #add-point:BEFORE FIELD xceccomp name="construct.b.page4.xceccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceccomp
            
            #add-point:AFTER FIELD xceccomp name="construct.a.page4.xceccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xceccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceccomp
            #add-point:ON ACTION controlp INFIELD xceccomp name="construct.c.page4.xceccomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xcea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xceb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xcec_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct901_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xceb_d.clear()
   CALL g_xceb4_d.clear()
   CALL g_xceb8_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axct901_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct901_browser_fill("")
      CALL axct901_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axct901_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axct901_fetch("F") 
      #顯示單身筆數
      CALL axct901_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct901_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcea_m.xceald = g_browser[g_current_idx].b_xceald
   LET g_xcea_m.xceadocno = g_browser[g_current_idx].b_xceadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
   #遮罩相關處理
   LET g_xcea_m_mask_o.* =  g_xcea_m.*
   CALL axct901_xcea_t_mask()
   LET g_xcea_m_mask_n.* =  g_xcea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct901_set_act_visible()   
   CALL axct901_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xcea_m_t.* = g_xcea_m.*
   LET g_xcea_m_o.* = g_xcea_m.*
   
   LET g_data_owner = g_xcea_m.xceaownid      
   LET g_data_dept  = g_xcea_m.xceaowndp
   
   #重新顯示   
   CALL axct901_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct901_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xceb_d.clear()   
   CALL g_xceb4_d.clear()  
   CALL g_xceb8_d.clear()  
 
 
   INITIALIZE g_xcea_m.* TO NULL             #DEFAULT 設定
   
   LET g_xceald_t = NULL
   LET g_xceadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcea_m.xceaownid = g_user
      LET g_xcea_m.xceaowndp = g_dept
      LET g_xcea_m.xceacrtid = g_user
      LET g_xcea_m.xceacrtdp = g_dept 
      LET g_xcea_m.xceacrtdt = cl_get_current()
      LET g_xcea_m.xceamodid = g_user
      LET g_xcea_m.xceamoddt = cl_get_current()
      LET g_xcea_m.xceastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xcea_m.xcea002 = "11"
      LET g_xcea_m.xceastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xcea_m_t.* = g_xcea_m.*
      LET g_xcea_m_o.* = g_xcea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcea_m.xceastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
    
      CALL axct901_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcea_m.* TO NULL
         INITIALIZE g_xceb_d TO NULL
         INITIALIZE g_xceb4_d TO NULL
         INITIALIZE g_xceb8_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axct901_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xceb_d.clear()
      #CALL g_xceb4_d.clear()
      #CALL g_xceb8_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct901_set_act_visible()   
   CALL axct901_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xceald_t = g_xcea_m.xceald
   LET g_xceadocno_t = g_xcea_m.xceadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xceaent = " ||g_enterprise|| " AND",
                      " xceald = '", g_xcea_m.xceald, "' "
                      ," AND xceadocno = '", g_xcea_m.xceadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axct901_cl
   
   CALL axct901_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
   
   #遮罩相關處理
   LET g_xcea_m_mask_o.* =  g_xcea_m.*
   CALL axct901_xcea_t_mask()
   LET g_xcea_m_mask_n.* =  g_xcea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceald_desc,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xceasite_desc, 
       g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea006_desc, 
       g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea003_desc,g_xcea_m.xcea101,g_xcea_m.xceastus, 
       g_xcea_m.xceaownid,g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid, 
       g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid, 
       g_xcea_m.xceamodid_desc,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt, 
       g_xcea_m.xceapstid,g_xcea_m.xceapstid_desc,g_xcea_m.xceapstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xcea_m.xceaownid      
   LET g_data_dept  = g_xcea_m.xceaowndp
   
   #功能已完成,通報訊息中心
   CALL axct901_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct901_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   CALL axct901_refresh_stus()
#判断状态码
   IF g_xcea_m.xceastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xcea_m_t.* = g_xcea_m.*
   LET g_xcea_m_o.* = g_xcea_m.*
   
   IF g_xcea_m.xceald IS NULL
   OR g_xcea_m.xceadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xceald_t = g_xcea_m.xceald
   LET g_xceadocno_t = g_xcea_m.xceadocno
 
   CALL s_transaction_begin()
   
   OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
   #檢查是否允許此動作
   IF NOT axct901_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcea_m_mask_o.* =  g_xcea_m.*
   CALL axct901_xcea_t_mask()
   LET g_xcea_m_mask_n.* =  g_xcea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axct901_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xceald_t = g_xcea_m.xceald
      LET g_xceadocno_t = g_xcea_m.xceadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xcea_m.xceamodid = g_user 
LET g_xcea_m.xceamoddt = cl_get_current()
LET g_xcea_m.xceamodid_desc = cl_get_username(g_xcea_m.xceamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axct901_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xcea_t SET (xceamodid,xceamoddt) = (g_xcea_m.xceamodid,g_xcea_m.xceamoddt)
          WHERE xceaent = g_enterprise AND xceald = g_xceald_t
            AND xceadocno = g_xceadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xcea_m.* = g_xcea_m_t.*
            CALL axct901_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xcea_m.xceald != g_xcea_m_t.xceald
      OR g_xcea_m.xceadocno != g_xcea_m_t.xceadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xceb_t SET xcebld = g_xcea_m.xceald
                                       ,xcebdocno = g_xcea_m.xceadocno
 
          WHERE xcebent = g_enterprise AND xcebld = g_xcea_m_t.xceald
            AND xcebdocno = g_xcea_m_t.xceadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xceb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE xcec_t
            SET xcecld = g_xcea_m.xceald
               ,xcecdocno = g_xcea_m.xceadocno
 
          WHERE xcecent = g_enterprise AND
                xcecld = g_xceald_t
            AND xcecdocno = g_xceadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcec_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct901_set_act_visible()   
   CALL axct901_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xceaent = " ||g_enterprise|| " AND",
                      " xceald = '", g_xcea_m.xceald, "' "
                      ," AND xceadocno = '", g_xcea_m.xceadocno, "' "
 
   #填到對應位置
   CALL axct901_browser_fill("")
 
   CLOSE axct901_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct901_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axct901.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct901_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_glad015             LIKE glad_t.glad015     #专案管理否  #170227-00006#1 add
   DEFINE  l_glad016             LIKE glad_t.glad016     #wbs管理    #170227-00006#1 add
   DEFINE  l_glad012             LIKE glad_t.glad012     #品类管理   #170227-00006#1 add
   DEFINE  l_sql1                STRING   #160711-00040#35 add
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceald_desc,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xceasite_desc, 
       g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea006_desc, 
       g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea003_desc,g_xcea_m.xcea101,g_xcea_m.xceastus, 
       g_xcea_m.xceaownid,g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid, 
       g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid, 
       g_xcea_m.xceamodid_desc,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt, 
       g_xcea_m.xceapstid,g_xcea_m.xceapstid_desc,g_xcea_m.xceapstdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102,xceb103,xceb110, 
       xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,xceb112, 
       xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201, 
       xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a, 
       xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c, 
       xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp,xcebseq,xceb117,xceb115, 
       xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a, 
       xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c, 
       xceb222d,xceb222e,xceb222f,xceb222g,xceb222h FROM xceb_t WHERE xcebent=? AND xcebld=? AND xcebdocno=?  
       AND xcebseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct901_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102,xcec103,xcec110, 
       xcec117,xcec118,xcec114,xcec115,xcec116,xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,xcec112, 
       xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,xcec201, 
       xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h,xcec212,xcec212a, 
       xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c, 
       xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp FROM xcec_t WHERE xcecent=?  
       AND xcecld=? AND xcecdocno=? AND xcecseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct901_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct901_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct901_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp, 
       g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101, 
       g_xcea_m.xceastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct901.input.head" >}
      #單頭段
      INPUT BY NAME g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp, 
          g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101, 
          g_xcea_m.xceastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axct901_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axct901_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceald
            
            #add-point:AFTER FIELD xceald name="input.a.xceald"

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcea_m.xceald) AND NOT cl_null(g_xcea_m.xceadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcea_m.xceald != g_xceald_t  OR g_xcea_m.xceadocno != g_xceadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcea_t WHERE "||"xceaent = '" ||g_enterprise|| "' AND "||"xceald = '"||g_xcea_m.xceald ||"' AND "|| "xceadocno = '"||g_xcea_m.xceadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
            IF NOT cl_null(g_xcea_m.xceald) THEN
               IF g_xcea_m.xceald <> g_xcea_m_o.xceald OR cl_null(g_xcea_m_o.xceald) OR cl_null(g_xceald_t) THEN   #160824-00007#224 161205 by lori add
                 #檢查是否存在 帳別資料檔 中
                 IF NOT ap_chk_isExist(g_xcea_m.xceald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
                   #LET g_xcea_m.xceald = g_xceald_t          #160824-00007#224 161205 by lori mark
                    LET g_xcea_m.xceald = g_xcea_m_o.xceald   #160824-00007#224 161205 by lori add
                    CALL axct901_get_xceald_desc()
                    CALL axct901_get_xceacomp_desc()                  
                    NEXT FIELD CURRENT
                 END IF   
                 
                 #檢查是否 有效
                #IF NOT ap_chk_isExist(g_xcea_m.xceald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'agl-00051',1) THEN   #160318-00005#47  mark
                 IF NOT ap_chk_isExist(g_xcea_m.xceald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'sub-01302','agli010') THEN   #160318-00005#47  add
                   #LET g_xcea_m.xceald = g_xceald_t          #160824-00007#224 161205 by lori mark
                    LET g_xcea_m.xceald = g_xcea_m_o.xceald   #160824-00007#224 161205 by lori add
                    CALL axct901_get_xceald_desc()
                    CALL axct901_get_xceacomp_desc()                  
                    NEXT FIELD CURRENT
                 END IF 
                 
                 #160824-00007#224 161205 by lori add---(S)
                 #默認帶出帳套歸屬法人
                 CALL axct901_get_xceacomp()
                    
                 #默認年度月份為當前成本計算年度期別
                 IF NOT cl_null(g_xcea_m.xceacomp) THEN
                    CALL cl_get_para(g_enterprise,g_xcea_m.xceacomp,'S-FIN-6010') RETURNING g_xcea_m.xcea004
                    CALL cl_get_para(g_enterprise,g_xcea_m.xceacomp,'S-FIN-6011') RETURNING g_xcea_m.xcea005
                    DISPLAY BY NAME g_xcea_m.xcea004,g_xcea_m.xcea005               
                 END IF
                 
                 CALL axct901_get_xceacomp_desc()
                 #160824-00007#224 161205 by lori add---(E)
               END IF   #160824-00007#224 161205 by lori add
            END IF   
            
            IF NOT cl_null(g_xcea_m.xceald) THEN 
               CALL axct901_get_glaa()
            END IF 
            
            #160824-00007#224 161205 by lori mark---(S)
            ##默認帶出帳套歸屬法人
            #IF NOT cl_null(g_xcea_m.xceald) THEN 
            #   CALL axct901_get_xceacomp()
            #END IF
            ##默認年度月份為當前成本計算年度期別
            #IF NOT cl_null(g_xcea_m.xceacomp) THEN
            #   CALL cl_get_para(g_enterprise,g_xcea_m.xceacomp,'S-FIN-6010') RETURNING g_xcea_m.xcea004
            #   CALL cl_get_para(g_enterprise,g_xcea_m.xceacomp,'S-FIN-6011') RETURNING g_xcea_m.xcea005
            #   DISPLAY BY NAME g_xcea_m.xcea004,g_xcea_m.xcea005               
            #END IF
            #CALL axct901_get_xceald_desc()
            #CALL axct901_get_xceacomp_desc()
            #160824-00007#224 161205 by lori mark---(E)
            
            #160824-00007#224 161205 by lori add---(S)
            CALL axct901_get_xceald_desc()            
            LET g_xcea_m_o.xceald = g_xcea_m.xceald   
            LET g_xcea_m_o.xcea004 = g_xcea_m.xcea004
            LET g_xcea_m_o.xcea005 = g_xcea_m.xcea005
            #160824-00007#224 161205 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceald
            #add-point:BEFORE FIELD xceald name="input.b.xceald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceald
            #add-point:ON CHANGE xceald name="input.g.xceald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceadocno
            #add-point:BEFORE FIELD xceadocno name="input.b.xceadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceadocno
            
            #add-point:AFTER FIELD xceadocno name="input.a.xceadocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcea_m.xceald) AND NOT cl_null(g_xcea_m.xceadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcea_m.xceald != g_xceald_t  OR g_xcea_m.xceadocno != g_xceadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcea_t WHERE "||"xceaent = '" ||g_enterprise|| "' AND "||"xceald = '"||g_xcea_m.xceald ||"' AND "|| "xceadocno = '"||g_xcea_m.xceadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_fin_chk_docno(g_xcea_m.xceald,'','',g_xcea_m.xceadocno,g_xcea_m.xcea001,g_prog_name1) THEN
                     LET g_xcea_m.xceadocno = g_xceadocno_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceadocno
            #add-point:ON CHANGE xceadocno name="input.g.xceadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceasite
            
            #add-point:AFTER FIELD xceasite name="input.a.xceasite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceasite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceasite
            #add-point:BEFORE FIELD xceasite name="input.b.xceasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceasite
            #add-point:ON CHANGE xceasite name="input.g.xceasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea001
            #add-point:BEFORE FIELD xcea001 name="input.b.xcea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea001
            
            #add-point:AFTER FIELD xcea001 name="input.a.xcea001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea001
            #add-point:ON CHANGE xcea001 name="input.g.xcea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceacomp
            
            #add-point:AFTER FIELD xceacomp name="input.a.xceacomp"
            IF NOT cl_null(g_xcea_m.xceacomp) THEN 
               IF g_xcea_m.xceacomp <> g_xcea_m_o.xceacomp OR cl_null(g_xcea_m_o.xceacomp) THEN   #160824-00007#224 161205 by lori add
                  #檢查是否存在 組織基礎資料檔 中
                  IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN
                     LET g_xcea_m.xceacomp = ''
                     CALL axct901_get_xceacomp_desc()                  
                     NEXT FIELD CURRENT
                  END IF    
                  
                  #檢查是否 有效
                 #IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
                  IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'sub-01302','aooi125') THEN    #160318-00005#47  add
                     LET g_xcea_m.xceacomp = ''
                     CALL axct901_get_xceacomp_desc()                  
                     NEXT FIELD CURRENT
                  END IF 
                  
                  #檢查是否為 法人
                 #IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
                  IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'sub-01302','aooi125') THEN    #160318-00005#47  add
                     LET g_xcea_m.xceacomp = ''
                     CALL axct901_get_xceacomp_desc()                  
                     NEXT FIELD CURRENT
                  END IF              
                 
                  ##檢查組織類型是否為 法人組織
                  #IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y' ",'apm-00250',1) THEN
                  #   LET g_xcea_m.xceacomp = ''
                  #   CALL axct901_get_xceacomp_desc()                  
                  #   NEXT FIELD CURRENT
                  #END IF  
                  
                  #帳套不為空時，檢查該法人下是否有此帳套
                  IF NOT cl_null(g_xcea_m.xceald) THEN
                     IF NOT ap_chk_isExist(g_xcea_m.xceacomp,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaacomp = ? AND glaastus = 'Y' AND glaald = '" ||g_xcea_m.xceald|| "'",'axc-00224',1) THEN
                        LET g_xcea_m.xceacomp = ''
                        CALL axct901_get_xceacomp_desc()                  
                        NEXT FIELD CURRENT
                     END IF   
                  END IF
               END IF   #160824-00007#224 161205 by lori add
            END IF
            
            CALL axct901_get_xceacomp_desc()

            LET g_xcea_m_o.xceacomp = g_xcea_m.xceacomp   #160824-00007#224 161205 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceacomp
            #add-point:BEFORE FIELD xceacomp name="input.b.xceacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceacomp
            #add-point:ON CHANGE xceacomp name="input.g.xceacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea002
            #add-point:BEFORE FIELD xcea002 name="input.b.xcea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea002
            
            #add-point:AFTER FIELD xcea002 name="input.a.xcea002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea002
            #add-point:ON CHANGE xcea002 name="input.g.xcea002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea006
            
            #add-point:AFTER FIELD xcea006 name="input.a.xcea006"
            IF NOT cl_null(g_xcea_m.xcea006) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcea_m.xcea006
                  LET g_chkparam.arg2 = g_xcea_m.xceacomp
                   LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13      
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist('v_ooag001_2') THEN
                     #檢查失敗時後續處理
                     LET g_xcea_m.xcea006 = ''
                     CALL axct901_get_xcea006_desc()
                     NEXT FIELD xcea006
                  END IF     
            END IF
            CALL axct901_get_xcea006_desc()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea006
            #add-point:BEFORE FIELD xcea006 name="input.b.xcea006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea006
            #add-point:ON CHANGE xcea006 name="input.g.xcea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea004
            #add-point:BEFORE FIELD xcea004 name="input.b.xcea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea004
            
            #add-point:AFTER FIELD xcea004 name="input.a.xcea004"
            IF NOT cl_null(g_xcea_m.xcea004) THEN
               IF g_xcea_m.xcea004 <> g_xcea_m_o.xcea004 OR cl_null(g_xcea_m_o.xcea004) THEN   #160824-00007#224 161205 by lori add
                  IF NOT s_fin_date_chk_year(g_xcea_m.xcea004) THEN
                    #LET g_xcea_m.xcea004 = ''                   #160824-00007#224 161205 by lori mark
                     LET g_xcea_m.xcea004 = g_xcea_m_o.xcea004   #160824-00007#224 161205 by lori add
                     DISPLAY BY NAME g_xcea_m.xcea004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_xcea_m.xcea004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#224 161205 by lori add   
            END IF   
            
            LET g_xcea_m_o.xcea004 = g_xcea_m.xcea004   #160824-00007#224 161205 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea004
            #add-point:ON CHANGE xcea004 name="input.g.xcea004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea005
            #add-point:BEFORE FIELD xcea005 name="input.b.xcea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea005
            
            #add-point:AFTER FIELD xcea005 name="input.a.xcea005"
            IF NOT cl_null(g_xcea_m.xcea005) THEN
               IF g_xcea_m.xcea005 <> g_xcea_m_o.xcea005 OR cl_null(g_xcea_m_o.xcea005) THEN   #160824-00007#224 161205 by lori add            
                  IF g_xcea_m.xcea005 < 1 OR g_xcea_m.xcea005 > 13 THEN
                    #LET g_xcea_m.xcea005 = ''                   #160824-00007#224 161205 by lori mark
                     LET g_xcea_m.xcea005 = g_xcea_m_o.xcea005   #160824-00007#224 161205 by lori add 
                     DISPLAY BY NAME g_xcea_m.xcea005            #160824-00007#224 161205 by lori add               
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00106'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD CURRENT          
                  END IF
                  
                  #160824-00007#224 161205 by lori add---(S)
                  IF NOT cl_null(g_xcea_m.xceald) THEN                 
                     IF NOT s_fin_date_chk_period(g_glaa003,g_xcea_m.xcea004,g_xcea_m.xcea005) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00119'
                        LET g_errparam.extend = g_xcea_m.xcea005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_xcea_m.xcea005 = ''
                        DISPLAY BY NAME g_xcea_m.xcea005
                        NEXT FIELD CURRENT
                     END IF
                  END IF            
                  #160824-00007#224 161205 by lori add---(E)                  
               END IF   #160824-00007#224 161205 by lori add 
            END IF
            
            #160824-00007#224 161205 by lori mark---(S)
            #IF NOT cl_null(g_xcea_m.xcea005) AND NOT cl_null(g_xcea_m.xceald) THEN                 
            #   IF NOT s_fin_date_chk_period(g_glaa003,g_xcea_m.xcea004,g_xcea_m.xcea005) THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'afa-00119'
            #      LET g_errparam.extend = g_xcea_m.xcea005
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_xcea_m.xcea005 = ''
            #      DISPLAY BY NAME g_xcea_m.xcea005
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF            
            #160824-00007#224 161205 by lori mark---(E)
            
            LET g_xcea_m_o.xcea005 = g_xcea_m.xcea005   #160824-00007#224 161205 by lori add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea005
            #add-point:ON CHANGE xcea005 name="input.g.xcea005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea003
            
            #add-point:AFTER FIELD xcea003 name="input.a.xcea003"
            IF NOT cl_null(g_xcea_m.xcea003) THEN 
               #檢查是否存在于 成本類型設置檔 中
               IF NOT ap_chk_isExist(g_xcea_m.xcea003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? ",'agl-00194',1) THEN
                  LET g_xcea_m.xcea003 = ''
                  CALL axct901_get_xcea003_desc()                  
                  NEXT FIELD CURRENT
               END IF
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcea_m.xcea003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? AND xcatstus = 'Y' ",'agl-00195',1) THEN   #160318-00005#47 mark
               IF NOT ap_chk_isExist(g_xcea_m.xcea003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? AND xcatstus = 'Y' ",'sub-01302','axci100') THEN    #160318-00005#47 add
                  LET g_xcea_m.xcea003 = ''
                  CALL axct901_get_xcea003_desc()                  
                  NEXT FIELD CURRENT
               END IF                   
            END IF
            
            CALL axct901_get_xcea003_desc() 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea003
            #add-point:BEFORE FIELD xcea003 name="input.b.xcea003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea003
            #add-point:ON CHANGE xcea003 name="input.g.xcea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcea101
            #add-point:BEFORE FIELD xcea101 name="input.b.xcea101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcea101
            
            #add-point:AFTER FIELD xcea101 name="input.a.xcea101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcea101
            #add-point:ON CHANGE xcea101 name="input.g.xcea101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceastus
            #add-point:BEFORE FIELD xceastus name="input.b.xceastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceastus
            
            #add-point:AFTER FIELD xceastus name="input.a.xceastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceastus
            #add-point:ON CHANGE xceastus name="input.g.xceastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xceald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceald
            #add-point:ON ACTION controlp INFIELD xceald name="input.c.xceald"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcea_m.xceald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_xcea_m.xceacomp) THEN
                LET g_qryparam.where = " glaacomp='",g_xcea_m.xceacomp,"'"
             END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcea_m.xceald = g_qryparam.return1              

            DISPLAY g_xcea_m.xceald TO xceald              #

            NEXT FIELD xceald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xceadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceadocno
            #add-point:ON ACTION controlp INFIELD xceadocno name="input.c.xceadocno"
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcea_m.xceadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024
            #LET g_qryparam.arg2 = g_prog_name1   #160705-00042#11 160715 by sakura mark      
            LET g_qryparam.arg2 = g_prog          #160705-00042#11 160715 by sakura add
            #160711-00040#35 add(S)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#35 add(E)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_xcea_m.xceadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcea_m.xceadocno TO xceadocno              #顯示到畫面上

            NEXT FIELD xceadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xceasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceasite
            #add-point:ON ACTION controlp INFIELD xceasite name="input.c.xceasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea001
            #add-point:ON ACTION controlp INFIELD xcea001 name="input.c.xcea001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xceacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceacomp
            #add-point:ON ACTION controlp INFIELD xceacomp name="input.c.xceacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcea_m.xceacomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooef001_8()    #161019-00017#3
            CALL q_ooef001_2()     #161019-00017#3
            LET g_xcea_m.xceacomp = g_qryparam.return1              

            DISPLAY g_xcea_m.xceacomp TO xceacomp              #

            NEXT FIELD xceacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea002
            #add-point:ON ACTION controlp INFIELD xcea002 name="input.c.xcea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea006
            #add-point:ON ACTION controlp INFIELD xcea006 name="input.c.xcea006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcea_m.xcea006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xcea_m.xcea006 = g_qryparam.return1              

            DISPLAY g_xcea_m.xcea006 TO xcea006              #

            NEXT FIELD xcea006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea004
            #add-point:ON ACTION controlp INFIELD xcea004 name="input.c.xcea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea005
            #add-point:ON ACTION controlp INFIELD xcea005 name="input.c.xcea005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea003
            #add-point:ON ACTION controlp INFIELD xcea003 name="input.c.xcea003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcea_m.xcea003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcea_m.xcea003 = g_qryparam.return1              

            DISPLAY g_xcea_m.xcea003 TO xcea003              #

            NEXT FIELD xcea003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcea101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcea101
            #add-point:ON ACTION controlp INFIELD xcea101 name="input.c.xcea101"
            
            #END add-point
 
 
         #Ctrlp:input.c.xceastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceastus
            #add-point:ON ACTION controlp INFIELD xceastus name="input.c.xceastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_xcea_m.xceacomp,g_xcea_m.xceadocno,g_xcea_m.xcea001,g_prog_name1)
                RETURNING l_success,g_xcea_m.xceadocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_xcea_m.xceadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xceadocno
               END IF
               DISPLAY BY NAME g_xcea_m.xceadocno
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  LET g_xcea_m.xcea001 = g_today
                  LET g_xcea_m.xceastus = 'N'
               END IF
               #end add-point
               
               INSERT INTO xcea_t (xceaent,xceald,xceadocno,xceasite,xcea001,xceacomp,xcea002,xcea006, 
                   xcea004,xcea005,xcea003,xcea101,xceastus,xceaownid,xceaowndp,xceacrtid,xceacrtdp, 
                   xceacrtdt,xceamodid,xceamoddt,xceacnfid,xceacnfdt,xceapstid,xceapstdt)
               VALUES (g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xcea001, 
                   g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004,g_xcea_m.xcea005, 
                   g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
                   g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
                   g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xcea_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct901_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axct901_b_fill()
                  CALL axct901_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axct901_xcea_t_mask_restore('restore_mask_o')
               
               UPDATE xcea_t SET (xceald,xceadocno,xceasite,xcea001,xceacomp,xcea002,xcea006,xcea004, 
                   xcea005,xcea003,xcea101,xceastus,xceaownid,xceaowndp,xceacrtid,xceacrtdp,xceacrtdt, 
                   xceamodid,xceamoddt,xceacnfid,xceacnfdt,xceapstid,xceapstdt) = (g_xcea_m.xceald,g_xcea_m.xceadocno, 
                   g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006, 
                   g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus, 
                   g_xcea_m.xceaownid,g_xcea_m.xceaowndp,g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt, 
                   g_xcea_m.xceamodid,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid, 
                   g_xcea_m.xceapstdt)
                WHERE xceaent = g_enterprise AND xceald = g_xceald_t
                  AND xceadocno = g_xceadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xcea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axct901_xcea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xcea_m_t)
               LET g_log2 = util.JSON.stringify(g_xcea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xceald_t = g_xcea_m.xceald
            LET g_xceadocno_t = g_xcea_m.xceadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axct901.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xceb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION call_axcq512
            LET g_action_choice="call_axcq512"
            IF cl_auth_chk_act("call_axcq512") THEN
               
               #add-point:ON ACTION call_axcq512 name="input.detail_input.page1.call_axcq512"
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xceb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct901_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xceb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xceb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xceb_d[l_ac].xcebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xceb_d_t.* = g_xceb_d[l_ac].*  #BACKUP
               LET g_xceb_d_o.* = g_xceb_d[l_ac].*  #BACKUP
               CALL axct901_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axct901_set_no_entry_b(l_cmd)
               IF NOT axct901_lock_b("xceb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct901_bcl INTO g_xceb_d[l_ac].xcebseq,g_xceb_d[l_ac].xceb001,g_xceb_d[l_ac].xceb003, 
                      g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005,g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb102, 
                      g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb110,g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118, 
                      g_xceb_d[l_ac].xceb114,g_xceb_d[l_ac].xceb115,g_xceb_d[l_ac].xceb116,g_xceb_d[l_ac].xceb119, 
                      g_xceb_d[l_ac].xceb120,g_xceb_d[l_ac].xceb107,g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109, 
                      g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb112,g_xceb_d[l_ac].xceb113,g_xceb_d[l_ac].xceb121, 
                      g_xceb_d[l_ac].xceb122,g_xceb_d[l_ac].xceb123,g_xceb_d[l_ac].xceb124,g_xceb_d[l_ac].xceb125, 
                      g_xceb_d[l_ac].xceb126,g_xceb_d[l_ac].xceb127,g_xceb_d[l_ac].xceb128,g_xceb_d[l_ac].xceb129, 
                      g_xceb_d[l_ac].xceb130,g_xceb_d[l_ac].xceb201,g_xceb_d[l_ac].xceb202,g_xceb_d[l_ac].xceb202a, 
                      g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c,g_xceb_d[l_ac].xceb202d,g_xceb_d[l_ac].xceb202e, 
                      g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g,g_xceb_d[l_ac].xceb202h,g_xceb_d[l_ac].xceb212, 
                      g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b,g_xceb_d[l_ac].xceb212c,g_xceb_d[l_ac].xceb212d, 
                      g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f,g_xceb_d[l_ac].xceb212g,g_xceb_d[l_ac].xceb212h, 
                      g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a,g_xceb_d[l_ac].xceb222b,g_xceb_d[l_ac].xceb222c, 
                      g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e,g_xceb_d[l_ac].xceb222f,g_xceb_d[l_ac].xceb222g, 
                      g_xceb_d[l_ac].xceb222h,g_xceb_d[l_ac].xceb301,g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp, 
                      g_xceb8_d[l_ac].xcebseq,g_xceb8_d[l_ac].xceb117,g_xceb8_d[l_ac].xceb115,g_xceb8_d[l_ac].xceb202, 
                      g_xceb8_d[l_ac].xceb202a,g_xceb8_d[l_ac].xceb202b,g_xceb8_d[l_ac].xceb202c,g_xceb8_d[l_ac].xceb202d, 
                      g_xceb8_d[l_ac].xceb202e,g_xceb8_d[l_ac].xceb202f,g_xceb8_d[l_ac].xceb202g,g_xceb8_d[l_ac].xceb202h, 
                      g_xceb8_d[l_ac].xceb212,g_xceb8_d[l_ac].xceb212a,g_xceb8_d[l_ac].xceb212b,g_xceb8_d[l_ac].xceb212c, 
                      g_xceb8_d[l_ac].xceb212d,g_xceb8_d[l_ac].xceb212e,g_xceb8_d[l_ac].xceb212f,g_xceb8_d[l_ac].xceb212g, 
                      g_xceb8_d[l_ac].xceb212h,g_xceb8_d[l_ac].xceb222,g_xceb8_d[l_ac].xceb222a,g_xceb8_d[l_ac].xceb222b, 
                      g_xceb8_d[l_ac].xceb222c,g_xceb8_d[l_ac].xceb222d,g_xceb8_d[l_ac].xceb222e,g_xceb8_d[l_ac].xceb222f, 
                      g_xceb8_d[l_ac].xceb222g,g_xceb8_d[l_ac].xceb222h
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xceb_d_t.xcebseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xceb_d_mask_o[l_ac].* =  g_xceb_d[l_ac].*
                  CALL axct901_xceb_t_mask()
                  LET g_xceb_d_mask_n[l_ac].* =  g_xceb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axct901_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xceb_d[l_ac].* TO NULL 
            INITIALIZE g_xceb_d_t.* TO NULL 
            INITIALIZE g_xceb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xceb_d_t.* = g_xceb_d[l_ac].*     #新輸入資料
            LET g_xceb_d_o.* = g_xceb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct901_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axct901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xceb_d[li_reproduce_target].* = g_xceb_d[li_reproduce].*
               LET g_xceb8_d[li_reproduce_target].* = g_xceb8_d[li_reproduce].*
 
               LET g_xceb_d[li_reproduce_target].xcebseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xceb_t 
             WHERE xcebent = g_enterprise AND xcebld = g_xcea_m.xceald
               AND xcebdocno = g_xcea_m.xceadocno
 
               AND xcebseq = g_xceb_d[l_ac].xcebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
           
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys[3] = g_xceb_d[g_detail_idx].xcebseq
               CALL axct901_insert_b('xceb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xceb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axct901_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xcea_m.xceald
               LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xceb_d_t.xcebseq
 
            
               #刪除同層單身
               IF NOT axct901_delete_b('xceb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axct901_key_delete_b(gs_keys,'xceb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axct901_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xceb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xceb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebseq
            #add-point:BEFORE FIELD xcebseq name="input.b.page1.xcebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebseq
            
            #add-point:AFTER FIELD xcebseq name="input.a.page1.xcebseq"
            #此段落由子樣板a05產生
            IF  g_xcea_m.xceald IS NOT NULL AND g_xcea_m.xceadocno IS NOT NULL AND g_xceb_d[g_detail_idx].xcebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcea_m.xceald != g_xceald_t OR g_xcea_m.xceadocno != g_xceadocno_t OR g_xceb_d[g_detail_idx].xcebseq != g_xceb_d_t.xcebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xceb_t WHERE "||"xcebent = '" ||g_enterprise|| "' AND "||"xcebld = '"||g_xcea_m.xceald ||"' AND "|| "xcebdocno = '"||g_xcea_m.xceadocno ||"' AND "|| "xcebseq = '"||g_xceb_d[g_detail_idx].xcebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcebseq
            #add-point:ON CHANGE xcebseq name="input.g.page1.xcebseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb001
            #add-point:BEFORE FIELD xceb001 name="input.b.page1.xceb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb001
            
            #add-point:AFTER FIELD xceb001 name="input.a.page1.xceb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb001
            #add-point:ON CHANGE xceb001 name="input.g.page1.xceb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb003
            #add-point:BEFORE FIELD xceb003 name="input.b.page1.xceb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb003
            
            #add-point:AFTER FIELD xceb003 name="input.a.page1.xceb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb003
            #add-point:ON CHANGE xceb003 name="input.g.page1.xceb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb004
            #add-point:BEFORE FIELD xceb004 name="input.b.page1.xceb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb004
            
            #add-point:AFTER FIELD xceb004 name="input.a.page1.xceb004"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb004
            #add-point:ON CHANGE xceb004 name="input.g.page1.xceb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb005
            #add-point:BEFORE FIELD xceb005 name="input.b.page1.xceb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb005
            
            #add-point:AFTER FIELD xceb005 name="input.a.page1.xceb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb005
            #add-point:ON CHANGE xceb005 name="input.g.page1.xceb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb101
            
            #add-point:AFTER FIELD xceb101 name="input.a.page1.xceb101"
            IF NOT cl_null(g_xceb_d[g_detail_idx].xceb101) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               SELECT glaa004 INTO g_glaa004 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_xceb_d[g_detail_idx].xceb101
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_glac002_4') THEN
                  #檢查失敗時後續處理
                   CALL axct901_get_xceb101_desc(g_xceb_d[g_detail_idx].xceb101) 
                   RETURNING g_xceb_d[g_detail_idx].xceb101_desc 
                  NEXT FIELD xceb101
               END IF
               
               #151117-00009#1--add--str--
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_xcea_m.xceald,g_xceb_d[g_detail_idx].xceb101)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xceb_d[g_detail_idx].xceb101
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #檢查失敗時後續處理
                  CALL axct901_get_xceb101_desc(g_xceb_d[g_detail_idx].xceb101) 
                   RETURNING g_xceb_d[g_detail_idx].xceb101_desc 
                  NEXT FIELD xceb101
               END IF
               #151117-00009#1--add--end
            END IF
            
            CALL axct901_get_xceb101_desc(g_xceb_d[g_detail_idx].xceb101) 
               RETURNING g_xceb_d[g_detail_idx].xceb101_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb101
            #add-point:BEFORE FIELD xceb101 name="input.b.page1.xceb101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb101
            #add-point:ON CHANGE xceb101 name="input.g.page1.xceb101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb102
            #add-point:BEFORE FIELD xceb102 name="input.b.page1.xceb102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb102
            
            #add-point:AFTER FIELD xceb102 name="input.a.page1.xceb102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb102
            #add-point:ON CHANGE xceb102 name="input.g.page1.xceb102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb103
            
            #add-point:AFTER FIELD xceb103 name="input.a.page1.xceb103"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb_d[l_ac].xcebcomp
            LET g_ref_fields[2] = g_xceb_d[l_ac].xceb103
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb_d[l_ac].xceb103_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb_d[l_ac].xceb103_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb103
            #add-point:BEFORE FIELD xceb103 name="input.b.page1.xceb103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb103
            #add-point:ON CHANGE xceb103 name="input.g.page1.xceb103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb117
            #add-point:BEFORE FIELD xceb117 name="input.b.page1.xceb117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb117
            
            #add-point:AFTER FIELD xceb117 name="input.a.page1.xceb117"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb_d[l_ac].xceb117) THEN
               IF (g_xceb_d[l_ac].xceb117 != g_xceb_d_t.xceb117 OR g_xceb_d_t.xceb117 IS NULL ) THEN
                  CALL s_voucher_glaq024_chk(g_xceb_d[l_ac].xceb117)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xceb_d[l_ac].xceb117
                     LET g_errparam.replace[1] ='arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog ='arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xceb_d[l_ac].xceb117 = g_xceb_d_t.xceb117
                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF
            #170227-00006#1---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb117
            #add-point:ON CHANGE xceb117 name="input.g.page1.xceb117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb118
            #add-point:BEFORE FIELD xceb118 name="input.b.page1.xceb118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb118
            
            #add-point:AFTER FIELD xceb118 name="input.a.page1.xceb118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb118
            #add-point:ON CHANGE xceb118 name="input.g.page1.xceb118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb114
            #add-point:BEFORE FIELD xceb114 name="input.b.page1.xceb114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb114
            
            #add-point:AFTER FIELD xceb114 name="input.a.page1.xceb114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb114
            #add-point:ON CHANGE xceb114 name="input.g.page1.xceb114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb115
            #add-point:BEFORE FIELD xceb115 name="input.b.page1.xceb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb115
            
            #add-point:AFTER FIELD xceb115 name="input.a.page1.xceb115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb115
            #add-point:ON CHANGE xceb115 name="input.g.page1.xceb115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb116
            #add-point:BEFORE FIELD xceb116 name="input.b.page1.xceb116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb116
            
            #add-point:AFTER FIELD xceb116 name="input.a.page1.xceb116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb116
            #add-point:ON CHANGE xceb116 name="input.g.page1.xceb116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb119
            #add-point:BEFORE FIELD xceb119 name="input.b.page1.xceb119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb119
            
            #add-point:AFTER FIELD xceb119 name="input.a.page1.xceb119"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb_d[l_ac].xceb119) THEN
               IF (g_xceb_d[l_ac].xceb119 != g_xceb_d_o.xceb119 OR cl_null(g_xceb_d_o.xceb119) ) THEN
                  CALL s_aap_project_chk(g_xceb_d[l_ac].xceb119) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xceb_d[l_ac].xceb119
                     LET g_errparam.replace[1] ='apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog ='apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xceb_d[l_ac].xceb119 = g_xceb_d_o.xceb119
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_xceb_d[l_ac].xceb101) THEN
                  CALL axct901_get_glad(g_xcea_m.xceald,g_xceb_d[l_ac].xceb101) RETURNING l_glad015,l_glad016,l_glad012
                  IF l_glad015 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xceb_d[l_ac].xceb101
                     LET g_errparam.code   = 'agl-00541'      
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()               
                  END IF  
               END IF                  
            END IF
            LET g_xceb_d_o.xceb119 = g_xceb_d[l_ac].xceb119
            #170227-00006#1---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb119
            #add-point:ON CHANGE xceb119 name="input.g.page1.xceb119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb120
            #add-point:BEFORE FIELD xceb120 name="input.b.page1.xceb120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb120
            
            #add-point:AFTER FIELD xceb120 name="input.a.page1.xceb120"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb_d[l_ac].xceb120) THEN
               IF cl_null(g_xceb_d[l_ac].xceb119) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00391'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()            
                  NEXT FIELD xceb119
               END IF            
               IF (g_xceb_d[l_ac].xceb120 != g_xceb_d_o.xceb120 OR g_xceb_d_o.xceb120 IS NULL ) THEN
                  CALL s_voucher_glaq028_chk(g_xceb_d[l_ac].xceb119,g_xceb_d[l_ac].xceb120)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xceb_d[l_ac].xceb120
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xceb_d[l_ac].xceb120 = g_xceb_d_o.xceb120
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_xceb_d[l_ac].xceb101) THEN
                  CALL axct901_get_glad(g_xcea_m.xceald,g_xceb_d[l_ac].xceb101) RETURNING l_glad015,l_glad016,l_glad012
                  IF l_glad016 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xceb_d[l_ac].xceb101
                     LET g_errparam.code   = 'agl-00542'      
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()               
                  END IF  
               END IF                           
            END IF            
            LET g_xceb_d_o.xceb120 = g_xceb_d[l_ac].xceb120
            #170227-00006#1---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb120
            #add-point:ON CHANGE xceb120 name="input.g.page1.xceb120"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb107
            
            #add-point:AFTER FIELD xceb107 name="input.a.page1.xceb107"
            IF NOT cl_null(g_xceb_d[l_ac].xceb107) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xceb_d[l_ac].xceb107

                LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13         
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb107
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xceb_d[l_ac].xceb107_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb_d[l_ac].xceb107_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb107
            #add-point:BEFORE FIELD xceb107 name="input.b.page1.xceb107"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb107
            #add-point:ON CHANGE xceb107 name="input.g.page1.xceb107"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb108
            
            #add-point:AFTER FIELD xceb108 name="input.a.page1.xceb108"
            IF NOT cl_null(g_xceb_d[l_ac].xceb108) THEN 
#150812-00010#3 mark --s
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_xceb_d[l_ac].xceb108
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_ooeg001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#150812-00010#3 mark --e
               #150812-00010#3--s
               CALL s_department_chk(g_xceb_d[l_ac].xceb108,g_xcea_m.xcea001) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xceb_d[l_ac].xceb108      = g_xceb_d_t.xceb108
                  LET g_xceb_d[l_ac].xceb108_desc = g_xceb_d_t.xceb108_desc
                  DISPLAY BY NAME g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb108_desc
                  NEXT FIELD CURRENT
               END IF               
               #150812-00010#3--e
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb108
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb_d[l_ac].xceb108_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb_d[l_ac].xceb108_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb108
            #add-point:BEFORE FIELD xceb108 name="input.b.page1.xceb108"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb108
            #add-point:ON CHANGE xceb108 name="input.g.page1.xceb108"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb109
            
            #add-point:AFTER FIELD xceb109 name="input.a.page1.xceb109"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb109
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb_d[l_ac].xceb109_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb_d[l_ac].xceb109_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb109
            #add-point:BEFORE FIELD xceb109 name="input.b.page1.xceb109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb109
            #add-point:ON CHANGE xceb109 name="input.g.page1.xceb109"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb111
            
            #add-point:AFTER FIELD xceb111 name="input.a.page1.xceb111"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb111
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb_d[l_ac].xceb111_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb_d[l_ac].xceb111_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb111
            #add-point:BEFORE FIELD xceb111 name="input.b.page1.xceb111"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb111
            #add-point:ON CHANGE xceb111 name="input.g.page1.xceb111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb112
            #add-point:BEFORE FIELD xceb112 name="input.b.page1.xceb112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb112
            
            #add-point:AFTER FIELD xceb112 name="input.a.page1.xceb112"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb112
            #add-point:ON CHANGE xceb112 name="input.g.page1.xceb112"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb113
            #add-point:BEFORE FIELD xceb113 name="input.b.page1.xceb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb113
            
            #add-point:AFTER FIELD xceb113 name="input.a.page1.xceb113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb113
            #add-point:ON CHANGE xceb113 name="input.g.page1.xceb113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb121
            #add-point:BEFORE FIELD xceb121 name="input.b.page1.xceb121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb121
            
            #add-point:AFTER FIELD xceb121 name="input.a.page1.xceb121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb121
            #add-point:ON CHANGE xceb121 name="input.g.page1.xceb121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb122
            #add-point:BEFORE FIELD xceb122 name="input.b.page1.xceb122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb122
            
            #add-point:AFTER FIELD xceb122 name="input.a.page1.xceb122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb122
            #add-point:ON CHANGE xceb122 name="input.g.page1.xceb122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb123
            #add-point:BEFORE FIELD xceb123 name="input.b.page1.xceb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb123
            
            #add-point:AFTER FIELD xceb123 name="input.a.page1.xceb123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb123
            #add-point:ON CHANGE xceb123 name="input.g.page1.xceb123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb124
            #add-point:BEFORE FIELD xceb124 name="input.b.page1.xceb124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb124
            
            #add-point:AFTER FIELD xceb124 name="input.a.page1.xceb124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb124
            #add-point:ON CHANGE xceb124 name="input.g.page1.xceb124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb125
            #add-point:BEFORE FIELD xceb125 name="input.b.page1.xceb125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb125
            
            #add-point:AFTER FIELD xceb125 name="input.a.page1.xceb125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb125
            #add-point:ON CHANGE xceb125 name="input.g.page1.xceb125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb126
            #add-point:BEFORE FIELD xceb126 name="input.b.page1.xceb126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb126
            
            #add-point:AFTER FIELD xceb126 name="input.a.page1.xceb126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb126
            #add-point:ON CHANGE xceb126 name="input.g.page1.xceb126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb127
            #add-point:BEFORE FIELD xceb127 name="input.b.page1.xceb127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb127
            
            #add-point:AFTER FIELD xceb127 name="input.a.page1.xceb127"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb127
            #add-point:ON CHANGE xceb127 name="input.g.page1.xceb127"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb128
            #add-point:BEFORE FIELD xceb128 name="input.b.page1.xceb128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb128
            
            #add-point:AFTER FIELD xceb128 name="input.a.page1.xceb128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb128
            #add-point:ON CHANGE xceb128 name="input.g.page1.xceb128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb129
            #add-point:BEFORE FIELD xceb129 name="input.b.page1.xceb129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb129
            
            #add-point:AFTER FIELD xceb129 name="input.a.page1.xceb129"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb129
            #add-point:ON CHANGE xceb129 name="input.g.page1.xceb129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb130
            #add-point:BEFORE FIELD xceb130 name="input.b.page1.xceb130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb130
            
            #add-point:AFTER FIELD xceb130 name="input.a.page1.xceb130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb130
            #add-point:ON CHANGE xceb130 name="input.g.page1.xceb130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb201
            #add-point:BEFORE FIELD xceb201 name="input.b.page1.xceb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb201
            
            #add-point:AFTER FIELD xceb201 name="input.a.page1.xceb201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb201
            #add-point:ON CHANGE xceb201 name="input.g.page1.xceb201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202
            #add-point:BEFORE FIELD xceb202 name="input.b.page1.xceb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202
            
            #add-point:AFTER FIELD xceb202 name="input.a.page1.xceb202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202
            #add-point:ON CHANGE xceb202 name="input.g.page1.xceb202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202a
            #add-point:BEFORE FIELD xceb202a name="input.b.page1.xceb202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202a
            
            #add-point:AFTER FIELD xceb202a name="input.a.page1.xceb202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202a
            #add-point:ON CHANGE xceb202a name="input.g.page1.xceb202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202b
            #add-point:BEFORE FIELD xceb202b name="input.b.page1.xceb202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202b
            
            #add-point:AFTER FIELD xceb202b name="input.a.page1.xceb202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202b
            #add-point:ON CHANGE xceb202b name="input.g.page1.xceb202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202c
            #add-point:BEFORE FIELD xceb202c name="input.b.page1.xceb202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202c
            
            #add-point:AFTER FIELD xceb202c name="input.a.page1.xceb202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202c
            #add-point:ON CHANGE xceb202c name="input.g.page1.xceb202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202d
            #add-point:BEFORE FIELD xceb202d name="input.b.page1.xceb202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202d
            
            #add-point:AFTER FIELD xceb202d name="input.a.page1.xceb202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202d
            #add-point:ON CHANGE xceb202d name="input.g.page1.xceb202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202e
            #add-point:BEFORE FIELD xceb202e name="input.b.page1.xceb202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202e
            
            #add-point:AFTER FIELD xceb202e name="input.a.page1.xceb202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202e
            #add-point:ON CHANGE xceb202e name="input.g.page1.xceb202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202f
            #add-point:BEFORE FIELD xceb202f name="input.b.page1.xceb202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202f
            
            #add-point:AFTER FIELD xceb202f name="input.a.page1.xceb202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202f
            #add-point:ON CHANGE xceb202f name="input.g.page1.xceb202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202g
            #add-point:BEFORE FIELD xceb202g name="input.b.page1.xceb202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202g
            
            #add-point:AFTER FIELD xceb202g name="input.a.page1.xceb202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202g
            #add-point:ON CHANGE xceb202g name="input.g.page1.xceb202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202h
            #add-point:BEFORE FIELD xceb202h name="input.b.page1.xceb202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202h
            
            #add-point:AFTER FIELD xceb202h name="input.a.page1.xceb202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202h
            #add-point:ON CHANGE xceb202h name="input.g.page1.xceb202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212
            #add-point:BEFORE FIELD xceb212 name="input.b.page1.xceb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212
            
            #add-point:AFTER FIELD xceb212 name="input.a.page1.xceb212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212
            #add-point:ON CHANGE xceb212 name="input.g.page1.xceb212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212a
            #add-point:BEFORE FIELD xceb212a name="input.b.page1.xceb212a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212a
            
            #add-point:AFTER FIELD xceb212a name="input.a.page1.xceb212a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212a
            #add-point:ON CHANGE xceb212a name="input.g.page1.xceb212a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212b
            #add-point:BEFORE FIELD xceb212b name="input.b.page1.xceb212b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212b
            
            #add-point:AFTER FIELD xceb212b name="input.a.page1.xceb212b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212b
            #add-point:ON CHANGE xceb212b name="input.g.page1.xceb212b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212c
            #add-point:BEFORE FIELD xceb212c name="input.b.page1.xceb212c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212c
            
            #add-point:AFTER FIELD xceb212c name="input.a.page1.xceb212c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212c
            #add-point:ON CHANGE xceb212c name="input.g.page1.xceb212c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212d
            #add-point:BEFORE FIELD xceb212d name="input.b.page1.xceb212d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212d
            
            #add-point:AFTER FIELD xceb212d name="input.a.page1.xceb212d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212d
            #add-point:ON CHANGE xceb212d name="input.g.page1.xceb212d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212e
            #add-point:BEFORE FIELD xceb212e name="input.b.page1.xceb212e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212e
            
            #add-point:AFTER FIELD xceb212e name="input.a.page1.xceb212e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212e
            #add-point:ON CHANGE xceb212e name="input.g.page1.xceb212e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212f
            #add-point:BEFORE FIELD xceb212f name="input.b.page1.xceb212f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212f
            
            #add-point:AFTER FIELD xceb212f name="input.a.page1.xceb212f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212f
            #add-point:ON CHANGE xceb212f name="input.g.page1.xceb212f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212g
            #add-point:BEFORE FIELD xceb212g name="input.b.page1.xceb212g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212g
            
            #add-point:AFTER FIELD xceb212g name="input.a.page1.xceb212g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212g
            #add-point:ON CHANGE xceb212g name="input.g.page1.xceb212g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212h
            #add-point:BEFORE FIELD xceb212h name="input.b.page1.xceb212h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212h
            
            #add-point:AFTER FIELD xceb212h name="input.a.page1.xceb212h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212h
            #add-point:ON CHANGE xceb212h name="input.g.page1.xceb212h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222
            #add-point:BEFORE FIELD xceb222 name="input.b.page1.xceb222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222
            
            #add-point:AFTER FIELD xceb222 name="input.a.page1.xceb222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222
            #add-point:ON CHANGE xceb222 name="input.g.page1.xceb222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222a
            #add-point:BEFORE FIELD xceb222a name="input.b.page1.xceb222a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222a
            
            #add-point:AFTER FIELD xceb222a name="input.a.page1.xceb222a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222a
            #add-point:ON CHANGE xceb222a name="input.g.page1.xceb222a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222b
            #add-point:BEFORE FIELD xceb222b name="input.b.page1.xceb222b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222b
            
            #add-point:AFTER FIELD xceb222b name="input.a.page1.xceb222b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222b
            #add-point:ON CHANGE xceb222b name="input.g.page1.xceb222b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222c
            #add-point:BEFORE FIELD xceb222c name="input.b.page1.xceb222c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222c
            
            #add-point:AFTER FIELD xceb222c name="input.a.page1.xceb222c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222c
            #add-point:ON CHANGE xceb222c name="input.g.page1.xceb222c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222d
            #add-point:BEFORE FIELD xceb222d name="input.b.page1.xceb222d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222d
            
            #add-point:AFTER FIELD xceb222d name="input.a.page1.xceb222d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222d
            #add-point:ON CHANGE xceb222d name="input.g.page1.xceb222d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222e
            #add-point:BEFORE FIELD xceb222e name="input.b.page1.xceb222e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222e
            
            #add-point:AFTER FIELD xceb222e name="input.a.page1.xceb222e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222e
            #add-point:ON CHANGE xceb222e name="input.g.page1.xceb222e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222f
            #add-point:BEFORE FIELD xceb222f name="input.b.page1.xceb222f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222f
            
            #add-point:AFTER FIELD xceb222f name="input.a.page1.xceb222f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222f
            #add-point:ON CHANGE xceb222f name="input.g.page1.xceb222f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222g
            #add-point:BEFORE FIELD xceb222g name="input.b.page1.xceb222g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222g
            
            #add-point:AFTER FIELD xceb222g name="input.a.page1.xceb222g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222g
            #add-point:ON CHANGE xceb222g name="input.g.page1.xceb222g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222h
            #add-point:BEFORE FIELD xceb222h name="input.b.page1.xceb222h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222h
            
            #add-point:AFTER FIELD xceb222h name="input.a.page1.xceb222h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222h
            #add-point:ON CHANGE xceb222h name="input.g.page1.xceb222h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb301
            #add-point:BEFORE FIELD xceb301 name="input.b.page1.xceb301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb301
            
            #add-point:AFTER FIELD xceb301 name="input.a.page1.xceb301"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb301
            #add-point:ON CHANGE xceb301 name="input.g.page1.xceb301"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb302
            #add-point:BEFORE FIELD xceb302 name="input.b.page1.xceb302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb302
            
            #add-point:AFTER FIELD xceb302 name="input.a.page1.xceb302"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb302
            #add-point:ON CHANGE xceb302 name="input.g.page1.xceb302"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebcomp
            #add-point:BEFORE FIELD xcebcomp name="input.b.page1.xcebcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebcomp
            
            #add-point:AFTER FIELD xcebcomp name="input.a.page1.xcebcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcebcomp
            #add-point:ON CHANGE xcebcomp name="input.g.page1.xcebcomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebseq
            #add-point:ON ACTION controlp INFIELD xcebseq name="input.c.page1.xcebseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb001
            #add-point:ON ACTION controlp INFIELD xceb001 name="input.c.page1.xceb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_sfaadocno()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb001 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb001 TO xceb001              #

            NEXT FIELD xceb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb003
            #add-point:ON ACTION controlp INFIELD xceb003 name="input.c.page1.xceb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb004
            #add-point:ON ACTION controlp INFIELD xceb004 name="input.c.page1.xceb004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb004 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb004 TO xceb004              #

            NEXT FIELD xceb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb005
            #add-point:ON ACTION controlp INFIELD xceb005 name="input.c.page1.xceb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb101
            #add-point:ON ACTION controlp INFIELD xceb101 name="input.c.page1.xceb101"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb101             #給予default值
            
            SELECT glaa004 INTO g_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
             
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "
            #151117-00009#1--add--str--
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_xcea_m.xceald,"'",
                                   "                    AND gladstus='Y' )"
            #151117-00009#1--add--end
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb101 = g_qryparam.return1              

            CALL axct901_get_xceb101_desc(g_xceb_d[l_ac].xceb101)
              RETURNING g_xceb_d[l_ac].xceb101_desc
              
            DISPLAY g_xceb_d[l_ac].xceb101 TO xceb101              #

            DISPLAY g_xceb_d[l_ac].xceb101_desc TO xceb101_desc 
            
            NEXT FIELD xceb101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb102
            #add-point:ON ACTION controlp INFIELD xceb102 name="input.c.page1.xceb102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb103
            #add-point:ON ACTION controlp INFIELD xceb103 name="input.c.page1.xceb103"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb103             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb103 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb103 TO xceb103              #

            NEXT FIELD xceb103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb117
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb117
            #add-point:ON ACTION controlp INFIELD xceb117 name="input.c.page1.xceb117"
            #此段落由子樣板a07產生            
            #開窗i段
            #170227-00006#1--s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb117   #給予default值  
            CALL q_rtax001 ()                                  #呼叫開窗
            LET g_xceb_d[l_ac].xceb117 = g_qryparam.return1            
            DISPLAY g_xceb_d[l_ac].xceb117 TO xceb117          
            NEXT FIELD xceb117                                 #返回原欄位
            #170227-00006#1--e
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb118
            #add-point:ON ACTION controlp INFIELD xceb118 name="input.c.page1.xceb118"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb114
            #add-point:ON ACTION controlp INFIELD xceb114 name="input.c.page1.xceb114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb115
            #add-point:ON ACTION controlp INFIELD xceb115 name="input.c.page1.xceb115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb116
            #add-point:ON ACTION controlp INFIELD xceb116 name="input.c.page1.xceb116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb119
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb119
            #add-point:ON ACTION controlp INFIELD xceb119 name="input.c.page1.xceb119"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb119             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb119 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb119 TO xceb119              #

            NEXT FIELD xceb119                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb120
            #add-point:ON ACTION controlp INFIELD xceb120 name="input.c.page1.xceb120"
            #此段落由子樣板a07產生            
            #開窗i段
            #170227-00006#1---s
            IF cl_null(g_xceb_d[l_ac].xceb119) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00391'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD xceb119
            END IF
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb120        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_xceb_d[l_ac].xceb119            
            CALL q_pjbb002_2()                                        #呼叫開窗
            LET g_xceb_d[l_ac].xceb120 = g_qryparam.return1        
            DISPLAY g_xceb_d[l_ac].xceb120 TO xceb120              #
            NEXT FIELD xceb120                          #返回原欄位 
            #170227-00006#1---e
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb107
            #add-point:ON ACTION controlp INFIELD xceb107 name="input.c.page1.xceb107"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb107             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb107 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb107 TO xceb107              #

            NEXT FIELD xceb107                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb108
            #add-point:ON ACTION controlp INFIELD xceb108 name="input.c.page1.xceb108"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb108             #給予default值
            LET g_qryparam.default2 = "" #g_xceb_d[l_ac].ooeg001 #部門編號
            #給予arg
           #LET g_qryparam.arg1 = "" #                      #150812-00010#3 mark 
           #CALL q_ooeg001()                                #150812-00010#3 mark    
            LET g_qryparam.arg1 = g_xcea_m.xcea001          #150812-00010#3
            CALL q_ooeg001_4()                              #150812-00010#3

            LET g_xceb_d[l_ac].xceb108 = g_qryparam.return1              
            #LET g_xceb_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_xceb_d[l_ac].xceb108 TO xceb108              #
            #DISPLAY g_xceb_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD xceb108                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb109
            #add-point:ON ACTION controlp INFIELD xceb109 name="input.c.page1.xceb109"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb109             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_7()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb109 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb109 TO xceb109              #

            NEXT FIELD xceb109                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb111
            #add-point:ON ACTION controlp INFIELD xceb111 name="input.c.page1.xceb111"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb_d[l_ac].xceb111             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_7()                                #呼叫開窗

            LET g_xceb_d[l_ac].xceb111 = g_qryparam.return1              

            DISPLAY g_xceb_d[l_ac].xceb111 TO xceb111              #

            NEXT FIELD xceb111                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb112
            #add-point:ON ACTION controlp INFIELD xceb112 name="input.c.page1.xceb112"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb113
            #add-point:ON ACTION controlp INFIELD xceb113 name="input.c.page1.xceb113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb121
            #add-point:ON ACTION controlp INFIELD xceb121 name="input.c.page1.xceb121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb122
            #add-point:ON ACTION controlp INFIELD xceb122 name="input.c.page1.xceb122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb123
            #add-point:ON ACTION controlp INFIELD xceb123 name="input.c.page1.xceb123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb124
            #add-point:ON ACTION controlp INFIELD xceb124 name="input.c.page1.xceb124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb125
            #add-point:ON ACTION controlp INFIELD xceb125 name="input.c.page1.xceb125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb126
            #add-point:ON ACTION controlp INFIELD xceb126 name="input.c.page1.xceb126"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb127
            #add-point:ON ACTION controlp INFIELD xceb127 name="input.c.page1.xceb127"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb128
            #add-point:ON ACTION controlp INFIELD xceb128 name="input.c.page1.xceb128"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb129
            #add-point:ON ACTION controlp INFIELD xceb129 name="input.c.page1.xceb129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb130
            #add-point:ON ACTION controlp INFIELD xceb130 name="input.c.page1.xceb130"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb201
            #add-point:ON ACTION controlp INFIELD xceb201 name="input.c.page1.xceb201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202
            #add-point:ON ACTION controlp INFIELD xceb202 name="input.c.page1.xceb202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202a
            #add-point:ON ACTION controlp INFIELD xceb202a name="input.c.page1.xceb202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202b
            #add-point:ON ACTION controlp INFIELD xceb202b name="input.c.page1.xceb202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202c
            #add-point:ON ACTION controlp INFIELD xceb202c name="input.c.page1.xceb202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202d
            #add-point:ON ACTION controlp INFIELD xceb202d name="input.c.page1.xceb202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202e
            #add-point:ON ACTION controlp INFIELD xceb202e name="input.c.page1.xceb202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202f
            #add-point:ON ACTION controlp INFIELD xceb202f name="input.c.page1.xceb202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202g
            #add-point:ON ACTION controlp INFIELD xceb202g name="input.c.page1.xceb202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202h
            #add-point:ON ACTION controlp INFIELD xceb202h name="input.c.page1.xceb202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212
            #add-point:ON ACTION controlp INFIELD xceb212 name="input.c.page1.xceb212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212a
            #add-point:ON ACTION controlp INFIELD xceb212a name="input.c.page1.xceb212a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212b
            #add-point:ON ACTION controlp INFIELD xceb212b name="input.c.page1.xceb212b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212c
            #add-point:ON ACTION controlp INFIELD xceb212c name="input.c.page1.xceb212c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212d
            #add-point:ON ACTION controlp INFIELD xceb212d name="input.c.page1.xceb212d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212e
            #add-point:ON ACTION controlp INFIELD xceb212e name="input.c.page1.xceb212e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212f
            #add-point:ON ACTION controlp INFIELD xceb212f name="input.c.page1.xceb212f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212g
            #add-point:ON ACTION controlp INFIELD xceb212g name="input.c.page1.xceb212g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb212h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212h
            #add-point:ON ACTION controlp INFIELD xceb212h name="input.c.page1.xceb212h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222
            #add-point:ON ACTION controlp INFIELD xceb222 name="input.c.page1.xceb222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222a
            #add-point:ON ACTION controlp INFIELD xceb222a name="input.c.page1.xceb222a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222b
            #add-point:ON ACTION controlp INFIELD xceb222b name="input.c.page1.xceb222b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222c
            #add-point:ON ACTION controlp INFIELD xceb222c name="input.c.page1.xceb222c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222d
            #add-point:ON ACTION controlp INFIELD xceb222d name="input.c.page1.xceb222d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222e
            #add-point:ON ACTION controlp INFIELD xceb222e name="input.c.page1.xceb222e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222f
            #add-point:ON ACTION controlp INFIELD xceb222f name="input.c.page1.xceb222f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222g
            #add-point:ON ACTION controlp INFIELD xceb222g name="input.c.page1.xceb222g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb222h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222h
            #add-point:ON ACTION controlp INFIELD xceb222h name="input.c.page1.xceb222h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb301
            #add-point:ON ACTION controlp INFIELD xceb301 name="input.c.page1.xceb301"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xceb302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb302
            #add-point:ON ACTION controlp INFIELD xceb302 name="input.c.page1.xceb302"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcebcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebcomp
            #add-point:ON ACTION controlp INFIELD xcebcomp name="input.c.page1.xcebcomp"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xceb_d[l_ac].* = g_xceb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct901_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xceb_d[l_ac].xcebseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xceb_d[l_ac].* = g_xceb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axct901_xceb_t_mask_restore('restore_mask_o')
      
               UPDATE xceb_t SET (xcebld,xcebdocno,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102, 
                   xceb103,xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108, 
                   xceb109,xceb111,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127, 
                   xceb128,xceb129,xceb130,xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e, 
                   xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f, 
                   xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g, 
                   xceb222h,xceb301,xceb302,xcebcomp) = (g_xcea_m.xceald,g_xcea_m.xceadocno,g_xceb_d[l_ac].xcebseq, 
                   g_xceb_d[l_ac].xceb001,g_xceb_d[l_ac].xceb003,g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005, 
                   g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb102,g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb110, 
                   g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118,g_xceb_d[l_ac].xceb114,g_xceb_d[l_ac].xceb115, 
                   g_xceb_d[l_ac].xceb116,g_xceb_d[l_ac].xceb119,g_xceb_d[l_ac].xceb120,g_xceb_d[l_ac].xceb107, 
                   g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109,g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb112, 
                   g_xceb_d[l_ac].xceb113,g_xceb_d[l_ac].xceb121,g_xceb_d[l_ac].xceb122,g_xceb_d[l_ac].xceb123, 
                   g_xceb_d[l_ac].xceb124,g_xceb_d[l_ac].xceb125,g_xceb_d[l_ac].xceb126,g_xceb_d[l_ac].xceb127, 
                   g_xceb_d[l_ac].xceb128,g_xceb_d[l_ac].xceb129,g_xceb_d[l_ac].xceb130,g_xceb_d[l_ac].xceb201, 
                   g_xceb_d[l_ac].xceb202,g_xceb_d[l_ac].xceb202a,g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c, 
                   g_xceb_d[l_ac].xceb202d,g_xceb_d[l_ac].xceb202e,g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g, 
                   g_xceb_d[l_ac].xceb202h,g_xceb_d[l_ac].xceb212,g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b, 
                   g_xceb_d[l_ac].xceb212c,g_xceb_d[l_ac].xceb212d,g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f, 
                   g_xceb_d[l_ac].xceb212g,g_xceb_d[l_ac].xceb212h,g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a, 
                   g_xceb_d[l_ac].xceb222b,g_xceb_d[l_ac].xceb222c,g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e, 
                   g_xceb_d[l_ac].xceb222f,g_xceb_d[l_ac].xceb222g,g_xceb_d[l_ac].xceb222h,g_xceb_d[l_ac].xceb301, 
                   g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp)
                WHERE xcebent = g_enterprise AND xcebld = g_xcea_m.xceald 
                  AND xcebdocno = g_xcea_m.xceadocno 
 
                  AND xcebseq = g_xceb_d_t.xcebseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xceb_d[l_ac].* = g_xceb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xceb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xceb_d[l_ac].* = g_xceb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys_bak[1] = g_xceald_t
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys_bak[2] = g_xceadocno_t
               LET gs_keys[3] = g_xceb_d[g_detail_idx].xcebseq
               LET gs_keys_bak[3] = g_xceb_d_t.xcebseq
               CALL axct901_update_b('xceb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axct901_xceb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xceb_d[g_detail_idx].xcebseq = g_xceb_d_t.xcebseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xcea_m.xceald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xceb_d_t.xcebseq
 
                  CALL axct901_key_update_b(gs_keys,'xceb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb_d_t)
               LET g_log2 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb_d[l_ac].xceb101) THEN
               CALL axct901_get_glad(g_xcea_m.xceald,g_xceb_d[l_ac].xceb101) RETURNING l_glad015,l_glad016,l_glad012          
               IF cl_null(g_xceb_d[l_ac].xceb119) AND l_glad015 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xceb_d[l_ac].xceb101
                  LET g_errparam.code   = 'agl-00541'      
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
               END IF   
               IF cl_null(g_xceb_d[l_ac].xceb120) AND l_glad016 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xceb_d[l_ac].xceb101
                  LET g_errparam.code   = 'agl-00542'      
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
               END IF  
            END IF 
            #170227-00006#1---e
            #end add-point
            CALL axct901_unlock_b("xceb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL axct901_b_fill3()
            CALL axct901_b_fill4()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xceb_d[li_reproduce_target].* = g_xceb_d[li_reproduce].*
               LET g_xceb8_d[li_reproduce_target].* = g_xceb8_d[li_reproduce].*
 
               LET g_xceb_d[li_reproduce_target].xcebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xceb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xceb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xceb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xceb4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct901_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xceb4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xceb4_d[l_ac].* TO NULL 
            INITIALIZE g_xceb4_d_t.* TO NULL 
            INITIALIZE g_xceb4_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_xceb4_d[l_ac].xcec201 = "0"
      LET g_xceb4_d[l_ac].xcec202 = "0"
      LET g_xceb4_d[l_ac].xcec202a = "0"
      LET g_xceb4_d[l_ac].xcec202b = "0"
      LET g_xceb4_d[l_ac].xcec202c = "0"
      LET g_xceb4_d[l_ac].xcec202d = "0"
      LET g_xceb4_d[l_ac].xcec202e = "0"
      LET g_xceb4_d[l_ac].xcec202f = "0"
      LET g_xceb4_d[l_ac].xcec202g = "0"
      LET g_xceb4_d[l_ac].xcec202h = "0"
      LET g_xceb4_d[l_ac].xcec212 = "0"
      LET g_xceb4_d[l_ac].xcec212a = "0"
      LET g_xceb4_d[l_ac].xcec212b = "0"
      LET g_xceb4_d[l_ac].xcec212c = "0"
      LET g_xceb4_d[l_ac].xcec212d = "0"
      LET g_xceb4_d[l_ac].xcec212e = "0"
      LET g_xceb4_d[l_ac].xcec212f = "0"
      LET g_xceb4_d[l_ac].xcec212g = "0"
      LET g_xceb4_d[l_ac].xcec212h = "0"
      LET g_xceb4_d[l_ac].xcec222 = "0"
      LET g_xceb4_d[l_ac].xcec222a = "0"
      LET g_xceb4_d[l_ac].xcec222b = "0"
      LET g_xceb4_d[l_ac].xcec222c = "0"
      LET g_xceb4_d[l_ac].xcec222d = "0"
      LET g_xceb4_d[l_ac].xcec222e = "0"
      LET g_xceb4_d[l_ac].xcec222f = "0"
      LET g_xceb4_d[l_ac].xcec222g = "0"
      LET g_xceb4_d[l_ac].xcec222h = "0"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_xceb4_d_t.* = g_xceb4_d[l_ac].*     #新輸入資料
            LET g_xceb4_d_o.* = g_xceb4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct901_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL axct901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xceb4_d[li_reproduce_target].* = g_xceb4_d[li_reproduce].*
 
               LET g_xceb4_d[li_reproduce_target].xcecseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xceb4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xceb4_d[l_ac].xcecseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xceb4_d_t.* = g_xceb4_d[l_ac].*  #BACKUP
               LET g_xceb4_d_o.* = g_xceb4_d[l_ac].*  #BACKUP
               CALL axct901_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL axct901_set_no_entry_b(l_cmd)
               IF NOT axct901_lock_b("xcec_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct901_bcl2 INTO g_xceb4_d[l_ac].xcecseq,g_xceb4_d[l_ac].xcec001,g_xceb4_d[l_ac].xcec003, 
                      g_xceb4_d[l_ac].xcec004,g_xceb4_d[l_ac].xcec005,g_xceb4_d[l_ac].xcec101,g_xceb4_d[l_ac].xcec102, 
                      g_xceb4_d[l_ac].xcec103,g_xceb4_d[l_ac].xcec110,g_xceb4_d[l_ac].xcec117,g_xceb4_d[l_ac].xcec118, 
                      g_xceb4_d[l_ac].xcec114,g_xceb4_d[l_ac].xcec115,g_xceb4_d[l_ac].xcec116,g_xceb4_d[l_ac].xcec119, 
                      g_xceb4_d[l_ac].xcec120,g_xceb4_d[l_ac].xcec107,g_xceb4_d[l_ac].xcec108,g_xceb4_d[l_ac].xcec109, 
                      g_xceb4_d[l_ac].xcec111,g_xceb4_d[l_ac].xcec112,g_xceb4_d[l_ac].xcec113,g_xceb4_d[l_ac].xcec121, 
                      g_xceb4_d[l_ac].xcec122,g_xceb4_d[l_ac].xcec123,g_xceb4_d[l_ac].xcec124,g_xceb4_d[l_ac].xcec125, 
                      g_xceb4_d[l_ac].xcec126,g_xceb4_d[l_ac].xcec127,g_xceb4_d[l_ac].xcec128,g_xceb4_d[l_ac].xcec129, 
                      g_xceb4_d[l_ac].xcec130,g_xceb4_d[l_ac].xcec201,g_xceb4_d[l_ac].xcec202,g_xceb4_d[l_ac].xcec202a, 
                      g_xceb4_d[l_ac].xcec202b,g_xceb4_d[l_ac].xcec202c,g_xceb4_d[l_ac].xcec202d,g_xceb4_d[l_ac].xcec202e, 
                      g_xceb4_d[l_ac].xcec202f,g_xceb4_d[l_ac].xcec202g,g_xceb4_d[l_ac].xcec202h,g_xceb4_d[l_ac].xcec212, 
                      g_xceb4_d[l_ac].xcec212a,g_xceb4_d[l_ac].xcec212b,g_xceb4_d[l_ac].xcec212c,g_xceb4_d[l_ac].xcec212d, 
                      g_xceb4_d[l_ac].xcec212e,g_xceb4_d[l_ac].xcec212f,g_xceb4_d[l_ac].xcec212g,g_xceb4_d[l_ac].xcec212h, 
                      g_xceb4_d[l_ac].xcec222,g_xceb4_d[l_ac].xcec222a,g_xceb4_d[l_ac].xcec222b,g_xceb4_d[l_ac].xcec222c, 
                      g_xceb4_d[l_ac].xcec222d,g_xceb4_d[l_ac].xcec222e,g_xceb4_d[l_ac].xcec222f,g_xceb4_d[l_ac].xcec222g, 
                      g_xceb4_d[l_ac].xcec222h,g_xceb4_d[l_ac].xcec301,g_xceb4_d[l_ac].xcec302,g_xceb4_d[l_ac].xceccomp 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xceb4_d_mask_o[l_ac].* =  g_xceb4_d[l_ac].*
                  CALL axct901_xcec_t_mask()
                  LET g_xceb4_d_mask_n[l_ac].* =  g_xceb4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axct901_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xcea_m.xceald
               LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
               LET gs_keys[gs_keys.getLength()+1] = g_xceb4_d_t.xcecseq
            
               #刪除同層單身
               IF NOT axct901_delete_b('xcec_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axct901_key_delete_b(gs_keys,'xcec_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axct901_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_xceb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xceb4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcec_t 
             WHERE xcecent = g_enterprise AND xcecld = g_xcea_m.xceald
               AND xcecdocno = g_xcea_m.xceadocno
               AND xcecseq = g_xceb4_d[l_ac].xcecseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys[3] = g_xceb4_d[g_detail_idx].xcecseq
               CALL axct901_insert_b('xcec_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xceb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axct901_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xceb4_d[l_ac].* = g_xceb4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct901_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xceb4_d[l_ac].* = g_xceb4_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axct901_xcec_t_mask_restore('restore_mask_o')
                              
               UPDATE xcec_t SET (xcecld,xcecdocno,xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102, 
                   xcec103,xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,xcec119,xcec120,xcec107,xcec108, 
                   xcec109,xcec111,xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127, 
                   xcec128,xcec129,xcec130,xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e, 
                   xcec202f,xcec202g,xcec202h,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f, 
                   xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g, 
                   xcec222h,xcec301,xcec302,xceccomp) = (g_xcea_m.xceald,g_xcea_m.xceadocno,g_xceb4_d[l_ac].xcecseq, 
                   g_xceb4_d[l_ac].xcec001,g_xceb4_d[l_ac].xcec003,g_xceb4_d[l_ac].xcec004,g_xceb4_d[l_ac].xcec005, 
                   g_xceb4_d[l_ac].xcec101,g_xceb4_d[l_ac].xcec102,g_xceb4_d[l_ac].xcec103,g_xceb4_d[l_ac].xcec110, 
                   g_xceb4_d[l_ac].xcec117,g_xceb4_d[l_ac].xcec118,g_xceb4_d[l_ac].xcec114,g_xceb4_d[l_ac].xcec115, 
                   g_xceb4_d[l_ac].xcec116,g_xceb4_d[l_ac].xcec119,g_xceb4_d[l_ac].xcec120,g_xceb4_d[l_ac].xcec107, 
                   g_xceb4_d[l_ac].xcec108,g_xceb4_d[l_ac].xcec109,g_xceb4_d[l_ac].xcec111,g_xceb4_d[l_ac].xcec112, 
                   g_xceb4_d[l_ac].xcec113,g_xceb4_d[l_ac].xcec121,g_xceb4_d[l_ac].xcec122,g_xceb4_d[l_ac].xcec123, 
                   g_xceb4_d[l_ac].xcec124,g_xceb4_d[l_ac].xcec125,g_xceb4_d[l_ac].xcec126,g_xceb4_d[l_ac].xcec127, 
                   g_xceb4_d[l_ac].xcec128,g_xceb4_d[l_ac].xcec129,g_xceb4_d[l_ac].xcec130,g_xceb4_d[l_ac].xcec201, 
                   g_xceb4_d[l_ac].xcec202,g_xceb4_d[l_ac].xcec202a,g_xceb4_d[l_ac].xcec202b,g_xceb4_d[l_ac].xcec202c, 
                   g_xceb4_d[l_ac].xcec202d,g_xceb4_d[l_ac].xcec202e,g_xceb4_d[l_ac].xcec202f,g_xceb4_d[l_ac].xcec202g, 
                   g_xceb4_d[l_ac].xcec202h,g_xceb4_d[l_ac].xcec212,g_xceb4_d[l_ac].xcec212a,g_xceb4_d[l_ac].xcec212b, 
                   g_xceb4_d[l_ac].xcec212c,g_xceb4_d[l_ac].xcec212d,g_xceb4_d[l_ac].xcec212e,g_xceb4_d[l_ac].xcec212f, 
                   g_xceb4_d[l_ac].xcec212g,g_xceb4_d[l_ac].xcec212h,g_xceb4_d[l_ac].xcec222,g_xceb4_d[l_ac].xcec222a, 
                   g_xceb4_d[l_ac].xcec222b,g_xceb4_d[l_ac].xcec222c,g_xceb4_d[l_ac].xcec222d,g_xceb4_d[l_ac].xcec222e, 
                   g_xceb4_d[l_ac].xcec222f,g_xceb4_d[l_ac].xcec222g,g_xceb4_d[l_ac].xcec222h,g_xceb4_d[l_ac].xcec301, 
                   g_xceb4_d[l_ac].xcec302,g_xceb4_d[l_ac].xceccomp) #自訂欄位頁簽
                WHERE xcecent = g_enterprise AND xcecld = g_xcea_m.xceald
                  AND xcecdocno = g_xcea_m.xceadocno
                  AND xcecseq = g_xceb4_d_t.xcecseq #項次 
                  
               #add-point:單身page2修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xceb4_d[l_ac].* = g_xceb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcec_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xceb4_d[l_ac].* = g_xceb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys_bak[1] = g_xceald_t
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys_bak[2] = g_xceadocno_t
               LET gs_keys[3] = g_xceb4_d[g_detail_idx].xcecseq
               LET gs_keys_bak[3] = g_xceb4_d_t.xcecseq
               CALL axct901_update_b('xcec_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct901_xcec_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xceb4_d[g_detail_idx].xcecseq = g_xceb4_d_t.xcecseq 
                  ) THEN
                  LET gs_keys[01] = g_xcea_m.xceald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xceb4_d_t.xcecseq
                  CALL axct901_key_update_b(gs_keys,'xcec_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb4_d_t)
               LET g_log2 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcecseq
            #add-point:BEFORE FIELD xcecseq name="input.b.page4.xcecseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcecseq
            
            #add-point:AFTER FIELD xcecseq name="input.a.page4.xcecseq"
            #此段落由子樣板a05產生
            IF  g_xcea_m.xceald IS NOT NULL AND g_xcea_m.xceadocno IS NOT NULL AND g_xceb4_d[g_detail_idx].xcecseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcea_m.xceald != g_xceald_t OR g_xcea_m.xceadocno != g_xceadocno_t OR g_xceb4_d[g_detail_idx].xcecseq != g_xceb4_d_t.xcecseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcec_t WHERE "||"xcecent = '" ||g_enterprise|| "' AND "||"xcecld = '"||g_xcea_m.xceald ||"' AND "|| "xcecdocno = '"||g_xcea_m.xceadocno ||"' AND "|| "xcecseq = '"||g_xceb4_d[g_detail_idx].xcecseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcecseq
            #add-point:ON CHANGE xcecseq name="input.g.page4.xcecseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec001
            #add-point:BEFORE FIELD xcec001 name="input.b.page4.xcec001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec001
            
            #add-point:AFTER FIELD xcec001 name="input.a.page4.xcec001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec001
            #add-point:ON CHANGE xcec001 name="input.g.page4.xcec001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec003
            #add-point:BEFORE FIELD xcec003 name="input.b.page4.xcec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec003
            
            #add-point:AFTER FIELD xcec003 name="input.a.page4.xcec003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec003
            #add-point:ON CHANGE xcec003 name="input.g.page4.xcec003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec004
            #add-point:BEFORE FIELD xcec004 name="input.b.page4.xcec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec004
            
            #add-point:AFTER FIELD xcec004 name="input.a.page4.xcec004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec004
            #add-point:ON CHANGE xcec004 name="input.g.page4.xcec004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec005
            #add-point:BEFORE FIELD xcec005 name="input.b.page4.xcec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec005
            
            #add-point:AFTER FIELD xcec005 name="input.a.page4.xcec005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec005
            #add-point:ON CHANGE xcec005 name="input.g.page4.xcec005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec101
            
            #add-point:AFTER FIELD xcec101 name="input.a.page4.xcec101"
            IF NOT cl_null(g_xceb4_d[g_detail_idx].xcec101) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               SELECT glaa004 INTO g_glaa004 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_xceb4_d[g_detail_idx].xcec101
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_glac002_4') THEN
                  #檢查失敗時後續處理
                   CALL axct901_get_xceb101_desc(g_xceb4_d[g_detail_idx].xcec101) 
                   RETURNING g_xceb4_d[g_detail_idx].xcec101_desc 
                  NEXT FIELD xcec101
               END IF
               
               #151117-00009#1--add--str--
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_xcea_m.xceald,g_xceb4_d[g_detail_idx].xcec101)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xceb4_d[g_detail_idx].xcec101
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #檢查失敗時後續處理
                   CALL axct901_get_xceb101_desc(g_xceb4_d[g_detail_idx].xcec101) 
                   RETURNING g_xceb4_d[g_detail_idx].xcec101_desc 
                  NEXT FIELD xcec101
               END IF
               #151117-00009#1--add--end
            END IF
            
            CALL axct901_get_xceb101_desc(g_xceb4_d[g_detail_idx].xcec101) 
               RETURNING g_xceb4_d[g_detail_idx].xcec101_desc



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec101
            #add-point:BEFORE FIELD xcec101 name="input.b.page4.xcec101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec101
            #add-point:ON CHANGE xcec101 name="input.g.page4.xcec101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec102
            #add-point:BEFORE FIELD xcec102 name="input.b.page4.xcec102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec102
            
            #add-point:AFTER FIELD xcec102 name="input.a.page4.xcec102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec102
            #add-point:ON CHANGE xcec102 name="input.g.page4.xcec102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec103
            
            #add-point:AFTER FIELD xcec103 name="input.a.page4.xcec103"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb4_d[l_ac].xceccomp
            LET g_ref_fields[2] = g_xceb4_d[l_ac].xcec103
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb4_d[l_ac].xcec103_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb4_d[l_ac].xcec103_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec103
            #add-point:BEFORE FIELD xcec103 name="input.b.page4.xcec103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec103
            #add-point:ON CHANGE xcec103 name="input.g.page4.xcec103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec117
            #add-point:BEFORE FIELD xcec117 name="input.b.page4.xcec117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec117
            
            #add-point:AFTER FIELD xcec117 name="input.a.page4.xcec117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec117
            #add-point:ON CHANGE xcec117 name="input.g.page4.xcec117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec114
            #add-point:BEFORE FIELD xcec114 name="input.b.page4.xcec114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec114
            
            #add-point:AFTER FIELD xcec114 name="input.a.page4.xcec114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec114
            #add-point:ON CHANGE xcec114 name="input.g.page4.xcec114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec119
            #add-point:BEFORE FIELD xcec119 name="input.b.page4.xcec119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec119
            
            #add-point:AFTER FIELD xcec119 name="input.a.page4.xcec119"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb4_d[l_ac].xcec119) THEN
               IF (g_xceb4_d[l_ac].xcec119 != g_xceb4_d_o.xcec119 OR g_xceb4_d_o.xcec119 IS NULL ) THEN
                  CALL s_aap_project_chk(g_xceb4_d[l_ac].xcec119) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xceb4_d[l_ac].xcec119
                     LET g_errparam.replace[1] ='apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog ='apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xceb4_d[l_ac].xcec119 = g_xceb4_d_o.xcec119
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_xceb4_d[l_ac].xcec101) THEN
                  CALL axct901_get_glad(g_xcea_m.xceald,g_xceb4_d[l_ac].xcec101) RETURNING l_glad015,l_glad016,l_glad012
                  IF l_glad015 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xceb4_d[l_ac].xcec101
                     LET g_errparam.code   = 'agl-00541'      
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()               
                  END IF  
               END IF                               
            END IF
            LET g_xceb4_d_o.xcec119 = g_xceb4_d[l_ac].xcec119
            #170227-00006#1---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec119
            #add-point:ON CHANGE xcec119 name="input.g.page4.xcec119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec120
            #add-point:BEFORE FIELD xcec120 name="input.b.page4.xcec120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec120
            
            #add-point:AFTER FIELD xcec120 name="input.a.page4.xcec120"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb4_d[l_ac].xcec120) THEN
               IF cl_null(g_xceb4_d[l_ac].xcec119) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00391'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()            
                  NEXT FIELD xcec119
               END IF            
               IF (g_xceb4_d[l_ac].xcec120 != g_xceb4_d_o.xcec120 OR g_xceb4_d_o.xcec120 IS NULL ) THEN
                  CALL s_voucher_glaq028_chk(g_xceb4_d[l_ac].xcec119,g_xceb4_d[l_ac].xcec120)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xceb4_d[l_ac].xcec120
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xceb4_d[l_ac].xcec120 = g_xceb4_d_o.xcec120
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_xceb4_d[l_ac].xcec101) THEN
                  CALL axct901_get_glad(g_xcea_m.xceald,g_xceb4_d[l_ac].xcec101) RETURNING l_glad015,l_glad016,l_glad012
                  IF l_glad016 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xceb4_d[l_ac].xcec101
                     LET g_errparam.code   = 'agl-00542'      
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()               
                  END IF  
               END IF                                
            END IF            
            LET g_xceb4_d_o.xcec120 = g_xceb4_d[l_ac].xcec120
            #170227-00006#1---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec120
            #add-point:ON CHANGE xcec120 name="input.g.page4.xcec120"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec107
            
            #add-point:AFTER FIELD xcec107 name="input.a.page4.xcec107"
            IF NOT cl_null(g_xceb4_d[l_ac].xcec107) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xceb4_d[l_ac].xcec107

                LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13         
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb4_d[l_ac].xcec107
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xceb4_d[l_ac].xcec107_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb4_d[l_ac].xcec107_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec107
            #add-point:BEFORE FIELD xcec107 name="input.b.page4.xcec107"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec107
            #add-point:ON CHANGE xcec107 name="input.g.page4.xcec107"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec108
            
            #add-point:AFTER FIELD xcec108 name="input.a.page4.xcec108"
            IF NOT cl_null(g_xceb4_d[l_ac].xcec108) THEN 
#150812-00010#3 mark--s
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_xceb4_d[l_ac].xcec108
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_ooeg001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#150812-00010#3 mark--e
               #150812-00010#3--s
               CALL s_department_chk(g_xceb4_d[l_ac].xcec108,g_xcea_m.xcea001) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xceb4_d[l_ac].xcec108      = g_xceb4_d_t.xcec108
                  LET g_xceb4_d[l_ac].xcec108_desc = g_xceb4_d_t.xcec108_desc
                  DISPLAY BY NAME g_xceb4_d[l_ac].xcec108,g_xceb4_d[l_ac].xcec108_desc
                  NEXT FIELD CURRENT
               END IF               
               #150812-00010#3150824 by 03538--e
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb4_d[l_ac].xcec108
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb4_d[l_ac].xcec108_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb4_d[l_ac].xcec108_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec108
            #add-point:BEFORE FIELD xcec108 name="input.b.page4.xcec108"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec108
            #add-point:ON CHANGE xcec108 name="input.g.page4.xcec108"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec109
            
            #add-point:AFTER FIELD xcec109 name="input.a.page4.xcec109"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb4_d[l_ac].xcec109
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb4_d[l_ac].xcec109_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb4_d[l_ac].xcec109_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec109
            #add-point:BEFORE FIELD xcec109 name="input.b.page4.xcec109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec109
            #add-point:ON CHANGE xcec109 name="input.g.page4.xcec109"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec111
            
            #add-point:AFTER FIELD xcec111 name="input.a.page4.xcec111"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xceb4_d[l_ac].xcec111
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xceb4_d[l_ac].xcec111_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xceb4_d[l_ac].xcec111_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec111
            #add-point:BEFORE FIELD xcec111 name="input.b.page4.xcec111"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec111
            #add-point:ON CHANGE xcec111 name="input.g.page4.xcec111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec113
            #add-point:BEFORE FIELD xcec113 name="input.b.page4.xcec113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec113
            
            #add-point:AFTER FIELD xcec113 name="input.a.page4.xcec113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec113
            #add-point:ON CHANGE xcec113 name="input.g.page4.xcec113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec121
            #add-point:BEFORE FIELD xcec121 name="input.b.page4.xcec121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec121
            
            #add-point:AFTER FIELD xcec121 name="input.a.page4.xcec121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec121
            #add-point:ON CHANGE xcec121 name="input.g.page4.xcec121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec122
            #add-point:BEFORE FIELD xcec122 name="input.b.page4.xcec122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec122
            
            #add-point:AFTER FIELD xcec122 name="input.a.page4.xcec122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec122
            #add-point:ON CHANGE xcec122 name="input.g.page4.xcec122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec123
            #add-point:BEFORE FIELD xcec123 name="input.b.page4.xcec123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec123
            
            #add-point:AFTER FIELD xcec123 name="input.a.page4.xcec123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec123
            #add-point:ON CHANGE xcec123 name="input.g.page4.xcec123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec124
            #add-point:BEFORE FIELD xcec124 name="input.b.page4.xcec124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec124
            
            #add-point:AFTER FIELD xcec124 name="input.a.page4.xcec124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec124
            #add-point:ON CHANGE xcec124 name="input.g.page4.xcec124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec125
            #add-point:BEFORE FIELD xcec125 name="input.b.page4.xcec125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec125
            
            #add-point:AFTER FIELD xcec125 name="input.a.page4.xcec125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec125
            #add-point:ON CHANGE xcec125 name="input.g.page4.xcec125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec126
            #add-point:BEFORE FIELD xcec126 name="input.b.page4.xcec126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec126
            
            #add-point:AFTER FIELD xcec126 name="input.a.page4.xcec126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec126
            #add-point:ON CHANGE xcec126 name="input.g.page4.xcec126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec127
            #add-point:BEFORE FIELD xcec127 name="input.b.page4.xcec127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec127
            
            #add-point:AFTER FIELD xcec127 name="input.a.page4.xcec127"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec127
            #add-point:ON CHANGE xcec127 name="input.g.page4.xcec127"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec128
            #add-point:BEFORE FIELD xcec128 name="input.b.page4.xcec128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec128
            
            #add-point:AFTER FIELD xcec128 name="input.a.page4.xcec128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec128
            #add-point:ON CHANGE xcec128 name="input.g.page4.xcec128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec129
            #add-point:BEFORE FIELD xcec129 name="input.b.page4.xcec129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec129
            
            #add-point:AFTER FIELD xcec129 name="input.a.page4.xcec129"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec129
            #add-point:ON CHANGE xcec129 name="input.g.page4.xcec129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec130
            #add-point:BEFORE FIELD xcec130 name="input.b.page4.xcec130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec130
            
            #add-point:AFTER FIELD xcec130 name="input.a.page4.xcec130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec130
            #add-point:ON CHANGE xcec130 name="input.g.page4.xcec130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec201
            #add-point:BEFORE FIELD xcec201 name="input.b.page4.xcec201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec201
            
            #add-point:AFTER FIELD xcec201 name="input.a.page4.xcec201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec201
            #add-point:ON CHANGE xcec201 name="input.g.page4.xcec201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202
            #add-point:BEFORE FIELD xcec202 name="input.b.page4.xcec202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202
            
            #add-point:AFTER FIELD xcec202 name="input.a.page4.xcec202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202
            #add-point:ON CHANGE xcec202 name="input.g.page4.xcec202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202a
            #add-point:BEFORE FIELD xcec202a name="input.b.page4.xcec202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202a
            
            #add-point:AFTER FIELD xcec202a name="input.a.page4.xcec202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202a
            #add-point:ON CHANGE xcec202a name="input.g.page4.xcec202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202b
            #add-point:BEFORE FIELD xcec202b name="input.b.page4.xcec202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202b
            
            #add-point:AFTER FIELD xcec202b name="input.a.page4.xcec202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202b
            #add-point:ON CHANGE xcec202b name="input.g.page4.xcec202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202c
            #add-point:BEFORE FIELD xcec202c name="input.b.page4.xcec202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202c
            
            #add-point:AFTER FIELD xcec202c name="input.a.page4.xcec202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202c
            #add-point:ON CHANGE xcec202c name="input.g.page4.xcec202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202d
            #add-point:BEFORE FIELD xcec202d name="input.b.page4.xcec202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202d
            
            #add-point:AFTER FIELD xcec202d name="input.a.page4.xcec202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202d
            #add-point:ON CHANGE xcec202d name="input.g.page4.xcec202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202e
            #add-point:BEFORE FIELD xcec202e name="input.b.page4.xcec202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202e
            
            #add-point:AFTER FIELD xcec202e name="input.a.page4.xcec202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202e
            #add-point:ON CHANGE xcec202e name="input.g.page4.xcec202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202f
            #add-point:BEFORE FIELD xcec202f name="input.b.page4.xcec202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202f
            
            #add-point:AFTER FIELD xcec202f name="input.a.page4.xcec202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202f
            #add-point:ON CHANGE xcec202f name="input.g.page4.xcec202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202g
            #add-point:BEFORE FIELD xcec202g name="input.b.page4.xcec202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202g
            
            #add-point:AFTER FIELD xcec202g name="input.a.page4.xcec202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202g
            #add-point:ON CHANGE xcec202g name="input.g.page4.xcec202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec202h
            #add-point:BEFORE FIELD xcec202h name="input.b.page4.xcec202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec202h
            
            #add-point:AFTER FIELD xcec202h name="input.a.page4.xcec202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec202h
            #add-point:ON CHANGE xcec202h name="input.g.page4.xcec202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212
            #add-point:BEFORE FIELD xcec212 name="input.b.page4.xcec212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212
            
            #add-point:AFTER FIELD xcec212 name="input.a.page4.xcec212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212
            #add-point:ON CHANGE xcec212 name="input.g.page4.xcec212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212a
            #add-point:BEFORE FIELD xcec212a name="input.b.page4.xcec212a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212a
            
            #add-point:AFTER FIELD xcec212a name="input.a.page4.xcec212a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212a
            #add-point:ON CHANGE xcec212a name="input.g.page4.xcec212a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212b
            #add-point:BEFORE FIELD xcec212b name="input.b.page4.xcec212b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212b
            
            #add-point:AFTER FIELD xcec212b name="input.a.page4.xcec212b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212b
            #add-point:ON CHANGE xcec212b name="input.g.page4.xcec212b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212c
            #add-point:BEFORE FIELD xcec212c name="input.b.page4.xcec212c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212c
            
            #add-point:AFTER FIELD xcec212c name="input.a.page4.xcec212c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212c
            #add-point:ON CHANGE xcec212c name="input.g.page4.xcec212c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212d
            #add-point:BEFORE FIELD xcec212d name="input.b.page4.xcec212d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212d
            
            #add-point:AFTER FIELD xcec212d name="input.a.page4.xcec212d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212d
            #add-point:ON CHANGE xcec212d name="input.g.page4.xcec212d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212e
            #add-point:BEFORE FIELD xcec212e name="input.b.page4.xcec212e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212e
            
            #add-point:AFTER FIELD xcec212e name="input.a.page4.xcec212e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212e
            #add-point:ON CHANGE xcec212e name="input.g.page4.xcec212e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212f
            #add-point:BEFORE FIELD xcec212f name="input.b.page4.xcec212f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212f
            
            #add-point:AFTER FIELD xcec212f name="input.a.page4.xcec212f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212f
            #add-point:ON CHANGE xcec212f name="input.g.page4.xcec212f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212g
            #add-point:BEFORE FIELD xcec212g name="input.b.page4.xcec212g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212g
            
            #add-point:AFTER FIELD xcec212g name="input.a.page4.xcec212g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212g
            #add-point:ON CHANGE xcec212g name="input.g.page4.xcec212g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec212h
            #add-point:BEFORE FIELD xcec212h name="input.b.page4.xcec212h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec212h
            
            #add-point:AFTER FIELD xcec212h name="input.a.page4.xcec212h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec212h
            #add-point:ON CHANGE xcec212h name="input.g.page4.xcec212h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222
            #add-point:BEFORE FIELD xcec222 name="input.b.page4.xcec222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222
            
            #add-point:AFTER FIELD xcec222 name="input.a.page4.xcec222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222
            #add-point:ON CHANGE xcec222 name="input.g.page4.xcec222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222a
            #add-point:BEFORE FIELD xcec222a name="input.b.page4.xcec222a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222a
            
            #add-point:AFTER FIELD xcec222a name="input.a.page4.xcec222a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222a
            #add-point:ON CHANGE xcec222a name="input.g.page4.xcec222a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222b
            #add-point:BEFORE FIELD xcec222b name="input.b.page4.xcec222b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222b
            
            #add-point:AFTER FIELD xcec222b name="input.a.page4.xcec222b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222b
            #add-point:ON CHANGE xcec222b name="input.g.page4.xcec222b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222c
            #add-point:BEFORE FIELD xcec222c name="input.b.page4.xcec222c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222c
            
            #add-point:AFTER FIELD xcec222c name="input.a.page4.xcec222c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222c
            #add-point:ON CHANGE xcec222c name="input.g.page4.xcec222c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222d
            #add-point:BEFORE FIELD xcec222d name="input.b.page4.xcec222d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222d
            
            #add-point:AFTER FIELD xcec222d name="input.a.page4.xcec222d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222d
            #add-point:ON CHANGE xcec222d name="input.g.page4.xcec222d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222e
            #add-point:BEFORE FIELD xcec222e name="input.b.page4.xcec222e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222e
            
            #add-point:AFTER FIELD xcec222e name="input.a.page4.xcec222e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222e
            #add-point:ON CHANGE xcec222e name="input.g.page4.xcec222e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222f
            #add-point:BEFORE FIELD xcec222f name="input.b.page4.xcec222f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222f
            
            #add-point:AFTER FIELD xcec222f name="input.a.page4.xcec222f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222f
            #add-point:ON CHANGE xcec222f name="input.g.page4.xcec222f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222g
            #add-point:BEFORE FIELD xcec222g name="input.b.page4.xcec222g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222g
            
            #add-point:AFTER FIELD xcec222g name="input.a.page4.xcec222g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222g
            #add-point:ON CHANGE xcec222g name="input.g.page4.xcec222g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec222h
            #add-point:BEFORE FIELD xcec222h name="input.b.page4.xcec222h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec222h
            
            #add-point:AFTER FIELD xcec222h name="input.a.page4.xcec222h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec222h
            #add-point:ON CHANGE xcec222h name="input.g.page4.xcec222h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec301
            #add-point:BEFORE FIELD xcec301 name="input.b.page4.xcec301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec301
            
            #add-point:AFTER FIELD xcec301 name="input.a.page4.xcec301"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec301
            #add-point:ON CHANGE xcec301 name="input.g.page4.xcec301"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcec302
            #add-point:BEFORE FIELD xcec302 name="input.b.page4.xcec302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcec302
            
            #add-point:AFTER FIELD xcec302 name="input.a.page4.xcec302"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcec302
            #add-point:ON CHANGE xcec302 name="input.g.page4.xcec302"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceccomp
            #add-point:BEFORE FIELD xceccomp name="input.b.page4.xceccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceccomp
            
            #add-point:AFTER FIELD xceccomp name="input.a.page4.xceccomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceccomp
            #add-point:ON CHANGE xceccomp name="input.g.page4.xceccomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.xcecseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcecseq
            #add-point:ON ACTION controlp INFIELD xcecseq name="input.c.page4.xcecseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec001
            #add-point:ON ACTION controlp INFIELD xcec001 name="input.c.page4.xcec001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_sfaadocno()                               #呼叫開窗

            LET g_xceb4_d[l_ac].xcec001 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec001 TO xcec001              #

            NEXT FIELD xcec001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec003
            #add-point:ON ACTION controlp INFIELD xcec003 name="input.c.page4.xcec003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec004
            #add-point:ON ACTION controlp INFIELD xcec004 name="input.c.page4.xcec004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec004 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec004 TO xcec004              #

            NEXT FIELD xcec004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec005
            #add-point:ON ACTION controlp INFIELD xcec005 name="input.c.page4.xcec005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec101
            #add-point:ON ACTION controlp INFIELD xcec101 name="input.c.page4.xcec101"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec101             #給予default值
            
            SELECT glaa004 INTO g_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
             
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "
            #151117-00009#1--add--str--
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_xcea_m.xceald,"'",
                                   "                    AND gladstus='Y' )"
            #151117-00009#1--add--end
 
            CALL aglt310_04()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec101 = g_qryparam.return1              

            CALL axct901_get_xceb101_desc(g_xceb4_d[l_ac].xcec101)
              RETURNING g_xceb4_d[l_ac].xcec101_desc  
            
            DISPLAY g_xceb4_d[l_ac].xcec101 TO xcec101              #
            DISPLAY g_xceb4_d[l_ac].xcec101_desc TO xcec101_desc 
            NEXT FIELD xcec101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec102
            #add-point:ON ACTION controlp INFIELD xcec102 name="input.c.page4.xcec102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec103
            #add-point:ON ACTION controlp INFIELD xcec103 name="input.c.page4.xcec103"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec103             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec103 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec103 TO xcec103              #

            NEXT FIELD xcec103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec117
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec117
            #add-point:ON ACTION controlp INFIELD xcec117 name="input.c.page4.xcec117"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec117             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_imag011()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec117 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec117 TO xcec117              #

            NEXT FIELD xcec117                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec114
            #add-point:ON ACTION controlp INFIELD xcec114 name="input.c.page4.xcec114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec119
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec119
            #add-point:ON ACTION controlp INFIELD xcec119 name="input.c.page4.xcec119"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec119             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec119 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec119 TO xcec119              #

            NEXT FIELD xcec119                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec120
            #add-point:ON ACTION controlp INFIELD xcec120 name="input.c.page4.xcec120"
            #此段落由子樣板a07產生            
            #開窗i段
            #170227-00006#1---s
            IF cl_null(g_xceb4_d[l_ac].xcec119) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00391'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD xcec119
            END IF                         
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec120             #給予default值
            LET g_qryparam.arg1 = g_xceb4_d[l_ac].xcec119                  
            CALL q_pjbb002_2()                                   #呼叫開窗
            LET g_xceb4_d[l_ac].xcec120 = g_qryparam.return1        
            DISPLAY g_xceb4_d[l_ac].xcec120 TO xcec120              #
            NEXT FIELD xcec120   
            #170227-00006#1---e

            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec107
            #add-point:ON ACTION controlp INFIELD xcec107 name="input.c.page4.xcec107"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec107             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec107 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec107 TO xcec107              #

            NEXT FIELD xcec107                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec108
            #add-point:ON ACTION controlp INFIELD xcec108 name="input.c.page4.xcec108"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec108             #給予default值
            LET g_qryparam.default2 = "" #g_xceb4_d[l_ac].ooeg001 #部門編號
            #給予arg
           #LET g_qryparam.arg1 = "" #                      #150812-00010#3 mark
           #CALL q_ooeg001()                                #150812-00010#3 mark
            LET g_qryparam.arg1 = g_xcea_m.xcea001          #150812-00010#3
            CALL q_ooeg001_4()                              #150812-00010#3           

            LET g_xceb4_d[l_ac].xcec108 = g_qryparam.return1              
            #LET g_xceb4_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_xceb4_d[l_ac].xcec108 TO xcec108              #
            #DISPLAY g_xceb4_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD xcec108                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec109
            #add-point:ON ACTION controlp INFIELD xcec109 name="input.c.page4.xcec109"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec109             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_7()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec109 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec109 TO xcec109              #

            NEXT FIELD xcec109                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec111
            #add-point:ON ACTION controlp INFIELD xcec111 name="input.c.page4.xcec111"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb4_d[l_ac].xcec111             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_7()                                #呼叫開窗

            LET g_xceb4_d[l_ac].xcec111 = g_qryparam.return1              

            DISPLAY g_xceb4_d[l_ac].xcec111 TO xcec111              #

            NEXT FIELD xcec111                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec113
            #add-point:ON ACTION controlp INFIELD xcec113 name="input.c.page4.xcec113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec121
            #add-point:ON ACTION controlp INFIELD xcec121 name="input.c.page4.xcec121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec122
            #add-point:ON ACTION controlp INFIELD xcec122 name="input.c.page4.xcec122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec123
            #add-point:ON ACTION controlp INFIELD xcec123 name="input.c.page4.xcec123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec124
            #add-point:ON ACTION controlp INFIELD xcec124 name="input.c.page4.xcec124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec125
            #add-point:ON ACTION controlp INFIELD xcec125 name="input.c.page4.xcec125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec126
            #add-point:ON ACTION controlp INFIELD xcec126 name="input.c.page4.xcec126"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec127
            #add-point:ON ACTION controlp INFIELD xcec127 name="input.c.page4.xcec127"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec128
            #add-point:ON ACTION controlp INFIELD xcec128 name="input.c.page4.xcec128"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec129
            #add-point:ON ACTION controlp INFIELD xcec129 name="input.c.page4.xcec129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec130
            #add-point:ON ACTION controlp INFIELD xcec130 name="input.c.page4.xcec130"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec201
            #add-point:ON ACTION controlp INFIELD xcec201 name="input.c.page4.xcec201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202
            #add-point:ON ACTION controlp INFIELD xcec202 name="input.c.page4.xcec202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202a
            #add-point:ON ACTION controlp INFIELD xcec202a name="input.c.page4.xcec202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202b
            #add-point:ON ACTION controlp INFIELD xcec202b name="input.c.page4.xcec202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202c
            #add-point:ON ACTION controlp INFIELD xcec202c name="input.c.page4.xcec202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202d
            #add-point:ON ACTION controlp INFIELD xcec202d name="input.c.page4.xcec202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202e
            #add-point:ON ACTION controlp INFIELD xcec202e name="input.c.page4.xcec202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202f
            #add-point:ON ACTION controlp INFIELD xcec202f name="input.c.page4.xcec202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202g
            #add-point:ON ACTION controlp INFIELD xcec202g name="input.c.page4.xcec202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec202h
            #add-point:ON ACTION controlp INFIELD xcec202h name="input.c.page4.xcec202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212
            #add-point:ON ACTION controlp INFIELD xcec212 name="input.c.page4.xcec212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212a
            #add-point:ON ACTION controlp INFIELD xcec212a name="input.c.page4.xcec212a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212b
            #add-point:ON ACTION controlp INFIELD xcec212b name="input.c.page4.xcec212b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212c
            #add-point:ON ACTION controlp INFIELD xcec212c name="input.c.page4.xcec212c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212d
            #add-point:ON ACTION controlp INFIELD xcec212d name="input.c.page4.xcec212d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212e
            #add-point:ON ACTION controlp INFIELD xcec212e name="input.c.page4.xcec212e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212f
            #add-point:ON ACTION controlp INFIELD xcec212f name="input.c.page4.xcec212f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212g
            #add-point:ON ACTION controlp INFIELD xcec212g name="input.c.page4.xcec212g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec212h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec212h
            #add-point:ON ACTION controlp INFIELD xcec212h name="input.c.page4.xcec212h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222
            #add-point:ON ACTION controlp INFIELD xcec222 name="input.c.page4.xcec222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222a
            #add-point:ON ACTION controlp INFIELD xcec222a name="input.c.page4.xcec222a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222b
            #add-point:ON ACTION controlp INFIELD xcec222b name="input.c.page4.xcec222b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222c
            #add-point:ON ACTION controlp INFIELD xcec222c name="input.c.page4.xcec222c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222d
            #add-point:ON ACTION controlp INFIELD xcec222d name="input.c.page4.xcec222d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222e
            #add-point:ON ACTION controlp INFIELD xcec222e name="input.c.page4.xcec222e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222f
            #add-point:ON ACTION controlp INFIELD xcec222f name="input.c.page4.xcec222f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222g
            #add-point:ON ACTION controlp INFIELD xcec222g name="input.c.page4.xcec222g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec222h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec222h
            #add-point:ON ACTION controlp INFIELD xcec222h name="input.c.page4.xcec222h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec301
            #add-point:ON ACTION controlp INFIELD xcec301 name="input.c.page4.xcec301"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xcec302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcec302
            #add-point:ON ACTION controlp INFIELD xcec302 name="input.c.page4.xcec302"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xceccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceccomp
            #add-point:ON ACTION controlp INFIELD xceccomp name="input.c.page4.xceccomp"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body4.after_row"
            #170227-00006#1---s
            IF NOT cl_null(g_xceb4_d[l_ac].xcec101) THEN
               CALL axct901_get_glad(g_xcea_m.xceald,g_xceb4_d[l_ac].xcec101) RETURNING l_glad015,l_glad016,l_glad012          
               IF cl_null(g_xceb4_d[l_ac].xcec119) AND l_glad015 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xceb4_d[l_ac].xcec101
                  LET g_errparam.code   = 'agl-00541'      
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
               END IF   
               IF cl_null(g_xceb4_d[l_ac].xcec120) AND l_glad016 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xceb4_d[l_ac].xcec101
                  LET g_errparam.code   = 'agl-00542'      
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
               END IF  
            END IF 
            #170227-00006#1---e
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xceb4_d[l_ac].* = g_xceb4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct901_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axct901_unlock_b("xcec_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            CALL axct901_b_fill5()
            CALL axct901_b_fill6()
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xceb4_d[li_reproduce_target].* = g_xceb4_d[li_reproduce].*
 
               LET g_xceb4_d[li_reproduce_target].xcecseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xceb4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xceb4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xceb8_d FROM s_detail8.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body8.before_input2"
            
            #end add-point
            
            CALL axct901_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xceb8_d.getLength()
            #add-point:資料輸入前 name="input.body8.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xceb8_d[l_ac].* TO NULL 
            INITIALIZE g_xceb8_d_t.* TO NULL 
            INITIALIZE g_xceb8_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body8.insert.before_bak"
            
            #end add-point
            LET g_xceb8_d_t.* = g_xceb8_d[l_ac].*     #新輸入資料
            LET g_xceb8_d_o.* = g_xceb8_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct901_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body8.insert.after_set_entry_b"
            
            #end add-point
            CALL axct901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xceb_d[li_reproduce_target].* = g_xceb_d[li_reproduce].*
               LET g_xceb8_d[li_reproduce_target].* = g_xceb8_d[li_reproduce].*
 
               LET g_xceb8_d[li_reproduce_target].xcebseq = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body8.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body8.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xceb8_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xceb8_d[l_ac].xcebseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xceb8_d_t.* = g_xceb8_d[l_ac].*  #BACKUP
               LET g_xceb8_d_o.* = g_xceb8_d[l_ac].*  #BACKUP
               CALL axct901_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body8.after_set_entry_b"
               
               #end add-point  
               CALL axct901_set_no_entry_b(l_cmd)
               IF NOT axct901_lock_b("xceb_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct901_bcl INTO g_xceb_d[l_ac].xcebseq,g_xceb_d[l_ac].xceb001,g_xceb_d[l_ac].xceb003, 
                      g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005,g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb102, 
                      g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb110,g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118, 
                      g_xceb_d[l_ac].xceb114,g_xceb_d[l_ac].xceb115,g_xceb_d[l_ac].xceb116,g_xceb_d[l_ac].xceb119, 
                      g_xceb_d[l_ac].xceb120,g_xceb_d[l_ac].xceb107,g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109, 
                      g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb112,g_xceb_d[l_ac].xceb113,g_xceb_d[l_ac].xceb121, 
                      g_xceb_d[l_ac].xceb122,g_xceb_d[l_ac].xceb123,g_xceb_d[l_ac].xceb124,g_xceb_d[l_ac].xceb125, 
                      g_xceb_d[l_ac].xceb126,g_xceb_d[l_ac].xceb127,g_xceb_d[l_ac].xceb128,g_xceb_d[l_ac].xceb129, 
                      g_xceb_d[l_ac].xceb130,g_xceb_d[l_ac].xceb201,g_xceb_d[l_ac].xceb202,g_xceb_d[l_ac].xceb202a, 
                      g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c,g_xceb_d[l_ac].xceb202d,g_xceb_d[l_ac].xceb202e, 
                      g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g,g_xceb_d[l_ac].xceb202h,g_xceb_d[l_ac].xceb212, 
                      g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b,g_xceb_d[l_ac].xceb212c,g_xceb_d[l_ac].xceb212d, 
                      g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f,g_xceb_d[l_ac].xceb212g,g_xceb_d[l_ac].xceb212h, 
                      g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a,g_xceb_d[l_ac].xceb222b,g_xceb_d[l_ac].xceb222c, 
                      g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e,g_xceb_d[l_ac].xceb222f,g_xceb_d[l_ac].xceb222g, 
                      g_xceb_d[l_ac].xceb222h,g_xceb_d[l_ac].xceb301,g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp, 
                      g_xceb8_d[l_ac].xcebseq,g_xceb8_d[l_ac].xceb117,g_xceb8_d[l_ac].xceb115,g_xceb8_d[l_ac].xceb202, 
                      g_xceb8_d[l_ac].xceb202a,g_xceb8_d[l_ac].xceb202b,g_xceb8_d[l_ac].xceb202c,g_xceb8_d[l_ac].xceb202d, 
                      g_xceb8_d[l_ac].xceb202e,g_xceb8_d[l_ac].xceb202f,g_xceb8_d[l_ac].xceb202g,g_xceb8_d[l_ac].xceb202h, 
                      g_xceb8_d[l_ac].xceb212,g_xceb8_d[l_ac].xceb212a,g_xceb8_d[l_ac].xceb212b,g_xceb8_d[l_ac].xceb212c, 
                      g_xceb8_d[l_ac].xceb212d,g_xceb8_d[l_ac].xceb212e,g_xceb8_d[l_ac].xceb212f,g_xceb8_d[l_ac].xceb212g, 
                      g_xceb8_d[l_ac].xceb212h,g_xceb8_d[l_ac].xceb222,g_xceb8_d[l_ac].xceb222a,g_xceb8_d[l_ac].xceb222b, 
                      g_xceb8_d[l_ac].xceb222c,g_xceb8_d[l_ac].xceb222d,g_xceb8_d[l_ac].xceb222e,g_xceb8_d[l_ac].xceb222f, 
                      g_xceb8_d[l_ac].xceb222g,g_xceb8_d[l_ac].xceb222h
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xceb8_d_mask_o[l_ac].* =  g_xceb8_d[l_ac].*
                  CALL axct901_xceb_t_mask()
                  LET g_xceb8_d_mask_n[l_ac].* =  g_xceb8_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axct901_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body8.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body8.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body8.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body8.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xcea_m.xceald
               LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
               LET gs_keys[gs_keys.getLength()+1] = g_xceb8_d_t.xcebseq
            
               #刪除同層單身
               IF NOT axct901_delete_b('xceb_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axct901_key_delete_b(gs_keys,'xceb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct901_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身3刪除中 name="input.body8.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axct901_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body8.a_delete"
               
               #end add-point
               LET l_count = g_xceb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body8.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xceb8_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body8.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xceb_t 
             WHERE xcebent = g_enterprise AND xcebld = g_xcea_m.xceald
               AND xcebdocno = g_xcea_m.xceadocno
               AND xcebseq = g_xceb8_d[l_ac].xcebseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body8.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys[3] = g_xceb8_d[g_detail_idx].xcebseq
               CALL axct901_insert_b('xceb_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body8.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xceb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axct901_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body8.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xceb8_d[l_ac].* = g_xceb8_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct901_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xceb8_d[l_ac].* = g_xceb8_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body8.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL axct901_xceb_t_mask_restore('restore_mask_o')
                              
               UPDATE xceb_t SET (xcebld,xcebdocno,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102, 
                   xceb103,xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108, 
                   xceb109,xceb111,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127, 
                   xceb128,xceb129,xceb130,xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e, 
                   xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f, 
                   xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g, 
                   xceb222h,xceb301,xceb302,xcebcomp) = (g_xcea_m.xceald,g_xcea_m.xceadocno,g_xceb_d[l_ac].xcebseq, 
                   g_xceb_d[l_ac].xceb001,g_xceb_d[l_ac].xceb003,g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005, 
                   g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb102,g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb110, 
                   g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118,g_xceb_d[l_ac].xceb114,g_xceb_d[l_ac].xceb115, 
                   g_xceb_d[l_ac].xceb116,g_xceb_d[l_ac].xceb119,g_xceb_d[l_ac].xceb120,g_xceb_d[l_ac].xceb107, 
                   g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109,g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb112, 
                   g_xceb_d[l_ac].xceb113,g_xceb_d[l_ac].xceb121,g_xceb_d[l_ac].xceb122,g_xceb_d[l_ac].xceb123, 
                   g_xceb_d[l_ac].xceb124,g_xceb_d[l_ac].xceb125,g_xceb_d[l_ac].xceb126,g_xceb_d[l_ac].xceb127, 
                   g_xceb_d[l_ac].xceb128,g_xceb_d[l_ac].xceb129,g_xceb_d[l_ac].xceb130,g_xceb_d[l_ac].xceb201, 
                   g_xceb_d[l_ac].xceb202,g_xceb_d[l_ac].xceb202a,g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c, 
                   g_xceb_d[l_ac].xceb202d,g_xceb_d[l_ac].xceb202e,g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g, 
                   g_xceb_d[l_ac].xceb202h,g_xceb_d[l_ac].xceb212,g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b, 
                   g_xceb_d[l_ac].xceb212c,g_xceb_d[l_ac].xceb212d,g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f, 
                   g_xceb_d[l_ac].xceb212g,g_xceb_d[l_ac].xceb212h,g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a, 
                   g_xceb_d[l_ac].xceb222b,g_xceb_d[l_ac].xceb222c,g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e, 
                   g_xceb_d[l_ac].xceb222f,g_xceb_d[l_ac].xceb222g,g_xceb_d[l_ac].xceb222h,g_xceb_d[l_ac].xceb301, 
                   g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp) #自訂欄位頁簽
                WHERE xcebent = g_enterprise AND xcebld = g_xcea_m.xceald
                  AND xcebdocno = g_xcea_m.xceadocno
                  AND xcebseq = g_xceb8_d_t.xcebseq #項次 
                  
               #add-point:單身page3修改中 name="input.body8.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xceb8_d[l_ac].* = g_xceb8_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xceb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xceb8_d[l_ac].* = g_xceb8_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcea_m.xceald
               LET gs_keys_bak[1] = g_xceald_t
               LET gs_keys[2] = g_xcea_m.xceadocno
               LET gs_keys_bak[2] = g_xceadocno_t
               LET gs_keys[3] = g_xceb8_d[g_detail_idx].xcebseq
               LET gs_keys_bak[3] = g_xceb8_d_t.xcebseq
               CALL axct901_update_b('xceb_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct901_xceb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xceb8_d[g_detail_idx].xcebseq = g_xceb8_d_t.xcebseq 
                  ) THEN
                  LET gs_keys[01] = g_xcea_m.xceald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcea_m.xceadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xceb8_d_t.xcebseq
                  CALL axct901_key_update_b(gs_keys,'xceb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb8_d_t)
               LET g_log2 = util.JSON.stringify(g_xcea_m),util.JSON.stringify(g_xceb8_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body8.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcebseq_3
            #add-point:BEFORE FIELD xcebseq_3 name="input.b.page8.xcebseq_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcebseq_3
            
            #add-point:AFTER FIELD xcebseq_3 name="input.a.page8.xcebseq_3"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcea_m.xceald IS NOT NULL AND g_xcea_m.xceadocno IS NOT NULL AND g_xceb8_d[g_detail_idx].xcebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcea_m.xceald != g_xceald_t OR g_xcea_m.xceadocno != g_xceadocno_t OR g_xceb8_d[g_detail_idx].xcebseq != g_xceb8_d_t.xcebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xceb_t WHERE "||"xcebent = '" ||g_enterprise|| "' AND "||"xcebld = '"||g_xcea_m.xceald ||"' AND "|| "xcebdocno = '"||g_xcea_m.xceadocno ||"' AND "|| "xcebseq = '"||g_xceb8_d[g_detail_idx].xcebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcebseq_3
            #add-point:ON CHANGE xcebseq_3 name="input.g.page8.xcebseq_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb117_3
            #add-point:BEFORE FIELD xceb117_3 name="input.b.page8.xceb117_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb117_3
            
            #add-point:AFTER FIELD xceb117_3 name="input.a.page8.xceb117_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb117_3
            #add-point:ON CHANGE xceb117_3 name="input.g.page8.xceb117_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb115_3
            #add-point:BEFORE FIELD xceb115_3 name="input.b.page8.xceb115_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb115_3
            
            #add-point:AFTER FIELD xceb115_3 name="input.a.page8.xceb115_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb115_3
            #add-point:ON CHANGE xceb115_3 name="input.g.page8.xceb115_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202_3
            #add-point:BEFORE FIELD xceb202_3 name="input.b.page8.xceb202_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202_3
            
            #add-point:AFTER FIELD xceb202_3 name="input.a.page8.xceb202_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202_3
            #add-point:ON CHANGE xceb202_3 name="input.g.page8.xceb202_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202a_3
            #add-point:BEFORE FIELD xceb202a_3 name="input.b.page8.xceb202a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202a_3
            
            #add-point:AFTER FIELD xceb202a_3 name="input.a.page8.xceb202a_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202a_3
            #add-point:ON CHANGE xceb202a_3 name="input.g.page8.xceb202a_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202b_3
            #add-point:BEFORE FIELD xceb202b_3 name="input.b.page8.xceb202b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202b_3
            
            #add-point:AFTER FIELD xceb202b_3 name="input.a.page8.xceb202b_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202b_3
            #add-point:ON CHANGE xceb202b_3 name="input.g.page8.xceb202b_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202c_3
            #add-point:BEFORE FIELD xceb202c_3 name="input.b.page8.xceb202c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202c_3
            
            #add-point:AFTER FIELD xceb202c_3 name="input.a.page8.xceb202c_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202c_3
            #add-point:ON CHANGE xceb202c_3 name="input.g.page8.xceb202c_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202d_3
            #add-point:BEFORE FIELD xceb202d_3 name="input.b.page8.xceb202d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202d_3
            
            #add-point:AFTER FIELD xceb202d_3 name="input.a.page8.xceb202d_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202d_3
            #add-point:ON CHANGE xceb202d_3 name="input.g.page8.xceb202d_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202e_3
            #add-point:BEFORE FIELD xceb202e_3 name="input.b.page8.xceb202e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202e_3
            
            #add-point:AFTER FIELD xceb202e_3 name="input.a.page8.xceb202e_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202e_3
            #add-point:ON CHANGE xceb202e_3 name="input.g.page8.xceb202e_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202f_3
            #add-point:BEFORE FIELD xceb202f_3 name="input.b.page8.xceb202f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202f_3
            
            #add-point:AFTER FIELD xceb202f_3 name="input.a.page8.xceb202f_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202f_3
            #add-point:ON CHANGE xceb202f_3 name="input.g.page8.xceb202f_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202g_3
            #add-point:BEFORE FIELD xceb202g_3 name="input.b.page8.xceb202g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202g_3
            
            #add-point:AFTER FIELD xceb202g_3 name="input.a.page8.xceb202g_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202g_3
            #add-point:ON CHANGE xceb202g_3 name="input.g.page8.xceb202g_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb202h_3
            #add-point:BEFORE FIELD xceb202h_3 name="input.b.page8.xceb202h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb202h_3
            
            #add-point:AFTER FIELD xceb202h_3 name="input.a.page8.xceb202h_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb202h_3
            #add-point:ON CHANGE xceb202h_3 name="input.g.page8.xceb202h_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212_3
            #add-point:BEFORE FIELD xceb212_3 name="input.b.page8.xceb212_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212_3
            
            #add-point:AFTER FIELD xceb212_3 name="input.a.page8.xceb212_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212_3
            #add-point:ON CHANGE xceb212_3 name="input.g.page8.xceb212_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212a_3
            #add-point:BEFORE FIELD xceb212a_3 name="input.b.page8.xceb212a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212a_3
            
            #add-point:AFTER FIELD xceb212a_3 name="input.a.page8.xceb212a_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212a_3
            #add-point:ON CHANGE xceb212a_3 name="input.g.page8.xceb212a_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212b_3
            #add-point:BEFORE FIELD xceb212b_3 name="input.b.page8.xceb212b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212b_3
            
            #add-point:AFTER FIELD xceb212b_3 name="input.a.page8.xceb212b_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212b_3
            #add-point:ON CHANGE xceb212b_3 name="input.g.page8.xceb212b_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212c_3
            #add-point:BEFORE FIELD xceb212c_3 name="input.b.page8.xceb212c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212c_3
            
            #add-point:AFTER FIELD xceb212c_3 name="input.a.page8.xceb212c_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212c_3
            #add-point:ON CHANGE xceb212c_3 name="input.g.page8.xceb212c_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212d_3
            #add-point:BEFORE FIELD xceb212d_3 name="input.b.page8.xceb212d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212d_3
            
            #add-point:AFTER FIELD xceb212d_3 name="input.a.page8.xceb212d_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212d_3
            #add-point:ON CHANGE xceb212d_3 name="input.g.page8.xceb212d_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212e_3
            #add-point:BEFORE FIELD xceb212e_3 name="input.b.page8.xceb212e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212e_3
            
            #add-point:AFTER FIELD xceb212e_3 name="input.a.page8.xceb212e_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212e_3
            #add-point:ON CHANGE xceb212e_3 name="input.g.page8.xceb212e_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212f_3
            #add-point:BEFORE FIELD xceb212f_3 name="input.b.page8.xceb212f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212f_3
            
            #add-point:AFTER FIELD xceb212f_3 name="input.a.page8.xceb212f_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212f_3
            #add-point:ON CHANGE xceb212f_3 name="input.g.page8.xceb212f_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212g_3
            #add-point:BEFORE FIELD xceb212g_3 name="input.b.page8.xceb212g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212g_3
            
            #add-point:AFTER FIELD xceb212g_3 name="input.a.page8.xceb212g_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212g_3
            #add-point:ON CHANGE xceb212g_3 name="input.g.page8.xceb212g_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb212h_3
            #add-point:BEFORE FIELD xceb212h_3 name="input.b.page8.xceb212h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb212h_3
            
            #add-point:AFTER FIELD xceb212h_3 name="input.a.page8.xceb212h_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb212h_3
            #add-point:ON CHANGE xceb212h_3 name="input.g.page8.xceb212h_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222_3
            #add-point:BEFORE FIELD xceb222_3 name="input.b.page8.xceb222_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222_3
            
            #add-point:AFTER FIELD xceb222_3 name="input.a.page8.xceb222_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222_3
            #add-point:ON CHANGE xceb222_3 name="input.g.page8.xceb222_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222a_3
            #add-point:BEFORE FIELD xceb222a_3 name="input.b.page8.xceb222a_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222a_3
            
            #add-point:AFTER FIELD xceb222a_3 name="input.a.page8.xceb222a_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222a_3
            #add-point:ON CHANGE xceb222a_3 name="input.g.page8.xceb222a_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222b_3
            #add-point:BEFORE FIELD xceb222b_3 name="input.b.page8.xceb222b_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222b_3
            
            #add-point:AFTER FIELD xceb222b_3 name="input.a.page8.xceb222b_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222b_3
            #add-point:ON CHANGE xceb222b_3 name="input.g.page8.xceb222b_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222c_3
            #add-point:BEFORE FIELD xceb222c_3 name="input.b.page8.xceb222c_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222c_3
            
            #add-point:AFTER FIELD xceb222c_3 name="input.a.page8.xceb222c_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222c_3
            #add-point:ON CHANGE xceb222c_3 name="input.g.page8.xceb222c_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222d_3
            #add-point:BEFORE FIELD xceb222d_3 name="input.b.page8.xceb222d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222d_3
            
            #add-point:AFTER FIELD xceb222d_3 name="input.a.page8.xceb222d_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222d_3
            #add-point:ON CHANGE xceb222d_3 name="input.g.page8.xceb222d_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222e_3
            #add-point:BEFORE FIELD xceb222e_3 name="input.b.page8.xceb222e_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222e_3
            
            #add-point:AFTER FIELD xceb222e_3 name="input.a.page8.xceb222e_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222e_3
            #add-point:ON CHANGE xceb222e_3 name="input.g.page8.xceb222e_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222f_3
            #add-point:BEFORE FIELD xceb222f_3 name="input.b.page8.xceb222f_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222f_3
            
            #add-point:AFTER FIELD xceb222f_3 name="input.a.page8.xceb222f_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222f_3
            #add-point:ON CHANGE xceb222f_3 name="input.g.page8.xceb222f_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222g_3
            #add-point:BEFORE FIELD xceb222g_3 name="input.b.page8.xceb222g_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222g_3
            
            #add-point:AFTER FIELD xceb222g_3 name="input.a.page8.xceb222g_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222g_3
            #add-point:ON CHANGE xceb222g_3 name="input.g.page8.xceb222g_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xceb222h_3
            #add-point:BEFORE FIELD xceb222h_3 name="input.b.page8.xceb222h_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xceb222h_3
            
            #add-point:AFTER FIELD xceb222h_3 name="input.a.page8.xceb222h_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xceb222h_3
            #add-point:ON CHANGE xceb222h_3 name="input.g.page8.xceb222h_3"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page8.xcebseq_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcebseq_3
            #add-point:ON ACTION controlp INFIELD xcebseq_3 name="input.c.page8.xcebseq_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb117_3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb117_3
            #add-point:ON ACTION controlp INFIELD xceb117_3 name="input.c.page8.xceb117_3"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xceb8_d[l_ac].xceb117             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_imag011()                                #呼叫開窗

            LET g_xceb8_d[l_ac].xceb117 = g_qryparam.return1              

            DISPLAY g_xceb8_d[l_ac].xceb117 TO xceb117_3              #

            NEXT FIELD xceb117_3                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb115_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb115_3
            #add-point:ON ACTION controlp INFIELD xceb115_3 name="input.c.page8.xceb115_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202_3
            #add-point:ON ACTION controlp INFIELD xceb202_3 name="input.c.page8.xceb202_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202a_3
            #add-point:ON ACTION controlp INFIELD xceb202a_3 name="input.c.page8.xceb202a_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202b_3
            #add-point:ON ACTION controlp INFIELD xceb202b_3 name="input.c.page8.xceb202b_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202c_3
            #add-point:ON ACTION controlp INFIELD xceb202c_3 name="input.c.page8.xceb202c_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202d_3
            #add-point:ON ACTION controlp INFIELD xceb202d_3 name="input.c.page8.xceb202d_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202e_3
            #add-point:ON ACTION controlp INFIELD xceb202e_3 name="input.c.page8.xceb202e_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202f_3
            #add-point:ON ACTION controlp INFIELD xceb202f_3 name="input.c.page8.xceb202f_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202g_3
            #add-point:ON ACTION controlp INFIELD xceb202g_3 name="input.c.page8.xceb202g_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb202h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb202h_3
            #add-point:ON ACTION controlp INFIELD xceb202h_3 name="input.c.page8.xceb202h_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212_3
            #add-point:ON ACTION controlp INFIELD xceb212_3 name="input.c.page8.xceb212_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212a_3
            #add-point:ON ACTION controlp INFIELD xceb212a_3 name="input.c.page8.xceb212a_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212b_3
            #add-point:ON ACTION controlp INFIELD xceb212b_3 name="input.c.page8.xceb212b_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212c_3
            #add-point:ON ACTION controlp INFIELD xceb212c_3 name="input.c.page8.xceb212c_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212d_3
            #add-point:ON ACTION controlp INFIELD xceb212d_3 name="input.c.page8.xceb212d_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212e_3
            #add-point:ON ACTION controlp INFIELD xceb212e_3 name="input.c.page8.xceb212e_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212f_3
            #add-point:ON ACTION controlp INFIELD xceb212f_3 name="input.c.page8.xceb212f_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212g_3
            #add-point:ON ACTION controlp INFIELD xceb212g_3 name="input.c.page8.xceb212g_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb212h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb212h_3
            #add-point:ON ACTION controlp INFIELD xceb212h_3 name="input.c.page8.xceb212h_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222_3
            #add-point:ON ACTION controlp INFIELD xceb222_3 name="input.c.page8.xceb222_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222a_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222a_3
            #add-point:ON ACTION controlp INFIELD xceb222a_3 name="input.c.page8.xceb222a_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222b_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222b_3
            #add-point:ON ACTION controlp INFIELD xceb222b_3 name="input.c.page8.xceb222b_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222c_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222c_3
            #add-point:ON ACTION controlp INFIELD xceb222c_3 name="input.c.page8.xceb222c_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222d_3
            #add-point:ON ACTION controlp INFIELD xceb222d_3 name="input.c.page8.xceb222d_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222e_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222e_3
            #add-point:ON ACTION controlp INFIELD xceb222e_3 name="input.c.page8.xceb222e_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222f_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222f_3
            #add-point:ON ACTION controlp INFIELD xceb222f_3 name="input.c.page8.xceb222f_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222g_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222g_3
            #add-point:ON ACTION controlp INFIELD xceb222g_3 name="input.c.page8.xceb222g_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.xceb222h_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xceb222h_3
            #add-point:ON ACTION controlp INFIELD xceb222h_3 name="input.c.page8.xceb222h_3"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body8.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xceb8_d[l_ac].* = g_xceb8_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct901_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axct901_unlock_b("xceb_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body8.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body8.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xceb_d[li_reproduce_target].* = g_xceb_d[li_reproduce].*
               LET g_xceb8_d[li_reproduce_target].* = g_xceb8_d[li_reproduce].*
 
               LET g_xceb8_d[li_reproduce_target].xcebseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xceb8_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xceb8_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axct901.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_xceb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL axct901_b_fill3()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 3
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL axct901_b_fill4()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 4
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL axct901_b_fill5()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
         
         END DISPLAY
         
         DISPLAY ARRAY g_xceb6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL axct901_b_fill6()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
         
         END DISPLAY 
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','3',"))      
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail8",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xceald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcebseq
               WHEN "s_detail4"
                  NEXT FIELD xcecseq
               WHEN "s_detail8"
                  NEXT FIELD xcebseq_3
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail8",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail8",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct901_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #fengmy 141222 add--begin
   #已確認資料不可修改和刪除
   IF g_xcea_m.xceastus = 'Y' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
   END IF
   #fengmy 141222 add--end
   
   CALL axct901_get_glaa()  
   
#   IF g_argv[1] = '1' THEN
#      CALL cl_set_act_visible('open_axct702_s01',FALSE)   
#      CALL cl_set_comp_visible('xceb201',FALSE)   
#      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',FALSE)
#      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',FALSE)         
#   END IF
#   IF g_argv[1] = '2' OR g_argv[1] = '3' THEN
#      CALL cl_set_act_visible('open_axct702_s01',TRUE) 
#      CALL cl_set_comp_visible('xceb201',TRUE)   
#      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',FALSE)
#      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',FALSE)       
#   END IF
#   IF g_argv[1] = '6' OR g_argv[1] = '7' THEN
#      CALL cl_set_act_visible('open_axct702_s01',FALSE) 
#      CALL cl_set_comp_visible('xceb201',TRUE)
#      CALL cl_set_comp_visible('xceb110,xceb118,xceb115,xceb116,xceb112',TRUE)
#      CALL cl_set_comp_visible('xcec110,xcec118,xcec115,xcec116,xcec112',TRUE) 
#      CALL cl_set_comp_visible('xceb001,xcec001',FALSE)
#   END IF   
   
   IF g_bfill = "Y" THEN
      CALL axct901_b_fill3() #單身填充
      CALL axct901_b_fill4() #單身填充
      CALL axct901_b_fill5() #單身填充
      CALL axct901_b_fill6() #單身填充
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axct901_b_fill() #單身填充
      CALL axct901_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceald_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceacomp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xcea006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xcea006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xcea006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xcea003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xcea003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xcea003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xceaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xceacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xceamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xceacnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceacnfid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceapstid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xceapstid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceapstid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_xcea_m_mask_o.* =  g_xcea_m.*
   CALL axct901_xcea_t_mask()
   LET g_xcea_m_mask_n.* =  g_xcea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceald_desc,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xceasite_desc, 
       g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea006_desc, 
       g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea003_desc,g_xcea_m.xcea101,g_xcea_m.xceastus, 
       g_xcea_m.xceaownid,g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid, 
       g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid, 
       g_xcea_m.xceamodid_desc,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt, 
       g_xcea_m.xceapstid,g_xcea_m.xceapstid_desc,g_xcea_m.xceapstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcea_m.xceastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xceb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            CALL axct901_get_glaa004()
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb101
#            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||g_glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xceb_d[l_ac].xceb101_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xceb_d[l_ac].xceb101_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xceb_d[l_ac].xcebcomp
#            LET g_ref_fields[2] = g_xceb_d[l_ac].xceb103
#            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xceb_d[l_ac].xceb103_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xceb_d[l_ac].xceb103_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xceb_d[l_ac].xceb111
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xceb_d[l_ac].xceb111_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xceb_d[l_ac].xceb111_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xceb4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"

#            CALL axct901_get_xceb101_desc(g_xceb4_d[l_ac].xcec101) RETURNING g_xceb4_d[l_ac].xcec101_desc
#           
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xceb4_d[l_ac].xceccomp
#            LET g_ref_fields[2] = g_xceb4_d[l_ac].xcec103
#            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xceb4_d[l_ac].xcec103_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xceb4_d[l_ac].xcec103_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xceb4_d[l_ac].xcec111
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xceb4_d[l_ac].xcec111_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xceb4_d[l_ac].xcec111_desc
#
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xceb8_d.getLength()
      #add-point:show段單身reference name="show.body8.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axct901_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('bpage_2,bpage_5',TRUE)
   ELSE
      CALL cl_set_comp_visible('bpage_2,bpage_5',FALSE)
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('bpage_3,bpage_6',TRUE)
   ELSE
      CALL cl_set_comp_visible('bpage_3,bpage_6',FALSE)
   END IF
   CALL axct901_b_fill3() #單身填充
   CALL axct901_b_fill4() #單身填充
   CALL axct901_b_fill5() #單身填充
   CALL axct901_b_fill6() #單身填充
   CALL cl_show_fld_cont()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axct901_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct901_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xcea_t.xceald 
   DEFINE l_oldno     LIKE xcea_t.xceald 
   DEFINE l_newno02     LIKE xcea_t.xceadocno 
   DEFINE l_oldno02     LIKE xcea_t.xceadocno 
 
   DEFINE l_master    RECORD LIKE xcea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xceb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xcec_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xcea_m.xceald IS NULL
   OR g_xcea_m.xceadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xceald_t = g_xcea_m.xceald
   LET g_xceadocno_t = g_xcea_m.xceadocno
 
    
   LET g_xcea_m.xceald = ""
   LET g_xcea_m.xceadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcea_m.xceaownid = g_user
      LET g_xcea_m.xceaowndp = g_dept
      LET g_xcea_m.xceacrtid = g_user
      LET g_xcea_m.xceacrtdp = g_dept 
      LET g_xcea_m.xceacrtdt = cl_get_current()
      LET g_xcea_m.xceamodid = g_user
      LET g_xcea_m.xceamoddt = cl_get_current()
      LET g_xcea_m.xceastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcea_m.xceastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xcea_m.xceald_desc = ''
   DISPLAY BY NAME g_xcea_m.xceald_desc
 
   
   CALL axct901_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xcea_m.* TO NULL
      INITIALIZE g_xceb_d TO NULL
      INITIALIZE g_xceb4_d TO NULL
      INITIALIZE g_xceb8_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axct901_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct901_set_act_visible()   
   CALL axct901_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xceald_t = g_xcea_m.xceald
   LET g_xceadocno_t = g_xcea_m.xceadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xceaent = " ||g_enterprise|| " AND",
                      " xceald = '", g_xcea_m.xceald, "' "
                      ," AND xceadocno = '", g_xcea_m.xceadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axct901_idx_chk()
   
   LET g_data_owner = g_xcea_m.xceaownid      
   LET g_data_dept  = g_xcea_m.xceaowndp
   
   #功能已完成,通報訊息中心
   CALL axct901_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct901_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xceb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xcec_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct901_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xceb_t
    WHERE xcebent = g_enterprise AND xcebld = g_xceald_t
     AND xcebdocno = g_xceadocno_t
 
    INTO TEMP axct901_detail
 
   #將key修正為調整後   
   UPDATE axct901_detail 
      #更新key欄位
      SET xcebld = g_xcea_m.xceald
          , xcebdocno = g_xcea_m.xceadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xceb_t SELECT * FROM axct901_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct901_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcec_t 
    WHERE xcecent = g_enterprise AND xcecld = g_xceald_t
      AND xcecdocno = g_xceadocno_t   
 
    INTO TEMP axct901_detail
 
   #將key修正為調整後   
   UPDATE axct901_detail SET xcecld = g_xcea_m.xceald
                                       , xcecdocno = g_xcea_m.xceadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xcec_t SELECT * FROM axct901_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct901_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xceald_t = g_xcea_m.xceald
   LET g_xceadocno_t = g_xcea_m.xceadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct901_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_sql           STRING
   
   CALL axct901_refresh_stus()
#判断状态码
   IF g_xcea_m.xceastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xcea_m.xceald IS NULL
   OR g_xcea_m.xceadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct901_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT axct901_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcea_m_mask_o.* =  g_xcea_m.*
   CALL axct901_xcea_t_mask()
   LET g_xcea_m_mask_n.* =  g_xcea_m.*
   
   CALL axct901_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xceald_t = g_xcea_m.xceald
      LET g_xceadocno_t = g_xcea_m.xceadocno
 
 
      DELETE FROM xcea_t
       WHERE xceaent = g_enterprise AND xceald = g_xcea_m.xceald
         AND xceadocno = g_xcea_m.xceadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xcea_m.xceald,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xcea001) THEN CALL s_transaction_end('N','0') RETURN END IF   #wujie 150214           
      CALL s_ld_sel_glaa(g_xcea_m.xceald,'glaa121') RETURNING  l_success,g_glaa121
#      IF NOT l_success THEN 
         IF g_glaa121 = 'Y' THEN
            CALL s_pre_voucher_del('XC','C10',g_xcea_m.xceald,g_xcea_m.xceadocno) RETURNING l_success
            
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
#      END IF

      # axct704/axct706/axct707 删除单据后，更新xcck中的立账状态码
      IF g_argv[1] MATCHES '[467]' THEN
        #C151008-004 Add  ---(S)---
         IF g_argv[1] = '4' THEN
            LET l_sql = "UPDATE xckd_t SET xckd019 = 'N' ",
                        " WHERE xckdent = '",g_enterprise,"' AND xckdld = '",g_xcea_m.xceald,"'",
                        "   AND xckd003 = '",g_xcea_m.xcea003,"' ",
                        "    AND xckdsite = '",g_xcea_m.xceasite,"'",
                        "   AND NVL(xckd019,'Y') = 'Y' ",
                        "   AND xckd001 = '1' ",
                        "   AND EXISTS(SELECT 1 FROM xceb_t ",
                        "               WHERE xcebent = ",g_enterprise,
                        "                 AND xcebld = '",g_xcea_m.xceald,"' ",
                        "                 AND xcebdocno = '",g_xcea_m.xceadocno,"' ",
                        #160527-00019#1---s
                        #"                 AND xcebua001 = xckd008 ",  
                        #"                 AND xcebud001 = xckd007 ",
                        "                 AND xceb131 = xckd007 ",
                        "                 AND xceb132 = xckd008 ", 
                        #160527-00019#1----e
                        "                 AND xceb110   = xckd012 ",
                        "             ) "
         END IF
         #ELSE  #mark by zhr 160103 
         IF g_argv[1] = '6' THEN          
            LET l_sql = "UPDATE xckd_t SET xckd019 = 'N' ",
                        " WHERE xckdent = '",g_enterprise,"' AND xckdld = '",g_xcea_m.xceald,"'",
                        "   AND xckd003 = '",g_xcea_m.xcea003,"' ",
                        "    AND xckdsite = '",g_xcea_m.xceasite,"'",
                        "   AND NVL(xckd019,'Y') = 'Y' ",
                        "   AND xckd001 = '1' ",
                        "   AND EXISTS(SELECT 1 FROM xceb_t ",
                        "               WHERE xcebent = ",g_enterprise,
                        "                 AND xcebld = '",g_xcea_m.xceald,"' ",
                        "                 AND xcebdocno = '",g_xcea_m.xceadocno,"' ",
                        #160527-00019#1---s
                        #"                 AND xcebua001 = xckd008 ",  
                        #"                 AND xcebud001 = xckd007 ",
                        "                 AND xceb131 = xckd007 ",
                        "                 AND xceb132 = xckd008 ", 
                        #160527-00019#1----e
                        "                 AND xceb115   = xckd013 ",
                        "                 AND xceb117   = xckd014 ",
                        "                 AND xceb110   = xckd012 ",
                        "             ) "
         END IF 
         #add by zhr 160103 str
         IF g_argv[1] = '7' THEN 
            #IF g_prog = 'cxct710' THEN        #160705-00042#10 160713 by sakura mark
            #IF g_prog MATCHES 'cxct710' THEN   #160705-00042#10 160713 by sakura add #170301-00023#11 mark    
            IF g_prog MATCHES 'cxct710*' THEN #170301-00023#11 add
               LET l_sql = "UPDATE xckd_t SET xckd022 = 'N' ",
                        " WHERE xckdent = '",g_enterprise,"' AND xckdld = '",g_xcea_m.xceald,"'",
                        "   AND xckd003 = '",g_xcea_m.xcea003,"' ",
                        "    AND xckdsite = '",g_xcea_m.xceasite,"'",
                        "   AND NVL(xckd022,'Y') = 'Y' ",
                        "   AND xckd001 = '1' ",
                        "   AND EXISTS(SELECT 1 FROM xceb_t ",
                        "               WHERE xcebent = ",g_enterprise,
                        "                 AND xcebld = '",g_xcea_m.xceald,"' ",
                        "                 AND xcebdocno = '",g_xcea_m.xceadocno,"' ",
                        #160527-00019#1---s
                        #"                 AND xcebua001 = xckd008 ",  
                        #"                 AND xcebud001 = xckd007 ",
                        "                 AND xceb131 = xckd007 ",
                        "                 AND xceb132 = xckd008 ", 
                        #160527-00019#1----e
                        "                 AND xceb115   = xckd013 ",
                        "                 AND xceb117   = xckd014 ",
                        "                 AND xceb110   = xckd012 ",
                        "             ) "
            ELSE
                LET l_sql = "UPDATE xckd_t SET xckd019 = 'N' ",
                        " WHERE xckdent = '",g_enterprise,"' AND xckdld = '",g_xcea_m.xceald,"'",
                        "   AND xckd003 = '",g_xcea_m.xcea003,"' ",
                        "    AND xckdsite = '",g_xcea_m.xceasite,"'",
                        "   AND NVL(xckd019,'Y') = 'Y' ",
                        "   AND xckd001 = '1' ",
                        "   AND EXISTS(SELECT 1 FROM xceb_t ",
                        "               WHERE xcebent = ",g_enterprise,
                        "                 AND xcebld = '",g_xcea_m.xceald,"' ",
                        "                 AND xcebdocno = '",g_xcea_m.xceadocno,"' ",
                        #160527-00019#1---s
                        #"                 AND xcebua001 = xckd008 ",  
                        #"                 AND xcebud001 = xckd007 ",
                        "                 AND xceb131 = xckd007 ",
                        "                 AND xceb132 = xckd008 ", 
                        #160527-00019#1----e
                        "                 AND xceb115   = xckd013 ",
                        "                 AND xceb117   = xckd014 ",
                        "                 AND xceb110   = xckd012 ",
                        "             ) "
            END IF 
         END IF
        #add by zhr 160103 end
        #C151008-004 Add  ---(E)---
        #C151008-004 Mark ---(S)---
        #LET l_sql = "UPDATE xcck_t SET xcckud001 = 'N' ",
        #            " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_xcea_m.xceald,"'",
        #            "   AND xcck003 = '",g_xcea_m.xcea003,"' ",
        #            "   AND xcck055 = '311' ",
        #            "   AND NVL(xcckud001,'N') = 'Y' ",
        #            "   AND xcck001 = '1' ",
        #            "   AND EXISTS(SELECT 1 FROM xceb_t ",
        #            "               WHERE xcebent = ",g_enterprise,
        #            "                 AND xcebld = '",g_xcea_m.xceald,"' ",
        #            "                 AND xcebdocno = '",g_xcea_m.xceadocno,"' ",
        #            "                 AND xceb001 = xcck006 ",
        #            "                 AND xceb002 = xcck007 ",
        #            "             ) "
        #C151008-004 Mark ---(E)---
         TRY
            EXECUTE IMMEDIATE l_sql
         CATCH
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd xcck_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
     
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END TRY
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xceb_t
       WHERE xcebent = g_enterprise AND xcebld = g_xcea_m.xceald
         AND xcebdocno = g_xcea_m.xceadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM xcec_t
       WHERE xcecent = g_enterprise AND
             xcecld = g_xcea_m.xceald AND xcecdocno = g_xcea_m.xceadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      IF g_argv[1] = '2' OR g_argv[1] = '5' THEN 
         DELETE FROM xced_t
          WHERE xcedent = g_enterprise AND
                xcedld = g_xcea_m.xceald AND xceddocno = g_xcea_m.xceadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xced_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            RETURN
         END IF        
      END IF
      
      #160527-00019#1---s
      CALL g_xceb9_d.clear()    
      CALL g_xceb10_d.clear()
      #160527-00019#1---e
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xcea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axct901_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xceb_d.clear() 
      CALL g_xceb4_d.clear()       
      CALL g_xceb8_d.clear()       
 
     
      CALL axct901_ui_browser_refresh()  
      #CALL axct901_ui_headershow()  
      #CALL axct901_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axct901_browser_fill("")
         CALL axct901_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axct901_cl
 
   #功能已完成,通報訊息中心
   CALL axct901_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct901_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xceb_d.clear()
   CALL g_xceb4_d.clear()
   CALL g_xceb8_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axct901_b_fill1()
   RETURN
   #end add-point
   
   #判斷是否填充
   IF axct901_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102,xceb103, 
             xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108,xceb109, 
             xceb111,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128, 
             xceb129,xceb130,xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g, 
             xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h, 
             xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301, 
             xceb302,xcebcomp,xcebseq,xceb117,xceb115,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e, 
             xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f, 
             xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g, 
             xceb222h ,t1.glacl004 ,t2.xcbfl003 ,t3.ooag011 ,t4.ooefl003 ,t5.pmaal003 ,t6.pmaal003 FROM xceb_t", 
                
                     " INNER JOIN xcea_t ON xceaent = " ||g_enterprise|| " AND xceald = xcebld ",
                     " AND xceadocno = xcebdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN glacl_t t1 ON t1.glaclent="||g_enterprise||" AND t1.glacl001='' AND t1.glacl002=xceb101 AND t1.glacl003='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t2 ON t2.xcbflent="||g_enterprise||" AND t2.xcbflcomp=xcebcomp AND t2.xcbfl001=xceb103 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=xceb107  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=xceb108 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=xceb109 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=xceb111 AND t6.pmaal002='"||g_dlang||"' ",
 
                     " WHERE xcebent=? AND xcebld=? AND xcebdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xceb_t.xcebseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct901_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct901_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xceb_d[l_ac].xcebseq, 
          g_xceb_d[l_ac].xceb001,g_xceb_d[l_ac].xceb003,g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005, 
          g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb102,g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb110, 
          g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118,g_xceb_d[l_ac].xceb114,g_xceb_d[l_ac].xceb115, 
          g_xceb_d[l_ac].xceb116,g_xceb_d[l_ac].xceb119,g_xceb_d[l_ac].xceb120,g_xceb_d[l_ac].xceb107, 
          g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109,g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb112, 
          g_xceb_d[l_ac].xceb113,g_xceb_d[l_ac].xceb121,g_xceb_d[l_ac].xceb122,g_xceb_d[l_ac].xceb123, 
          g_xceb_d[l_ac].xceb124,g_xceb_d[l_ac].xceb125,g_xceb_d[l_ac].xceb126,g_xceb_d[l_ac].xceb127, 
          g_xceb_d[l_ac].xceb128,g_xceb_d[l_ac].xceb129,g_xceb_d[l_ac].xceb130,g_xceb_d[l_ac].xceb201, 
          g_xceb_d[l_ac].xceb202,g_xceb_d[l_ac].xceb202a,g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c, 
          g_xceb_d[l_ac].xceb202d,g_xceb_d[l_ac].xceb202e,g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g, 
          g_xceb_d[l_ac].xceb202h,g_xceb_d[l_ac].xceb212,g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b, 
          g_xceb_d[l_ac].xceb212c,g_xceb_d[l_ac].xceb212d,g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f, 
          g_xceb_d[l_ac].xceb212g,g_xceb_d[l_ac].xceb212h,g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a, 
          g_xceb_d[l_ac].xceb222b,g_xceb_d[l_ac].xceb222c,g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e, 
          g_xceb_d[l_ac].xceb222f,g_xceb_d[l_ac].xceb222g,g_xceb_d[l_ac].xceb222h,g_xceb_d[l_ac].xceb301, 
          g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp,g_xceb8_d[l_ac].xcebseq,g_xceb8_d[l_ac].xceb117, 
          g_xceb8_d[l_ac].xceb115,g_xceb8_d[l_ac].xceb202,g_xceb8_d[l_ac].xceb202a,g_xceb8_d[l_ac].xceb202b, 
          g_xceb8_d[l_ac].xceb202c,g_xceb8_d[l_ac].xceb202d,g_xceb8_d[l_ac].xceb202e,g_xceb8_d[l_ac].xceb202f, 
          g_xceb8_d[l_ac].xceb202g,g_xceb8_d[l_ac].xceb202h,g_xceb8_d[l_ac].xceb212,g_xceb8_d[l_ac].xceb212a, 
          g_xceb8_d[l_ac].xceb212b,g_xceb8_d[l_ac].xceb212c,g_xceb8_d[l_ac].xceb212d,g_xceb8_d[l_ac].xceb212e, 
          g_xceb8_d[l_ac].xceb212f,g_xceb8_d[l_ac].xceb212g,g_xceb8_d[l_ac].xceb212h,g_xceb8_d[l_ac].xceb222, 
          g_xceb8_d[l_ac].xceb222a,g_xceb8_d[l_ac].xceb222b,g_xceb8_d[l_ac].xceb222c,g_xceb8_d[l_ac].xceb222d, 
          g_xceb8_d[l_ac].xceb222e,g_xceb8_d[l_ac].xceb222f,g_xceb8_d[l_ac].xceb222g,g_xceb8_d[l_ac].xceb222h, 
          g_xceb_d[l_ac].xceb101_desc,g_xceb_d[l_ac].xceb103_desc,g_xceb_d[l_ac].xceb107_desc,g_xceb_d[l_ac].xceb108_desc, 
          g_xceb_d[l_ac].xceb109_desc,g_xceb_d[l_ac].xceb111_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF axct901_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102,xcec103, 
             xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,xcec119,xcec120,xcec107,xcec108,xcec109, 
             xcec111,xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128, 
             xcec129,xcec130,xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g, 
             xcec202h,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h, 
             xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301, 
             xcec302,xceccomp ,t7.glacl004 ,t8.xcbfl003 ,t9.ooag011 ,t10.ooefl003 ,t11.pmaal003 ,t12.pmaal003 FROM xcec_t", 
                
                     " INNER JOIN  xcea_t ON xceaent = " ||g_enterprise|| " AND xceald = xcecld ",
                     " AND xceadocno = xcecdocno ",
 
                     "",
                     
                                    " LEFT JOIN glacl_t t7 ON t7.glaclent="||g_enterprise||" AND t7.glacl001='' AND t7.glacl003=xcec101 AND t7.glacl003='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t8 ON t8.xcbflent="||g_enterprise||" AND t8.xcbflcomp=xceccomp AND t8.xcbfl001=xcec103 AND t8.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xcec107  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=xcec108 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t11 ON t11.pmaalent="||g_enterprise||" AND t11.pmaal001=xcec109 AND t11.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t12 ON t12.pmaalent="||g_enterprise||" AND t12.pmaal001=xcec111 AND t12.pmaal002='"||g_dlang||"' ",
 
                     " WHERE xcecent=? AND xcecld=? AND xcecdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcec_t.xcecseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct901_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axct901_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xceb4_d[l_ac].xcecseq, 
          g_xceb4_d[l_ac].xcec001,g_xceb4_d[l_ac].xcec003,g_xceb4_d[l_ac].xcec004,g_xceb4_d[l_ac].xcec005, 
          g_xceb4_d[l_ac].xcec101,g_xceb4_d[l_ac].xcec102,g_xceb4_d[l_ac].xcec103,g_xceb4_d[l_ac].xcec110, 
          g_xceb4_d[l_ac].xcec117,g_xceb4_d[l_ac].xcec118,g_xceb4_d[l_ac].xcec114,g_xceb4_d[l_ac].xcec115, 
          g_xceb4_d[l_ac].xcec116,g_xceb4_d[l_ac].xcec119,g_xceb4_d[l_ac].xcec120,g_xceb4_d[l_ac].xcec107, 
          g_xceb4_d[l_ac].xcec108,g_xceb4_d[l_ac].xcec109,g_xceb4_d[l_ac].xcec111,g_xceb4_d[l_ac].xcec112, 
          g_xceb4_d[l_ac].xcec113,g_xceb4_d[l_ac].xcec121,g_xceb4_d[l_ac].xcec122,g_xceb4_d[l_ac].xcec123, 
          g_xceb4_d[l_ac].xcec124,g_xceb4_d[l_ac].xcec125,g_xceb4_d[l_ac].xcec126,g_xceb4_d[l_ac].xcec127, 
          g_xceb4_d[l_ac].xcec128,g_xceb4_d[l_ac].xcec129,g_xceb4_d[l_ac].xcec130,g_xceb4_d[l_ac].xcec201, 
          g_xceb4_d[l_ac].xcec202,g_xceb4_d[l_ac].xcec202a,g_xceb4_d[l_ac].xcec202b,g_xceb4_d[l_ac].xcec202c, 
          g_xceb4_d[l_ac].xcec202d,g_xceb4_d[l_ac].xcec202e,g_xceb4_d[l_ac].xcec202f,g_xceb4_d[l_ac].xcec202g, 
          g_xceb4_d[l_ac].xcec202h,g_xceb4_d[l_ac].xcec212,g_xceb4_d[l_ac].xcec212a,g_xceb4_d[l_ac].xcec212b, 
          g_xceb4_d[l_ac].xcec212c,g_xceb4_d[l_ac].xcec212d,g_xceb4_d[l_ac].xcec212e,g_xceb4_d[l_ac].xcec212f, 
          g_xceb4_d[l_ac].xcec212g,g_xceb4_d[l_ac].xcec212h,g_xceb4_d[l_ac].xcec222,g_xceb4_d[l_ac].xcec222a, 
          g_xceb4_d[l_ac].xcec222b,g_xceb4_d[l_ac].xcec222c,g_xceb4_d[l_ac].xcec222d,g_xceb4_d[l_ac].xcec222e, 
          g_xceb4_d[l_ac].xcec222f,g_xceb4_d[l_ac].xcec222g,g_xceb4_d[l_ac].xcec222h,g_xceb4_d[l_ac].xcec301, 
          g_xceb4_d[l_ac].xcec302,g_xceb4_d[l_ac].xceccomp,g_xceb4_d[l_ac].xcec101_desc,g_xceb4_d[l_ac].xcec103_desc, 
          g_xceb4_d[l_ac].xcec107_desc,g_xceb4_d[l_ac].xcec108_desc,g_xceb4_d[l_ac].xcec109_desc,g_xceb4_d[l_ac].xcec111_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_xceb_d.deleteElement(g_xceb_d.getLength())
   CALL g_xceb4_d.deleteElement(g_xceb4_d.getLength())
   CALL g_xceb8_d.deleteElement(g_xceb8_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb
   FREE axct901_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xceb_d.getLength()
      LET g_xceb_d_mask_o[l_ac].* =  g_xceb_d[l_ac].*
      CALL axct901_xceb_t_mask()
      LET g_xceb_d_mask_n[l_ac].* =  g_xceb_d[l_ac].*
   END FOR
   
   LET g_xceb4_d_mask_o.* =  g_xceb4_d.*
   FOR l_ac = 1 TO g_xceb4_d.getLength()
      LET g_xceb4_d_mask_o[l_ac].* =  g_xceb4_d[l_ac].*
      CALL axct901_xcec_t_mask()
      LET g_xceb4_d_mask_n[l_ac].* =  g_xceb4_d[l_ac].*
   END FOR
   LET g_xceb8_d_mask_o.* =  g_xceb8_d.*
   FOR l_ac = 1 TO g_xceb8_d.getLength()
      LET g_xceb8_d_mask_o[l_ac].* =  g_xceb8_d[l_ac].*
      CALL axct901_xceb_t_mask()
      LET g_xceb8_d_mask_n[l_ac].* =  g_xceb8_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct901_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xceb_t
       WHERE xcebent = g_enterprise AND
         xcebld = ps_keys_bak[1] AND xcebdocno = ps_keys_bak[2] AND xcebseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xceb_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xceb8_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xcec_t
       WHERE xcecent = g_enterprise AND
             xcecld = ps_keys_bak[1] AND xcecdocno = ps_keys_bak[2] AND xcecseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xceb4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct901_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET g_xceb_d[g_detail_idx].xceb005 = ' '
      #end add-point 
      INSERT INTO xceb_t
                  (xcebent,
                   xcebld,xcebdocno,
                   xcebseq
                   ,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102,xceb103,xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp,xceb117,xceb115,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xceb_d[g_detail_idx].xceb001,g_xceb_d[g_detail_idx].xceb003,g_xceb_d[g_detail_idx].xceb004, 
                       g_xceb_d[g_detail_idx].xceb005,g_xceb_d[g_detail_idx].xceb101,g_xceb_d[g_detail_idx].xceb102, 
                       g_xceb_d[g_detail_idx].xceb103,g_xceb_d[g_detail_idx].xceb110,g_xceb_d[g_detail_idx].xceb117, 
                       g_xceb_d[g_detail_idx].xceb118,g_xceb_d[g_detail_idx].xceb114,g_xceb_d[g_detail_idx].xceb115, 
                       g_xceb_d[g_detail_idx].xceb116,g_xceb_d[g_detail_idx].xceb119,g_xceb_d[g_detail_idx].xceb120, 
                       g_xceb_d[g_detail_idx].xceb107,g_xceb_d[g_detail_idx].xceb108,g_xceb_d[g_detail_idx].xceb109, 
                       g_xceb_d[g_detail_idx].xceb111,g_xceb_d[g_detail_idx].xceb112,g_xceb_d[g_detail_idx].xceb113, 
                       g_xceb_d[g_detail_idx].xceb121,g_xceb_d[g_detail_idx].xceb122,g_xceb_d[g_detail_idx].xceb123, 
                       g_xceb_d[g_detail_idx].xceb124,g_xceb_d[g_detail_idx].xceb125,g_xceb_d[g_detail_idx].xceb126, 
                       g_xceb_d[g_detail_idx].xceb127,g_xceb_d[g_detail_idx].xceb128,g_xceb_d[g_detail_idx].xceb129, 
                       g_xceb_d[g_detail_idx].xceb130,g_xceb_d[g_detail_idx].xceb201,g_xceb_d[g_detail_idx].xceb202, 
                       g_xceb_d[g_detail_idx].xceb202a,g_xceb_d[g_detail_idx].xceb202b,g_xceb_d[g_detail_idx].xceb202c, 
                       g_xceb_d[g_detail_idx].xceb202d,g_xceb_d[g_detail_idx].xceb202e,g_xceb_d[g_detail_idx].xceb202f, 
                       g_xceb_d[g_detail_idx].xceb202g,g_xceb_d[g_detail_idx].xceb202h,g_xceb_d[g_detail_idx].xceb212, 
                       g_xceb_d[g_detail_idx].xceb212a,g_xceb_d[g_detail_idx].xceb212b,g_xceb_d[g_detail_idx].xceb212c, 
                       g_xceb_d[g_detail_idx].xceb212d,g_xceb_d[g_detail_idx].xceb212e,g_xceb_d[g_detail_idx].xceb212f, 
                       g_xceb_d[g_detail_idx].xceb212g,g_xceb_d[g_detail_idx].xceb212h,g_xceb_d[g_detail_idx].xceb222, 
                       g_xceb_d[g_detail_idx].xceb222a,g_xceb_d[g_detail_idx].xceb222b,g_xceb_d[g_detail_idx].xceb222c, 
                       g_xceb_d[g_detail_idx].xceb222d,g_xceb_d[g_detail_idx].xceb222e,g_xceb_d[g_detail_idx].xceb222f, 
                       g_xceb_d[g_detail_idx].xceb222g,g_xceb_d[g_detail_idx].xceb222h,g_xceb_d[g_detail_idx].xceb301, 
                       g_xceb_d[g_detail_idx].xceb302,g_xceb_d[g_detail_idx].xcebcomp,g_xceb_d[g_detail_idx].xceb117, 
                       g_xceb_d[g_detail_idx].xceb115,g_xceb_d[g_detail_idx].xceb202,g_xceb_d[g_detail_idx].xceb202a, 
                       g_xceb_d[g_detail_idx].xceb202b,g_xceb_d[g_detail_idx].xceb202c,g_xceb_d[g_detail_idx].xceb202d, 
                       g_xceb_d[g_detail_idx].xceb202e,g_xceb_d[g_detail_idx].xceb202f,g_xceb_d[g_detail_idx].xceb202g, 
                       g_xceb_d[g_detail_idx].xceb202h,g_xceb_d[g_detail_idx].xceb212,g_xceb_d[g_detail_idx].xceb212a, 
                       g_xceb_d[g_detail_idx].xceb212b,g_xceb_d[g_detail_idx].xceb212c,g_xceb_d[g_detail_idx].xceb212d, 
                       g_xceb_d[g_detail_idx].xceb212e,g_xceb_d[g_detail_idx].xceb212f,g_xceb_d[g_detail_idx].xceb212g, 
                       g_xceb_d[g_detail_idx].xceb212h,g_xceb_d[g_detail_idx].xceb222,g_xceb_d[g_detail_idx].xceb222a, 
                       g_xceb_d[g_detail_idx].xceb222b,g_xceb_d[g_detail_idx].xceb222c,g_xceb_d[g_detail_idx].xceb222d, 
                       g_xceb_d[g_detail_idx].xceb222e,g_xceb_d[g_detail_idx].xceb222f,g_xceb_d[g_detail_idx].xceb222g, 
                       g_xceb_d[g_detail_idx].xceb222h)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xceb_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xceb8_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      LET g_xceb4_d[g_detail_idx].xcec005 = ' '
      #end add-point 
      INSERT INTO xcec_t
                  (xcecent,
                   xcecld,xcecdocno,
                   xcecseq
                   ,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102,xcec103,xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xceb4_d[g_detail_idx].xcec001,g_xceb4_d[g_detail_idx].xcec003,g_xceb4_d[g_detail_idx].xcec004, 
                       g_xceb4_d[g_detail_idx].xcec005,g_xceb4_d[g_detail_idx].xcec101,g_xceb4_d[g_detail_idx].xcec102, 
                       g_xceb4_d[g_detail_idx].xcec103,g_xceb4_d[g_detail_idx].xcec110,g_xceb4_d[g_detail_idx].xcec117, 
                       g_xceb4_d[g_detail_idx].xcec118,g_xceb4_d[g_detail_idx].xcec114,g_xceb4_d[g_detail_idx].xcec115, 
                       g_xceb4_d[g_detail_idx].xcec116,g_xceb4_d[g_detail_idx].xcec119,g_xceb4_d[g_detail_idx].xcec120, 
                       g_xceb4_d[g_detail_idx].xcec107,g_xceb4_d[g_detail_idx].xcec108,g_xceb4_d[g_detail_idx].xcec109, 
                       g_xceb4_d[g_detail_idx].xcec111,g_xceb4_d[g_detail_idx].xcec112,g_xceb4_d[g_detail_idx].xcec113, 
                       g_xceb4_d[g_detail_idx].xcec121,g_xceb4_d[g_detail_idx].xcec122,g_xceb4_d[g_detail_idx].xcec123, 
                       g_xceb4_d[g_detail_idx].xcec124,g_xceb4_d[g_detail_idx].xcec125,g_xceb4_d[g_detail_idx].xcec126, 
                       g_xceb4_d[g_detail_idx].xcec127,g_xceb4_d[g_detail_idx].xcec128,g_xceb4_d[g_detail_idx].xcec129, 
                       g_xceb4_d[g_detail_idx].xcec130,g_xceb4_d[g_detail_idx].xcec201,g_xceb4_d[g_detail_idx].xcec202, 
                       g_xceb4_d[g_detail_idx].xcec202a,g_xceb4_d[g_detail_idx].xcec202b,g_xceb4_d[g_detail_idx].xcec202c, 
                       g_xceb4_d[g_detail_idx].xcec202d,g_xceb4_d[g_detail_idx].xcec202e,g_xceb4_d[g_detail_idx].xcec202f, 
                       g_xceb4_d[g_detail_idx].xcec202g,g_xceb4_d[g_detail_idx].xcec202h,g_xceb4_d[g_detail_idx].xcec212, 
                       g_xceb4_d[g_detail_idx].xcec212a,g_xceb4_d[g_detail_idx].xcec212b,g_xceb4_d[g_detail_idx].xcec212c, 
                       g_xceb4_d[g_detail_idx].xcec212d,g_xceb4_d[g_detail_idx].xcec212e,g_xceb4_d[g_detail_idx].xcec212f, 
                       g_xceb4_d[g_detail_idx].xcec212g,g_xceb4_d[g_detail_idx].xcec212h,g_xceb4_d[g_detail_idx].xcec222, 
                       g_xceb4_d[g_detail_idx].xcec222a,g_xceb4_d[g_detail_idx].xcec222b,g_xceb4_d[g_detail_idx].xcec222c, 
                       g_xceb4_d[g_detail_idx].xcec222d,g_xceb4_d[g_detail_idx].xcec222e,g_xceb4_d[g_detail_idx].xcec222f, 
                       g_xceb4_d[g_detail_idx].xcec222g,g_xceb4_d[g_detail_idx].xcec222h,g_xceb4_d[g_detail_idx].xcec301, 
                       g_xceb4_d[g_detail_idx].xcec302,g_xceb4_d[g_detail_idx].xceccomp)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xceb4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xceb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axct901_xceb_t_mask_restore('restore_mask_o')
               
      UPDATE xceb_t 
         SET (xcebld,xcebdocno,
              xcebseq
              ,xceb001,xceb003,xceb004,xceb005,xceb101,xceb102,xceb103,xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp,xceb117,xceb115,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h,xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a,xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xceb_d[g_detail_idx].xceb001,g_xceb_d[g_detail_idx].xceb003,g_xceb_d[g_detail_idx].xceb004, 
                  g_xceb_d[g_detail_idx].xceb005,g_xceb_d[g_detail_idx].xceb101,g_xceb_d[g_detail_idx].xceb102, 
                  g_xceb_d[g_detail_idx].xceb103,g_xceb_d[g_detail_idx].xceb110,g_xceb_d[g_detail_idx].xceb117, 
                  g_xceb_d[g_detail_idx].xceb118,g_xceb_d[g_detail_idx].xceb114,g_xceb_d[g_detail_idx].xceb115, 
                  g_xceb_d[g_detail_idx].xceb116,g_xceb_d[g_detail_idx].xceb119,g_xceb_d[g_detail_idx].xceb120, 
                  g_xceb_d[g_detail_idx].xceb107,g_xceb_d[g_detail_idx].xceb108,g_xceb_d[g_detail_idx].xceb109, 
                  g_xceb_d[g_detail_idx].xceb111,g_xceb_d[g_detail_idx].xceb112,g_xceb_d[g_detail_idx].xceb113, 
                  g_xceb_d[g_detail_idx].xceb121,g_xceb_d[g_detail_idx].xceb122,g_xceb_d[g_detail_idx].xceb123, 
                  g_xceb_d[g_detail_idx].xceb124,g_xceb_d[g_detail_idx].xceb125,g_xceb_d[g_detail_idx].xceb126, 
                  g_xceb_d[g_detail_idx].xceb127,g_xceb_d[g_detail_idx].xceb128,g_xceb_d[g_detail_idx].xceb129, 
                  g_xceb_d[g_detail_idx].xceb130,g_xceb_d[g_detail_idx].xceb201,g_xceb_d[g_detail_idx].xceb202, 
                  g_xceb_d[g_detail_idx].xceb202a,g_xceb_d[g_detail_idx].xceb202b,g_xceb_d[g_detail_idx].xceb202c, 
                  g_xceb_d[g_detail_idx].xceb202d,g_xceb_d[g_detail_idx].xceb202e,g_xceb_d[g_detail_idx].xceb202f, 
                  g_xceb_d[g_detail_idx].xceb202g,g_xceb_d[g_detail_idx].xceb202h,g_xceb_d[g_detail_idx].xceb212, 
                  g_xceb_d[g_detail_idx].xceb212a,g_xceb_d[g_detail_idx].xceb212b,g_xceb_d[g_detail_idx].xceb212c, 
                  g_xceb_d[g_detail_idx].xceb212d,g_xceb_d[g_detail_idx].xceb212e,g_xceb_d[g_detail_idx].xceb212f, 
                  g_xceb_d[g_detail_idx].xceb212g,g_xceb_d[g_detail_idx].xceb212h,g_xceb_d[g_detail_idx].xceb222, 
                  g_xceb_d[g_detail_idx].xceb222a,g_xceb_d[g_detail_idx].xceb222b,g_xceb_d[g_detail_idx].xceb222c, 
                  g_xceb_d[g_detail_idx].xceb222d,g_xceb_d[g_detail_idx].xceb222e,g_xceb_d[g_detail_idx].xceb222f, 
                  g_xceb_d[g_detail_idx].xceb222g,g_xceb_d[g_detail_idx].xceb222h,g_xceb_d[g_detail_idx].xceb301, 
                  g_xceb_d[g_detail_idx].xceb302,g_xceb_d[g_detail_idx].xcebcomp,g_xceb_d[g_detail_idx].xceb117, 
                  g_xceb_d[g_detail_idx].xceb115,g_xceb_d[g_detail_idx].xceb202,g_xceb_d[g_detail_idx].xceb202a, 
                  g_xceb_d[g_detail_idx].xceb202b,g_xceb_d[g_detail_idx].xceb202c,g_xceb_d[g_detail_idx].xceb202d, 
                  g_xceb_d[g_detail_idx].xceb202e,g_xceb_d[g_detail_idx].xceb202f,g_xceb_d[g_detail_idx].xceb202g, 
                  g_xceb_d[g_detail_idx].xceb202h,g_xceb_d[g_detail_idx].xceb212,g_xceb_d[g_detail_idx].xceb212a, 
                  g_xceb_d[g_detail_idx].xceb212b,g_xceb_d[g_detail_idx].xceb212c,g_xceb_d[g_detail_idx].xceb212d, 
                  g_xceb_d[g_detail_idx].xceb212e,g_xceb_d[g_detail_idx].xceb212f,g_xceb_d[g_detail_idx].xceb212g, 
                  g_xceb_d[g_detail_idx].xceb212h,g_xceb_d[g_detail_idx].xceb222,g_xceb_d[g_detail_idx].xceb222a, 
                  g_xceb_d[g_detail_idx].xceb222b,g_xceb_d[g_detail_idx].xceb222c,g_xceb_d[g_detail_idx].xceb222d, 
                  g_xceb_d[g_detail_idx].xceb222e,g_xceb_d[g_detail_idx].xceb222f,g_xceb_d[g_detail_idx].xceb222g, 
                  g_xceb_d[g_detail_idx].xceb222h) 
         WHERE xcebent = g_enterprise AND xcebld = ps_keys_bak[1] AND xcebdocno = ps_keys_bak[2] AND xcebseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xceb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xceb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axct901_xceb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcec_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axct901_xcec_t_mask_restore('restore_mask_o')
               
      UPDATE xcec_t 
         SET (xcecld,xcecdocno,
              xcecseq
              ,xcec001,xcec003,xcec004,xcec005,xcec101,xcec102,xcec103,xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xceb4_d[g_detail_idx].xcec001,g_xceb4_d[g_detail_idx].xcec003,g_xceb4_d[g_detail_idx].xcec004, 
                  g_xceb4_d[g_detail_idx].xcec005,g_xceb4_d[g_detail_idx].xcec101,g_xceb4_d[g_detail_idx].xcec102, 
                  g_xceb4_d[g_detail_idx].xcec103,g_xceb4_d[g_detail_idx].xcec110,g_xceb4_d[g_detail_idx].xcec117, 
                  g_xceb4_d[g_detail_idx].xcec118,g_xceb4_d[g_detail_idx].xcec114,g_xceb4_d[g_detail_idx].xcec115, 
                  g_xceb4_d[g_detail_idx].xcec116,g_xceb4_d[g_detail_idx].xcec119,g_xceb4_d[g_detail_idx].xcec120, 
                  g_xceb4_d[g_detail_idx].xcec107,g_xceb4_d[g_detail_idx].xcec108,g_xceb4_d[g_detail_idx].xcec109, 
                  g_xceb4_d[g_detail_idx].xcec111,g_xceb4_d[g_detail_idx].xcec112,g_xceb4_d[g_detail_idx].xcec113, 
                  g_xceb4_d[g_detail_idx].xcec121,g_xceb4_d[g_detail_idx].xcec122,g_xceb4_d[g_detail_idx].xcec123, 
                  g_xceb4_d[g_detail_idx].xcec124,g_xceb4_d[g_detail_idx].xcec125,g_xceb4_d[g_detail_idx].xcec126, 
                  g_xceb4_d[g_detail_idx].xcec127,g_xceb4_d[g_detail_idx].xcec128,g_xceb4_d[g_detail_idx].xcec129, 
                  g_xceb4_d[g_detail_idx].xcec130,g_xceb4_d[g_detail_idx].xcec201,g_xceb4_d[g_detail_idx].xcec202, 
                  g_xceb4_d[g_detail_idx].xcec202a,g_xceb4_d[g_detail_idx].xcec202b,g_xceb4_d[g_detail_idx].xcec202c, 
                  g_xceb4_d[g_detail_idx].xcec202d,g_xceb4_d[g_detail_idx].xcec202e,g_xceb4_d[g_detail_idx].xcec202f, 
                  g_xceb4_d[g_detail_idx].xcec202g,g_xceb4_d[g_detail_idx].xcec202h,g_xceb4_d[g_detail_idx].xcec212, 
                  g_xceb4_d[g_detail_idx].xcec212a,g_xceb4_d[g_detail_idx].xcec212b,g_xceb4_d[g_detail_idx].xcec212c, 
                  g_xceb4_d[g_detail_idx].xcec212d,g_xceb4_d[g_detail_idx].xcec212e,g_xceb4_d[g_detail_idx].xcec212f, 
                  g_xceb4_d[g_detail_idx].xcec212g,g_xceb4_d[g_detail_idx].xcec212h,g_xceb4_d[g_detail_idx].xcec222, 
                  g_xceb4_d[g_detail_idx].xcec222a,g_xceb4_d[g_detail_idx].xcec222b,g_xceb4_d[g_detail_idx].xcec222c, 
                  g_xceb4_d[g_detail_idx].xcec222d,g_xceb4_d[g_detail_idx].xcec222e,g_xceb4_d[g_detail_idx].xcec222f, 
                  g_xceb4_d[g_detail_idx].xcec222g,g_xceb4_d[g_detail_idx].xcec222h,g_xceb4_d[g_detail_idx].xcec301, 
                  g_xceb4_d[g_detail_idx].xcec302,g_xceb4_d[g_detail_idx].xceccomp) 
         WHERE xcecent = g_enterprise AND xcecld = ps_keys_bak[1] AND xcecdocno = ps_keys_bak[2] AND xcecseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcec_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axct901_xcec_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axct901_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct901_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct901_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL axct901_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','3',"
   #僅鎖定自身table
   LET ls_group = "xceb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axct901_bcl USING g_enterprise,
                                       g_xcea_m.xceald,g_xcea_m.xceadocno,g_xceb_d[g_detail_idx].xcebseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axct901_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xcec_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axct901_bcl2 USING g_enterprise,
                                             g_xcea_m.xceald,g_xcea_m.xceadocno,g_xceb4_d[g_detail_idx].xcecseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axct901_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct901_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axct901_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axct901_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct901_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xceadocno,xceald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xceald,xceadocno",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct901_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xceald,xceadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xceadocno,xceald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct901_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   #170227-00006#1---s
   CALL cl_set_comp_entry("xceb117,xceb119,xceb120",TRUE)
   CALL cl_set_comp_entry("xcec119,xcec120",TRUE)
   #170227-00006#1---e
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct901_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_glad015     LIKE glad_t.glad015     #专案管理否  #170227-00006#1 add
   DEFINE l_glad016     LIKE glad_t.glad016     #wbs管理    #170227-00006#1 add
   DEFINE l_glad012     LIKE glad_t.glad012     #品类管理   #170227-00006#1 add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   #170227-00006#1---s
   IF NOT cl_null(g_xceb_d[l_ac].xceb101) THEN
      CALL axct901_get_glad(g_xcea_m.xceald,g_xceb_d[l_ac].xceb101) RETURNING l_glad015,l_glad016,l_glad012          
      IF l_glad012 <> 'Y' THEN
         CALL cl_set_comp_entry("xceb117",FALSE)
      END IF
      IF l_glad015 <> 'Y' THEN
         CALL cl_set_comp_entry("xceb119",FALSE)
      END IF
      IF l_glad016 <> 'Y' THEN
         CALL cl_set_comp_entry("xceb120",FALSE)
      END IF
   END IF 
   IF NOT cl_null(g_xceb4_d[l_ac].xcec101) THEN
      CALL axct901_get_glad(g_xcea_m.xceald,g_xceb4_d[l_ac].xcec101) RETURNING l_glad015,l_glad016,l_glad012            
      IF l_glad015 <> 'Y' THEN
         CALL cl_set_comp_entry("xcec119",FALSE)
      END IF
      IF l_glad016 <> 'Y' THEN
         CALL cl_set_comp_entry("xcec120",FALSE)
      END IF
   END IF 
   #170227-00006#1---e
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct901_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct901_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_xcea_m.xceastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct901_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct901.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct901_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct901_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   DEFINE ls_wc1  STRING
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   LET ls_wc1 = ls_wc
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xceald = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xceadocno = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
 
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xcea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xceb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xcec_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
  LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc1, " xcea002 = '", g_argv[1], "' AND "
   END IF
   #liuym151208 add------------S-----
      IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc1, " xceald = '", g_argv[04], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc1, " xceadocno = '", g_argv[05], "' AND "
   END IF
   #liuym151208 add------------E-----
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc1, " xceald = '", g_argv[04], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc1, " xceadocno = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   CASE g_argv[1]
      WHEN '1' LET g_prog_name1 = 'axct901' 
      WHEN '2' LET g_prog_name1 = 'axct902'
      WHEN '3' LET g_prog_name1 = 'axct903'
      WHEN '4' LET g_prog_name1 = 'axct904'
      WHEN '5' LET g_prog_name1 = 'axct905'
      WHEN '6' LET g_prog_name1 = 'axct906' 
      WHEN '7' LET g_prog_name1 = 'axct907'
      WHEN '8' LET g_prog_name1 = 'axct908'
      WHEN '9' LET g_prog_name1 = 'axct909'
      WHEN '10' LET g_prog_name1 = 'axct910'
      WHEN '11' LET g_prog_name1 = 'axct911' #add zhangllc 151009
      WHEN '12' LET g_prog_name1 = 'axct912' #add zhangllc 151009
      WHEN '13' LET g_prog_name1 = 'axct913' #add zhujing 2015-12-15
      WHEN '14' LET g_prog_name1 = 'axct914' #add zhujing 2015-12-15
   END CASE
   IF cl_null(g_argv[04]) AND cl_null(g_argv[05]) THEN
      LET g_wc = ' 1=2'    #不要自动打开查询,会很慢
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axct901_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_glaa121   LIKE glaa_t.glaa121
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_chr       LIKE type_t.chr1
   DEFINE l_slip      LIKE xcea_t.xceadocno
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
#因为pattern的改变，创建临时表要放在这里，事务开始前
   DROP TABLE axct901_tmp01          #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
#   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE axct901_glgb_tmp AS ",
#                "SELECT * FROM glgb_t WHERE 1=2 "
#   PREPARE glgb_tbl FROM l_sql
#   EXECUTE glgb_tbl
#   FREE glgb_tbl
   CREATE TEMP TABLE axct901_tmp01
   ( glgb001     LIKE glgb_t.glgb001,     #摘要                        
     glgb002     LIKE glgb_t.glgb002,     #科目编号                    
     glgb003     LIKE glgb_t.glgb003,     #借方金额                    
     glgb004     LIKE glgb_t.glgb004,     #贷方金额                    
     glgb005     LIKE glgb_t.glgb005,     #交易币别                    
     glgb006     LIKE glgb_t.glgb006,     #汇率                        
     glgb007     LIKE glgb_t.glgb007,     #计价单位                    
     glgb008     LIKE glgb_t.glgb008,     #数量                        
     glgb009     LIKE glgb_t.glgb009,     #单价                        
     glgb010     LIKE glgb_t.glgb010,     #原币金额                    
     glgb011     LIKE glgb_t.glgb011,     #票据号码                    
     glgb012     LIKE glgb_t.glgb012,     #票据日期                    
     glgb013     LIKE glgb_t.glgb013,     #收付对象                    
     glgb014     LIKE glgb_t.glgb014,     #银行帐号                    
     glgb015     LIKE glgb_t.glgb015,     #结算方式                    
     glgb016     LIKE glgb_t.glgb016,     #收支项目                    
     glgb017     LIKE glgb_t.glgb017,     #营运据点                    
     glgb018     LIKE glgb_t.glgb018,     #部门                        
     glgb019     LIKE glgb_t.glgb019,     #利润/成本中心               
     glgb020     LIKE glgb_t.glgb020,     #区域                        
     glgb021     LIKE glgb_t.glgb021,     #交易客商                    
     glgb022     LIKE glgb_t.glgb022,     #账款客商                    
     glgb023     LIKE glgb_t.glgb023,     #客群                        
     glgb024     LIKE glgb_t.glgb024,     #产品类别                    
     glgb025     LIKE glgb_t.glgb025,     #人员                        
     glgb026     LIKE glgb_t.glgb026,     #预算编号（20140904改为nouse)
     glgb027     LIKE glgb_t.glgb027,     #专案编号                    
     glgb028     LIKE glgb_t.glgb028,     #WBS                         
     glgb029     LIKE glgb_t.glgb029,     #自由核算项一                
     glgb030     LIKE glgb_t.glgb030,     #自由核算项二                
     glgb031     LIKE glgb_t.glgb031,     #自由核算项三                
     glgb032     LIKE glgb_t.glgb032,     #自由核算项四                
     glgb033     LIKE glgb_t.glgb033,     #自由核算项五                
     glgb034     LIKE glgb_t.glgb034,     #自由核算项六                
     glgb035     LIKE glgb_t.glgb035,     #自由核算项七                
     glgb036     LIKE glgb_t.glgb036,     #自由核算项八                
     glgb037     LIKE glgb_t.glgb037,     #自由核算项九                
     glgb038     LIKE glgb_t.glgb038,     #自由核算项十                
     glgb039     LIKE glgb_t.glgb039,     #汇率(本位币二)              
     glgb040     LIKE glgb_t.glgb040,     #借方金额(本位币二)          
     glgb041     LIKE glgb_t.glgb041,     #贷方金额(本位币二)          
     glgb042     LIKE glgb_t.glgb042,     #汇率(本位币三)              
     glgb043     LIKE glgb_t.glgb043,     #借方金额(本位币三)          
     glgb044     LIKE glgb_t.glgb044,     #贷方金额(本位币三)          
     glgb051     LIKE glgb_t.glgb051,     #经营方式                    
     glgb052     LIKE glgb_t.glgb052,     #渠道                        
     glgb053     LIKE glgb_t.glgb053,     #品牌                        
     glgb054     LIKE glgb_t.glgb054,     #银行存提码                  
     glgb055     LIKE glgb_t.glgb055,     #现金变动码                  
     glgb056     LIKE glgb_t.glgb056,     #银行账户                    
     glgb100     LIKE glgb_t.glgb100,     #系统别                      
     glgb101     LIKE glgb_t.glgb101,     #类别                        
     glgbcomp    LIKE glgb_t.glgbcomp,    #营运据点(法人)              
     glgbdocno   LIKE glgb_t.glgbdocno,   #单据编号                    
     glgbent     LIKE glgb_t.glgbent,     #企业编号                    
     glgbld      LIKE glgb_t.glgbld,      #账别(套)编号                
     glgbseq     LIKE glgb_t.glgbseq     #项次                        
     );
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE TEMP TABLE axct901_tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF 
   
   IF NOT axct701_02_create_tmp_table() THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xcea_m.xceald IS NULL
      OR g_xcea_m.xceadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axct901_cl USING g_enterprise,g_xcea_m.xceald,g_xcea_m.xceadocno
   IF STATUS THEN
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct901_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald,g_xcea_m.xceadocno, 
       g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea004, 
       g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp, 
       g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt, 
       g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt,g_xcea_m.xceald_desc, 
       g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc,g_xcea_m.xceaownid_desc, 
       g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT axct901_action_chk() THEN
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceald_desc,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xceasite_desc, 
       g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc,g_xcea_m.xcea002,g_xcea_m.xcea006,g_xcea_m.xcea006_desc, 
       g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea003_desc,g_xcea_m.xcea101,g_xcea_m.xceastus, 
       g_xcea_m.xceaownid,g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid, 
       g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid, 
       g_xcea_m.xceamodid_desc,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt, 
       g_xcea_m.xceapstid,g_xcea_m.xceapstid_desc,g_xcea_m.xceapstdt
 
   CASE g_xcea_m.xceastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xcea_m.xceastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
#将一些不能切换的状态给隐藏掉，比如post时只能切confimed，不可切unconfirmed和invalid 
         IF g_xcea_m.xceastus = 'X' THEN
            CLOSE axct901_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         
         HIDE OPTION "signing"
         HIDE OPTION "withdraw"
         HIDE OPTION "closed"
         HIDE OPTION "hold"
         
         CASE g_xcea_m.xceastus
            WHEN "N"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  SHOW OPTION "signing"
                  HIDE OPTION "confirmed"
               END IF
            WHEN "X"
               HIDE OPTION "invalid"
               HIDE OPTION "confirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"               
               HIDE OPTION "hold"
            WHEN "Y"
               HIDE OPTION "confirmed"
               HIDE OPTION "invalid"
               HIDE OPTION "hold"
               HIDE OPTION "unposted"
            WHEN "S"
               HIDE OPTION "posted"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "invalid" 
               HIDE OPTION "confirmed"
            WHEN "R"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "D"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
                SHOW OPTION "withdraw"  
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "confirmed"
                HIDE OPTION "hold"
            
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
                SHOW OPTION "confirmed" 
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "hold"        
         END CASE  
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axct901_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axct901_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axct901_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axct901_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            IF NOT cl_ask_confirm('aim-00110') THEN
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            IF NOT axct901_unconf_chk() THEN 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               RETURN 
            END IF
            #检查若有凭证，不可取消审核
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            IF NOT cl_ask_confirm('aim-00108') THEN
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            IF NOT axct901_conf_chk() THEN 
               CLOSE axct901_cl
               CALL s_transaction_end('N','0')
               RETURN 
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      g_xcea_m.xceastus = lc_state OR cl_null(lc_state) THEN
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
#update 少了确认人员和日期，sql又不能改，只能自己写，下面pattern的sql不走
   #分錄#
   CALL s_ld_sel_glaa(g_xcea_m.xceald,'glaa121') RETURNING l_success,l_glaa121   
   CALL s_aooi200_fin_get_slip(g_xcea_m.xceadocno) RETURNING l_success,l_slip
   CALL s_fin_get_doc_para(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip,'D-FIN-0030') RETURNING l_chr
   
   CASE lc_state
    WHEN 'Y' 
      LET g_xcea_m.xceacnfdt = cl_get_current()
      UPDATE xcea_t SET xceastus = lc_state,
                        xceacnfid = g_user,
                        xceacnfdt = g_xcea_m.xceacnfdt                    
       WHERE xceaent = g_enterprise 
         AND xceald = g_xcea_m.xceald
         AND xceadocno = g_xcea_m.xceadocno

      IF l_glaa121 = 'Y' AND l_chr = 'Y'THEN
         UPDATE glga_t SET glgastus  = lc_state,
                           glgacnfid = g_user,
                           glgacnfdt = g_xcea_m.xceacnfdt
          WHERE glgaent = g_enterprise
            AND glgald  = g_xcea_m.xceald 
            AND glgadocno = g_xcea_m.xceadocno

      END IF
   WHEN 'N'
      UPDATE xcea_t SET xceastus = lc_state,
                        xceacnfid = '',
                        xceacnfdt = ''                    
       WHERE xceaent = g_enterprise 
         AND xceald = g_xcea_m.xceald
         AND xceadocno = g_xcea_m.xceadocno
         
      IF l_glaa121 = 'Y' AND l_chr = 'Y'THEN
         UPDATE glga_t SET glgastus  = lc_state,
                           glgacnfid = '',
                           glgacnfdt = ''
          WHERE glgaent = g_enterprise
            AND glgald  = g_xcea_m.xceald 
            AND glgadocno = g_xcea_m.xceadocno

      END IF         
   END CASE
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE axct901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL axct901_refresh_stus()
   CALL s_transaction_end('Y','0')
   RETURN
   #end add-point
   
   LET g_xcea_m.xceamodid = g_user
   LET g_xcea_m.xceamoddt = cl_get_current()
   LET g_xcea_m.xceastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xcea_t 
      SET (xceastus,xceamodid,xceamoddt) 
        = (g_xcea_m.xceastus,g_xcea_m.xceamodid,g_xcea_m.xceamoddt)     
    WHERE xceaent = g_enterprise AND xceald = g_xcea_m.xceald
      AND xceadocno = g_xcea_m.xceadocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axct901_master_referesh USING g_xcea_m.xceald,g_xcea_m.xceadocno INTO g_xcea_m.xceald, 
          g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xcea002,g_xcea_m.xcea006, 
          g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid, 
          g_xcea_m.xceaowndp,g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid, 
          g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstdt, 
          g_xcea_m.xceald_desc,g_xcea_m.xceasite_desc,g_xcea_m.xceacomp_desc,g_xcea_m.xcea006_desc,g_xcea_m.xcea003_desc, 
          g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp_desc, 
          g_xcea_m.xceamodid_desc,g_xcea_m.xceacnfid_desc,g_xcea_m.xceapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xcea_m.xceald,g_xcea_m.xceald_desc,g_xcea_m.xceadocno,g_xcea_m.xceasite,g_xcea_m.xceasite_desc, 
          g_xcea_m.xcea001,g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc,g_xcea_m.xcea002,g_xcea_m.xcea006, 
          g_xcea_m.xcea006_desc,g_xcea_m.xcea004,g_xcea_m.xcea005,g_xcea_m.xcea003,g_xcea_m.xcea003_desc, 
          g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp, 
          g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid,g_xcea_m.xceacrtid_desc,g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc, 
          g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamodid_desc,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid, 
          g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt,g_xcea_m.xceapstid,g_xcea_m.xceapstid_desc,g_xcea_m.xceapstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axct901_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct901_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct901.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct901_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xceb_d.getLength() THEN
         LET g_detail_idx = g_xceb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xceb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xceb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_xceb4_d.getLength() THEN
         LET g_detail_idx = g_xceb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xceb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xceb4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail8")
      IF g_detail_idx > g_xceb8_d.getLength() THEN
         LET g_detail_idx = g_xceb8_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xceb8_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xceb8_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct901_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axct901_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct901_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct901.status_show" >}
PRIVATE FUNCTION axct901_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct901.mask_functions" >}
&include "erp/axc/axct901_mask.4gl"
 
{</section>}
 
{<section id="axct901.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axct901_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL axct901_show()
   CALL axct901_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xcea_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xceb_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_xceb4_d))
   CALL cl_bpm_set_detail_data("s_detail8", util.JSONArray.fromFGL(g_xceb8_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL axct901_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axct901_ui_headershow()
   CALL axct901_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axct901_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axct901_ui_headershow()  
   CALL axct901_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axct901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct901_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xcea_m.xceald
   LET g_pk_array[1].column = 'xceald'
   LET g_pk_array[2].values = g_xcea_m.xceadocno
   LET g_pk_array[2].column = 'xceadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct901.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axct901.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct901_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL axct901_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct901.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axct901_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct901.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取帳套說明
# Memo...........:
# Usage..........: CALL axct901_get_xceald_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceald_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceald_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取法人說明
# Memo...........:
# Usage..........: CALL axct901_get_xceacomp_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceacomp_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xceacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xceacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xceacomp_desc
END FUNCTION

################################################################################
# Descriptions...: 帳務人員說明
# Memo...........:
# Usage..........: CALL axct901_get_xcea006_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xcea006_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xcea006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xcea_m.xcea006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xcea006_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取成本計算類型
# Memo...........:
# Usage..........: CALL axct901_get_xcea003_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xcea003_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcea_m.xcea003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcea_m.xcea003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcea_m.xcea003_desc
END FUNCTION

################################################################################
# Descriptions...: 建立xceb,xcec臨時表--為顯示小計合計
# Memo...........:
# Usage..........: CALL axct901_create_tmp()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_create_tmp()
DROP TABLE axct901_tmp02              #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02

   CREATE TEMP TABLE axct901_tmp02
   (
   flag         LIKE type_t.num5,               #1:小計；2:合計；0:明細
   xcebseq      LIKE xceb_t.xcebseq,      
   xceb001      LIKE xceb_t.xceb001,      
   xceb003      LIKE xceb_t.xceb003,      
   xceb004      LIKE xceb_t.xceb004,      
   xceb005      LIKE xceb_t.xceb005,      
   xceb101      LIKE xceb_t.xceb101,      
   xceb101_desc LIKE glacl_t.glacl004,
   xceb102      LIKE xceb_t.xceb102,      
   xceb103      LIKE xceb_t.xceb103,      
   xceb103_desc LIKE xcbfl_t.xcbfl003, 
   xceb110      LIKE xceb_t.xceb110,      
   xceb117      LIKE xceb_t.xceb117,      
   xceb118      LIKE xceb_t.xceb118,      
   xceb114      LIKE xceb_t.xceb114,      
   xceb115      LIKE xceb_t.xceb115,      
   xceb116      LIKE xceb_t.xceb116,      
   xceb119      LIKE xceb_t.xceb119,      
   xceb120      LIKE xceb_t.xceb120,      
   xceb107      LIKE xceb_t.xceb107,      
   xceb108      LIKE xceb_t.xceb108,      
   xceb109      LIKE xceb_t.xceb109,      
   xceb111      LIKE xceb_t.xceb111,      
   xceb111_desc LIKE pmaal_t.pmaal003, 
   xceb112      LIKE xceb_t.xceb112,      
   xceb113      LIKE xceb_t.xceb113,      
   xceb121      LIKE xceb_t.xceb121,      
   xceb122      LIKE xceb_t.xceb122,      
   xceb123      LIKE xceb_t.xceb123,      
   xceb124      LIKE xceb_t.xceb124,      
   xceb125      LIKE xceb_t.xceb125,      
   xceb126      LIKE xceb_t.xceb126,      
   xceb127      LIKE xceb_t.xceb127,      
   xceb128      LIKE xceb_t.xceb128,      
   xceb129      LIKE xceb_t.xceb129,      
   xceb130      LIKE xceb_t.xceb130,      
   xceb201      LIKE xceb_t.xceb201,      
   xceb202      LIKE xceb_t.xceb202,      
   xceb202a     LIKE xceb_t.xceb202a,     
   xceb202b     LIKE xceb_t.xceb202b,     
   xceb202c     LIKE xceb_t.xceb202c,     
   xceb202d     LIKE xceb_t.xceb202d,     
   xceb202e     LIKE xceb_t.xceb202e,     
   xceb202f     LIKE xceb_t.xceb202f,     
   xceb202g     LIKE xceb_t.xceb202g,     
   xceb202h     LIKE xceb_t.xceb202h,     
   xceb212      LIKE xceb_t.xceb212,      
   xceb212a     LIKE xceb_t.xceb212a,     
   xceb212b     LIKE xceb_t.xceb212b,     
   xceb212c     LIKE xceb_t.xceb212c,     
   xceb212d     LIKE xceb_t.xceb212d,     
   xceb212e     LIKE xceb_t.xceb212e,     
   xceb212f     LIKE xceb_t.xceb212f,     
   xceb212g     LIKE xceb_t.xceb212g,     
   xceb212h     LIKE xceb_t.xceb212h,     
   xceb222      LIKE xceb_t.xceb222,      
   xceb222a     LIKE xceb_t.xceb222a,     
   xceb222b     LIKE xceb_t.xceb222b,     
   xceb222c     LIKE xceb_t.xceb222c,     
   xceb222d     LIKE xceb_t.xceb222d,     
   xceb222e     LIKE xceb_t.xceb222e,     
   xceb222f     LIKE xceb_t.xceb222f,     
   xceb222g     LIKE xceb_t.xceb222g,     
   xceb222h     LIKE xceb_t.xceb222h,     
   xceb301      LIKE xceb_t.xceb301,      
   xceb302      LIKE xceb_t.xceb302,      
   xcebcomp     LIKE xceb_t.xcebcomp     
    );
    
   DROP TABLE axct901_tmp03         #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03   

   CREATE TEMP TABLE axct901_tmp03 
   (
   flag         LIKE type_t.num5,                   #1:小計；2:合計；0:明細
   xcecseq      LIKE xcec_t.xcecseq,     
   xcec001      LIKE xcec_t.xcec001,     
   xcec003      LIKE xcec_t.xcec003,     
   xcec004      LIKE xcec_t.xcec004,     
   xcec005      LIKE xcec_t.xcec005,     
   xcec101      LIKE xcec_t.xcec101,     
   xcec101_desc LIKE glacl_t.glacl004,
   xcec102      LIKE xcec_t.xcec102,     
   xcec103      LIKE xcec_t.xcec103,     
   xcec103_desc LIKE xcbfl_t.xcbfl003,
   xcec110      LIKE xcec_t.xcec110,     
   xcec117      LIKE xcec_t.xcec117,     
   xcec118      LIKE xcec_t.xcec118,     
   xcec114      LIKE xcec_t.xcec114,     
   xcec115      LIKE xcec_t.xcec115,     
   xcec116      LIKE xcec_t.xcec116,     
   xcec119      LIKE xcec_t.xcec119,     
   xcec120      LIKE xcec_t.xcec120,     
   xcec107      LIKE xcec_t.xcec107,     
   xcec108      LIKE xcec_t.xcec108,     
   xcec109      LIKE xcec_t.xcec109,     
   xcec111      LIKE xcec_t.xcec111,     
   xcec111_desc LIKE pmaal_t.pmaal003,
   xcec112      LIKE xcec_t.xcec112,     
   xcec113      LIKE xcec_t.xcec113,     
   xcec121      LIKE xcec_t.xcec121,     
   xcec122      LIKE xcec_t.xcec122,     
   xcec123      LIKE xcec_t.xcec123,     
   xcec124      LIKE xcec_t.xcec124,     
   xcec125      LIKE xcec_t.xcec125,     
   xcec126      LIKE xcec_t.xcec126,     
   xcec127      LIKE xcec_t.xcec127,     
   xcec128      LIKE xcec_t.xcec128,     
   xcec129      LIKE xcec_t.xcec129,     
   xcec130      LIKE xcec_t.xcec130,     
   xcec201      LIKE xcec_t.xcec201,     
   xcec202      LIKE xcec_t.xcec202,     
   xcec202a     LIKE xcec_t.xcec202a,    
   xcec202b     LIKE xcec_t.xcec202b,    
   xcec202c     LIKE xcec_t.xcec202c,    
   xcec202d     LIKE xcec_t.xcec202d,    
   xcec202e     LIKE xcec_t.xcec202e,    
   xcec202f     LIKE xcec_t.xcec202f,    
   xcec202g     LIKE xcec_t.xcec202g,    
   xcec202h     LIKE xcec_t.xcec202h,    
   xcec212      LIKE xcec_t.xcec212,     
   xcec212a     LIKE xcec_t.xcec212a,    
   xcec212b     LIKE xcec_t.xcec212b,    
   xcec212c     LIKE xcec_t.xcec212c,    
   xcec212d     LIKE xcec_t.xcec212d,    
   xcec212e     LIKE xcec_t.xcec212e,    
   xcec212f     LIKE xcec_t.xcec212f,    
   xcec212g     LIKE xcec_t.xcec212g,    
   xcec212h     LIKE xcec_t.xcec212h,    
   xcec222      LIKE xcec_t.xcec222,     
   xcec222a     LIKE xcec_t.xcec222a,    
   xcec222b     LIKE xcec_t.xcec222b,    
   xcec222c     LIKE xcec_t.xcec222c,    
   xcec222d     LIKE xcec_t.xcec222d,    
   xcec222e     LIKE xcec_t.xcec222e,    
   xcec222f     LIKE xcec_t.xcec222f,    
   xcec222g     LIKE xcec_t.xcec222g,    
   xcec222h     LIKE xcec_t.xcec222h,    
   xcec301      LIKE xcec_t.xcec301,     
   xcec302      LIKE xcec_t.xcec302,     
   xceccomp     LIKE xcec_t.xceccomp    
    );       
END FUNCTION

################################################################################
# Descriptions...: 臨時表新增資料并顯示明細+小計+合計
# Memo...........:
# Usage..........: CALL axct901_b_fill1()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill1()
DEFINE l_flag        LIKE type_t.num5
   
   CALL axct901_create_tmp()
   DELETE FROM axct901_tmp02      #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
   DELETE FROM axct901_tmp03      #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
   
   #20150731--add--str--lujh
   CALL g_xceb9_d.clear()    
   CALL g_xceb10_d.clear()
   #20150731--add--end--lujh
   
   CALL axct901_get_glaa()
   
   #ins 明細資料-彙總單身
   IF axct901_fill_chk(1) THEN   
      LET g_sql = " INSERT INTO axct901_tmp02 ",        #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
          "SELECT  UNIQUE 0,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,'',xceb102,xceb103,'',xceb110,xceb117,xceb118,xceb114,xceb115,xceb116, 
          xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,'',xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,
          xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h, 
          xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a, 
          xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp FROM xceb_t",   
                  " INNER JOIN xcea_t ON xceaent = xcebent AND xceald = xcebld ", #170215-00016#1 add ent
                  " AND xceadocno = xcebdocno ",
                  " WHERE xcebent='",g_enterprise,"' AND xcebld='",g_xcea_m.xceald,"'",
                  "   AND xcebdocno= '",g_xcea_m.xceadocno,"'"
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      LET g_sql = g_sql, " ORDER BY xceb_t.xcebseq"	
      PREPARE axct901_xceb_tmp_prep FROM g_sql
      EXECUTE axct901_xceb_tmp_prep 
      
      IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
         #ins 小計
         LET g_sql = " INSERT INTO axct901_tmp02 ",            #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
             "SELECT  UNIQUE 1,0,xceb001,'','','','','','','','','','','','','','',
             '','','','','','','','','','','','','','','','','','','',
              SUM(xceb202),SUM(xceb202a),SUM(xceb202b),SUM(xceb202c),SUM(xceb202d),SUM(xceb202e),
              SUM(xceb202f),SUM(xceb202g),SUM(xceb202h), 
              SUM(xceb212),SUM(xceb212a),SUM(xceb212b),SUM(xceb212c),SUM(xceb212d),SUM(xceb212e),SUM(xceb212f),
              SUM(xceb212g),SUM(xceb212h),SUM(xceb222),SUM(xceb222a), 
              SUM(xceb222b),SUM(xceb222c),SUM(xceb222d),SUM(xceb222e),SUM(xceb222f),SUM(xceb222g),SUM(xceb222h),'',0,''
               FROM axct901_tmp02 WHERE flag = 0 " ,      #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
               " GROUP BY xceb001 ",
               " ORDER BY xceb001"
         PREPARE axct901_xceb_tmp_prep1 FROM g_sql
         EXECUTE axct901_xceb_tmp_prep1 
      END IF
      
      #合計
      LET g_sql = " INSERT INTO axct901_tmp02 ",          #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
          "SELECT  UNIQUE 2,0,'','','','','','','','','','', '','','','','',
          '','','','','','','','','','','','','','','','','','','',
           SUM(xceb202),SUM(xceb202a),SUM(xceb202b),SUM(xceb202c),SUM(xceb202d),SUM(xceb202e),
           SUM(xceb202f),SUM(xceb202g),SUM(xceb202h), 
           SUM(xceb212),SUM(xceb212a),SUM(xceb212b),SUM(xceb212c),SUM(xceb212d),SUM(xceb212e),SUM(xceb212f),
           SUM(xceb212g),SUM(xceb212h),SUM(xceb222),SUM(xceb222a), 
           SUM(xceb222b),SUM(xceb222c),SUM(xceb222d),SUM(xceb222e),SUM(xceb222f),SUM(xceb222g),SUM(xceb222h),'',0,'' ",
            "FROM axct901_tmp02 "             #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
      IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN     
         LET g_sql = g_sql ," WHERE flag = 1 ORDER BY xceb001 "    
      ELSE   
         LET g_sql = g_sql ," WHERE flag = 0 ORDER BY xceb004 " 
      END IF      

      PREPARE axct901_xceb_tmp_prep2 FROM g_sql
      EXECUTE axct901_xceb_tmp_prep2
      
      #顯示
      LET g_sql = "SELECT UNIQUE flag,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,t1.glacl004,xceb102,xceb103,t2.xcbfl003,xceb110,xceb117,xceb118,xceb114,xceb115,xceb116,  
          xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,t3.pmaal003,xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,
          xceb201,xceb202,xceb202a,xceb202b,xceb202c,xceb202d,xceb202e,xceb202f,xceb202g,xceb202h, 
          xceb212,xceb212a,xceb212b,xceb212c,xceb212d,xceb212e,xceb212f,xceb212g,xceb212h,xceb222,xceb222a, 
          xceb222b,xceb222c,xceb222d,xceb222e,xceb222f,xceb222g,xceb222h,xceb301,xceb302,xcebcomp,t4.ooag011,t5.ooefl003,t6.pmaal003 FROM axct901_tmp02 ",   #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
          " LEFT OUTER JOIN glacl_t t1 ON glaclent ='",g_enterprise,"' AND glacl001 ='",g_glaa004,"' AND glacl002 = xceb101 AND glacl003 ='",g_dlang,"'",
          " LEFT OUTER JOIN xcbfl_t t2 ON xcbflent ='",g_enterprise,"' AND xcbflcomp = xcebcomp AND xcbfl001 = xceb103 AND xcbfl002 ='",g_dlang,"'",
          " LEFT OUTER JOIN pmaal_t t3 ON t3.pmaalent ='",g_enterprise,"' AND t3.pmaal001 = xceb111 AND t3.pmaal002 ='",g_dlang,"'",
          " LEFT OUTER JOIN ooag_t t4 ON ooagent ='",g_enterprise,"' AND ooag001 = xceb107",
          " LEFT OUTER JOIN ooefl_t t5 ON ooeflent ='",g_enterprise,"' AND ooefl001 = xceb108 AND ooefl002 ='",g_dlang,"'",
          " LEFT OUTER JOIN pmaal_t t6 ON t6.pmaalent ='",g_enterprise,"' AND t6.pmaal001 = xceb109 AND t6.pmaal002 ='",g_dlang,"'"      
      
      LET g_sql = g_sql, " ORDER BY xceb001,flag,xcebseq"
      #end add-point
      
      PREPARE axct901_pb_1 FROM g_sql
      DECLARE b_fill_cs_1 CURSOR FOR axct901_pb_1
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                         
      FOREACH b_fill_cs_1 INTO l_flag,g_xceb_d[l_ac].xcebseq,g_xceb_d[l_ac].xceb001,
          g_xceb_d[l_ac].xceb003,g_xceb_d[l_ac].xceb004,g_xceb_d[l_ac].xceb005, 
          g_xceb_d[l_ac].xceb101,g_xceb_d[l_ac].xceb101_desc,
          g_xceb_d[l_ac].xceb102,g_xceb_d[l_ac].xceb103,g_xceb_d[l_ac].xceb103_desc, 
          g_xceb_d[l_ac].xceb110,g_xceb_d[l_ac].xceb117,g_xceb_d[l_ac].xceb118,g_xceb_d[l_ac].xceb114,
          g_xceb_d[l_ac].xceb115,g_xceb_d[l_ac].xceb116,          
          g_xceb_d[l_ac].xceb119,g_xceb_d[l_ac].xceb120,
          g_xceb_d[l_ac].xceb107,g_xceb_d[l_ac].xceb108,g_xceb_d[l_ac].xceb109,
          g_xceb_d[l_ac].xceb111,g_xceb_d[l_ac].xceb111_desc,
          g_xceb_d[l_ac].xceb112,g_xceb_d[l_ac].xceb113,
          g_xceb_d[l_ac].xceb121,g_xceb_d[l_ac].xceb122,
          g_xceb_d[l_ac].xceb123,g_xceb_d[l_ac].xceb124,
          g_xceb_d[l_ac].xceb125,g_xceb_d[l_ac].xceb126,
          g_xceb_d[l_ac].xceb127,g_xceb_d[l_ac].xceb128,
          g_xceb_d[l_ac].xceb129,g_xceb_d[l_ac].xceb130,
          g_xceb_d[l_ac].xceb201,g_xceb_d[l_ac].xceb202, 
          g_xceb_d[l_ac].xceb202a,g_xceb_d[l_ac].xceb202b,g_xceb_d[l_ac].xceb202c,g_xceb_d[l_ac].xceb202d, 
          g_xceb_d[l_ac].xceb202e,g_xceb_d[l_ac].xceb202f,g_xceb_d[l_ac].xceb202g,g_xceb_d[l_ac].xceb202h, 
          g_xceb_d[l_ac].xceb212,g_xceb_d[l_ac].xceb212a,g_xceb_d[l_ac].xceb212b,g_xceb_d[l_ac].xceb212c, 
          g_xceb_d[l_ac].xceb212d,g_xceb_d[l_ac].xceb212e,g_xceb_d[l_ac].xceb212f,g_xceb_d[l_ac].xceb212g, 
          g_xceb_d[l_ac].xceb212h,g_xceb_d[l_ac].xceb222,g_xceb_d[l_ac].xceb222a,g_xceb_d[l_ac].xceb222b, 
          g_xceb_d[l_ac].xceb222c,g_xceb_d[l_ac].xceb222d,g_xceb_d[l_ac].xceb222e,g_xceb_d[l_ac].xceb222f, 
          g_xceb_d[l_ac].xceb222g,g_xceb_d[l_ac].xceb222h,
          g_xceb_d[l_ac].xceb301,g_xceb_d[l_ac].xceb302,g_xceb_d[l_ac].xcebcomp,g_xceb_d[l_ac].xceb107_desc,g_xceb_d[l_ac].xceb108_desc,g_xceb_d[l_ac].xceb109_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xceb:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
            IF l_flag = 1 THEN
               LET g_xceb_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb_d[l_ac].xceb001  #顯示小計
            END IF
            IF l_flag = 2 THEN
               LET g_xceb_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb_d[l_ac].xceb001  #顯示合計
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb_d[l_ac].xceb103  #顯示小計
            END IF
            IF l_flag = 2 THEN
               LET g_xceb_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb_d[l_ac].xceb103  #顯示合計
            END IF          
         END IF   
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF         
      END FOREACH
      LET g_error_show = 0  
   END IF
   
   #ins 明細資料-明細單身
   IF axct901_fill_chk(2) THEN
      LET g_sql = " INSERT INTO axct901_tmp03 ",    #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
          "SELECT  UNIQUE 0,xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,'',xcec102,xcec103,'',xcec110,xcec117,xcec118,xcec114,xcec115,xcec116, 
          xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,'',xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,
          xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h, 
          xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a, 
          xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp FROM xcec_t",              
                  " INNER JOIN xcea_t ON xceaent = xcecent AND xceald = xcecld ", #170215-00016#1 add ent
                  " AND xceadocno = xcecdocno ",
                  " WHERE xcecent='",g_enterprise,"' AND xcecld='",g_xcea_m.xceald,"'",
                  "   AND xcecdocno='",g_xcea_m.xceadocno,"'"   

      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY xcec_t.xcecseq"
      PREPARE axct901_xcec_tmp_prep FROM g_sql
      EXECUTE axct901_xcec_tmp_prep 
      
      IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
         #小計
         LET g_sql = " INSERT INTO axct901_tmp03 ",          #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
             "SELECT  UNIQUE 1,0,xcec001,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
              SUM(xcec202),SUM(xcec202a),SUM(xcec202b),SUM(xcec202c),SUM(xcec202d),SUM(xcec202e),SUM(xcec202f),SUM(xcec202g),SUM(xcec202h), 
              SUM(xcec212),SUM(xcec212a),SUM(xcec212b),SUM(xcec212c),SUM(xcec212d),SUM(xcec212e),SUM(xcec212f),SUM(xcec212g),SUM(xcec212h),SUM(xcec222),SUM(xcec222a), 
              SUM(xcec222b),SUM(xcec222c),SUM(xcec222d),SUM(xcec222e),SUM(xcec222f),SUM(xcec222g),SUM(xcec222h),'',0,'' ",
             " FROM axct901_tmp03  WHERE flag = 0",          #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
             " GROUP BY xcec001 ",
             " ORDER BY xcec001"
             
         PREPARE axct901_xcec_tmp_prep1 FROM g_sql
         EXECUTE axct901_xcec_tmp_prep1    
      END IF
      
      #合計
      LET g_sql = " INSERT INTO axct901_tmp03 ",          #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
          "SELECT  UNIQUE 2,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
           SUM(xcec202),SUM(xcec202a),SUM(xcec202b),SUM(xcec202c),SUM(xcec202d),SUM(xcec202e),SUM(xcec202f),SUM(xcec202g),SUM(xcec202h), 
           SUM(xcec212),SUM(xcec212a),SUM(xcec212b),SUM(xcec212c),SUM(xcec212d),SUM(xcec212e),SUM(xcec212f),SUM(xcec212g),SUM(xcec212h),SUM(xcec222),SUM(xcec222a), 
           SUM(xcec222b),SUM(xcec222c),SUM(xcec222d),SUM(xcec222e),SUM(xcec222f),SUM(xcec222g),SUM(xcec222h),'',0,'' ",
          " FROM axct901_tmp03  "                         #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
          
      IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN     
         LET g_sql = g_sql ," WHERE flag = 1 ORDER BY xcec001 "    
      ELSE   
         LET g_sql = g_sql ," WHERE flag = 0 ORDER BY xcec004 " 
      END IF
      
      PREPARE axct901_xcec_tmp_prep2 FROM g_sql
      EXECUTE axct901_xcec_tmp_prep2
      
      #顯示
      LET g_sql = " SELECT UNIQUE flag,xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,t1.glacl004,xcec102,xcec103,t2.xcbfl003,xcec110,xcec117,xcec118,xcec114,xcec115,xcec116, 
          xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,t3.pmaal003,xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,
          xcec201,xcec202,xcec202a,xcec202b,xcec202c,xcec202d,xcec202e,xcec202f,xcec202g,xcec202h, 
          xcec212,xcec212a,xcec212b,xcec212c,xcec212d,xcec212e,xcec212f,xcec212g,xcec212h,xcec222,xcec222a, 
          xcec222b,xcec222c,xcec222d,xcec222e,xcec222f,xcec222g,xcec222h,xcec301,xcec302,xceccomp,t4.ooag011,t5.ooefl003,t6.pmaal003 ",
          "  FROM axct901_tmp03 ",     #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03
          " LEFT OUTER JOIN glacl_t t1 ON glaclent ='",g_enterprise,"' AND glacl001 ='",g_glaa004,"' AND glacl002 = xcec101 AND glacl003 ='",g_dlang,"'",
          " LEFT OUTER JOIN xcbfl_t t2 ON xcbflent ='",g_enterprise,"' AND xcbflcomp = xceccomp AND xcbfl001 = xcec103 AND xcbfl002 ='",g_dlang,"'",
          " LEFT OUTER JOIN pmaal_t t3 ON t3.pmaalent ='",g_enterprise,"' AND t3.pmaal001 = xcec111 AND t3.pmaal002 ='",g_dlang,"'",
          " LEFT OUTER JOIN ooag_t t4 ON ooagent ='",g_enterprise,"' AND ooag001 = xcec107",
          " LEFT OUTER JOIN ooefl_t t5 ON ooeflent ='",g_enterprise,"' AND ooefl001 = xcec108 AND ooefl002 ='",g_dlang,"'",
          " LEFT OUTER JOIN pmaal_t t6 ON t6.pmaalent ='",g_enterprise,"' AND t6.pmaal001 = xcec109 AND t6.pmaal002 ='",g_dlang,"'",
          "  ORDER BY xcec001,flag,xcecseq"
      PREPARE axct901_pb2_1 FROM g_sql
      DECLARE b_fill_cs2_1 CURSOR FOR axct901_pb2_1
      
      LET l_ac = 1
                                            
      FOREACH b_fill_cs2_1 INTO l_flag,g_xceb4_d[l_ac].xcecseq,g_xceb4_d[l_ac].xcec001,g_xceb4_d[l_ac].xcec003, 
          g_xceb4_d[l_ac].xcec004,g_xceb4_d[l_ac].xcec005,g_xceb4_d[l_ac].xcec101,g_xceb4_d[l_ac].xcec101_desc,g_xceb4_d[l_ac].xcec102, 
          g_xceb4_d[l_ac].xcec103,g_xceb4_d[l_ac].xcec103_desc,g_xceb4_d[l_ac].xcec110,g_xceb4_d[l_ac].xcec117,g_xceb4_d[l_ac].xcec118,
          g_xceb4_d[l_ac].xcec114,g_xceb4_d[l_ac].xcec115,g_xceb4_d[l_ac].xcec116,
          g_xceb4_d[l_ac].xcec119,g_xceb4_d[l_ac].xcec120,
          g_xceb4_d[l_ac].xcec107,g_xceb4_d[l_ac].xcec108,g_xceb4_d[l_ac].xcec109,
          g_xceb4_d[l_ac].xcec111,g_xceb4_d[l_ac].xcec111_desc,
          g_xceb4_d[l_ac].xcec112,g_xceb4_d[l_ac].xcec113,
          g_xceb4_d[l_ac].xcec121,g_xceb4_d[l_ac].xcec122,
          g_xceb4_d[l_ac].xcec123,g_xceb4_d[l_ac].xcec124,
          g_xceb4_d[l_ac].xcec125,g_xceb4_d[l_ac].xcec126,
          g_xceb4_d[l_ac].xcec127,g_xceb4_d[l_ac].xcec128,
          g_xceb4_d[l_ac].xcec129,g_xceb4_d[l_ac].xcec130,
          g_xceb4_d[l_ac].xcec201, 
          g_xceb4_d[l_ac].xcec202,g_xceb4_d[l_ac].xcec202a,g_xceb4_d[l_ac].xcec202b,g_xceb4_d[l_ac].xcec202c, 
          g_xceb4_d[l_ac].xcec202d,g_xceb4_d[l_ac].xcec202e,g_xceb4_d[l_ac].xcec202f,g_xceb4_d[l_ac].xcec202g, 
          g_xceb4_d[l_ac].xcec202h,g_xceb4_d[l_ac].xcec212,g_xceb4_d[l_ac].xcec212a,g_xceb4_d[l_ac].xcec212b, 
          g_xceb4_d[l_ac].xcec212c,g_xceb4_d[l_ac].xcec212d,g_xceb4_d[l_ac].xcec212e,g_xceb4_d[l_ac].xcec212f, 
          g_xceb4_d[l_ac].xcec212g,g_xceb4_d[l_ac].xcec212h,g_xceb4_d[l_ac].xcec222,g_xceb4_d[l_ac].xcec222a, 
          g_xceb4_d[l_ac].xcec222b,g_xceb4_d[l_ac].xcec222c,g_xceb4_d[l_ac].xcec222d,g_xceb4_d[l_ac].xcec222e, 
          g_xceb4_d[l_ac].xcec222f,g_xceb4_d[l_ac].xcec222g,g_xceb4_d[l_ac].xcec222h,g_xceb4_d[l_ac].xcec301, 
          g_xceb4_d[l_ac].xcec302,g_xceb4_d[l_ac].xceccomp,g_xceb4_d[l_ac].xcec107_desc,g_xceb4_d[l_ac].xcec108_desc,g_xceb4_d[l_ac].xcec109_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcec:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
            IF l_flag = 1 THEN
               LET g_xceb4_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb4_d[l_ac].xcec001
            END IF
            IF l_flag = 2 THEN
               LET g_xceb4_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb4_d[l_ac].xcec001
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb4_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb4_d[l_ac].xcec103
            END IF
            IF l_flag = 2 THEN
               LET g_xceb4_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb4_d[l_ac].xcec103
            END IF
         END IF         
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
   
   
#fengmy150731---begin
      #顯示
      LET g_sql = "SELECT xceb117,xceb115,
          SUM(xceb202),SUM(xceb202a),SUM(xceb202b),SUM(xceb202c),SUM(xceb202d),SUM(xceb202e),SUM(xceb202f),SUM(xceb202g),SUM(xceb202h), 
          SUM(xceb212),SUM(xceb212a),SUM(xceb212b),SUM(xceb212c),SUM(xceb212d),SUM(xceb212e),SUM(xceb212f),SUM(xceb212g),SUM(xceb212h),
          SUM(xceb222),SUM(xceb222a),SUM(xceb222b),SUM(xceb222c),SUM(xceb222d),SUM(xceb222e),SUM(xceb222f),SUM(xceb222g),SUM(xceb222h)
          FROM axct901_tmp02 WHERE flag = 0     GROUP BY xceb117,xceb115 ORDER BY xceb117,xceb115 "       #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02
      PREPARE axct901_pb3_1 FROM g_sql
      DECLARE b_fill_cs3_1 CURSOR FOR axct901_pb3_1
      
      LET l_ac = 1
                                            
      FOREACH b_fill_cs3_1 INTO g_xceb8_d[l_ac].xceb117,g_xceb8_d[l_ac].xceb115,
          g_xceb8_d[l_ac].xceb202,g_xceb8_d[l_ac].xceb202a,g_xceb8_d[l_ac].xceb202b,g_xceb8_d[l_ac].xceb202c, 
          g_xceb8_d[l_ac].xceb202d,g_xceb8_d[l_ac].xceb202e,g_xceb8_d[l_ac].xceb202f,g_xceb8_d[l_ac].xceb202g, 
          g_xceb8_d[l_ac].xceb202h,g_xceb8_d[l_ac].xceb212,g_xceb8_d[l_ac].xceb212a,g_xceb8_d[l_ac].xceb212b, 
          g_xceb8_d[l_ac].xceb212c,g_xceb8_d[l_ac].xceb212d,g_xceb8_d[l_ac].xceb212e,g_xceb8_d[l_ac].xceb212f, 
          g_xceb8_d[l_ac].xceb212g,g_xceb8_d[l_ac].xceb212h,g_xceb8_d[l_ac].xceb222,g_xceb8_d[l_ac].xceb222a, 
          g_xceb8_d[l_ac].xceb222b,g_xceb8_d[l_ac].xceb222c,g_xceb8_d[l_ac].xceb222d,g_xceb8_d[l_ac].xceb222e, 
          g_xceb8_d[l_ac].xceb222f,g_xceb8_d[l_ac].xceb222g,g_xceb8_d[l_ac].xceb222h
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcec:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

   
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH

CALL g_xceb8_d.deleteElement(g_xceb8_d.getLength())   
#fengmy150731---end

   #20150731--add--str--lujh
   IF axct901_fill_chk(1) THEN   
      LET g_sql = "SELECT xceb115,xceb117,SUM(xceb202)",
                  "  FROM xceb_t ",
                  " WHERE xcebent = '",g_enterprise,"'",
                  "   AND xcebld='",g_xcea_m.xceald,"'", 
                  "   AND xcebdocno= '",g_xcea_m.xceadocno,"'"                  
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      LET g_sql = g_sql," GROUP BY xceb115,xceb117 ",
                        " ORDER BY xceb115,xceb117"	
      PREPARE axct901_xceb_sum_prep FROM g_sql
      DECLARE axct901_xceb_sum_cs CURSOR FOR axct901_xceb_sum_prep
      #end add-point
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                         
      FOREACH axct901_xceb_sum_cs INTO g_xceb9_d[l_ac].xceb115,g_xceb9_d[l_ac].xceb117,g_xceb9_d[l_ac].xceb202
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xceb:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xceb9_d[l_ac].xceb117
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xceb9_d[l_ac].xceb117_4_desc = '', g_rtn_fields[1] , ''
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF         
      END FOREACH
   END IF
   
   IF axct901_fill_chk(2) THEN   
      LET g_sql = "SELECT xcec115,xcec117,SUM(xcec202)",
                  "  FROM xcec_t ",
                  " WHERE xcecent = '",g_enterprise,"'",
                  "   AND xcecld='",g_xcea_m.xceald,"'", 
                  "   AND xcecdocno= '",g_xcea_m.xceadocno,"'"                  
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      LET g_sql = g_sql," GROUP BY xcec115,xcec117 ",
                        " ORDER BY xcec115,xcec117"  
      PREPARE axct901_xcec_sum_prep FROM g_sql
      DECLARE axct901_xcec_sum_cs CURSOR FOR axct901_xcec_sum_prep
      #end add-point
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                         
      FOREACH axct901_xcec_sum_cs INTO g_xceb10_d[l_ac].xcec115,g_xceb10_d[l_ac].xcec117,g_xceb10_d[l_ac].xcec202
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcec:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xceb10_d[l_ac].xcec117
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xceb10_d[l_ac].xcec117_4_desc = '', g_rtn_fields[1] , ''
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF         
      END FOREACH
   END IF
   
   CALL g_xceb9_d.deleteElement(g_xceb9_d.getLength())
   CALL g_xceb10_d.deleteElement(g_xceb10_d.getLength())
   #20150731--add--end--lujh
 
   CALL g_xceb_d.deleteElement(g_xceb_d.getLength())
   CALL g_xceb4_d.deleteElement(g_xceb4_d.getLength())
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
END FUNCTION

################################################################################
# Descriptions...: 顯示彙總頁簽-本位幣二
# Memo...........:
# Usage..........: CALL axct901_b_fill3()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill3()
DEFINE l_flag        LIKE type_t.num5

   CALL axct901_get_glaa()
   IF g_glaa015 = 'N' THEN   #为提高效率，隐藏的不走
      RETURN
   END IF
   
   CALL g_xceb2_d.clear()  
 
   IF axct901_fill_chk(1) THEN
      LET g_sql = "SELECT UNIQUE flag,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,'',xceb102,xceb103,'',xceb110,xceb117,xceb118,xceb114 ,xceb115,xceb116,",
                  "              xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,'',xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201,", 
                  "              xceb212,xceb212a,xceb212b,xceb212c,xceb212d,", 
                  "              xceb212e,xceb212f,xceb212g,xceb212h",       
                  " FROM axct901_tmp02 "    #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02    
      
      LET g_sql = g_sql, " ORDER BY xceb001,flag,xcebseq"   

      PREPARE axct901_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axct901_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                               
      FOREACH b_fill_cs3 INTO l_flag,g_xceb2_d[l_ac].xcebseq,g_xceb2_d[l_ac].xceb001,g_xceb2_d[l_ac].xceb003,g_xceb2_d[l_ac].xceb004,g_xceb2_d[l_ac].xceb005, 
          g_xceb2_d[l_ac].xceb101,g_xceb2_d[l_ac].xceb101_desc,g_xceb2_d[l_ac].xceb102,g_xceb2_d[l_ac].xceb103,g_xceb2_d[l_ac].xceb103_desc,
          g_xceb2_d[l_ac].xceb110,g_xceb2_d[l_ac].xceb117,g_xceb2_d[l_ac].xceb118, 
          g_xceb2_d[l_ac].xceb114,g_xceb2_d[l_ac].xceb115,g_xceb2_d[l_ac].xceb116,
          g_xceb2_d[l_ac].xceb119,g_xceb2_d[l_ac].xceb120,
          g_xceb2_d[l_ac].xceb107,g_xceb2_d[l_ac].xceb108,g_xceb2_d[l_ac].xceb109,
          g_xceb2_d[l_ac].xceb111,g_xceb2_d[l_ac].xceb111_desc,
          g_xceb2_d[l_ac].xceb112,g_xceb2_d[l_ac].xceb113,
          g_xceb2_d[l_ac].xceb121,g_xceb2_d[l_ac].xceb122,
          g_xceb2_d[l_ac].xceb123,g_xceb2_d[l_ac].xceb124,
          g_xceb2_d[l_ac].xceb125,g_xceb2_d[l_ac].xceb126,
          g_xceb2_d[l_ac].xceb127,g_xceb2_d[l_ac].xceb128,
          g_xceb2_d[l_ac].xceb129,g_xceb2_d[l_ac].xceb130,          
          g_xceb2_d[l_ac].xceb201,g_xceb2_d[l_ac].xceb212, 
          g_xceb2_d[l_ac].xceb212a,g_xceb2_d[l_ac].xceb212b,g_xceb2_d[l_ac].xceb212c,g_xceb2_d[l_ac].xceb212d, 
          g_xceb2_d[l_ac].xceb212e,g_xceb2_d[l_ac].xceb212f,g_xceb2_d[l_ac].xceb212g,g_xceb2_d[l_ac].xceb212h
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xceb2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         CALL axct901_get_xceb101_desc(g_xceb2_d[l_ac].xceb101) RETURNING g_xceb2_d[l_ac].xceb101_desc
         CALL axct901_get_xceb103_desc(g_xceb2_d[l_ac].xceb103) RETURNING g_xceb2_d[l_ac].xceb103_desc
         CALL axct901_get_xceb111_desc(g_xceb2_d[l_ac].xceb111) RETURNING g_xceb2_d[l_ac].xceb111_desc
         CALL s_desc_get_person_desc(g_xceb2_d[l_ac].xceb107) RETURNING g_xceb2_d[l_ac].xceb107_desc
         CALL s_desc_get_department_desc(g_xceb2_d[l_ac].xceb108) RETURNING g_xceb2_d[l_ac].xceb108_desc
         CALL s_desc_get_trading_partner_full_desc(g_xceb2_d[l_ac].xceb109) RETURNING g_xceb2_d[l_ac].xceb109_desc

         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN     
            IF l_flag = 1 THEN
               LET g_xceb2_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb2_d[l_ac].xceb001
            END IF
            IF l_flag = 2 THEN
               LET g_xceb2_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb2_d[l_ac].xceb001
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb2_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb2_d[l_ac].xceb103
            END IF
            IF l_flag = 2 THEN
               LET g_xceb2_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb2_d[l_ac].xceb103
            END IF
         END IF   

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
      
   CALL g_xceb2_d.deleteElement(g_xceb2_d.getLength())
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb3
END FUNCTION

################################################################################
# Descriptions...: 獲取科目說明
# Memo...........:
# Usage..........: CALL axct901_get_xceb101_desc(p_xceb101)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb101_desc(p_xceb101)
DEFINE p_xceb101  LIKE xceb_t.xceb101

    CALL axct901_get_glaa004()
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_xceb101
    CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||g_glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN  g_rtn_fields[1]
    
END FUNCTION

################################################################################
# Descriptions...: 獲取會計科目參照表
# Memo...........:
# Usage..........: CALL axct901_get_glaa004()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_glaa004()
   SELECT glaa004 INTO g_glaa004 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
END FUNCTION

################################################################################
# Descriptions...: 獲取成本域說明
# Memo...........:
# Usage..........: CALL axct901_get_xceb103_desc(p_xceb103)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb103_desc(p_xceb103)
DEFINE p_xceb103  LIKE xceb_t.xceb103
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcea_m.xceacomp
   LET g_ref_fields[2] = p_xceb103
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1] 
END FUNCTION

################################################################################
# Descriptions...: 獲取交易對象說明
# Memo...........:
# Usage..........: CALL axct901_get_xceb111_desc(p_xceb111)
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb111_desc(p_xceb111)
DEFINE p_xceb111  LIKE xceb_t.xceb111
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xceb111
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]  
END FUNCTION

################################################################################
# Descriptions...: 顯示彙總頁簽-本位幣三
# Memo...........:
# Usage..........: CALL axct901_b_fill4()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill4()
DEFINE l_flag     LIKE type_t.num5

   CALL axct901_get_glaa()
   IF g_glaa019 = 'N' THEN   #为提高效率，隐藏的不走
      RETURN
   END IF
   
   CALL g_xceb3_d.clear()  
 
   IF axct901_fill_chk(1) THEN
      LET g_sql = "SELECT UNIQUE flag,xcebseq,xceb001,xceb003,xceb004,xceb005,xceb101,'',xceb102,xceb103,'',xceb110,xceb117,xceb118,xceb114 ,xceb115,xceb116,",
                  "              xceb119,xceb120,xceb107,xceb108,xceb109,xceb111,'',xceb112,xceb113,xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130,xceb201,", 
                  "              xceb222,xceb222a,xceb222b,xceb222c,xceb222d,", 
                  "              xceb222e,xceb222f,xceb222g,xceb222h",
                  " FROM axct901_tmp02 "      #160727-00019#22 Mod  axct901_xceb_tmp--> axct901_tmp02    
      
      LET g_sql = g_sql, " ORDER BY xceb001,flag,xcebseq"   

      PREPARE axct901_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR axct901_pb4
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                               
      FOREACH b_fill_cs4 INTO l_flag,g_xceb3_d[l_ac].xcebseq,g_xceb3_d[l_ac].xceb001,g_xceb3_d[l_ac].xceb003,g_xceb3_d[l_ac].xceb004,g_xceb3_d[l_ac].xceb005, 
          g_xceb3_d[l_ac].xceb101,g_xceb3_d[l_ac].xceb101_desc,g_xceb3_d[l_ac].xceb102,g_xceb3_d[l_ac].xceb103,g_xceb3_d[l_ac].xceb103_desc,
          g_xceb3_d[l_ac].xceb110,g_xceb3_d[l_ac].xceb117,g_xceb3_d[l_ac].xceb118,  
          g_xceb3_d[l_ac].xceb114,g_xceb3_d[l_ac].xceb115,g_xceb3_d[l_ac].xceb116,  
          g_xceb3_d[l_ac].xceb119,g_xceb3_d[l_ac].xceb120,
          g_xceb3_d[l_ac].xceb107,g_xceb3_d[l_ac].xceb108,g_xceb3_d[l_ac].xceb109,
          g_xceb3_d[l_ac].xceb111,g_xceb3_d[l_ac].xceb111_desc,
          g_xceb3_d[l_ac].xceb112,g_xceb3_d[l_ac].xceb113,
          g_xceb3_d[l_ac].xceb121,g_xceb3_d[l_ac].xceb122,
          g_xceb3_d[l_ac].xceb123,g_xceb3_d[l_ac].xceb124,
          g_xceb3_d[l_ac].xceb125,g_xceb3_d[l_ac].xceb126,
          g_xceb3_d[l_ac].xceb127,g_xceb3_d[l_ac].xceb128,
          g_xceb3_d[l_ac].xceb129,g_xceb3_d[l_ac].xceb130,
          g_xceb3_d[l_ac].xceb201,g_xceb3_d[l_ac].xceb222, 
          g_xceb3_d[l_ac].xceb222a,g_xceb3_d[l_ac].xceb222b,g_xceb3_d[l_ac].xceb222c,g_xceb3_d[l_ac].xceb222d, 
          g_xceb3_d[l_ac].xceb222e,g_xceb3_d[l_ac].xceb222f,g_xceb3_d[l_ac].xceb222g,g_xceb3_d[l_ac].xceb222h
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xceb3:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         CALL axct901_get_xceb101_desc(g_xceb3_d[l_ac].xceb101) RETURNING g_xceb3_d[l_ac].xceb101_desc
         CALL axct901_get_xceb103_desc(g_xceb3_d[l_ac].xceb103) RETURNING g_xceb3_d[l_ac].xceb103_desc
         CALL axct901_get_xceb111_desc(g_xceb3_d[l_ac].xceb111) RETURNING g_xceb3_d[l_ac].xceb111_desc
         CALL s_desc_get_person_desc(g_xceb3_d[l_ac].xceb107) RETURNING g_xceb3_d[l_ac].xceb107_desc
         CALL s_desc_get_department_desc(g_xceb3_d[l_ac].xceb108) RETURNING g_xceb3_d[l_ac].xceb108_desc
         CALL s_desc_get_trading_partner_full_desc(g_xceb3_d[l_ac].xceb109) RETURNING g_xceb3_d[l_ac].xceb109_desc

         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN          
            IF l_flag = 1 THEN
               LET g_xceb3_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb3_d[l_ac].xceb001
            END IF
            IF l_flag = 2 THEN
               LET g_xceb3_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb3_d[l_ac].xceb001
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb3_d[l_ac].xcebseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb3_d[l_ac].xceb103
            END IF
            IF l_flag = 2 THEN
               LET g_xceb3_d[l_ac].xcebseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb3_d[l_ac].xceb103
            END IF                
         END IF   

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
      
   CALL g_xceb3_d.deleteElement(g_xceb3_d.getLength())
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb4
END FUNCTION

################################################################################
# Descriptions...: 顯示明細頁簽-本位幣二
# Memo...........:
# Usage..........: CALL axct901_b_fill5()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill5()
DEFINE l_flag        LIKE type_t.num5

   CALL axct901_get_glaa()
   IF g_glaa015 = 'N' THEN   #为提高效率，隐藏的不走
      RETURN
   END IF
   
   CALL g_xceb5_d.clear()  
   
   IF axct901_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE flag,xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,'',xcec102,xcec103,'',xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,",
                  "               xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,'',xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,", 
                  "               xcec201,xcec212,xcec212a,xcec212b,xcec212c,xcec212d,", 
                  "               xcec212e,xcec212f,xcec212g,xcec212h ", 
                  "  FROM axct901_tmp03"       #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03 
      
      LET g_sql = g_sql, " ORDER BY xcec001,flag,xcecseq" 

      PREPARE axct901_pb5 FROM g_sql
      DECLARE b_fill_cs5 CURSOR FOR axct901_pb5
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                          
      FOREACH b_fill_cs5 INTO l_flag,g_xceb5_d[l_ac].xcecseq,g_xceb5_d[l_ac].xcec001,g_xceb5_d[l_ac].xcec003, 
          g_xceb5_d[l_ac].xcec004,g_xceb5_d[l_ac].xcec005,g_xceb5_d[l_ac].xcec101,g_xceb5_d[l_ac].xcec101_desc,g_xceb5_d[l_ac].xcec102,g_xceb5_d[l_ac].xcec103,g_xceb5_d[l_ac].xcec103_desc, 
          g_xceb5_d[l_ac].xcec110,g_xceb5_d[l_ac].xcec117,g_xceb5_d[l_ac].xcec118,
          g_xceb5_d[l_ac].xcec114,g_xceb5_d[l_ac].xcec115,g_xceb5_d[l_ac].xcec116,
          g_xceb5_d[l_ac].xcec119,g_xceb5_d[l_ac].xcec120,
          g_xceb5_d[l_ac].xcec107,g_xceb5_d[l_ac].xcec108,g_xceb5_d[l_ac].xcec109,
          g_xceb5_d[l_ac].xcec111,g_xceb5_d[l_ac].xcec111_desc,
          g_xceb5_d[l_ac].xcec112,g_xceb5_d[l_ac].xcec113,
          g_xceb5_d[l_ac].xcec121,g_xceb5_d[l_ac].xcec122,
          g_xceb5_d[l_ac].xcec123,g_xceb5_d[l_ac].xcec124,
          g_xceb5_d[l_ac].xcec125,g_xceb5_d[l_ac].xcec126,
          g_xceb5_d[l_ac].xcec127,g_xceb5_d[l_ac].xcec128,
          g_xceb5_d[l_ac].xcec129,g_xceb5_d[l_ac].xcec130,
          g_xceb5_d[l_ac].xcec201, 
          g_xceb5_d[l_ac].xcec212,g_xceb5_d[l_ac].xcec212a,g_xceb5_d[l_ac].xcec212b,g_xceb5_d[l_ac].xcec212c, 
          g_xceb5_d[l_ac].xcec212d,g_xceb5_d[l_ac].xcec212e,g_xceb5_d[l_ac].xcec212f,g_xceb5_d[l_ac].xcec212g, 
          g_xceb5_d[l_ac].xcec212h
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcec2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         CALL axct901_get_xceb101_desc(g_xceb5_d[l_ac].xcec101) RETURNING g_xceb5_d[l_ac].xcec101_desc 
         CALL axct901_get_xceb103_desc(g_xceb5_d[l_ac].xcec103) RETURNING g_xceb5_d[l_ac].xcec103_desc
         CALL axct901_get_xceb111_desc(g_xceb5_d[l_ac].xcec111) RETURNING g_xceb5_d[l_ac].xcec111_desc
         CALL s_desc_get_person_desc(g_xceb5_d[l_ac].xcec107) RETURNING g_xceb5_d[l_ac].xcec107_desc
         CALL s_desc_get_department_desc(g_xceb5_d[l_ac].xcec108) RETURNING g_xceb5_d[l_ac].xcec108_desc
         CALL s_desc_get_trading_partner_full_desc(g_xceb5_d[l_ac].xcec109) RETURNING g_xceb5_d[l_ac].xcec109_desc

         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
            IF l_flag = 1 THEN
               LET g_xceb5_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb5_d[l_ac].xcec001
            END IF
            IF l_flag = 2 THEN
               LET g_xceb5_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb5_d[l_ac].xcec001
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb5_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb5_d[l_ac].xcec103
            END IF
            IF l_flag = 2 THEN
               LET g_xceb5_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb5_d[l_ac].xcec103
            END IF           
         END IF   
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF

   CALL g_xceb5_d.deleteElement(g_xceb5_d.getLength())
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb5
END FUNCTION

################################################################################
# Descriptions...: 顯示明細頁簽-本位幣三
# Memo...........:
# Usage..........: CALL axct901_b_fill6()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill6()
DEFINE l_flag        LIKE type_t.num5

   CALL axct901_get_glaa()
   IF g_glaa019 = 'N' THEN   #为提高效率，隐藏的不走
      RETURN
   END IF
   
   CALL g_xceb6_d.clear()  
   
   IF axct901_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE flag,xcecseq,xcec001,xcec003,xcec004,xcec005,xcec101,'',xcec102,xcec103,'',xcec110,xcec117,xcec118,xcec114,xcec115,xcec116,",
                  "               xcec119,xcec120,xcec107,xcec108,xcec109,xcec111,'',xcec112,xcec113,xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130,", 
                  "               xcec201,xcec222,xcec222a,xcec222b,xcec222c,xcec222d,", 
                  "               xcec222e,xcec222f,xcec222g,xcec222h ", 
                  "  FROM axct901_tmp03"     #160727-00019#22 Mod  axct901_xcec_tmp--> axct901_tmp03    
      
      LET g_sql = g_sql, " ORDER BY xcec001,flag,xcecseq" 

      PREPARE axct901_pb6 FROM g_sql
      DECLARE b_fill_cs6 CURSOR FOR axct901_pb6
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                          
      FOREACH b_fill_cs6 INTO l_flag,g_xceb6_d[l_ac].xcecseq,g_xceb6_d[l_ac].xcec001,g_xceb6_d[l_ac].xcec003, 
          g_xceb6_d[l_ac].xcec004,g_xceb6_d[l_ac].xcec005,g_xceb6_d[l_ac].xcec101,g_xceb6_d[l_ac].xcec101_desc,g_xceb6_d[l_ac].xcec102,g_xceb6_d[l_ac].xcec103,g_xceb6_d[l_ac].xcec103_desc, 
          g_xceb6_d[l_ac].xcec110,g_xceb6_d[l_ac].xcec117,g_xceb6_d[l_ac].xcec118,
          g_xceb6_d[l_ac].xcec114,g_xceb6_d[l_ac].xcec115,g_xceb6_d[l_ac].xcec116,
          g_xceb6_d[l_ac].xcec119,g_xceb6_d[l_ac].xcec120,
          g_xceb6_d[l_ac].xcec107,g_xceb6_d[l_ac].xcec108,g_xceb6_d[l_ac].xcec109,
          g_xceb6_d[l_ac].xcec111,g_xceb6_d[l_ac].xcec111_desc,
          g_xceb6_d[l_ac].xcec112,g_xceb6_d[l_ac].xcec113,
          g_xceb6_d[l_ac].xcec121,g_xceb6_d[l_ac].xcec122,
          g_xceb6_d[l_ac].xcec123,g_xceb6_d[l_ac].xcec124,
          g_xceb6_d[l_ac].xcec125,g_xceb6_d[l_ac].xcec126,
          g_xceb6_d[l_ac].xcec127,g_xceb6_d[l_ac].xcec128,
          g_xceb6_d[l_ac].xcec129,g_xceb6_d[l_ac].xcec130,
          g_xceb6_d[l_ac].xcec201, 
          g_xceb6_d[l_ac].xcec222,g_xceb6_d[l_ac].xcec222a,g_xceb6_d[l_ac].xcec222b,g_xceb6_d[l_ac].xcec222c, 
          g_xceb6_d[l_ac].xcec222d,g_xceb6_d[l_ac].xcec222e,g_xceb6_d[l_ac].xcec222f,g_xceb6_d[l_ac].xcec222g, 
          g_xceb6_d[l_ac].xcec222h
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcec3:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         CALL axct901_get_xceb101_desc(g_xceb6_d[l_ac].xcec101) RETURNING g_xceb6_d[l_ac].xcec101_desc 
         CALL axct901_get_xceb103_desc(g_xceb6_d[l_ac].xcec103) RETURNING g_xceb6_d[l_ac].xcec103_desc
         CALL axct901_get_xceb111_desc(g_xceb6_d[l_ac].xcec111) RETURNING g_xceb6_d[l_ac].xcec111_desc
         CALL s_desc_get_person_desc(g_xceb6_d[l_ac].xcec107) RETURNING g_xceb6_d[l_ac].xcec107_desc
         CALL s_desc_get_department_desc(g_xceb6_d[l_ac].xcec108) RETURNING g_xceb6_d[l_ac].xcec108_desc
         CALL s_desc_get_trading_partner_full_desc(g_xceb6_d[l_ac].xcec109) RETURNING g_xceb6_d[l_ac].xcec109_desc         
         IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
            IF l_flag = 1 THEN
               LET g_xceb6_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb6_d[l_ac].xcec001
            END IF
            IF l_flag = 2 THEN
               LET g_xceb6_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb6_d[l_ac].xcec001
            END IF
         ELSE
            IF l_flag = 1 THEN
               LET g_xceb6_d[l_ac].xcecseq = ''
               CALL cl_getmsg('axc-00205',g_lang) RETURNING g_xceb6_d[l_ac].xcec103
            END IF
            IF l_flag = 2 THEN
               LET g_xceb6_d[l_ac].xcecseq= ''
               CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xceb6_d[l_ac].xcec103
            END IF         
         END IF         
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF

   CALL g_xceb6_d.deleteElement(g_xceb6_d.getLength())
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb6
END FUNCTION

################################################################################
# Descriptions...: 憑證預覽顯示
# Memo...........:
# Usage..........: CALL axct901_b_fill7()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_b_fill7()
DEFINE l_xceb101_desc    LIKE type_t.chr500  
DEFINE l_xceb103_desc    LIKE type_t.chr500 
DEFINE l_xceb110_desc    LIKE type_t.chr500 
DEFINE l_xceb111_desc    LIKE type_t.chr500 
DEFINE l_xceb112_desc    LIKE type_t.chr500 
DEFINE l_xceb113_desc    LIKE type_t.chr500 
DEFINE l_xceb114_desc    LIKE type_t.chr500 
DEFINE l_xceb115_desc    LIKE type_t.chr500 
DEFINE l_xceb116_desc    LIKE type_t.chr500 
DEFINE l_xceb117_desc    LIKE type_t.chr500 
DEFINE l_xceb118_desc    LIKE type_t.chr500 
DEFINE l_xceb101         LIKE xceb_t.xceb101 
DEFINE l_xceb103         LIKE xceb_t.xceb103 
DEFINE l_xceb110         LIKE xceb_t.xceb110 
DEFINE l_xceb111         LIKE xceb_t.xceb111 
DEFINE l_xceb112         LIKE xceb_t.xceb112 
DEFINE l_xceb113         LIKE xceb_t.xceb113 
DEFINE l_xceb114         LIKE xceb_t.xceb114 
DEFINE l_xceb115         LIKE xceb_t.xceb115 
DEFINE l_xceb116         LIKE xceb_t.xceb116 
DEFINE l_xceb117         LIKE xceb_t.xceb117 
DEFINE l_xceb118         LIKE xceb_t.xceb118 
DEFINE l_xceb119         LIKE xceb_t.xceb119 
DEFINE l_xceb120         LIKE xceb_t.xceb120 
DEFINE l_flag            LIKE type_t.num5
DEFINE l_glaq003         LIKE glaq_t.glaq003
DEFINE l_glaq004         LIKE glaq_t.glaq004
DEFINE l_glaq003_1         LIKE glaq_t.glaq003
DEFINE l_glaq004_1         LIKE glaq_t.glaq004
DEFINE l_glaq003_2         LIKE glaq_t.glaq003
DEFINE l_glaq004_2         LIKE glaq_t.glaq004


CALL g_xceb7_d.clear()  
   IF g_argv[1] = '1' OR g_argv[1] = '2' OR g_argv[1] = '5' THEN 
   LET g_sql = " SELECT  UNIQUE xceadocno,xcea001,xcebseq,xceb102,xceb101,",
               " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h),",
               " 0,",
               " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h),",
               " 0,",
               " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h),",
               " 0,'',1",
               "   FROM xcea_t,xceb_t",
               "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'" ,
               " GROUP BY xceadocno,xcea001,xcebseq,xceb102,xceb101",
               " UNION ",
               " SELECT  UNIQUE xceadocno,xcea001,xcecseq,xcec102,xcec101,",
               " 0,",
               " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
               " 0,",
               " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
               " 0,",
               " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),'',2",
               "   FROM xcea_t,xcec_t",
               "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'"              
   
   LET g_sql = g_sql, " GROUP BY xceadocno,xcea001,xcecseq,xcec102,xcec101"
   END IF
   
   IF g_argv[1] = '7' OR g_argv[1] = '8' THEN 
      LET g_sql = " SELECT  UNIQUE xceadocno,xcea001,xcebseq,xceb102,xceb101,",
               " 0,",  
               " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h),",
               " 0,",
               " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h),",
               " 0,",
               " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h),",
               " '',1",
               "   FROM xcea_t,xceb_t",
               "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'" ,
               " GROUP BY xceadocno,xcea001,xcebseq,xceb102,xceb101",
               " UNION ",
               " SELECT  UNIQUE xceadocno,xcea001,xcecseq,xcec102,xcec101,",
               " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
               " 0,",
               " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
               " 0,",
               " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
               " 0,",               
               " '',2",
               "   FROM xcea_t,xcec_t",
               "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'"              
   
   LET g_sql = g_sql, " GROUP BY xceadocno,xcea001,xcecseq,xcec102,xcec101"   
   END IF

   IF g_argv[1] = '9' THEN 
   LET g_sql = " SELECT  UNIQUE xceadocno,xcea001,xcebseq,xceb102,xceb101,",
               " xceb202,",
               " 0,",
               " xceb212,",
               " 0,",
               " xceb222,",
               " 0,'',1",
               "   FROM xcea_t,xceb_t",
               "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'" ,
               " UNION ",
               " SELECT  UNIQUE xceadocno,xcea001,xcecseq,xcec102,xcec101,",
               " 0,",
               " xcec202,",
               " 0,",
               " xcec212,",
               " 0,",
               " xcec222,'',2",
               "   FROM xcea_t,xcec_t",
               "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
               "    AND xceaent = '",g_enterprise,"'",
               "    AND xceadocno = '",g_xcea_m.xceadocno,"' AND xcea001 = '",g_xcea_m.xcea001,"'"              
   END IF

   PREPARE axct901_pb7 FROM g_sql
   DECLARE b_fill_cs7 CURSOR FOR axct901_pb7
   
   LET g_cnt = l_ac
   LET l_ac = 1 
                                               
   FOREACH b_fill_cs7 INTO g_xceb7_d[l_ac].xcebdocno,g_xceb7_d[l_ac].xcea001,g_xceb7_d[l_ac].xcebseq,g_xceb7_d[l_ac].xceb102, 
       g_xceb7_d[l_ac].xceb101,g_xceb7_d[l_ac].xceb202,g_xceb7_d[l_ac].xceb202a,g_xceb7_d[l_ac].xceb202b,
       g_xceb7_d[l_ac].xceb202c,g_xceb7_d[l_ac].xceb202d,g_xceb7_d[l_ac].xceb202e,g_xceb7_d[l_ac].imag1,l_flag
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF g_argv[1] = '8' THEN 
         IF g_xceb7_d[l_ac].xceb202 > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202 = g_xceb7_d[l_ac].xceb202  #借方
            LET g_xceb7_d[l_ac].xceb202a = 0 #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202 < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202a = g_xceb7_d[l_ac].xceb202 * (-1) #貸方
            LET g_xceb7_d[l_ac].xceb202 = 0   #借方 
         END IF
         IF g_xceb7_d[l_ac].xceb202a > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202 = 0  #借方
            LET g_xceb7_d[l_ac].xceb202a = g_xceb7_d[l_ac].xceb202a #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202a < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202 = g_xceb7_d[l_ac].xceb202a * (-1) #借方
            LET g_xceb7_d[l_ac].xceb202a = 0   #貸方 
         END IF
         #本位幣二
         IF g_xceb7_d[l_ac].xceb202b > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202b = g_xceb7_d[l_ac].xceb202b  #借方
            LET g_xceb7_d[l_ac].xceb202c = 0 #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202b < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202c = g_xceb7_d[l_ac].xceb202b * (-1) #貸方
            LET g_xceb7_d[l_ac].xceb202b = 0   #借方 
         END IF
         IF g_xceb7_d[l_ac].xceb202c > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202b = 0  #借方
            LET g_xceb7_d[l_ac].xceb202c = g_xceb7_d[l_ac].xceb202c #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202c < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202b = g_xceb7_d[l_ac].xceb202c * (-1) #借方
            LET g_xceb7_d[l_ac].xceb202c = 0   #貸方 
         END IF 
         #本位幣三
         IF g_xceb7_d[l_ac].xceb202d > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202d = g_xceb7_d[l_ac].xceb202d  #借方
            LET g_xceb7_d[l_ac].xceb202e = 0 #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202d < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202e = g_xceb7_d[l_ac].xceb202d * (-1) #貸方
            LET g_xceb7_d[l_ac].xceb202d = 0   #借方 
         END IF
         IF g_xceb7_d[l_ac].xceb202e > 0 THEN 
            LET g_xceb7_d[l_ac].xceb202d = 0  #借方
            LET g_xceb7_d[l_ac].xceb202e = g_xceb7_d[l_ac].xceb202e #貸方
         END IF   
         IF g_xceb7_d[l_ac].xceb202e < 0 THEN 
            LET g_xceb7_d[l_ac].xceb202d = g_xceb7_d[l_ac].xceb202e * (-1) #借方
            LET g_xceb7_d[l_ac].xceb202e = 0   #貸方 
         END IF          
      END IF
 
      IF l_flag = 1 THEN
         SELECT xceb103,xceb110,xceb111,xceb112,xceb113,xceb114,xceb115,xceb116,
                xceb117,xceb118,xceb119,xceb120
           INTO l_xceb103,l_xceb110,l_xceb111,l_xceb112,l_xceb113,l_xceb114,l_xceb115,l_xceb116,
                l_xceb117,l_xceb118,l_xceb119,l_xceb120 
           FROM xceb_t     
         WHERE xcebent = g_enterprise AND xcebdocno = g_xcea_m.xceadocno
           AND xcebseq =  g_xceb7_d[l_ac].xcebseq        
      ELSE
         SELECT xcec103,xcec110,xcec111,xcec112,xcec113,xcec114,xcec115,xcec116,
                xcec117,xcec118,xcec119,xcec120
           INTO l_xceb103,l_xceb110,l_xceb111,l_xceb112,l_xceb113,l_xceb114,l_xceb115,l_xceb116,
                l_xceb117,l_xceb118,l_xceb119,l_xceb120 
           FROM xcec_t     
          WHERE xcecent = g_enterprise AND xcecdocno = g_xcea_m.xceadocno
            AND xcecseq =  g_xceb7_d[l_ac].xcebseq 
      END IF
      
      CALL axct901_get_xceb101_desc(g_xceb7_d[l_ac].xceb101)
          RETURNING l_xceb101_desc  

      #组合名称以及核算项
      LET l_xceb101 = ''
      #成本域,ok
      IF NOT cl_null(l_xceb103) THEN
         CALL axct901_get_xceb103_desc(l_xceb103) RETURNING l_xceb103_desc
         LET l_xceb101 = l_xceb103_desc
      END IF
      #原因碼
      IF NOT cl_null(l_xceb110) THEN
         CALL axct901_get_xceb112_desc('216',l_xceb110) RETURNING l_xceb110_desc
         IF cl_null(l_xceb110_desc) THEN
            CALL axct901_get_xceb112_desc('280',l_xceb110) RETURNING l_xceb110_desc
         END IF
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb110_desc
         ELSE
            LET l_xceb101 = l_xceb110_desc
         END IF
      END IF
      
      #交易對象,ok
      IF NOT cl_null(l_xceb111) THEN
         CALL axct901_get_xceb111_desc(l_xceb111) RETURNING l_xceb111_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb111_desc
         ELSE
            LET l_xceb101 = l_xceb111_desc
         END IF
      END IF
      #客群,ok
      IF NOT cl_null(l_xceb112) THEN
         CALL axct901_get_xceb112_desc('281',l_xceb112) RETURNING l_xceb112_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb112_desc
         ELSE
            LET l_xceb101 = l_xceb112_desc
         END IF
      END IF
      #區域,ok
      IF NOT cl_null(l_xceb113) THEN
         CALL axct901_get_xceb112_desc('287',l_xceb113) RETURNING l_xceb113_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb113_desc
         ELSE
            LET l_xceb101 = l_xceb113_desc
         END IF
      END IF
      #成本中心,ok
      IF NOT cl_null(l_xceb114) THEN
         CALL axct901_get_xceb114_desc(l_xceb114) RETURNING l_xceb114_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb114_desc
         ELSE
            LET l_xceb101 = l_xceb114_desc
         END IF
      END IF
      
      #經營類別,預留多語言
      IF NOT cl_null(l_xceb115) THEN
        #CALL axct901_xceb115_desc(l_xceb115) RETURNING l_xce115_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb115
         ELSE
            LET l_xceb101 = l_xceb115
         END IF
      END IF
      #渠道,ok
      IF NOT cl_null(l_xceb116) THEN
         CALL axct901_get_xceb112_desc('2035',l_xceb116) RETURNING l_xceb116_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb116_desc
         ELSE
            LET l_xceb101 = l_xceb116_desc
         END IF
      END IF
      #品類,ok
      IF NOT cl_null(l_xceb117) THEN
         CALL axct901_get_xceb117_desc(l_xceb117) RETURNING l_xceb117_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb117_desc
         ELSE
            LET l_xceb101 = l_xceb117_desc
         END IF
      END IF
      #品牌
      IF NOT cl_null(l_xceb118) THEN
         CALL axct901_get_xceb112_desc('2002',l_xceb118) RETURNING l_xceb118_desc
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb118_desc
         ELSE
            LET l_xceb101 = l_xceb118_desc
         END IF
      END IF
      #項目號,ok
      IF NOT cl_null(l_xceb119) THEN
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb119
         ELSE
            LET l_xceb101 = l_xceb119
         END IF
      END IF
      #WBS,ok
      IF NOT cl_null(l_xceb120) THEN
         IF NOT cl_null(l_xceb101) THEN
            LET l_xceb101 = l_xceb101 ,'-',l_xceb120
         ELSE
            LET l_xceb101 = l_xceb120
         END IF
      END IF
   
      LET g_xceb7_d[l_ac].xceb101 = g_xceb7_d[l_ac].xceb101,'\n',
                                    l_xceb101_desc,'\n',
                                    l_xceb101

   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0

   
   CALL g_xceb7_d.deleteElement(g_xceb7_d.getLength())
 
  
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct901_pb7
END FUNCTION

################################################################################
# Descriptions...: 客群
# Memo...........:
# Usage..........: CALL axct901_get_xceb112_desc(p_oocql001,p_oocql002)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb112_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001     LIKE oocql_t.oocql001
DEFINE p_oocql002     LIKE oocql_t.oocql002

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 成本中心
# Memo...........:
# Usage..........: CALL axct901_get_xceb114_desc(p_ooef001)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb114_desc(p_ooef001)
DEFINE p_ooef001     LIKE ooef_t.ooef001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001==? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 品類
# Memo...........:
# Usage..........: CALL axct901_get_xceb117_desc(p_xceb117)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceb117_desc(p_xceb117)
DEFINE p_xceb117   LIKE xceb_t.xceb117

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_xceb117
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 根據帳套獲取相關資料
# Memo...........:
# Usage..........: CALL axct901_get_glaa()
# Input parameter: 
# Return code....:  
# Date & Author..: 2014/4/20 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_glaa()
   #會計週期參照表、會計科目參照表、單據別參照表
   SELECT glaa001,glaa003,glaa004,glaa015,glaa016,glaa019,glaa020,glaa024,glaa121 
     INTO g_glaa001,g_glaa003,g_glaa004,g_glaa015,g_glaa016,g_glaa019,g_glaa020,g_glaa024,g_glaa121 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xcea_m.xceald   
END FUNCTION

################################################################################
# Descriptions...: 參數為2，執行axct702時，人工費用科目設置
# Memo...........:
# Usage..........: CALL axct901_axct702_s01()
# Input parameter:   
# Return code....: 
# Date & Author..: 2014/4/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_axct702_s01()
OPEN WINDOW w_axct702_s01 WITH FORM cl_ap_formpath("axc","axct901_03")
      CALL cl_ui_init()   
      CALL axct901_axct702_b_fill()
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     
      
      INPUT ARRAY g_xced_d FROM s_detail8.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
                  
            BEFORE INPUT
               CALL cl_set_combo_scc('xced001','8921') 
               CALL axct901_axct702_b_fill()
               LET g_rec_b = g_xced_d.getLength()
               CALL cl_set_comp_entry("xceddocno,xcedld,xcedseq,xced001,xced102",FALSE) 
               CALL cl_set_comp_entry("xced117,xced114,xced119,xced120,xced111,xced113",FALSE) 
               CALL cl_set_comp_entry("xced202,xced212,xced222",FALSE) 
               IF g_glaa015 ='Y' THEN CALL cl_set_comp_visible("xced212",TRUE) ELSE CALL cl_set_comp_visible("xced212",FALSE) END IF
               IF g_glaa019 ='Y' THEN CALL cl_set_comp_visible("xced222",TRUE) ELSE CALL cl_set_comp_visible("xced222",FALSE) END IF
            
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.idx
            
            
            
            AFTER FIELD xced101
               CALL axct901_get_xceb101_desc(g_xced_d[l_ac].xced101)
                 RETURNING g_xced_d[l_ac].xced101_desc
               
               DISPLAY g_xced_d[l_ac].xced101_desc TO xced101_desc 
               
            ON ACTION controlp INFIELD xced101
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_xced_d[l_ac].xced101             #給予default值
               
               SELECT glaa004 INTO g_glaa004 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_xcea_m.xceald
                
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "
               #151117-00009#1--add--str--
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND glac006 = '1'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent=",g_enterprise," AND gladld='",g_xcea_m.xceald,"'",
                                      "                    AND gladstus='Y' )"
               #151117-00009#1--add--end
               
               CALL aglt310_04()                                #呼叫開窗
               
               LET g_xced_d[l_ac].xced101 = g_qryparam.return1              
               
               CALL axct901_get_xceb101_desc(g_xced_d[l_ac].xced101)
                 RETURNING g_xced_d[l_ac].xced101_desc
                 
               DISPLAY g_xced_d[l_ac].xced101 TO xced101              #
               
               DISPLAY g_xced_d[l_ac].xced101_desc TO xced101_desc 
               
               UPDATE xced_t SET xced101 = g_xced_d[l_ac].xced101
                WHERE xceddocno = g_xcea_m.xceadocno
                  AND xcedld = g_xcea_m.xceald
                  AND xcedseq = g_xced_d[l_ac].xcedseq 
                  AND xcedent = g_enterprise              #160902-00048#3 add
                                            
                     NEXT FIELD xced101                          #返回原欄位


            ON CHANGE xced101
               UPDATE xced_t SET xced101 = g_xced_d[l_ac].xced101
                WHERE xceddocno = g_xcea_m.xceadocno
                  AND xcedld = g_xcea_m.xceald
                  AND xcedseq = g_xced_d[l_ac].xcedseq
                  AND xcedent = g_enterprise              #160902-00048#3 add

      END INPUT
      
#      DISPLAY ARRAY g_xced_d TO s_detail8.* ATTRIBUTES(COUNT=g_rec_b)  
#         
#            BEFORE ROW
#               CALL cl_set_combo_scc('xced001','8921') 
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail8")
#               LET l_ac = g_detail_idx
#               
#            
#            BEFORE DISPLAY 
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               LET l_ac = DIALOG.getCurrentRow("s_detail8")
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               CALL axct901_axct702_b_fill()
#               
#         
#         END DISPLAY

      ON ACTION close
         UPDATE xced_t SET xced101 = g_xced_d[l_ac].xced101
          WHERE xceddocno = g_xcea_m.xceadocno
            AND xcedld = g_xcea_m.xceald
            AND xcedseq = g_xced_d[l_ac].xcedseq
            AND xcedent = g_enterprise              #160902-00048#3 add            
         EXIT DIALOG

      ON ACTION exit
         UPDATE xced_t SET xced101 = g_xced_d[l_ac].xced101
          WHERE xceddocno = g_xcea_m.xceadocno
            AND xcedld = g_xcea_m.xceald
            AND xcedseq = g_xced_d[l_ac].xcedseq
            AND xcedent = g_enterprise              #160902-00048#3 add            
         EXIT DIALOG
      


   END DIALOG

   #畫面關閉
   CLOSE WINDOW w_axct702_s01
   LET INT_FLAG = FALSE 
END FUNCTION

################################################################################
# Descriptions...: 默認帶出帳套的所屬法人
# Memo...........:
# Usage..........: CALL axct901_get_xceacomp()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/20 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_xceacomp()
   SELECT glaacomp INTO g_xcea_m.xceacomp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xcea_m.xceald
   CALL axct901_get_xceacomp_desc()   
   DISPLAY BY NAME g_xcea_m.xceacomp,g_xcea_m.xceacomp_desc 

   LET g_xcea_m_o.xceacomp = g_xcea_m.xceacomp #160824-00007#224 161205 by lori add
END FUNCTION

################################################################################
# Descriptions...: 顯示人工費用科目設置
# Memo...........:
# Usage..........: CALL axct901_axct702_b_fill()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_axct702_b_fill()
DEFINE l_gzze003  LIKE gzze_t.gzze003

   CALL g_xced_d.clear()  
   
   #動態顯示多本位幣信息
   LET l_gzze003 = cl_getmsg('axc-00268',g_dlang)
   LET l_gzze003 = l_gzze003,"(",g_glaa001,")"
   CALL cl_set_comp_att_text('xced202',l_gzze003) 

   LET l_gzze003 = cl_getmsg('axc-00268',g_dlang)
   LET l_gzze003 = l_gzze003,"(",g_glaa016,")"
   CALL cl_set_comp_att_text('xced212',l_gzze003)
   
   LET l_gzze003 = cl_getmsg('axc-00268',g_dlang)
   LET l_gzze003 = l_gzze003,"(",g_glaa020,")"
   CALL cl_set_comp_att_text('xced222',l_gzze003)
   
   LET g_sql = " SELECT xceddocno,xcedld,xcedseq,xced001,xced101,'',",
               "        xced102,xced117,xced114,xced119,xced120,xced111,xced113,",
               "        xced202,xced212,xced222 ",
               "   FROM xced_t ",
               "  WHERE xcedent = '",g_enterprise,"'", 
               "    AND xceddocno = '",g_xcea_m.xceadocno,"' AND xcedld = '",g_xcea_m.xceald,"'"
   PREPARE axct702_pb FROM g_sql
   DECLARE axct702_cs CURSOR FOR axct702_pb
   
   LET g_cnt = l_ac
   LET l_ac = 1 
                                               
   FOREACH axct702_cs INTO g_xced_d[l_ac].xceddocno,g_xced_d[l_ac].xcedld,g_xced_d[l_ac].xcedseq,
                           g_xced_d[l_ac].xced001,g_xced_d[l_ac].xced101,g_xced_d[l_ac].xced101_desc, 
                           g_xced_d[l_ac].xced102,g_xced_d[l_ac].xced117,g_xced_d[l_ac].xced114,g_xced_d[l_ac].xced119,
                           g_xced_d[l_ac].xced120,g_xced_d[l_ac].xced111,g_xced_d[l_ac].xced113,
                           g_xced_d[l_ac].xced202,g_xced_d[l_ac].xced212,g_xced_d[l_ac].xced222       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      CALL axct901_get_xceb101_desc(g_xced_d[l_ac].xced101) RETURNING g_xced_d[l_ac].xced101_desc  

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0

   
   CALL g_xced_d.deleteElement(g_xced_d.getLength())
 
  
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct702_pb
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_refresh_stus()


       SELECT DISTINCT xcea101,xceastus,xceaownid,xceaowndp,xceacrtid,xceacrtdp,
                       xceacrtdt,xceamodid,xceamoddt,xceacnfid,xceacnfdt
         INTO g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,g_xcea_m.xceaowndp,g_xcea_m.xceacrtid,g_xcea_m.xceacrtdp,
              g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfdt         
         FROM xcea_t
        WHERE xceaent   = g_enterprise
          AND xceald    = g_xcea_m.xceald
          AND xceadocno = g_xcea_m.xceadocno
       
       LET g_xcea_m.xceaownid_desc = s_desc_get_person_desc(g_xcea_m.xceaownid)
       LET g_xcea_m.xceacrtid_desc = s_desc_get_person_desc(g_xcea_m.xceacrtid)
       LET g_xcea_m.xceamodid_desc = s_desc_get_person_desc(g_xcea_m.xceamodid)
       LET g_xcea_m.xceacnfid_desc = s_desc_get_person_desc(g_xcea_m.xceacnfid)
       
       LET g_xcea_m.xceaowndp_desc = s_desc_get_department_desc(g_xcea_m.xceaowndp)
       LET g_xcea_m.xceacrtdp_desc = s_desc_get_department_desc(g_xcea_m.xceacrtdp)
 
       CASE g_xcea_m.xceastus
          WHEN "N"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
          WHEN "X"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
          WHEN "Y"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
          WHEN "A"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
          WHEN "D"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
          WHEN "R"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
          WHEN "W"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
          
       END CASE 
       
       DISPLAY BY NAME
       g_xcea_m.xcea101,g_xcea_m.xceastus,g_xcea_m.xceaownid,
       g_xcea_m.xceaownid_desc,g_xcea_m.xceaowndp,g_xcea_m.xceaowndp_desc,g_xcea_m.xceacrtid,g_xcea_m.xceacrtid_desc, 
       g_xcea_m.xceacrtdp,g_xcea_m.xceacrtdp_desc,g_xcea_m.xceacrtdt,g_xcea_m.xceamodid,g_xcea_m.xceamodid_desc, 
       g_xcea_m.xceamoddt,g_xcea_m.xceacnfid,g_xcea_m.xceacnfid_desc,g_xcea_m.xceacnfdt
END FUNCTION

################################################################################
# Descriptions...: 审核前检查分录
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_conf_chk()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE xcea_t.xceadocno
   DEFINE l_sql           STRING
   DEFINE l_chr           LIKE type_t.chr1
   DEFINE l_efin5001       LIKE type_t.chr1  #add zhangllc 151125
   
   LET r_success = TRUE
   CALL axct901_refresh_stus()
#判断状态码
   IF g_xcea_m.xceastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00067'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF


   #如果有啟用分錄要檢核分錄是否正確
   #141202-00061-15--(S)
   CALL s_aooi200_fin_get_slip(g_xcea_m.xceadocno) RETURNING l_success,l_slip 
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN
   END IF  
   #add zhangllc 151125 --begin
   #是否允许制单与确认者相同
   CALL s_fin_chk_E5001(g_xcea_m.xceald,g_xcea_m.xceacomp,l_slip ) RETURNING l_efin5001
   IF l_efin5001 = 'N' THEN
      IF g_xcea_m.xceacrtid = g_user THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00346'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   #add zhangllc 151125 --end
   CALL axct901_get_glaa()
   IF g_glaa121 = 'Y' THEN
      INSERT INTO axct901_tmp01        #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
      SELECT glgb001,glgb002,glgb003,glgb004,glgb005,glgb006,glgb007,glgb008,glgb009,glgb010,
             glgb011,glgb012,glgb013,glgb014,glgb015,glgb016,glgb017,glgb018,glgb019,glgb020,
             glgb021,glgb022,glgb023,glgb024,glgb025,glgb026,glgb027,glgb028,glgb029,glgb030,
             glgb031,glgb032,glgb033,glgb034,glgb035,glgb036,glgb037,glgb038,glgb039,glgb040,
             glgb041,glgb042,glgb043,glgb044,glgb051,glgb052,glgb053,glgb054,glgb055,glgb056,
             glgb100,glgb101,glgbcomp,glgbdocno,glgbent,glgbld,glgbseq
        FROM glgb_t
       WHERE glgbent   = g_enterprise
         AND glgbld    = g_xcea_m.xceald
         AND glgbdocno = g_xcea_m.xceadocno
         AND glgb100   = 'XC'
         AND glgb101   = 'C10'        
   ELSE
      CALL axct701_02(g_xcea_m.xceald,g_xcea_m.xceadocno,g_xcea_m.xcea002,'Y')
      
      INSERT INTO axct901_tmp01 (glgbent,glgbld,glgbcomp,glgbdocno,glgbseq,   #这个单号项次不是凭证单号项次，是总账来源单据的单号项次   #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
                            glgb100,glgb101,glgb001,glgb002,glgb003,
                            glgb004,glgb005,glgb006,glgb007,glgb008,
                            glgb009,glgb010,glgb011,glgb012,glgb013,
                            glgb014,glgb015,glgb016,glgb017,glgb018,
                            glgb019,glgb020,glgb021,glgb022,glgb023,
                            glgb024,glgb025,glgb026,glgb027,glgb028,
                            glgb029,glgb030,glgb031,glgb032,glgb033,
                            glgb034,glgb035,glgb036,glgb037,glgb038,
                            glgb039,glgb040,glgb041,glgb042,glgb043,
                            glgb044,glgb051,glgb052,glgb053,glgb054,
                            glgb055,glgb056)
                     SELECT glaqent,glaqld,glaqcomp,docno,seq,
                            'XC','C10',glaq001,glaq002,d,
                            c,glaq005,glaq006,glaq007,0,             #临时表里没有glaq008
                            glaq009,glaq010,glaq011,glaq012,glaq013,
                            glaq014,glaq015,glaq016,glaq017,glaq018,
                            glaq019,glaq020,glaq021,glaq022,glaq023,
                            glaq024,glaq025,glaq026,glaq027,glaq028,
                            glaq029,glaq030,glaq031,glaq032,glaq033,
                            glaq034,glaq035,glaq036,glaq037,glaq038,
                            glaq039,glaq040,glaq041,glaq042,glaq043,
                            glaq044,glaq051,glaq052,glaq053,''
                            ,'',''
#                       FROM s_voucher_xc_group    #170215-00016#1 mark
                        FROM vouc_grp_tmp01        #170215-00016#1 add
                      WHERE glaqent = g_enterprise
                        AND glaqld  = g_xcea_m.xceald
                        AND docno   = g_xcea_m.xceadocno
   END IF      
   CALL cl_err_collect_init() #汇总错误讯息初始化 后续有审核检查都要包在这里面
   
   IF NOT axct901_chk_voucher('XC','C10',g_xcea_m.xceald,g_xcea_m.xceadocno) THEN     #检查内容同s_chk_voucher(),差别是把表换成了axct901_glgb_tmp 
      LET r_success = FALSE                
   END IF 
   CALL cl_err_collect_show()   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 参考s_chk_voucher检查分录
# Memo...........:
# Usage..........: CALL axct901_chk_voucher()
#                  RETURNING r_success
# Input parameter: p_sys          系统别
#                : p_cate         类别    SCC:8035
#                : p_ld           账套
#                : p_docno        单据编号
# Return code....: r_success      成功否标识位
# Date & Author..: 2015/03/10 By wujie
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_chk_voucher(p_sys,p_cate,p_ld,p_docno)
   DEFINE p_sys          LIKE type_t.chr2 
   DEFINE p_cate         LIKE type_t.chr10
   DEFINE p_ld           LIKE glaa_t.glaald
   DEFINE p_docno        LIKE glga_t.glgadocno
   DEFINE l_glgb002      LIKE glgb_t.glgb002
   DEFINE l_glgb003      LIKE glgb_t.glgb003
   DEFINE l_glgb004      LIKE glgb_t.glgb004
   DEFINE l_glgb040      LIKE glgb_t.glgb040
   DEFINE l_glgb041      LIKE glgb_t.glgb041
   DEFINE l_glgb043      LIKE glgb_t.glgb043
   DEFINE l_glgb044      LIKE glgb_t.glgb044
   DEFINE l_glaa015      LIKE glaa_t.glaa015
   DEFINE l_glaa019      LIKE glaa_t.glaa019
   DEFINE l_glgb017      LIKE glgb_t.glgb017
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_glgb         RECORD 
                         glgb018  LIKE glgb_t.glgb018,
                         glgb019  LIKE glgb_t.glgb019,
                         glgb020  LIKE glgb_t.glgb020,
                         glgb021  LIKE glgb_t.glgb021,
                         glgb022  LIKE glgb_t.glgb022,
                         glgb023  LIKE glgb_t.glgb023,
                         glgb024  LIKE glgb_t.glgb024,
                         glgb025  LIKE glgb_t.glgb025,
                         glgb027  LIKE glgb_t.glgb027,
                         glgb028  LIKE glgb_t.glgb028,
                         glgb051  LIKE glgb_t.glgb051,
                         glgb052  LIKE glgb_t.glgb052,
                         glgb053  LIKE glgb_t.glgb053,
                         glgb029  LIKE glgb_t.glgb029,
                         glgb030  LIKE glgb_t.glgb030,
                         glgb031  LIKE glgb_t.glgb031,
                         glgb032  LIKE glgb_t.glgb032,
                         glgb033  LIKE glgb_t.glgb033,
                         glgb034  LIKE glgb_t.glgb034,
                         glgb035  LIKE glgb_t.glgb035,
                         glgb036  LIKE glgb_t.glgb036,
                         glgb037  LIKE glgb_t.glgb037,
                         glgb038  LIKE glgb_t.glgb038,
                         glgb055  LIKE glgb_t.glgb055                         
                         END RECORD
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   IF cl_null(p_sys) THEN 
      #系统别参数为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00259'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE

      RETURN r_success
   END IF
   
   IF cl_null(p_cate) THEN 
      #类别参数为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00260'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE

      RETURN r_success
   END IF
   
   IF cl_null(p_ld) THEN
      #帐套参数为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00121'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE

      RETURN r_success
   END IF
   
   #检查帐套是否正确
   CALL s_ld_chk_authorization(g_user,p_ld) RETURNING r_success
   IF r_success = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00022'
      LET g_errparam.extend = p_ld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
 
      RETURN r_success
   END IF 
   
   IF cl_null(p_docno) THEN 
      #单据编号参数为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00261'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE

      RETURN r_success
   END IF
   
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
      
   LET l_count = 0   
   SELECT COUNT(*) INTO l_count
     FROM axct901_tmp01         #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
    WHERE glgbent = g_enterprise
      AND glgbld = p_ld
      AND glgbdocno = p_docno
      AND glgb100 = p_sys
      AND glgb101 = p_cate
      
   IF l_count = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00293'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      
      RETURN r_success
   END IF
   
   #1.存在會計科目表號為空的傳票報錯
   LET l_count=0
   LET l_sql="SELECT COUNT(*) FROM axct901_tmp01 ",         #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
             " WHERE glgbent = '",g_enterprise,"'",
             "   AND (glgb002 IS NULL OR glgb002=' ') ",
             "   AND glgbld = '",p_ld,"'",
             "   AND glgbdocno = '",p_docno,"'",
             "   AND glgb100 = '",p_sys,"'",
             "   AND glgb101 = '",p_cate,"'"
   PREPARE s_chk_voucher_pr FROM l_sql
   EXECUTE s_chk_voucher_pr INTO l_count
   IF l_count>0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00067'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   
   #2.科目性質不為帳戶,不為明細或獨立帳戶,或者科目无效，则返回报错
   LET l_sql="SELECT glgb002 FROM axct901_tmp01 ",     #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
             " WHERE glgbent = '",g_enterprise,"'",
             "   AND glgbld = '",p_ld,"'",
             "   AND glgbdocno = '",p_docno,"'",
             "   AND glgb100 = '",p_sys,"'",
             "   AND glgb101 = '",p_cate,"'"
   PREPARE s_chk_voucher_pr1 FROM l_sql
   DECLARE s_chk_voucher_cs1 CURSOR FOR s_chk_voucher_pr1
   FOREACH s_chk_voucher_cs1 INTO l_glgb002
      IF NOT cl_null(l_glgb002) THEN 
         CALL s_voucher_glaq002_chk(p_ld,l_glgb002)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = p_docno,"/",l_glgb002
            LET g_errparam.code   = g_errno
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            #LET r_success = FALSE
         END IF 
      END IF
   END FOREACH 
   
   #3.借貸金額不平報錯
   LET l_sql="SELECT SUM(glgb003),SUM(glgb004),SUM(glgb040),SUM(glgb041),SUM(glgb043),SUM(glgb044)",
             "  FROM axct901_tmp01 ",         #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
             " WHERE glgbent = '",g_enterprise,"'",
             "   AND glgbld = '",p_ld,"'",
             "   AND glgbdocno = '",p_docno,"'",
             "   AND glgb100 = '",p_sys,"'",
             "   AND glgb101 = '",p_cate,"'"
   PREPARE s_chk_voucher_pr2 FROM l_sql
   EXECUTE s_chk_voucher_pr2 INTO l_glgb003,l_glgb004,l_glgb040,l_glgb041,l_glgb043,l_glgb044
   IF cl_null(l_glgb003) THEN LET l_glgb003=0 END IF
   IF cl_null(l_glgb004) THEN LET l_glgb004=0 END IF
   IF cl_null(l_glgb040) THEN LET l_glgb040=0 END IF
   IF cl_null(l_glgb041) THEN LET l_glgb041=0 END IF
   IF cl_null(l_glgb043) THEN LET l_glgb043=0 END IF
   IF cl_null(l_glgb044) THEN LET l_glgb044=0 END IF
   IF l_glgb003 <> l_glgb004 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00250'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   
   #本位币二
   IF l_glaa015 = 'Y' AND l_glgb040 <> l_glgb041 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00250'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   
   #本位币三
   IF l_glaa019 = 'Y' AND l_glgb043 <> l_glgb044 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00250'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   
   #4.营运组织核算项若为核算组织(ooef204='Y'),则本张凭证以该组织角度来看应借贷平衡
   LET l_sql = " SELECT DISTINCT glgb017 FROM axct901_tmp01 ",       #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
               "  WHERE glgbent = ",g_enterprise,"",
               "    AND glgbld = '",p_ld,"'",
               "    AND glgbdocno = '",p_docno,"'",
               "    AND glgb100 = '",p_sys,"'",
               "    AND glgb101 = '",p_cate,"'",
               "    AND glgb017 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef204 = 'Y')"  
   PREPARE s_chk_voucher_glgb017_pre  FROM l_sql
   DECLARE s_chk_voucher_glgb017_cs CURSOR FOR s_chk_voucher_glgb017_pre
   FOREACH s_chk_voucher_glgb017_cs INTO l_glgb017
       IF SQLCA.SQLCODE THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = sqlca.sqlcode
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          EXIT FOREACH
       END IF
       LET l_glgb003 = 0 
       LET l_glgb004 = 0
       LET l_glgb040 = 0
       LET l_glgb041 = 0
       LET l_glgb043 = 0
       LET l_glgb044 = 0
       
       SELECT SUM(glgb003),SUM(glgb004),SUM(glgb040),SUM(glgb041),SUM(glgb043),SUM(glgb044) 
         INTO l_glgb003,l_glgb004,l_glgb040,l_glgb041,l_glgb043,l_glgb044  
         FROM axct901_tmp01            #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
        WHERE glgbent = g_enterprise
          AND glgbld = p_ld
          AND glgbdocno = p_docno 
          AND glgb100 = p_sys
          AND glgb101 = p_cate
          AND glgb017 = l_glgb017
       IF l_glgb003 <> l_glgb004 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = l_glgb017
          LET g_errparam.code   = 'agl-00166'
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success = FALSE
       END IF
       #本位幣二
       IF l_glaa015='Y' THEN
          IF l_glgb040 <> l_glgb041 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_glgb017
             LET g_errparam.code   = 'agl-00225'
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET r_success = FALSE
          END IF
       END IF
       #本位幣三
       IF l_glaa019='Y' THEN
          IF l_glgb043 <> l_glgb044 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_glgb017
             LET g_errparam.code   = 'agl-00226'
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET r_success = FALSE
          END IF
       END IF
   END FOREACH
   
   
   #5.检查核算项
   LET l_sql="SELECT glgb002,glgb018,glgb019,glgb020,glgb021,glgb022,glgb023,glgb024,",
             "       glgb025,glgb027,glgb028,glgb051,glgb052,glgb053,glgb029,glgb030,",
             "       glgb031,glgb032,glgb033,glgb034,glgb035,glgb036,glgb037,glgb038,",
             "       glgb055",
             "  FROM axct901_tmp01 ",           #160727-00019#22 Mod  axct901_glgb_tmp--> axct901_tmp01
             " WHERE glgbent = ",g_enterprise,"",
             "   AND glgbld = '",p_ld,"'",
             "   AND glgbdocno = '",p_docno,"'",
             "   AND glgb100 = '",p_sys,"'",
             "   AND glgb101 = '",p_cate,"'"
   PREPARE s_chk_voucher_pr3 FROM l_sql
   DECLARE s_chk_voucher_cs3 CURSOR FOR s_chk_voucher_pr3
   
   FOREACH s_chk_voucher_cs3 INTO l_glgb002,l_glgb.*
      CALL s_fix_acc_open_chk(p_ld,l_glgb002,l_glgb.*) RETURNING l_success
      IF l_success = FALSE THEN
         LET r_success = FALSE
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_unconf_chk()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE xcea_t.xceadocno
   DEFINE l_sql           STRING
   
   LET r_success = TRUE

   CALL axct901_refresh_stus()
#判断状态码
   IF g_xcea_m.xceastus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00026'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF NOT cl_null(g_xcea_m.xcea101) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00018'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身欄位說明不同顯示
# Memo...........:
# Usage..........: CALL axct901_set_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2016/3/25 By 02114
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_set_desc()
   DEFINE l_gzze003       LIKE gzze_t.gzze003   
   DEFINE l_gzze003_1     LIKE gzze_t.gzze003  
   CASE g_argv[1] 
      WHEN '4' 
         LET l_gzze003 = cl_getmsg('axc-00757',g_dlang)
         CALL cl_set_comp_att_text('bpage_1',l_gzze003)
         CALL cl_set_comp_att_text('bpage_4',l_gzze003) 
      WHEN '6' 
         LET l_gzze003 = cl_getmsg('axc-00758',g_dlang)
         CALL cl_set_comp_att_text('bpage_1',l_gzze003)
         CALL cl_set_comp_att_text('bpage_4',l_gzze003) 
      WHEN '7' 
         LET l_gzze003 = cl_getmsg('axc-00759',g_dlang)
         CALL cl_set_comp_att_text('bpage_1',l_gzze003)
         CALL cl_set_comp_att_text('bpage_4',l_gzze003)
      WHEN '10' 
         LET l_gzze003 = cl_getmsg('axc-00760',g_dlang)
         CALL cl_set_comp_att_text('bpage_1',l_gzze003)
         CALL cl_set_comp_att_text('bpage_4',l_gzze003)
    END CASE 
END FUNCTION
################################################################################
# Descriptions...: 帳套檢查
# Memo...........:
# Usage..........: CALL axct901_get_glad(p_gladld,p_glad001)
#                  RETURNING r_success
# Input parameter: p_gladld   帳套
#                : p_glad001  科目
# Return code....: r_glad015  專案管理否
#                : r_glad016  wbs管理否
# Date & Author..: #170227-00006#1 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION axct901_get_glad(p_gladld,p_glad001)
   DEFINE p_gladld        LIKE glad_t.gladld
   DEFINE p_glad001       LIKE glad_t.glad001
   DEFINE r_glad015       LIKE glad_t.glad015     #专案管理否
   DEFINE r_glad016       LIKE glad_t.glad016     #wbs管理
   DEFINE r_glad012       LIKE glad_t.glad012     #品类管理
   
   LET r_glad015 = ''
   LET r_glad016 = ''
   LET r_glad012 = ''
   
   SELECT glad015,glad016,glad012      
     INTO r_glad015,r_glad016,r_glad012
     FROM glad_t
   WHERE gladent = g_enterprise
     AND gladld  = p_gladld
     AND glad001 = p_glad001
     
     
  RETURN r_glad015,r_glad016,r_glad012

END FUNCTION

 
{</section>}
 
