GLOBALS
   CONSTANT gc_compile_4gl_sub = "BGXWQ"
   CONSTANT gc_compile_4gl_main = "SMZ"
   CONSTANT gc_link_4gl_sub = "BGXWQ"
   CONSTANT gc_link_4gl_main = "SMZ"
   CONSTANT gc_part1 = "FBGXWQ"
   CONSTANT gc_part2 = "SMZ@"

   DEFINE gb_part1           BOOLEAN #160223-00028 add
   DEFINE g_sys_dgenv        LIKE dzaa_t.dzaa009   #DGENV (value from adzp990)                                                                  
   DEFINE gb_god_mode        BOOLEAN #(value from adzp990)
   DEFINE gb_bak_mode        BOOLEAN #備份模式           #20150923
   DEFINE g_bak_tar_path     STRING  #備份檔存放路徑     #20150923
   DEFINE g_imp_progid       STRING  #匯入程式代號       #20150923
   DEFINE g_tar_path         STRING  #打包tar檔存放路徑  #20151207
   DEFINE g_imp_progtype     STRING  #匯入程式建構類別   #160620-00020
END GLOBALS

PUBLIC TYPE T_DZYD_T RECORD
              dzyd001         LIKE dzyd_t.dzyd001,     #
              dzyd002         LIKE dzyd_t.dzyd002,     #prog
              dzyd003         LIKE dzyd_t.dzyd003,     #type
              dzyd004         LIKE dzyd_t.dzyd004,     #done
              dzyd005         LIKE dzyd_t.dzyd005,     #module
              dzyd006         LIKE dzyd_t.dzyd006,     #status
              dzyd007         LIKE dzyd_t.dzyd007,     #錯誤訊息(簡單)
              dzyd008         LIKE dzyd_t.dzyd008,     #pid
              dzyd009         LIKE dzyd_t.dzyd009,     #建構版次
              dzyd010         LIKE dzyd_t.dzyd010,     #規格版次
              dzyd011         LIKE dzyd_t.dzyd011,     #程式版次
              dzyd012         LIKE dzyd_t.dzyd012,     #識別標示
              dzyd013         LIKE dzyd_t.dzyd013,     #順序
              dzyd014         LIKE dzyd_t.dzyd014,     #客製否
              dzyd015         LIKE dzyd_t.dzyd015,     #merge否
              dzyd016         LIKE dzyd_t.dzyd016,     #執行階段
              dzyd017         LIKE dzyd_t.dzyd017,     #執行日期
              dzyd018         LIKE dzyd_t.dzyd018      #錯誤訊息(完整)
            END RECORD            

PUBLIC TYPE T_REDO RECORD
              tar_name        LIKE type_t.chr80,       #匯入包編號  
              prog            LIKE type_t.chr20,       #程式代碼
              type            LIKE type_t.chr1,        #建構類型
              done            LIKE type_t.chr80,       #已執行項目(for redo) 格式:type|module|revision|regen4fd|taggen|r.c3|compile|link|4rp
              module          LIKE type_t.chr5,        #模組別
             #no_use01        LIKE type_t.chr1,        #no_use01     #160223-00028 mark
              hardcode_qry    LIKE type_t.chr1,        #hardcode qry #160223-00028 add
              err             LIKE type_t.chr50,       #錯誤訊息
              pid             LIKE type_t.chr20,       #pid
              ver             SMALLINT,                #建構版次
              spec_ver        SMALLINT,                #spec版次
              code_ver        SMALLINT,                #code版次
              identity        LIKE type_t.chr1,        #識別標示(客製否)
              order           SMALLINT,                #順序
              source_ver      SMALLINT,                #來源程式建構版次
              merge           LIKE type_t.chr1,        #merge否
              stage           LIKE type_t.chr80,       #階段
              crtdt           LIKE type_t.chr50,       #執行日期
              errmsg          VARCHAR(4000),           #錯誤訊息(完整)
              source_identity LIKE type_t.chr1,        #來源程式識別標示(客製否) #s/c 
              source_spec_ver SMALLINT,                #來源程式spec版刺
              source_code_ver SMALLINT,                #來源程式code版次
              checkout        LIKE type_t.chr1,        #簽出否
              status          LIKE type_t.chr1,        #執行結果
              crtid           LIKE type_t.chr20        #執行使用者
            END RECORD            
