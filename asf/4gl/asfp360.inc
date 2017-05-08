SCHEMA ds

GLOBALS

DEFINE g_ref_unit            LIKE type_t.chr1   #是否启用参考单位
DEFINE g_para                LIKE type_t.chr80
DEFINE g_sql                 STRING

DEFINE g_ooca002     LIKE ooca_t.ooca002  #小數位數  #add 150119
DEFINE g_ooca004     LIKE ooca_t.ooca004  #捨入類型  #add 150119

   ##############
   ##asfp360_01##
   ##############
   DEFINE g_sfaadocno_01    LIKE sfaa_t.sfaadocno   #工单单号
   DEFINE g_rec_b_01        LIKE type_t.num10       #单身笔数

   TYPE type_g_asfp360_01_m2       RECORD
          sfaa010       LIKE sfaa_t.sfaa010,  #生产料号
          sfaa010_desc  LIKE imaal_t.imaal003,
          sfaa010_desc2 LIKE imaal_t.imaal004,
          sfaa012       LIKE sfaa_t.sfaa012,  #生产数量
          sfaa049       LIKE sfaa_t.sfaa049,  #已发数量
          sfaa050       LIKE sfaa_t.sfaa050,  #已入库合格量
          sfaa051       LIKE sfaa_t.sfaa051,  #已入库不合格量
          sfaa052       LIKE sfaa_t.sfaa052,  #Bonus
          sfaa053       LIKE sfaa_t.sfaa053,  #生产数量
          sfaa054       LIKE sfaa_t.sfaa054,  #生产数量
          sfaa055       LIKE sfaa_t.sfaa055,  #生产数量
          sfaa056       LIKE sfaa_t.sfaa056   #生产数量
          END RECORD
   DEFINE g_asfp360_01_m2       type_g_asfp360_01_m2

   TYPE type_g_asfp360_01_d        RECORD
         sfbaseq              LIKE sfba_t.sfbaseq,     #项次
         sfbaseq1             LIKE sfba_t.sfbaseq1,    #项序
         sfba002              LIKE sfba_t.sfba002,     #部位
         sfba002_desc         LIKE oocql_t.oocql004,   #
         sfba003              LIKE sfba_t.sfba003,     #作业
         sfba003_desc         LIKE oocql_t.oocql004,   #
         sfba004              LIKE sfba_t.sfba004,     #作业序
         sfba006              LIKE sfba_t.sfba006,     #需求料号
         sfba006_desc         LIKE imaal_t.imaal003,   #品名
         sfba006_desc2        LIKE imaal_t.imaal004,   #规格
         sfba021              LIKE sfba_t.sfba021,     #特征
         sfba014              LIKE sfba_t.sfba014,     #单位
         sfba014_desc         LIKE oocal_t.oocal003,   #
         sfba013              LIKE sfba_t.sfba013,     #应发数量
         sfba016              LIKE sfba_t.sfba016,     #已发量
         no_issue_qty         LIKE sfba_t.sfba013      #未发数量
                             END RECORD
   DEFINE g_asfp360_01_d      DYNAMIC ARRAY OF type_g_asfp360_01_d
   DEFINE g_asfp360_01_d_t    type_g_asfp360_01_d

   ##############
   ##asfp360_02##
   ##############
   TYPE type_g_asfp360_02_m        RECORD
          insets         LIKE sfaa_t.sfaa049,  #拟挪入套数
          type           LIKE type_t.chr1      #挪料方式：1.成套挪料、2.单颗挪料
          END RECORD
   DEFINE g_asfp360_02_m        type_g_asfp360_02_m
   DEFINE g_max_sets_02  LIKE sfaa_t.sfaa049   #可挪入的最大套数

   TYPE type_g_asfp360_02_m2       RECORD
          sfaa010       LIKE sfaa_t.sfaa010,  #生产料号
          sfaa010_desc  LIKE imaal_t.imaal003,
          sfaa010_desc2 LIKE imaal_t.imaal004,
          sfaa012       LIKE sfaa_t.sfaa012,  #生产数量
          sfaa049       LIKE sfaa_t.sfaa049,  #已发数量
          sfaa050       LIKE sfaa_t.sfaa050,  #已入库合格量
          sfaa051       LIKE sfaa_t.sfaa051,  #已入库不合格量
          sfaa052       LIKE sfaa_t.sfaa052,  #Bonus
          sfaa053       LIKE sfaa_t.sfaa053,  #生产数量
          sfaa054       LIKE sfaa_t.sfaa054,  #生产数量
          sfaa055       LIKE sfaa_t.sfaa055,  #生产数量
          sfaa056       LIKE sfaa_t.sfaa056   #生产数量
          END RECORD
   DEFINE g_asfp360_02_m2       type_g_asfp360_02_m2

   TYPE type_g_asfp360_02_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         sfbaseq              LIKE sfba_t.sfbaseq,     #项次
         sfbaseq1             LIKE sfba_t.sfbaseq1,    #项序
         sfba002              LIKE sfba_t.sfba002,     #部位
         sfba002_desc         LIKE oocql_t.oocql004,   #
         sfba003              LIKE sfba_t.sfba003,     #作业
         sfba003_desc         LIKE oocql_t.oocql004,   #
         sfba004              LIKE sfba_t.sfba004,     #作业序
         sfba006              LIKE sfba_t.sfba006,     #需求料号
         sfba006_desc         LIKE imaal_t.imaal003,   #品名
         sfba006_desc2        LIKE imaal_t.imaal004,   #规格
         sfba021              LIKE sfba_t.sfba021,     #特征
         sfba014              LIKE sfba_t.sfba014,     #单位
         sfba014_desc         LIKE oocal_t.oocal003,   #
         sfba013              LIKE sfba_t.sfba013,     #应发数量
         sfba016              LIKE sfba_t.sfba016,     #已发量
         no_issue_qty         LIKE sfba_t.sfba013,     #未发数量
         #defqty               LIKE sfba_t.sfba013,     #最大可挪入數量-拟拨入数量默认值 方便日后判断
         plan_inqty           LIKE sfba_t.sfba013,     #拟挪入数量
         unitr                LIKE sfba_t.sfba014,     #参考单位
         plan_inqtyr          LIKE sfba_t.sfba013      #参考单位拟挪入数量
                             END RECORD
   DEFINE g_asfp360_02_d      DYNAMIC ARRAY OF type_g_asfp360_02_d
   DEFINE g_asfp360_02_d_t    type_g_asfp360_02_d
   DEFINE g_asfp360_02_d_o    type_g_asfp360_02_d

   DEFINE g_rec_b_02        LIKE type_t.num10       #单身笔数

   ##############
   ##asfp360_03##
   ##############
   DEFINE g_wc_03               STRING

   TYPE type_g_asfp360_03_d1    RECORD
                                sel            LIKE type_t.chr1,      #选择
                                sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                                sfaa010        LIKE sfaa_t.sfaa010,   #生产料号
                                sfaa010_desc   LIKE type_t.chr500,
                                sfaa010_desc2  LIKE type_t.chr500,
                                sfaa012        LIKE sfaa_t.sfaa012,   #生产数量
                                sfaa049        LIKE sfaa_t.sfaa049,   #已发套数
                                sfaa050        LIKE sfaa_t.sfaa050,   #已入库量
                                can_outsets    LIKE sfaa_t.sfaa049,   #可拨出套数
                                plan_outsets   LIKE sfaa_t.sfaa049,   #拟拨出套数
                                sfaa019        LIKE sfaa_t.sfaa019,   #预计开工日
                                sfaa020        LIKE sfaa_t.sfaa020    #预计完工日
                                END RECORD
   DEFINE g_asfp360_03_d1      DYNAMIC ARRAY OF type_g_asfp360_03_d1
   DEFINE g_asfp360_03_d1_t    type_g_asfp360_03_d1
   DEFINE g_asfp360_03_d1_o    type_g_asfp360_03_d1

   #制程单身预留
   TYPE type_g_asfp360_03_d2    RECORD
                                sel            LIKE type_t.chr1,     #选择
                                sfcb001        LIKE sfcb_t.sfcb001,  #RUN CARD
                                sfcb002        LIKE sfcb_t.sfcb002,  #项次
                                sfcb003        LIKE sfcb_t.sfcb003,  #作业
                                sfcb004        LIKE sfcb_t.sfcb004,  #作业序
                                sfcb050        LIKE sfcb_t.sfcb050,  #在制数量
                                sfcb028        LIKE sfcb_t.sfcb028,  #良品转入
                                sfcb033        LIKE sfcb_t.sfcb033,  #良品转出
                                sfcb036        LIKE sfcb_t.sfcb036,  #当站报废
                                sfcb037        LIKE sfcb_t.sfcb037,  #当站下线
                                sfcb046        LIKE sfcb_t.sfcb046,  #待Move in數
                                sfcb047        LIKE sfcb_t.sfcb047,  #待Check in數
                                sfcb048        LIKE sfcb_t.sfcb048,  #待Check out數
                                sfcb049        LIKE sfcb_t.sfcb049,  #待Move out數
                                outqty         LIKE sfcb_t.sfcb049,  #擬撥出數量
                                manh           LIKE sfcb_t.sfcb023,  #應轉出工時
                                mach           LIKE sfcb_t.sfcb025   #應轉出機時
                                END RECORD
   DEFINE g_asfp360_03_d2      DYNAMIC ARRAY OF type_g_asfp360_03_d2
   DEFINE g_asfp360_03_d2_t    type_g_asfp360_03_d2
   DEFINE g_asfp360_03_d2_o    type_g_asfp360_03_d2

   TYPE type_g_asfp360_03_d3    RECORD
                                sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                                sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                                sfba002        LIKE sfba_t.sfba002,  #部位
                                sfba002_desc   LIKE type_t.chr500,
                                sfba003        LIKE sfba_t.sfba003,  #作业
                                sfba003_desc   LIKE type_t.chr500,
                                sfba004        LIKE sfba_t.sfba004,  #作业序
                                sfba005        LIKE sfba_t.sfba005,  #BOM料号
                                sfba006        LIKE sfba_t.sfba006,  #发料料号
                                sfba006_desc   LIKE type_t.chr500,
                                sfba006_desc2  LIKE type_t.chr500,
                                sfba021        LIKE sfba_t.sfba021,  #特征
                                sfba014        LIKE sfba_t.sfba014,  #单位
                                sfba014_desc   LIKE type_t.chr500,
                                sfba013        LIKE sfba_t.sfba013,  #应发
                                sfba016        LIKE sfba_t.sfba016,  #已发
                                outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                                unitr          LIKE sfba_t.sfba014,  #参考单位
                                outqtyr        LIKE sfba_t.sfba016   #参考单位拨出数量
                                END RECORD
   DEFINE g_asfp360_03_d3      DYNAMIC ARRAY OF type_g_asfp360_03_d3
   DEFINE g_asfp360_03_d3_t    type_g_asfp360_03_d3
   DEFINE g_asfp360_03_d3_o    type_g_asfp360_03_d3

   TYPE type_g_asfp360_03_d4    RECORD
                                sel            LIKE type_t.chr1,     #选择
                                inaodocno      LIKE inao_t.inaodocno,#发料单号
                                inaoseq        LIKE inao_t.inaoseq,  #项次
                                inaoseq1       LIKE inao_t.inaoseq1, #项序
                                inaoseq2       LIKE inao_t.inaoseq2, #序号
                                inao001        LIKE inao_t.inao001,  #料件编号
                                inao001_desc   LIKE type_t.chr500,
                                inao001_desc2  LIKE type_t.chr500,
                                inao008        LIKE inao_t.inao008,  #制造批号
                                inao009        LIKE inao_t.inao009,  #制造序号
                                inao010        LIKE inao_t.inao010,  #制造日期
                                can_outqty     LIKE inao_t.inao012,  #可拨出数量
                                outqty         LIKE inao_t.inao012   #数量
                                END RECORD
   DEFINE g_asfp360_03_d4      DYNAMIC ARRAY OF type_g_asfp360_03_d4
   DEFINE g_asfp360_03_d4_t    type_g_asfp360_03_d4
   DEFINE g_asfp360_03_d4_o    type_g_asfp360_03_d4

   TYPE type_g_asfp360_03_d5    RECORD
                                inqty_sum      LIKE sfba_t.sfba013,  #来源拨出数量合计
                                inqtyr_sum     LIKE sfba_t.sfba013   #参考单位来源拨出数量合计
                                END RECORD
   DEFINE g_asfp360_03_d5      DYNAMIC ARRAY OF type_g_asfp360_03_d5

   DEFINE g_rec_b03_1        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b03_2        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b03_3        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b03_4        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b03_5        LIKE type_t.num10       #单身笔数

   ##############
   ##asfp360_04##
   ##############
   #單頭 type 宣告
   TYPE type_g_asfp360_04_m    RECORD
                               user        LIKE sfda_t.sfda004,   #申请人
                               user_desc   LIKE type_t.chr500,
                               slips       LIKE sfda_t.sfdadocno, #发料单别
                               slips_desc  LIKE type_t.chr500,
                               slipr       LIKE sfda_t.sfdadocno, #退料单别
                               slipr_desc  LIKE type_t.chr500,
                               ware        LIKE inaa_t.inaa001,   #库位
                               ware_desc   LIKE type_t.chr500,
                               loca        LIKE inab_t.inab002,   #储位
                               loca_desc   LIKE type_t.chr500,
                               lot         LIKE inag_t.inag006,   #批号
                               lot_desc    LIKE type_t.chr500
                               END RECORD
   DEFINE g_asfp360_04_m       type_g_asfp360_04_m

   TYPE type_g_asfp360_04_m2   RECORD
                               sfladocno   LIKE sfla_t.sfladocno,  #挪料序号
                               send_no     LIKE sfda_t.sfdadocno,  #发料单号 
                               send_type   LIKE sfda_t.sfda002,    #发料类型
                               return_no   LIKE sfda_t.sfdadocno,  #退料单号
                               return_type LIKE sfda_t.sfda002     #发料类型
                               END RECORD
   DEFINE g_asfp360_04_m2      type_g_asfp360_04_m2

   TYPE type_g_asfp360_04_d1    RECORD
                                sfdcseq        LIKE sfdc_t.sfdcseq,   #项次
                                sfdc001        LIKE sfdc_t.sfdc001,   #工单单号
                                sfdc002        LIKE sfdc_t.sfdc002,   #工单项次
                                sfdc003        LIKE sfdc_t.sfdc003,   #工单项序
                                sfba002        LIKE sfba_t.sfba002,   #部位
                                sfba002_desc   LIKE type_t.chr500,
                                sfba003        LIKE sfba_t.sfba003,   #作业
                                sfba003_desc   LIKE type_t.chr500,
                                sfba004        LIKE sfba_t.sfba004,   #作业序
                                sfdc004        LIKE sfdc_t.sfdc004,   #需求料号
                                sfdc010_desc   LIKE type_t.chr500,
                                sfdc010_desc2  LIKE type_t.chr500,
                                sfdc005        LIKE sfdc_t.sfdc005,   #特征
                                sfdc006        LIKE sfdc_t.sfdc006,   #单位
                                sfdc006_desc   LIKE type_t.chr500,
                                sfba013        LIKE sfba_t.sfba013,   #应发
                                sfba016        LIKE sfba_t.sfba016,   #已发
                                sfdc008        LIKE sfdc_t.sfdc008,   #发料数量
                                sfdc009        LIKE sfdc_t.sfdc009,   #参考单位
                                sfdc009_desc   LIKE type_t.chr500,
                                sfdc011        LIKE sfdc_t.sfdc011    #参考单位数量
                                END RECORD
   DEFINE g_asfp360_04_d1      DYNAMIC ARRAY OF type_g_asfp360_04_d1

   TYPE type_g_asfp360_04_d2    RECORD
                                sfdcseq        LIKE sfdc_t.sfdcseq,   #项次
                                sfdc001        LIKE sfdc_t.sfdc001,   #工单单号
                                sfdc002        LIKE sfdc_t.sfdc002,   #工单项次
                                sfdc003        LIKE sfdc_t.sfdc003,   #工单项序
                                sfba002        LIKE sfba_t.sfba002,   #部位
                                sfba002_desc   LIKE type_t.chr500,
                                sfba003        LIKE sfba_t.sfba003,   #作业
                                sfba003_desc   LIKE type_t.chr500,
                                sfba004        LIKE sfba_t.sfba004,   #作业序
                                sfdc004        LIKE sfdc_t.sfdc004,   #需求料号
                                sfdc010_desc   LIKE type_t.chr500,
                                sfdc010_desc2  LIKE type_t.chr500,
                                sfdc005        LIKE sfdc_t.sfdc005,   #特征
                                sfdc006        LIKE sfdc_t.sfdc006,   #单位
                                sfdc006_desc   LIKE type_t.chr500,
                                sfba013        LIKE sfba_t.sfba013,   #应发
                                sfba016        LIKE sfba_t.sfba016,   #已发
                                sfdc008        LIKE sfdc_t.sfdc008,   #发料数量
                                sfdc009        LIKE sfdc_t.sfdc009,   #参考单位
                                sfdc009_desc   LIKE type_t.chr500,
                                sfdc011        LIKE sfdc_t.sfdc011    #参考单位数量
                                END RECORD
   DEFINE g_asfp360_04_d2      DYNAMIC ARRAY OF type_g_asfp360_04_d2

   DEFINE g_rec_b04_1        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b04_2        LIKE type_t.num10       #单身笔数
   ##############
   ##asfp360_05##
   ##############
   DEFINE g_wc_05               STRING

   TYPE type_g_asfp360_05_d1    RECORD
                                sfbaseq              LIKE sfba_t.sfbaseq,     #项次
                                sfbaseq1             LIKE sfba_t.sfbaseq1,    #项序
                                sfba002              LIKE sfba_t.sfba002,     #部位
                                sfba002_desc         LIKE oocql_t.oocql004,   #
                                sfba003              LIKE sfba_t.sfba003,     #作业
                                sfba003_desc         LIKE oocql_t.oocql004,   #
                                sfba004              LIKE sfba_t.sfba004,     #作业序
                                sfba005              LIKE sfba_t.sfba005,     #BOM料号
                                sfba006              LIKE sfba_t.sfba006,     #需求料号
                                sfba006_desc         LIKE imaal_t.imaal003,   #品名
                                sfba006_desc2        LIKE imaal_t.imaal004,   #规格
                                sfba021              LIKE sfba_t.sfba021,     #特征
                                sfba014              LIKE sfba_t.sfba014,     #单位
                                sfba014_desc         LIKE oocal_t.oocal003,   #
                                sfba013              LIKE sfba_t.sfba013,     #应发数量
                                sfba016              LIKE sfba_t.sfba016,     #已发量
                                no_issue_qty         LIKE sfba_t.sfba013,     #未发数量
                                #defqty               LIKE sfba_t.sfba013,     #最大可挪入數量-拟拨入数量默认值 方便日后判断
                                plan_inqty           LIKE sfba_t.sfba013,     #拟挪入数量
                                unitr                LIKE sfba_t.sfba014,     #参考单位
                                plan_inqtyr          LIKE sfba_t.sfba013,     #参考单位拟挪入数量
                                inqty_sum            LIKE sfba_t.sfba013,     #来源拨出数量合计
                                inqtyr_sum           LIKE sfba_t.sfba013      #参考单位来源拨出数量合计 
                                END RECORD
   DEFINE g_asfp360_05_d1      DYNAMIC ARRAY OF type_g_asfp360_05_d1
   DEFINE g_asfp360_05_d1_t    type_g_asfp360_05_d1
   DEFINE g_asfp360_05_d1_o    type_g_asfp360_05_d1

   TYPE type_g_asfp360_05_d3    RECORD
                                sel            LIKE type_t.chr1,      #选择
                                sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                                sfaa010        LIKE sfaa_t.sfaa010,   #生产料号
                                sfaa010_desc   LIKE type_t.chr500,
                                sfaa010_desc2  LIKE type_t.chr500,
                                sfaa012        LIKE sfaa_t.sfaa012,   #生产数量
                                sfaa049        LIKE sfaa_t.sfaa049,   #已发套数
                                sfaa050        LIKE sfaa_t.sfaa050,   #已入库量
                                sfaa019        LIKE sfaa_t.sfaa019,   #预计开工日
                                sfaa020        LIKE sfaa_t.sfaa020,   #预计完工日
                                sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                                sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                                sfba002        LIKE sfba_t.sfba002,  #部位
                                sfba002_desc   LIKE type_t.chr500,
                                sfba003        LIKE sfba_t.sfba003,  #作业
                                sfba003_desc   LIKE type_t.chr500,
                                sfba004        LIKE sfba_t.sfba004,  #作业序
                                sfba005        LIKE sfba_t.sfba005,  #BOM料号
                                sfba006        LIKE sfba_t.sfba006,  #发料料号
                                sfba006_desc   LIKE type_t.chr500,
                                sfba006_desc2  LIKE type_t.chr500,
                                sfba021        LIKE sfba_t.sfba021,  #特征
                                sfba014        LIKE sfba_t.sfba014,  #单位
                                sfba014_desc   LIKE type_t.chr500,
                                sfba013        LIKE sfba_t.sfba013,  #应发
                                sfba016        LIKE sfba_t.sfba016,  #已发
                                can_outqty     LIKE sfaa_t.sfaa049,  #可拨出数量
                                outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                                unitr          LIKE sfba_t.sfba014,  #参考单位
                                outqtyr        LIKE sfba_t.sfba016   #参考单位拨出数量
                                END RECORD
   DEFINE g_asfp360_05_d3      DYNAMIC ARRAY OF type_g_asfp360_05_d3
   DEFINE g_asfp360_05_d3_t    type_g_asfp360_05_d3
   DEFINE g_asfp360_05_d3_o    type_g_asfp360_05_d3

   TYPE type_g_asfp360_05_d4    RECORD
                                sel            LIKE type_t.chr1,     #选择
                                inaodocno      LIKE inao_t.inaodocno,#发料单号
                                inaoseq        LIKE inao_t.inaoseq,  #项次
                                inaoseq1       LIKE inao_t.inaoseq1, #项序
                                inaoseq2       LIKE inao_t.inaoseq2, #序号
                                inao001        LIKE inao_t.inao001,  #料件编号
                                inao001_desc   LIKE type_t.chr500,
                                inao001_desc2  LIKE type_t.chr500,
                                inao008        LIKE inao_t.inao008,  #制造批号
                                inao009        LIKE inao_t.inao009,  #制造序号
                                inao010        LIKE inao_t.inao010,  #制造日期
                                can_outqty     LIKE inao_t.inao012,  #可拨出数量
                                outqty         LIKE inao_t.inao012   #数量
                                END RECORD
   DEFINE g_asfp360_05_d4      DYNAMIC ARRAY OF type_g_asfp360_05_d4
   DEFINE g_asfp360_05_d4_t    type_g_asfp360_05_d4
   DEFINE g_asfp360_05_d4_o    type_g_asfp360_05_d4

   DEFINE g_rec_b05_1        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b05_2        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b05_3        LIKE type_t.num10       #单身笔数
   DEFINE g_rec_b05_4        LIKE type_t.num10       #单身笔数
END GLOBALS
