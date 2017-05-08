#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp900_06.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-12-16 17:21:52), PR版次:0001(2016-02-22 10:26:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: awsp900_06
#+ Description: JSON功能
#+ Creator....: 04182(2015-12-16 10:23:49)
#+ Modifier...: 04182 -SD/PR- 04182
 
{</section>}
 
{<section id="awsp900_06.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
IMPORT com
IMPORT xml
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_ws.inc"            #TIPTOP Service Gateway 使用的全域變數檔
GLOBALS "../../cfg/top_json.inc"
#end add-point
 
{</section>}
 
{<section id="awsp900_06.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="awsp900_06.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
#DEFINE g_json_rec      util.JSONObject
#DEFINE g_json_arr_m    util.JSONArray
#DEFINE g_json_arr_m    util.JSONObject
#end add-point
 
{</section>}
 
{<section id="awsp900_06.other_dialog" >}

 
{</section>}
 
{<section id="awsp900_06.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_init_jsondata() ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_init_jsondata()
DEFINE ls_json  STRING
DEFINE json_obj util.JSONObject
DEFINE lb_exist BOOLEAN
DEFINE lb_exist2 BOOLEAN
DEFINE json_arr util.JSONArray
DEFINE ls_str   STRING

     CALL g_master.clear()
     CALL g_errcollect.clear()
     LET g_status.code = '0'
     LET g_status.sqlcode = '0'
     LET g_status.description = '' 
     #LET g_errcollect[1].code = '0'
     #LET g_errcollect[1].message = 'TEST'
     
     LET ls_json = g_messge.param[1].value
     #DISPLAY 'ls_json:',ls_json
     LET json_obj = util.JSONObject.parse(ls_json)
     LET lb_exist = json_obj.has('RecordSet')
     LET lb_exist2 = json_obj.has('Parameter')

     IF NOT lb_exist and NOT lb_exist2 THEN
        RETURN FALSE
     END IF

     IF lb_exist THEN
        LET g_json_arr = json_obj.get('RecordSet')
        DISPLAY 'json_arr:',g_json_arr.toString()
        LET g_json_rec = g_json_arr.get(1)
        LET lb_exist = g_json_rec.has('Master')

        IF lb_exist THEN

           LET json_obj = g_json_rec.get('Master')
           #LET json_obj = json_arr.get(1)  
           LET lb_exist = json_obj.has('Head')

           IF lb_exist THEN

              RETURN TRUE
           ELSE
              RETURN FALSE
           END IF         

        ELSE
           RETURN FALSE
        END IF

     ELSE
        RETURN FALSE
     END IF 
       
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
PUBLIC FUNCTION awsp900_06_getParameter()
DEFINE json_para  util.JSONObject
DEFINE ls_json    STRING
DEFINE json_obj   util.JSONObject
DEFINE json_arr util.JSONArray

     LET ls_json = g_messge.param[1].value
     LET json_obj = util.JSONObject.parse(ls_json)
     LET json_arr = json_obj.get('Parameter')
     LET json_para = json_arr.get(1)      

     RETURN json_para
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_getMaster (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_i   Master 的位置
#                : 
# Return code....: json_master   回傳 Head 節點
#                : 
# Date & Author..: 20151217 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_getMaster(p_i)
DEFINE json_master  util.JSONObject
DEFINE p_i          INTEGER
DEFINE ls_json  STRING
DEFINE json_obj util.JSONObject
DEFINE json_arr util.JSONArray
DEFINE json_head util.JSONObject
DEFINE i,j        INTEGER

     LET g_json_rec = g_json_arr.get(p_i) 
     LET json_master = g_json_rec.get('Master')
     LET json_master = json_master.get('Head')     
     DISPLAY 'json_master:', json_master.toString()
     
     RETURN json_master
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_getDetail (p_i,p_name)
#                  RETURNING json_detail
# Input parameter: p_i            Master 的位置
#                : p_name         Detail Name
# Return code....: json_detail    回傳 Content 的 JSONArray (多筆)
#                : 
# Date & Author..: 2015/12/17 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_getDetail(p_i,p_name)
DEFINE p_i      INTEGER
DEFINE p_name   STRING
DEFINE ls_json  STRING
DEFINE json_obj util.JSONObject
DEFINE json_arr util.JSONArray
DEFINE json_detail  util.JSONArray
DEFINE json_master  util.JSONObject
DEFINE i          INTEGER

     LET g_json_rec = g_json_arr.get(p_i) 
     LET json_master = g_json_rec.get('Master')
     LET json_arr = json_master.get('Detail')   
     #DISPLAY 'json_detail:',json_arr.toString()
     
     FOR i = 1 to json_arr.getlength()
         LET json_obj = json_arr.get(i)
         IF json_obj.get('DetailName') = p_name CLIPPED THEN
            LET json_detail = json_obj.get('Content')
            DISPLAY 'json_detail:',json_detail.toString()
            EXIT FOR
         END IF
         
     END FOR
     
     RETURN json_detail
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_getMasterLength ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: l_cnt          master個數
#                : 
# Date & Author..: 2015/12/21 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_getMasterLength()
DEFINE l_cnt       INTEGER

       LET l_cnt = g_json_arr.getlength()
       DISPLAY 'master count:',l_cnt
       RETURN l_cnt
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_setParameter ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/17 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_setParameter()
DEFINE json_para  util.JSONObject
DEFINE ls_json    STRING
DEFINE json_obj   util.JSONObject
DEFINE json_arr util.JSONArray

 

       RETURN json_para
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_setRecordSet ()
#                  RETURNING json_rec
# Input parameter: 
#                : 
# Return code....: json_rec   json object
#                : 
# Date & Author..: 2015/12/17 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_setRecordSet()
DEFINE json_rec  util.JSONObject
DEFINE ls_json    STRING
DEFINE json_obj   util.JSONObject
DEFINE json_arr util.JSONArray

     LET ls_json = g_messge.param[1].value
     LET json_obj = util.JSONObject.parse(ls_json)
     LET json_arr = json_obj.get('RecordSet')
     LET json_rec = json_arr.get(1)   

       RETURN json_rec
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_setResponse ()
#                  RETURNING l_str
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: l_str          回傳字串
#                : 
# Date & Author..: 2015/12/18 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_setResponse()
DEFINE l_str     STRING
DEFINE json_obj  util.JSONObject
DEFINE json_obj1 util.JSONObject
DEFINE ExecutionStatus RECORD
		 code STRING,  --g_status.code
		 sqlcode STRING,  --g_status.sqlcode
		 description STRING --g_status.description
		 END RECORD	
		 
DEFINE  Key RECORD
		  CustomData STRING
        END RECORD
        
DEFINE i         INTEGER
DEFINE msg_arr DYNAMIC ARRAY OF RECORD
     code      STRING,
     message   STRING
     END RECORD
    #LET g_errcollect[1].code="wss-00217"    
    LET json_obj = util.JSONObject.create()
    #LET ExecutionStatus.code = '0'
    #LET ExecutionStatus.sqlcode = '0'
    #LET ExecutionStatus.description = '執行成功'   
    #CALL json_obj.put("ExecutionStatus", ExecutionStatus)    
    CALL json_obj.put("ExecutionStatus", g_status)
    #IF g_errcollect.getlength() > 0 THEN
    #   FOR i = 1 to g_errcollect.getlength()
    #       LET msg_arr[i].code = g_errcollect[i].code
    #       LET msg_arr[i].message = g_errcollect[i].message
    #   END FOR
    #   LET json_obj1 = json_obj.get('ExecutionStatus')       
    #   CALL json_obj1.put('ErrorCollect',msg_arr)
    #END IF
    LET i = g_errlog_arr.getlength()
    DISPLAY 'err count:',i
    IF g_errlog_arr.getlength() > 0 THEN
       FOR i = 1 to g_errlog_arr.getlength()
           LET msg_arr[i].code = g_errlog_arr[i].code
           LET msg_arr[i].message = cl_replace_str(g_errlog_arr[i].message,'\n','')
       END FOR
       LET json_obj1 = json_obj.get('ExecutionStatus')       
       CALL json_obj1.put('ErrorCollect',msg_arr)
    END IF    
    IF cl_null(g_customData) THEN
       LET Key.CustomData = ''
    ELSE
       LET Key.CustomData = g_customData
    END IF
    CALL json_obj.put("Key", Key)
    
    IF g_master.getlength() > 0 THEN

       CALL json_obj.put("RecordSet",g_master)

    END IF
    #LET json_obj1 = json_obj.get('Key')
    #CALL json_obj1.remove('CustomData')
    LET l_str = json_obj.toString()
    LET l_str = util.JSON.format(l_str)
    RETURN l_str
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_setDetail (p_detail_name,p_json_array)
#                  RETURNING lb_status
# Input parameter: p_detail_name  detail name
#                : p_json_array   detail context
# Return code....: lb_status      狀態
#                : 
# Date & Author..: 2015/12/21 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_setDetail(p_detail_name,p_json_array)
   DEFINE p_detail_name   STRING           #單身資料所屬控件名稱(ex:s_detailX)
   DEFINE p_json_array    util.JSONArray

   LET g_detail[g_detail.getLength() + 1].DetailName = p_detail_name
   LET g_detail[g_detail.getLength()].Content = p_json_array
   
   RETURN
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_06_setMaster (p_json_array)
#                  RETURNING 
# Input parameter: p_json_array   master資料
#                : 
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/21 By yc.chao
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_06_setMaster(p_json_array)
   DEFINE p_json_array    util.JSONObject
   DEFINE master          util.JSONObject
   DEFINE obj3            util.JSONObject
   DEFINE obj             util.JSONObject
   DEFINE detail          util.JSONObject  
   DEFINE i               INTEGER   
   
   DEFINE master_rec RECORD
        #RecordSet DYNAMIC ARRAY OF RECORD
                Master util.JSONObject
        #END RECORD
   END RECORD 

  
   LET obj = util.JSONObject.create()
   LET master_rec.Master =  p_json_array   
   
   LET obj3 = util.JSONObject.fromFGL(master_rec)
   LET obj = obj3.get('Master')   
   
   
   IF g_detail.getlength() > 0 THEN
      LET detail = util.JSONObject.create()

      CALL obj.put('Detail', g_detail)
   END IF
   LET g_master[g_master.getLength()+1] = obj3
   DISPLAY obj3.toString()   
   
   CALL g_detail.clear()
   RETURN
END FUNCTION

 
{</section>}
 
