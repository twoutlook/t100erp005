SCHEMA ds

GLOBALS
   DEFINE g_schedule_id   LIKE gzpe_t.gzpe001      #報表背景執行的排程編號
   DEFINE g_schedule_seq  LIKE gzpe_t.gzpe002      #報表背景執行的排程序號
   DEFINE g_schedule RECORD
      gzpa003  LIKE gzpa_t.gzpa003, #排程執行類型 (預設:
      gzpa001  LIKE gzpa_t.gzpa001, #排程編號
      gzpa002  LIKE gzpa_t.gzpa002, #排程說明
      gzpa006  LIKE gzpa_t.gzpa006, #指定執行日期
      gzpa007  LIKE gzpa_t.gzpa007, #指定執行時間
      gzpa008  LIKE gzpa_t.gzpa008, #月別
      #gzpa009  LIKE gzpa_t.gzpa009, #月份列表
      m01      LIKE type_t.chr1,
      m02      LIKE type_t.chr1,
      m03      LIKE type_t.chr1,
      m04      LIKE type_t.chr1,
      m05      LIKE type_t.chr1,
      m06      LIKE type_t.chr1,
      m07      LIKE type_t.chr1,
      m08      LIKE type_t.chr1,
      m09      LIKE type_t.chr1,
      m10      LIKE type_t.chr1,
      m11      LIKE type_t.chr1,
      m12      LIKE type_t.chr1,
      gzpa010  LIKE gzpa_t.gzpa010, #周別
      #gzpa011  LIKE gzpa_t.gzpa011, #周別列表
      wk1      LIKE type_t.chr1,
      wk2      LIKE type_t.chr1,
      wk3      LIKE type_t.chr1,
      wk4      LIKE type_t.chr1,
      wk5      LIKE type_t.chr1,
      #gzpa012  LIKE type_t.chr1, #日別
      gzpa012  LIKE gzpa_t.gzpa012, #日別
      #gzpa013  LIKE gzpa_t.gzpa013, #日別列表
      wd0      LIKE type_t.chr1,
      wd1      LIKE type_t.chr1,
      wd2      LIKE type_t.chr1,
      wd3      LIKE type_t.chr1,
      wd4      LIKE type_t.chr1,
      wd5      LIKE type_t.chr1,
      wd6      LIKE type_t.chr1,
      d01      LIKE type_t.chr1,
      d02      LIKE type_t.chr1,
      d03      LIKE type_t.chr1,
      d04      LIKE type_t.chr1,
      d05      LIKE type_t.chr1,
      d06      LIKE type_t.chr1,
      d07      LIKE type_t.chr1,
      d08      LIKE type_t.chr1,
      d09      LIKE type_t.chr1,
      d10      LIKE type_t.chr1,
      d11      LIKE type_t.chr1,
      d12      LIKE type_t.chr1,
      d13      LIKE type_t.chr1,
      d14      LIKE type_t.chr1,
      d15      LIKE type_t.chr1,
      d16      LIKE type_t.chr1,
      d17      LIKE type_t.chr1,
      d18      LIKE type_t.chr1,
      d19      LIKE type_t.chr1,
      d20      LIKE type_t.chr1,
      d21      LIKE type_t.chr1,
      d22      LIKE type_t.chr1,
      d23      LIKE type_t.chr1,
      d24      LIKE type_t.chr1,
      d25      LIKE type_t.chr1,
      d26      LIKE type_t.chr1,
      d27      LIKE type_t.chr1,
      d28      LIKE type_t.chr1,
      d29      LIKE type_t.chr1,
      d30      LIKE type_t.chr1,
      d31      LIKE type_t.chr1,
      den      LIKE type_t.chr1,
      gzpa015  LIKE gzpa_t.gzpa015, #時間時段種類
      gzpa016  LIKE gzpa_t.gzpa016, #週期指定執行時間
      sc1      LIKE type_t.chr1,    #時段一
      gzpa017  LIKE gzpa_t.gzpa017, #時段一起始時間
      gzpa018  LIKE gzpa_t.gzpa018, #時段一結束時間
      gzpa019  LIKE gzpa_t.gzpa019, #時段一間格數
      gzpa020  LIKE gzpa_t.gzpa020, #時段一間格單位
      sc2      LIKE type_t.chr1,    #時段二
      gzpa021  LIKE gzpa_t.gzpa021, #時段二起始時間
      gzpa022  LIKE gzpa_t.gzpa022, #時段二結束時間
      gzpa023  LIKE gzpa_t.gzpa023, #時段二間格數
      gzpa024  LIKE gzpa_t.gzpa024, #時段二間格單位
      sc3      LIKE type_t.chr1,    #時段三
      gzpa025  LIKE gzpa_t.gzpa025, #時段三起始時間
      gzpa026  LIKE gzpa_t.gzpa026, #時段三結束時間
      gzpa027  LIKE gzpa_t.gzpa027, #時段三間格數
      gzpa028  LIKE gzpa_t.gzpa028, #時段三間格單位
      gzpa029  LIKE gzpa_t.gzpa029, #執行日遇到假日
      gzpa030  LIKE gzpa_t.gzpa030, #遇到假日處理方法
      gzpa031  LIKE gzpa_t.gzpa031, #前一程序未完成時不執行新程序
      gzgf001  LIKE gzgf_t.gzgf001, #報表元件     #140808 報表排程 add
      gzgf002  LIKE gzgf_t.gzgf002, #樣板代號     #140808 報表排程 add
      gzgf004  LIKE gzgf_t.gzgf004, #角色         #140808 報表排程 add
      gzgf005  LIKE gzgf_t.gzgf005, #用戶         #140808 報表排程 add
      gzgd007  LIKE gzgd_t.gzgd007 #樣板名稱(4rp) #140808 報表排程 add
          END RECORD

   DEFINE g_schedule_t RECORD
      gzpa003  LIKE gzpa_t.gzpa003, #排程執行類型 (預設:
      gzpa002  LIKE gzpa_t.gzpa002, #排程說明
      gzpa006  LIKE gzpa_t.gzpa006, #指定執行日期
      gzpa007  LIKE gzpa_t.gzpa007, #指定執行時間
      gzpa008  LIKE gzpa_t.gzpa008, #月別
      #gzpa009  LIKE gzpa_t.gzpa009, #月份列表
      m01      LIKE type_t.chr1,
      m02      LIKE type_t.chr1,
      m03      LIKE type_t.chr1,
      m04      LIKE type_t.chr1,
      m05      LIKE type_t.chr1,
      m06      LIKE type_t.chr1,
      m07      LIKE type_t.chr1,
      m08      LIKE type_t.chr1,
      m09      LIKE type_t.chr1,
      m10      LIKE type_t.chr1,
      m11      LIKE type_t.chr1,
      m12      LIKE type_t.chr1,
      gzpa010  LIKE gzpa_t.gzpa010, #周別
      #gzpa011  LIKE gzpa_t.gzpa011, #周別列表
      wk1      LIKE type_t.chr1,
      wk2      LIKE type_t.chr1,
      wk3      LIKE type_t.chr1,
      wk4      LIKE type_t.chr1,
      wk5      LIKE type_t.chr1,
      #gzpa012  LIKE type_t.chr1, #日別
      gzpa012  LIKE gzpa_t.gzpa012, #日別
      #gzpa013  LIKE gzpa_t.gzpa013, #日別列表
      wd0      LIKE type_t.chr1,
      wd1      LIKE type_t.chr1,
      wd2      LIKE type_t.chr1,
      wd3      LIKE type_t.chr1,
      wd4      LIKE type_t.chr1,
      wd5      LIKE type_t.chr1,
      wd6      LIKE type_t.chr1,
      d01      LIKE type_t.chr1,
      d02      LIKE type_t.chr1,
      d03      LIKE type_t.chr1,
      d04      LIKE type_t.chr1,
      d05      LIKE type_t.chr1,
      d06      LIKE type_t.chr1,
      d07      LIKE type_t.chr1,
      d08      LIKE type_t.chr1,
      d09      LIKE type_t.chr1,
      d10      LIKE type_t.chr1,
      d11      LIKE type_t.chr1,
      d12      LIKE type_t.chr1,
      d13      LIKE type_t.chr1,
      d14      LIKE type_t.chr1,
      d15      LIKE type_t.chr1,
      d16      LIKE type_t.chr1,
      d17      LIKE type_t.chr1,
      d18      LIKE type_t.chr1,
      d19      LIKE type_t.chr1,
      d20      LIKE type_t.chr1,
      d21      LIKE type_t.chr1,
      d22      LIKE type_t.chr1,
      d23      LIKE type_t.chr1,
      d24      LIKE type_t.chr1,
      d25      LIKE type_t.chr1,
      d26      LIKE type_t.chr1,
      d27      LIKE type_t.chr1,
      d28      LIKE type_t.chr1,
      d29      LIKE type_t.chr1,
      d30      LIKE type_t.chr1,
      d31      LIKE type_t.chr1,
      den      LIKE type_t.chr1,
      gzpa015  LIKE gzpa_t.gzpa015, #時間時段種類
      gzpa016  LIKE gzpa_t.gzpa016, #週期指定執行時間
      sc1      LIKE type_t.chr1,    #時段一
      gzpa017  LIKE gzpa_t.gzpa017, #時段一起始時間
      gzpa018  LIKE gzpa_t.gzpa018, #時段一結束時間
      gzpa019  LIKE gzpa_t.gzpa019, #時段一間格數
      gzpa020  LIKE gzpa_t.gzpa020, #時段一間格單位
      sc2      LIKE type_t.chr1,    #時段二
      gzpa021  LIKE gzpa_t.gzpa021, #時段二起始時間
      gzpa022  LIKE gzpa_t.gzpa022, #時段二結束時間
      gzpa023  LIKE gzpa_t.gzpa023, #時段二間格數
      gzpa024  LIKE gzpa_t.gzpa024, #時段二間格單位
      sc3      LIKE type_t.chr1,    #時段三
      gzpa025  LIKE gzpa_t.gzpa025, #時段三起始時間
      gzpa026  LIKE gzpa_t.gzpa026, #時段三結束時間
      gzpa027  LIKE gzpa_t.gzpa027, #時段三間格數
      gzpa028  LIKE gzpa_t.gzpa028, #時段三間格單位
      gzpa029  LIKE gzpa_t.gzpa029, #執行日遇到假日
      gzpa030  LIKE gzpa_t.gzpa030, #遇到假日處理方法
      gzpa031  LIKE gzpa_t.gzpa031,  #前一程序未完成時不執行新程序
      gzgf001  LIKE gzgf_t.gzgf001, #報表元件     #140808 報表排程 add
      gzgf002  LIKE gzgf_t.gzgf002, #樣板代號     #140808 報表排程 add
      gzgf004  LIKE gzgf_t.gzgf004, #角色         #140808 報表排程 add
      gzgf005  LIKE gzgf_t.gzgf005, #用戶         #140808 報表排程 add
      gzgd007  LIKE gzgd_t.gzgd007 #樣板名稱(4rp) #140808 報表排程 add
          END RECORD
DEFINE g_schedule_d DYNAMIC ARRAY OF RECORD
       gzpe011      LIKE gzpe_t.gzpe011,
       gzpe003      LIKE gzpe_t.gzpe003,
       gzpe007      LIKE gzpe_t.gzpe007,
       gzpe012      LIKE gzpe_t.gzpe012,
       gzpe004      LIKE gzpe_t.gzpe004,
       gzpe008      LIKE gzpe_t.gzpe008,
       gzpe009      LIKE gzpe_t.gzpe009,
       gzpe005      LIKE gzpe_t.gzpe005,
       gzpe006      LIKE gzpe_t.gzpe006,
       gzpe010      LIKE gzpe_t.gzpe010
          END RECORD
END GLOBALS
