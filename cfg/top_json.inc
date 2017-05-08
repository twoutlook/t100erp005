#+ Version..: T6-ERP-1.00.00(版次:1) Build-000387
#+
#+ Filename...: awsp900.inc
#+ Description: TIPTOP Services 服務全域變數檔 (暫時硬寫，無透過設計器)
#+ Creator....: 00509(2013/10/14)
#+ Modifier...: 00509(2013/10/14)
#+ Buildtype..:


SCHEMA ds

GLOBALS

    #JSON變數
    DEFINE g_json_rec      util.JSONObject
    DEFINE g_json_arr      util.JSONArray

    DEFINE g_detail           DYNAMIC ARRAY OF RECORD
          DetailName        STRING,
          Content           util.JSONArray
          END RECORD

    DEFINE g_master    DYNAMIC ARRAY OF util.JSONObject

    #JSON
    DEFINE g_json_req      util.JSONObject
    DEFINE g_json_res      util.JSONObject
    DEFINE g_data_obj      util.JSONObject
    DEFINE g_data_json     BOOLEAN
    DEFINE g_param_json    BOOLEAN
    DEFINE g_json_param    util.JSONObject
    DEFINE g_data_array    util.JSONArray

    DEFINE g_param         DYNAMIC ARRAY OF RECORD
           param_name      STRING,
           param_value     STRING
           END RECORD

    DEFINE g_json_ver      INTEGER
    DEFINE g_trans_type    STRING
END GLOBALS
